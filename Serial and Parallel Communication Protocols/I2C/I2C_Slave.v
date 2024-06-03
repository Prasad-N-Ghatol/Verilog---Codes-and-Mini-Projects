/*
Verilog Code, to implement a I2C Slave.



Author : Prasad Narayan Ghatol
*/



module I2C_Slave 
#(parameter DEVICE_ADDRESS = 7'h68)
(
    input        Reset_In,                      // Reset Signal, to reset the Slave

    inout        I2C_SDA,                       // SDA Line of the I2C
    input        I2C_SCL,                       // SCL Line of the I2C

    input  [7:0] S_Data_In,                     // Data to be sent to the Master Device

    output [6:0] S_Slave_Device_Address_Out,    // Slave Device Address Read on the I2C
    output       S_Read_Writeb_Out,             // Read(1) / Write(0) Signal read on the I2C
    output [7:0] S_Reg_Address_Out,             // Register Address read on the I2C

    output [7:0] S_Data_Out,                    // Data read on the I2C
    output       S_Data_Read_Enable_Out         // Enable Signal to read the Data on the S_Data_Out Line
);


// --------------------------------------------------
// wires and regs
// --------------------------------------------------
wire       SDA_Write_Enable;                    // Enable to write Data to the SDA

reg        SDA_Data;                            // Data to be written to the SDA

wire       Read_SDA;                            // Data Read on the SDA

reg        PSDA_Latched_SCL_Value;              // Latch the value on SCL on rising edge of SDA
reg        NSDA_Latched_SCL_Value;              // Latch the value on SCL on falling edge of SDA

wire       I2C_Transaction_InProgress;          // To hold, if I2C Transaction is under progress or not
wire       I2C_Start;                           // To indicate the Start of the I2C Transaction

reg        Start_Detected;                      // I2C Transaction Start is detected
reg        Stop_Detected;                       // I2C Transaction Stop is detected

reg  [7:0] SDA_Read_SIPO;                       // SPIO to hold the 8-bit values read from the SDA

reg  [7:0] Latched_S_Data_In;                   // Latch the Data to be send over the SDA

wire       Send_Out_Slave_Instruction_Enable;   // Enable to send the Slave Instruction on the output of Slave Device
wire       Send_Out_Reg_Address_Enable;         // Enable to send the Register Address on the output of Slave Device
wire       Send_Out_Data_Enable;                // Enable to send the Data on the output of Slave Device

reg  [7:0] Latched_Slave_Instruction;           // Latched value of the Slave Instruction
reg  [7:0] Latched_Reg_Address;                 // Latched value of the Register Address
reg  [7:0] Latched_Data;                        // Latched value of the Data

wire       Device_Selected;                     // To hold the value, of whether the Slave Device is selected or not

reg        Bit_Counter_Enable;                  // Enable the Bit Counter
reg  [3:0] Bit_Counter;                         // To track the number of bit to be sent or received



// --------------------------------------------------
// I2C Slave States
// --------------------------------------------------
localparam [3:0]    IDLE                        = 4'h0,
                    START                       = 4'h1,
                    READ_SLAVE_INSTRUCTION      = 4'h2,
                    SEND_SLAVE_INSTRUCTION_ACK  = 4'h3,
                    READ_ADDRESS                = 4'h4,
                    SEND_READ_ADDRESS_ACK       = 4'h5,
                    SEND_DATA                   = 4'h6,
                    READ_SEND_DATA_ACK         	= 4'h7,
                    READ_DATA                   = 4'h8,
                    SEND_READ_DATA_ACK          = 4'h9;


reg [3:0] S_Next_State, S_Present_State;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign SDA_Write_Enable = ((S_Present_State == SEND_SLAVE_INSTRUCTION_ACK) || 
                        (S_Present_State == SEND_READ_ADDRESS_ACK) || 
                        (S_Present_State == SEND_READ_DATA_ACK) || 
                        (S_Present_State == SEND_DATA))
                            ? 1'b1 : 1'b0;
assign I2C_SDA = (SDA_Write_Enable && Device_Selected) ? SDA_Data : 1'bZ;

assign Read_SDA = I2C_SDA;


assign S_Slave_Device_Address_Out = Send_Out_Slave_Instruction_Enable ? Latched_Slave_Instruction[7:1] : 7'bZ;
assign S_Read_Writeb_Out = Send_Out_Slave_Instruction_Enable ? Latched_Slave_Instruction[0] : 1'bZ;
assign S_Reg_Address_Out = Send_Out_Reg_Address_Enable ? Latched_Reg_Address : 8'bZ;

assign S_Data_Out = Send_Out_Data_Enable ? Latched_Data : 8'bZ;
assign S_Data_Read_Enable_Out = (S_Present_State == SEND_READ_DATA_ACK) ? 1'b1 : 1'b0;


assign I2C_Transaction_InProgress = S_Present_State == IDLE ? 1'b0 : 1'b1;

assign I2C_Start = ~I2C_Transaction_InProgress && Start_Detected;

assign Device_Selected = (DEVICE_ADDRESS == Latched_Slave_Instruction[7:1]) ? 1'b1 : 1'b0;

assign Send_Out_Slave_Instruction_Enable = (S_Present_State >= SEND_SLAVE_INSTRUCTION_ACK) ? 1'b1 : 1'b0;
assign Send_Out_Reg_Address_Enable = (S_Present_State >= SEND_READ_ADDRESS_ACK) ? 1'b1 : 1'b0;
assign Send_Out_Data_Enable = (S_Present_State >= SEND_READ_DATA_ACK) ? 1'b1 : 1'b0;

// --------------------------------------------------
// Start and Stop Detection
// --------------------------------------------------
// Start Bit Detection
always @ (negedge Read_SDA)
    begin
        NSDA_Latched_SCL_Value <= I2C_SCL;
    end

always @ (Reset_In or NSDA_Latched_SCL_Value or I2C_SCL or Read_SDA)
    begin
        if (Reset_In)
            begin
                Start_Detected <= 1'b0;
            end
        else if ((NSDA_Latched_SCL_Value == 1'b1) && (I2C_SCL == 1'b1) && (Read_SDA == 1'b0))
            begin
                Start_Detected <= 1'b1;
            end
        else
            begin
                Start_Detected <= 1'b0;
            end
    end


// Stop Bit Detection
always @ (posedge Read_SDA)
    begin
        PSDA_Latched_SCL_Value <= I2C_SCL;
    end

always @ (Reset_In or PSDA_Latched_SCL_Value or I2C_SCL or Read_SDA)
    begin
        if (Reset_In)
            begin
                Stop_Detected <= 1'b0;
            end
        else if ((PSDA_Latched_SCL_Value == 1'b1) && (I2C_SCL == 1'b1) && (Read_SDA == 1'b1))
            begin
                Stop_Detected <= 1'b1;
            end
        else
            begin
                Stop_Detected <= 1'b0;
            end
    end



// --------------------------------------------------
// Other modules
// --------------------------------------------------
// Bit Counter
always @ (negedge I2C_SCL or posedge Reset_In)
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


// Latching of Input Data
always @ (posedge I2C_SCL or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Latched_S_Data_In <= 8'b0;
            end
        else
            begin
                // Latch In Data
                if ((S_Present_State == READ_SLAVE_INSTRUCTION) || 
                    (S_Present_State == READ_SEND_DATA_ACK))
                    begin
                        Latched_S_Data_In <= S_Data_In;
                    end
                else
                    begin
                        Latched_S_Data_In <= Latched_S_Data_In;
                    end
            end
    end



// --------------------------------------------------
// Slave Read Logic
// --------------------------------------------------
// SDA Read SIPO
always @ (posedge I2C_SCL or posedge Reset_In)
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


// Latching of the data
always @ (negedge I2C_SCL or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Latched_Slave_Instruction <= 8'b0;
                Latched_Reg_Address <= 8'b0;
                Latched_Data <= 8'b0;
            end
        else if (S_Present_State == IDLE)
            begin
                Latched_Slave_Instruction <= 8'b0;
                Latched_Reg_Address <= 8'b0;
                Latched_Data <= 8'b0;
            end
        else
            begin
                // Latched_Slave_Instruction
                if (S_Next_State == SEND_SLAVE_INSTRUCTION_ACK)
                    begin
                        Latched_Slave_Instruction <= SDA_Read_SIPO;
                    end
                else
                    begin
                        Latched_Slave_Instruction <= Latched_Slave_Instruction;
                    end

                // Latched_Reg_Address
                if (S_Next_State == SEND_READ_ADDRESS_ACK)
                    begin
                        Latched_Reg_Address <= SDA_Read_SIPO;
                    end
                else
                    begin
                        Latched_Reg_Address <= Latched_Reg_Address;
                    end

                // Latched_Data
                if (S_Next_State == SEND_READ_DATA_ACK)
                    begin
                        Latched_Data <= SDA_Read_SIPO;
                    end
                else
                    begin
                        Latched_Data <= Latched_Data;
                    end
            end
    end



// --------------------------------------------------
// I2C Slave Logic
// --------------------------------------------------
always @ (negedge I2C_SCL or posedge Reset_In or posedge I2C_Start or posedge Stop_Detected)
    begin
        if (Reset_In)
            begin
                S_Present_State <= IDLE;
            end
        else if (I2C_Start)
            begin
                S_Present_State <= START;
            end
        else if (Stop_Detected)
            begin
                S_Present_State <= IDLE;
            end
        else
            begin
                S_Present_State <= S_Next_State;
            end
    end


always @ (I2C_SCL or S_Present_State or Bit_Counter or Device_Selected or Latched_Slave_Instruction or Latched_S_Data_In or Read_SDA)
    begin
        case (S_Present_State)
            IDLE                        : // 4'h0
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b0;

                    S_Next_State <= IDLE;
                end

            START                        : // 4'h1
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b0;

                    S_Next_State <= READ_SLAVE_INSTRUCTION;
                end

            READ_SLAVE_INSTRUCTION      : // 4'h2
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b1;

                    if (Bit_Counter == 4'd0)
                        begin
                            S_Next_State <= SEND_SLAVE_INSTRUCTION_ACK;
                        end
                    else
                        begin
                            S_Next_State <= READ_SLAVE_INSTRUCTION;
                        end
                end

            SEND_SLAVE_INSTRUCTION_ACK  : // 4'h3
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b0;

                    if (Device_Selected)
                        begin
                            if (~Latched_Slave_Instruction[0])
                                begin
                                    S_Next_State <= READ_ADDRESS;
                                end
                            else
                                begin
                                    S_Next_State <= SEND_DATA;
                                end
                        end
                    else
                        begin
                            S_Next_State <= IDLE;
                        end
                end

            READ_ADDRESS                : // 4'h4
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b1;

                    if (Bit_Counter == 4'd0)
                        begin
                            S_Next_State <= SEND_READ_ADDRESS_ACK;
                        end
                    else
                        begin
                            S_Next_State <= READ_ADDRESS;
                        end
                end

            SEND_READ_ADDRESS_ACK       : // 4'h5
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b0;

                    S_Next_State <= READ_DATA;
                end

            SEND_DATA                   : // 4'h6
                begin
                    SDA_Data <= Latched_S_Data_In[Bit_Counter];
                    
                    Bit_Counter_Enable <= 1'b1;

                    if (Bit_Counter == 4'd0)
                        begin
                            S_Next_State <= READ_SEND_DATA_ACK;
                        end
                    else
                        begin
                            S_Next_State <= SEND_DATA;
                        end
                end

            READ_SEND_DATA_ACK         	: // 4'h7
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b0;

                    if (I2C_SCL)
                        begin
                            if (~Read_SDA)
                                begin
                                    S_Next_State <= SEND_DATA;
                                end
                            else
                                begin
                                    S_Next_State <= IDLE;
                                end
                        end
                    else
                        begin
                            S_Next_State <= READ_SEND_DATA_ACK;
                        end
                end

            READ_DATA                   : // 4'h8
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b1;

                    if (Bit_Counter == 4'd0)
                        begin
                            S_Next_State <= SEND_READ_DATA_ACK;
                        end
                    else
                        begin
                            S_Next_State <= READ_DATA;
                        end
                end

            SEND_READ_DATA_ACK          : // 4'h9
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b0;

                    S_Next_State <= READ_DATA;
                end

            default: 
                begin
                    SDA_Data <= 1'b0;
                    
                    Bit_Counter_Enable <= 1'b0;

                    S_Next_State <= IDLE;
                end
        endcase
    end



endmodule