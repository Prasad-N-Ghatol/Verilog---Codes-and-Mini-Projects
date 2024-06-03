/*
Verilog Code, to implement a I2C Master.



This Design supprts to send the Data, in Single or Burst Mode.
The Burst Mode can send/receive a maximum of 4 Bytes.



Author : Prasad Narayan Ghatol
*/



module I2C_Master (
    input        I2C_Clk_In,                // Clock Input to the Master
    input        Reset_In,                  // Reset Signal, to reset the Master

    inout        I2C_SDA,                   // SDA Line of the I2C
    output       I2C_SCL,                   // SCL Line of the I2C

    input        I2C_Start_Transfer_In,     // Signal to Start the I2C Transfer

    input        M_Burst_Singleb_In,        // Burst(1) / Single(0) to perform the Burst/Single operation
    input  [1:0] M_Burst_Length_In,         // Number of Bytes of Data to be sent or received, in Bursts
    input        M_Read_Writeb_In,          // Read(1) / Write(0) to perform the Read/Write operation

    input  [6:0] M_Slave_Device_Address_In, // Slave Device Address, to select the Slave Device
    input  [7:0] M_Reg_Address_In,          // Register Address to be sent to the Slave Device
    input  [7:0] M_Data_In,                 // Data to be sent to the Slave Device

    output [7:0] M_Data_Out,                // Data read by the Master, from the Slave Devices
    output       M_Data_Read_Enable_Out     // Enable Signal to read the Data on the M_Data_Out Line
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
wire       SDA_Enable;                      // Enable The SDA so the Master has the control of the I2C Bus

reg        SDA_Override_Enable;             // Override Enable, to place the override the data to be sent on the SDA
reg        SDA_Override_Data;               // Data to be overridden on the SDA

reg        SDA_Write_Enable;                // Enable to write data to the SDA
reg        SDA_Data;                        // Data to be sent on the SDA

wire       Read_SDA;                        // Read the values on the SDA

wire       SCL_Enable;                      // Enable the SCL Line, for sending the CLock to the Slave Devices 


// Latch the Data inorder to be sent by the Master
reg        Latched_Burst_Singleb_In;
reg  [1:0] Latched_Burst_Length_In;
reg        Latched_Read_Writeb_In;
reg  [6:0] Latched_Slave_Device_Address_In;
reg  [7:0] Latched_Reg_Address_In;
reg  [7:0] Latched_Data_In;


reg        Bit_Counter_Enable;              // Enable the Bit Counter
reg  [3:0] Bit_Counter;                     // To track the number of bit to be sent or received

wire       Burst_Counter_Enable;            // Enable the Burst Counter
reg        Burst_Counter_Decrement;         // Signal to decrement the Burst Counter Value
reg  [1:0] Burst_Counter;                   // To track the number of bytes to be sent or received


wire [7:0] Slave_Instruction_Write;         // 8-Bit wire, to hold the Slave Device Address, with Write Operation 
wire [7:0] Slave_Instruction_Read;          // 8-Bit wire, to hold the Slave Device Address, with Read Operation

reg  [7:0] SDA_Read_SIPO;                   // SIPO Register, to hold the value read from the SDA
reg  [7:0] Read_Data;                       // To hold the value, read from SDA, to be sent out from the Master



// --------------------------------------------------
// I2C Master States
// --------------------------------------------------
localparam [3:0]    IDLE                                = 4'h0,
                    START                               = 4'h1,
                    SEND_SLAVE_INSTRUCTION              = 4'h2,
                    CHECK_SLAVE_INSTRUCTION_ACK         = 4'h3,
                    SEND_ADDRESS                        = 4'h4,
                    CHECK_SEND_ADDRESS_ACK              = 4'h5,
                    SEND_DATA                           = 4'h6,
                    CHECK_SEND_DATA_ACK                 = 4'h7,
                    RESTART_STOP                        = 4'h8,
                    RESTART_START                       = 4'h9,
                    RESTART_SLAVE_INSTRUCTION           = 4'hA,
                    RESTART_CHECK_SLAVE_INSTRUCTION_ACK = 4'hB,
                    READ_DATA                           = 4'hC,
                    SEND_READ_DATA_ACK                  = 4'hD,
                    SEND_NACK                           = 4'hE,
                    STOP                                = 4'hF;

reg [3:0] M_Next_State, M_Present_State;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign SDA_Enable = (M_Present_State == IDLE) ? 1'b0 : 1'b1;
assign I2C_SDA = SDA_Enable ? (SDA_Override_Enable ? SDA_Override_Data : (SDA_Write_Enable ? SDA_Data : 1'bZ)) : 1'b1;

assign Read_SDA = I2C_SDA;

assign SCL_Enable = ((M_Present_State == IDLE) || 
                    (M_Present_State == START) || 
                    (M_Present_State == RESTART_START)) 
                        ? 1'b0 : 1'b1;
assign I2C_SCL = SCL_Enable ? I2C_Clk_In : 1'b1;

assign Slave_Instruction_Write = {Latched_Slave_Device_Address_In, 1'b0};
assign Slave_Instruction_Read = {Latched_Slave_Device_Address_In, 1'b1};

assign M_Data_Read_Enable_Out = ((M_Present_State == SEND_READ_DATA_ACK) || (M_Present_State == SEND_NACK)) ? 1'b1 : 1'b0;
assign M_Data_Out = ((M_Present_State == SEND_READ_DATA_ACK) || (M_Present_State == SEND_NACK)) ? Read_Data : 8'bZ;

assign Burst_Counter_Enable = ((M_Present_State <= CHECK_SEND_ADDRESS_ACK)) ? 1'b0 : 1'b1;



// --------------------------------------------------
// SDA and SCL Logic
// --------------------------------------------------
// Start and Stop Bit Generation
always @ (*)
    begin
        if ((M_Present_State == START) || M_Present_State == RESTART_START)
            begin
                SDA_Override_Enable <= 1'b1;
                SDA_Override_Data <= ~I2C_Clk_In;
            end
        else if ((M_Present_State == STOP) || (M_Present_State == RESTART_STOP))
            begin
                SDA_Override_Enable <= 1'b1;
                SDA_Override_Data <= 1'b0;
            end
        else
            begin
                SDA_Override_Enable <= 1'b0;
                SDA_Override_Data <= 1'b1;
            end
    end



// --------------------------------------------------
// Other modules
// --------------------------------------------------
// SDA Write Enable Logic
always @ (*)
    begin
        if ((M_Present_State == CHECK_SLAVE_INSTRUCTION_ACK) || 
            (M_Present_State == CHECK_SEND_ADDRESS_ACK) || 
            (M_Present_State == CHECK_SEND_DATA_ACK) || 
            (M_Present_State == RESTART_CHECK_SLAVE_INSTRUCTION_ACK) || 
            (M_Present_State == READ_DATA))
            begin
                SDA_Write_Enable <= 1'b0;
            end
        else
            begin
                SDA_Write_Enable <= 1'b1;
            end
    end


// Latching of Input Data
always @ (posedge I2C_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Latched_Burst_Singleb_In <= 1'b0;
                Latched_Burst_Length_In <= 2'b0;
                Latched_Read_Writeb_In <= 1'b0;
                Latched_Slave_Device_Address_In <= 7'b0;
                Latched_Reg_Address_In <= 8'b0;
                Latched_Data_In <= 8'b0;
            end
        else if (M_Present_State == IDLE)
            begin
                Latched_Burst_Singleb_In <= 1'b0;
                Latched_Burst_Length_In <= 2'b0;
                Latched_Read_Writeb_In <= 1'b0;
                Latched_Slave_Device_Address_In <= 7'b0;
                Latched_Reg_Address_In <= 8'b0;
                Latched_Data_In <= 8'b0;
            end
        else 
            begin
                // Latch the configuration data
                if (M_Present_State == START)
                    begin
                        Latched_Burst_Singleb_In <= M_Burst_Singleb_In;
                        Latched_Burst_Length_In <= M_Burst_Length_In;
                        Latched_Read_Writeb_In <= M_Read_Writeb_In;
                        Latched_Slave_Device_Address_In <= M_Slave_Device_Address_In;
                        Latched_Reg_Address_In <= M_Reg_Address_In;
                    end
                else
                    begin
                        Latched_Burst_Singleb_In <= Latched_Burst_Singleb_In;
                        Latched_Burst_Length_In <= Latched_Burst_Length_In;
                        Latched_Read_Writeb_In <= Latched_Read_Writeb_In;
                        Latched_Slave_Device_Address_In <= Latched_Slave_Device_Address_In;
                        Latched_Reg_Address_In <= Latched_Reg_Address_In;
                    end
                
                // Latch In the Data to be sent to the Slave Devices
                if ((M_Present_State == CHECK_SEND_ADDRESS_ACK) || (M_Present_State == CHECK_SEND_DATA_ACK))
                    begin
                        Latched_Data_In <= M_Data_In;
                    end
                else
                    begin
                        Latched_Data_In <= Latched_Data_In;
                    end
            end
    end


// Bit Counter
always @ (negedge I2C_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Bit_Counter <= 4'd7;
            end
        else if (Bit_Counter_Enable)
            begin
                Bit_Counter <= Bit_Counter - 1'b1;
            end
        else
            begin
                Bit_Counter <= 4'd7;
            end
    end


// Burst Counter
always @ (negedge I2C_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Burst_Counter <= Latched_Burst_Length_In;
            end
        else if (Burst_Counter_Enable)
            begin
                if (Burst_Counter_Decrement)
                    begin
                        Burst_Counter <= Burst_Counter - 1'b1;
                    end
                else
                    begin
                        Burst_Counter <= Burst_Counter;
                    end
            end
        else
            begin
                Burst_Counter <= Latched_Burst_Length_In;
            end
    end



// --------------------------------------------------
// Master Read Logic
// --------------------------------------------------
// SIPO Shift Register
always @ (posedge I2C_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                SDA_Read_SIPO <= 8'b0;
            end
        else
            begin
                SDA_Read_SIPO[0] <= Read_SDA;
                SDA_Read_SIPO[1] <= SDA_Read_SIPO[0];
                SDA_Read_SIPO[2] <= SDA_Read_SIPO[1];
                SDA_Read_SIPO[3] <= SDA_Read_SIPO[2];
                SDA_Read_SIPO[4] <= SDA_Read_SIPO[3];
                SDA_Read_SIPO[5] <= SDA_Read_SIPO[4];
                SDA_Read_SIPO[6] <= SDA_Read_SIPO[5];
                SDA_Read_SIPO[7] <= SDA_Read_SIPO[6];
            end
    end


// Latching the Read Data
always @ (negedge I2C_Clk_In)
    begin
        if ((M_Next_State == SEND_READ_DATA_ACK) || (M_Next_State == SEND_NACK))
            begin
                Read_Data <= SDA_Read_SIPO;
            end
        else
            begin
                Read_Data <= Read_Data;
            end
    end



// --------------------------------------------------
// I2C Master Logic
// --------------------------------------------------
// I2C Master State Control
always @ (negedge I2C_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                M_Present_State <= IDLE;
            end
        else if (I2C_Start_Transfer_In && (M_Present_State <= IDLE))
            begin
                M_Present_State <= START;
            end
        else
            begin
                M_Present_State <= M_Next_State;
            end
    end


// I2C Master FSM
always @ (I2C_Clk_In or M_Present_State or Bit_Counter or Slave_Instruction_Write or Read_SDA or Latched_Reg_Address_In or Latched_Read_Writeb_In or Latched_Data_In or Latched_Burst_Singleb_In or Burst_Counter or Slave_Instruction_Read)
    begin
        case (M_Present_State)
            IDLE                                : // 4'h0
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;

                    M_Next_State <= IDLE;
                end

            START                               : // 4'h1
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    M_Next_State <= SEND_SLAVE_INSTRUCTION;
                end

            SEND_SLAVE_INSTRUCTION              : // 4'h2
                begin
                    Bit_Counter_Enable <= 1'b1;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= Slave_Instruction_Write[Bit_Counter];

                    if (Bit_Counter == 4'd0)
                        begin
                            M_Next_State <= CHECK_SLAVE_INSTRUCTION_ACK;
                        end
                    else
                        begin
                            M_Next_State <= SEND_SLAVE_INSTRUCTION;
                        end
                end

            CHECK_SLAVE_INSTRUCTION_ACK         : // 4'h3
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    if (I2C_Clk_In)
                        begin
                            if (~Read_SDA)
                                begin
                                    M_Next_State <= SEND_ADDRESS;
                                end
                            else
                                begin
                                    M_Next_State <= STOP;
                                end
                        end
                    else
                        begin
                            M_Next_State <= CHECK_SLAVE_INSTRUCTION_ACK;
                        end
                end

            SEND_ADDRESS                        : // 4'h4
                begin
                    Bit_Counter_Enable <= 1'b1;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= Latched_Reg_Address_In[Bit_Counter];
                    
                    if (Bit_Counter == 4'd0)
                        begin
                            M_Next_State <= CHECK_SEND_ADDRESS_ACK;
                        end
                    else
                        begin
                            M_Next_State <= SEND_ADDRESS;
                        end
                end

            CHECK_SEND_ADDRESS_ACK              : // 4'h5
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    if (I2C_Clk_In)
                        begin
                            if (~Read_SDA)
                                begin
                                    if (Latched_Read_Writeb_In)
                                        begin
                                            M_Next_State <= RESTART_STOP;
                                        end
                                    else
                                        begin
                                            M_Next_State <= SEND_DATA;
                                        end
                                end
                            else
                                begin
                                    M_Next_State <= STOP;
                                end
                        end
                    else
                        begin
                            M_Next_State <= CHECK_SEND_ADDRESS_ACK;
                        end
                end

            SEND_DATA                           : // 4'h6
                begin
                    Bit_Counter_Enable <= 1'b1;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= Latched_Data_In[Bit_Counter];
                    
                    if (Bit_Counter == 4'd0)
                        begin
                            M_Next_State <= CHECK_SEND_DATA_ACK;
                        end
                    else
                        begin
                            M_Next_State <= SEND_DATA;
                        end
                end

            CHECK_SEND_DATA_ACK                 : // 4'h7
                begin
                    Bit_Counter_Enable <= 1'b0;

                    SDA_Data <= 1'b1;

                    if (I2C_Clk_In)
                        begin
                            Burst_Counter_Decrement <= 1'b1;
                        end
                    else
                        begin
                            Burst_Counter_Decrement <= 1'b0;
                        end

                    if (I2C_Clk_In)
                        begin
                            if (Latched_Burst_Singleb_In && (Burst_Counter != 2'd0))
                                begin
                                    if (~Read_SDA)
                                        begin
                                            M_Next_State <= SEND_DATA;
                                        end
                                    else
                                        begin
                                            M_Next_State <= STOP;
                                        end
                                end
                            else
                                begin
                                    M_Next_State <= STOP;
                                end
                        end
                    else
                        begin
                            M_Next_State <= CHECK_SEND_DATA_ACK;
                        end
                end

            RESTART_STOP                        : // 4'h8
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    M_Next_State <= RESTART_START;
                end

            RESTART_START                       : // 4'h9
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    M_Next_State <= RESTART_SLAVE_INSTRUCTION;
                end

            RESTART_SLAVE_INSTRUCTION           : // 4'hA
                begin
                    Bit_Counter_Enable <= 1'b1;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= Slave_Instruction_Read[Bit_Counter];

                    if (Bit_Counter == 4'd0)
                        begin
                            M_Next_State <= RESTART_CHECK_SLAVE_INSTRUCTION_ACK;
                        end
                    else
                        begin
                            M_Next_State <= RESTART_SLAVE_INSTRUCTION;
                        end
                end

            RESTART_CHECK_SLAVE_INSTRUCTION_ACK : // 4'hB
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    if (I2C_Clk_In)
                        begin
                            if (~Read_SDA)
                                begin
                                    M_Next_State <= READ_DATA;
                                end
                            else
                                begin
                                    M_Next_State <= STOP;
                                end
                        end
                    else
                        begin
                            M_Next_State <= RESTART_CHECK_SLAVE_INSTRUCTION_ACK;
                        end
                end

            READ_DATA                           : // 4'hC
                begin
                    Bit_Counter_Enable <= 1'b1;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    if (Bit_Counter == 4'd0)
                        begin
                            if (~Latched_Burst_Singleb_In || (Burst_Counter == 2'd0))
                                begin
                                    M_Next_State <= SEND_NACK;
                                end
                            else
                                begin
                                    M_Next_State <= SEND_READ_DATA_ACK;
                                end
                        end
                    else
                        begin
                            M_Next_State <= READ_DATA;
                        end
                end

            SEND_READ_DATA_ACK                  : // 4'hD
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b1;

                    SDA_Data <= 1'b0;
                    
                    M_Next_State <= READ_DATA;
                end

            SEND_NACK                           : // 4'hE
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    M_Next_State <= STOP;
                end

            STOP                                : // 4'hF
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    M_Next_State <= IDLE;
                end
                
            default : 
                begin
                    Bit_Counter_Enable <= 1'b0;
                    Burst_Counter_Decrement <= 1'b0;

                    SDA_Data <= 1'b1;
                    
                    M_Next_State <= IDLE;
                end
        endcase
    end




endmodule