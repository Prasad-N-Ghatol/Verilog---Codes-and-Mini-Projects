/*
Verilog Code for UART Device



Full UART Frame : 

|   St  | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | D8 |   Pb   | Sp0 | Sp1 |
| Start |                    Data                    | Parity |    Stop   |
|  bit  |                    bits                    |  bit   |    bits   |



Operating Modes Supported in this Design :

Baud Rates : 4800, 9600, 19200, 38400, 57600, 115200.

Data Bit Length : 5, 6, 7, 8, 9 bits.

Parity : Enable, Disable.
Parity Type : Even, Odd.

Number of Stop bits : 1, 2 bits.



Author : Prasad Narayan Ghatol
*/



module UART_Device(
    // UART Lines for communication
    output           UART_TX,
    input            UART_RX,

    // Design and UART Control Signals
    input            Reset_In,

    input            TX_UART_Clk_In,            // TX Clock for the UART Data Transfer
    input            RX_UART_Clk_In,            // RX Clock for the UART Data Transfer

    input  [2:0]     UART_Num_Data_Bits_In,     // Length of the data in bits
    input            UART_Parity_Enable_In,     // Send the Parity bit or not (0 = Disable , 1 = Enable)
    input            UART_Even_Oddb_Parity_In,  // Send Even or Odd Parity (0 = Odd Parity , 1 = Even Parity)
    input            UART_Num_Stop_Bits_In,     // Number of Stop Bits to Send (0 = 1 Stop bit , 1 = 2 Stop bits)

    // Device Signals
    input            Start_Signal_In,           // Signal to Start the Data Transfer
    input  [8:0]     Data_In,                   // Data to be sent on the TX
    output [8:0]     Data_Out,                  // Data Received from RX
    output           Data_Read_Enable_Out       // Enable Signal to read the Data on Data_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg  [3:0] UART_Data_Len;


reg        TX_Write_Enable;
reg        UART_TX_Data;
reg        TX_Parity_Bit;
reg  [3:0] TX_Data_Counter;
reg  [1:0] TX_Stop_bit_Counter;


reg        RX_Start_Detect;
wire       UART_RX_Data;
reg        RX_Stop_Bit_Count_Enable;
reg  [1:0] RX_Stop_Bit_Counter;
reg  [3:0] RX_Data_Counter;
reg        RX_Data_Send_Enable;
reg        RX_Calc_Parity_Bit;
reg        RX_8_Count_Enable;
reg  [2:0] RX_8_Clocks_Counter;
reg        RX_16_Count_Enable;
reg  [3:0] RX_16_Clocks_Counter;
reg        RX_Soft_Reset;
reg        RX_SIPO_Enable;
reg  [8:0] SIPO_RX_Data;


reg [2:0] RX_State, TX_State;



// --------------------------------------------------
// Parameters
// --------------------------------------------------
localparam [2:0]    S_IDLE   = 3'd0,
                    S_START  = 3'd1,
                    S_DATA   = 3'd2,
                    S_PARITY = 3'd3,
                    S_STOP   = 3'd4;


localparam [2:0]    DATA_BITS_5 = 3'd0,
                    DATA_BITS_6 = 3'd1,
                    DATA_BITS_7 = 3'd2,
                    DATA_BITS_8 = 3'd3,
                    DATA_BITS_9 = 3'd4;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign UART_TX = TX_Write_Enable ? UART_TX_Data : 1'b1;

assign UART_RX_Data = UART_RX;

assign Data_Out = RX_Data_Send_Enable ? SIPO_RX_Data : 9'bZ;

assign Data_Read_Enable_Out = RX_Data_Send_Enable;



// --------------------------------------------------
// Data Bit Length Decoder
// --------------------------------------------------
always @ (UART_Num_Data_Bits_In)
    begin
        if (UART_Num_Data_Bits_In == DATA_BITS_5)
            UART_Data_Len = 4'd5;
        else if (UART_Num_Data_Bits_In == DATA_BITS_6)
            UART_Data_Len = 4'd6;
        else if (UART_Num_Data_Bits_In == DATA_BITS_7)
            UART_Data_Len = 4'd7;
        else if (UART_Num_Data_Bits_In == DATA_BITS_8)
            UART_Data_Len = 4'd8;
        else if (UART_Num_Data_Bits_In == DATA_BITS_9)
            UART_Data_Len = 4'd9;
        else
            UART_Data_Len = 4'd8;
    end



// --------------------------------------------------
// UART TX Part
// --------------------------------------------------
always @ (negedge TX_UART_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                TX_Write_Enable <= 1'b0;
                UART_TX_Data <= 1'b1;
                TX_Data_Counter <= 4'b0;

                TX_Stop_bit_Counter <= 2'b0;

                TX_Parity_Bit <= 1'b0;

                TX_State <= S_IDLE;
            end
        else
            begin
            case (TX_State)
                    S_IDLE :
                        begin
                            TX_Write_Enable <= 1'b0;
                            UART_TX_Data <= 1'b1;
                            TX_Data_Counter <= 4'b0;

                            TX_Stop_bit_Counter <= 2'b0;

                            TX_Parity_Bit <= 1'b0;

                            if (Start_Signal_In)
                                begin
                                    TX_State <= S_START;
                                end
                            else
                                begin
                                    TX_State <= S_IDLE;
                                end
                        end
                    S_START :
                        begin
                            TX_Write_Enable <= 1'b1;
                            UART_TX_Data <= 1'b0;
                            TX_Data_Counter <= 4'b0;

                            TX_Stop_bit_Counter <= 2'b0;

                            TX_Parity_Bit <= 1'b0;

                            TX_State <= S_DATA;
                        end
                    S_DATA :
                        begin
                            TX_Write_Enable <= 1'b1;
                            UART_TX_Data <= Data_In[TX_Data_Counter];
                            TX_Data_Counter <= TX_Data_Counter + 1'b1;

                            TX_Stop_bit_Counter <= 2'b0;

                            TX_Parity_Bit <= TX_Parity_Bit ^ Data_In[TX_Data_Counter];

                            if (TX_Data_Counter == (UART_Data_Len-1'b1))
                                begin
                                    if (UART_Parity_Enable_In)
                                        begin
                                            TX_State <= S_PARITY;
                                        end
                                    else
                                        begin
                                            TX_State <= S_STOP;
                                        end
                                end
                            else
                                begin
                                    TX_State <= S_DATA;
                                end
                        end
                    S_PARITY :
                        begin
                            TX_Write_Enable <= 1'b1;
                            TX_Data_Counter <= 4'b0;

                            TX_Stop_bit_Counter <= 2'b0;

                            TX_Parity_Bit <= TX_Parity_Bit;

                            if(UART_Even_Oddb_Parity_In)
                                begin
                                    UART_TX_Data <= TX_Parity_Bit;
                                end
                            else
                                begin
                                    UART_TX_Data <= ~TX_Parity_Bit;
                                end

                            TX_State <= S_STOP;
                        end
                    S_STOP :
                        begin
                            TX_Write_Enable <= 1'b1;
                            UART_TX_Data <= 1'b1;
                            TX_Data_Counter <= 4'b0;

                            TX_Stop_bit_Counter <= TX_Stop_bit_Counter + 1'b1;

                            TX_Parity_Bit <= 1'b0;

                            if (UART_Num_Stop_Bits_In == TX_Stop_bit_Counter)
                                begin
                                    TX_State <= S_IDLE;
                                end
                            else
                                begin
                                    TX_State <= S_STOP;
                                end
                        end
                    default : 
                        begin
                            TX_Write_Enable <= 1'b0;
                            UART_TX_Data <= 1'b1;
                            TX_Data_Counter <= 4'b0;

                            TX_Stop_bit_Counter <= 2'b0;

                            TX_Parity_Bit <= 1'b0;

                            TX_State <= S_IDLE;
                        end
                endcase
            end
    end



// --------------------------------------------------
// UART RX Part
// --------------------------------------------------
// 8 Clock Cycles Counter
always @ (negedge RX_UART_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                RX_8_Clocks_Counter <= 3'b0;
            end
        else if (RX_8_Count_Enable)
            begin
                RX_8_Clocks_Counter <= RX_8_Clocks_Counter + 1'b1;
            end
        else
            begin
                RX_8_Clocks_Counter <= 3'b0;
            end
    end

// 16 Clock Cycles Counter
always @ (negedge RX_UART_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                RX_16_Clocks_Counter <= 4'b0;
            end
        else if (RX_16_Count_Enable)
            begin
                RX_16_Clocks_Counter <= RX_16_Clocks_Counter + 1'b1;
            end
        else
            begin
                RX_16_Clocks_Counter <= 4'b0;
            end
    end

// Stop Bit Counter
always @ (negedge RX_UART_Clk_In or posedge Reset_In or posedge RX_Soft_Reset)
    begin
        if (Reset_In || RX_Soft_Reset)
            begin
                RX_Stop_Bit_Counter <= 2'b0;
            end
        else if (RX_Stop_Bit_Count_Enable)
            begin
                RX_Stop_Bit_Counter <= RX_Stop_Bit_Counter + 1'b1;
            end
        else
            begin
                RX_Stop_Bit_Counter <= RX_Stop_Bit_Counter;
            end
    end

// RX SPIO
always @ (negedge RX_UART_Clk_In or posedge Reset_In or posedge RX_Soft_Reset)
    begin
        if (Reset_In || RX_Soft_Reset)
            begin
                SIPO_RX_Data <= 9'b0;
                RX_Data_Counter <= 4'b0;
            end
        else if (RX_SIPO_Enable)
            begin
                RX_Data_Counter <= RX_Data_Counter + 1'b1;

                SIPO_RX_Data[RX_Data_Counter] <= UART_RX_Data;

                RX_Calc_Parity_Bit <= RX_Calc_Parity_Bit ^ UART_RX_Data;
            end
        else
            begin
                SIPO_RX_Data <= SIPO_RX_Data;
                RX_Data_Counter <= RX_Data_Counter;
            end
    end

// RX Start Detect
always @ (negedge RX_UART_Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                RX_Start_Detect <= 1'b0;
            end
        else if ((UART_RX_Data == 1'b0) && (RX_State == S_IDLE))
            begin
                RX_Start_Detect <= 1'b1;
            end
        else if (RX_State == S_STOP)
            begin
                RX_Start_Detect <= 1'b0;
            end
        else
            begin
                RX_Start_Detect <= RX_Start_Detect;
            end
    end

// RX Logic
always @ (negedge RX_UART_Clk_In or posedge Reset_In or posedge RX_Start_Detect)
    begin
        if (Reset_In)
            begin
                RX_Data_Send_Enable <= 1'b0;

                RX_Stop_Bit_Count_Enable <= 1'b0;

                RX_Soft_Reset <= 1'b1;
                RX_SIPO_Enable <= 1'b0;

                RX_8_Count_Enable <= 1'b0;
                RX_16_Count_Enable <= 1'b0;

                RX_State <= S_IDLE;
            end
        else
            begin
                case (RX_State)
                    S_IDLE :
                        begin
                            RX_Data_Send_Enable <= 1'b0;

                            RX_Soft_Reset <= 1'b1;
                            RX_SIPO_Enable <= 1'b0;

                            RX_Stop_Bit_Count_Enable <= 1'b0;

                            RX_8_Count_Enable <= 1'b0;
                            RX_16_Count_Enable <= 1'b0;

                            if (RX_Start_Detect)
                                begin
                                    RX_State <= S_START;
                                end
                            else
                                begin
                                    RX_State <= S_IDLE;
                                end
                        end
                    S_START :
                        begin
                            RX_Data_Send_Enable <= 1'b0;

                            RX_Soft_Reset <= 1'b0;
                            RX_SIPO_Enable <= 1'b0;

                            RX_Stop_Bit_Count_Enable <= 1'b0;

                            RX_8_Count_Enable <= 1'b1;
                            RX_16_Count_Enable <= 1'b0;

                            if (RX_8_Clocks_Counter == 3'd7)
                                begin
                                    if (UART_RX_Data == 1'b0)
                                        begin
                                            RX_State <= S_DATA;
                                        end
                                    else
                                        begin
                                            RX_State <= S_IDLE;
                                        end
                                end
                            else
                                begin
                                    RX_State <= S_START;
                                end
                        end
                    S_DATA :
                        begin
                            RX_Data_Send_Enable <= 1'b0;

                            RX_Stop_Bit_Count_Enable <= 1'b0;

                            RX_Soft_Reset <= 1'b0;

                            RX_8_Count_Enable <= 1'b0;
                            RX_16_Count_Enable <= 1'b1;

                            if (RX_16_Clocks_Counter == 4'd15)
                                begin
                                    RX_SIPO_Enable <= 1'b1;

                                    if (RX_Data_Counter  == (UART_Data_Len-1'b1))
                                        begin
                                            if (UART_Parity_Enable_In)
                                                begin
                                                    RX_State <= S_PARITY;
                                                end
                                            else
                                                begin
                                                    RX_State <= S_STOP;
                                                end
                                        end
                                    else
                                        begin
                                            RX_State <= S_DATA;
                                        end
                                end
                            else
                                begin
                                    RX_SIPO_Enable <= 1'b0;

                                    RX_State <= S_DATA;
                                end
                        end
                    S_PARITY :
                        begin
                            RX_Stop_Bit_Count_Enable <= 1'b0;

                            RX_Soft_Reset <= 1'b0;
                            RX_SIPO_Enable <= 1'b0;

                            RX_8_Count_Enable <= 1'b0;
                            RX_16_Count_Enable <= 1'b1;

                            RX_Data_Send_Enable <= 1'b1;

                            if (RX_16_Clocks_Counter == 4'd15)
                                begin
                                    RX_State <= S_STOP;
                                end
                            else
                                begin
                                    RX_State <= S_PARITY;
                                end
                        end
                    S_STOP :
                        begin
                            RX_Data_Send_Enable <= 1'b1;

                            RX_Soft_Reset <= 1'b0;
                            RX_SIPO_Enable <= 1'b0;

                            RX_8_Count_Enable <= 1'b0;
                            RX_16_Count_Enable <= 1'b1;


                            if (RX_16_Clocks_Counter == 4'd15)
                                begin
                                    RX_Stop_Bit_Count_Enable <= 1'b1;
                                    
                                    if (UART_Num_Stop_Bits_In == RX_Stop_Bit_Counter)
                                        begin
                                            RX_State <= S_IDLE;
                                        end
                                    else
                                        begin
                                            RX_State <= S_STOP;
                                        end
                                end
                            else
                                begin
                                    RX_Stop_Bit_Count_Enable <= 1'b0;

                                    RX_State <= S_STOP;
                                end
                        end
                    default :
                        begin
                            RX_Data_Send_Enable <= 1'b0;

                            RX_Soft_Reset <= 1'b1;
                            RX_SIPO_Enable <= 1'b0;

                            RX_Stop_Bit_Count_Enable <= 1'b0;

                            RX_8_Count_Enable <= 1'b0;
                            RX_16_Count_Enable <= 1'b0;

                            RX_State <= S_IDLE;
                        end
                endcase
            end
    end



endmodule