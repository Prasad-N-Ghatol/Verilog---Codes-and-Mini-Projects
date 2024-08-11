/*
Testbench for UART



Author : Prasad Narayan Ghatol
*/



`timescale 1ns/1ps

module UART_tb #(parameter SYS_CLOCK = 100_000_000) ();



// --------------------------------------------------
// wire and reg declaration
// --------------------------------------------------
wire       UART_TX;
wire       UART_RX;

reg        Clk_In;
reg        Reset_In;

wire       TX_UART_Clk_Out;
wire       RX_UART_Clk_Out;

reg  [2:0] UART_Baud_Rate_Mode_In;

reg  [2:0] UART_Num_Data_Bits_In;
reg        UART_Parity_Enable_In;
reg        UART_Even_Oddb_Parity_In;
reg        UART_Num_Stop_Bits_In;

reg        Device_0_Start_Signal_In;
reg  [8:0] Device_0_Data_In;
wire [8:0] Device_0_Data_Out;
wire       Device_0_Data_Read_Enable_Out;
wire       Device_0_TX_Busy_Indicator;
wire       Device_0_RX_Busy_Indicator;

reg        Device_1_Start_Signal_In;
reg  [8:0] Device_1_Data_In;
wire [8:0] Device_1_Data_Out;
wire       Device_1_Data_Read_Enable_Out;
wire       Device_1_TX_Busy_Indicator;
wire       Device_1_RX_Busy_Indicator;



// --------------------------------------------------
// DUT Instantiation
// --------------------------------------------------
UART #(.SYS_CLOCK(100_000_000)) DUT (
    .UART_TX(UART_TX),
    .UART_RX(UART_RX),

    .Clk_In(Clk_In),
    .Reset_In(Reset_In),

    .TX_UART_Clk_Out(TX_UART_Clk_Out),
    .RX_UART_Clk_Out(RX_UART_Clk_Out),

    .UART_Baud_Rate_Mode_In(UART_Baud_Rate_Mode_In),

    .UART_Num_Data_Bits_In(UART_Num_Data_Bits_In),
    .UART_Parity_Enable_In(UART_Parity_Enable_In),
    .UART_Even_Oddb_Parity_In(UART_Even_Oddb_Parity_In),
    .UART_Num_Stop_Bits_In(UART_Num_Stop_Bits_In),

    .Device_0_Start_Signal_In(Device_0_Start_Signal_In),
    .Device_0_Data_In(Device_0_Data_In),
    .Device_0_Data_Out(Device_0_Data_Out),
    .Device_0_Data_Read_Enable_Out(Device_0_Data_Read_Enable_Out),
    .Device_0_TX_Busy_Indicator(Device_0_TX_Busy_Indicator),
    .Device_0_RX_Busy_Indicator(Device_0_RX_Busy_Indicator),

    .Device_1_Start_Signal_In(Device_1_Start_Signal_In),
    .Device_1_Data_In(Device_1_Data_In),
    .Device_1_Data_Out(Device_1_Data_Out),
    .Device_1_Data_Read_Enable_Out(Device_1_Data_Read_Enable_Out),
    .Device_1_TX_Busy_Indicator(Device_1_TX_Busy_Indicator),
    .Device_1_RX_Busy_Indicator(Device_1_RX_Busy_Indicator)
);



// --------------------------------------------------
// Constants Declaration
// --------------------------------------------------
localparam [2:0]    B_4800   = 3'b000, // Tb Delay = 3125000
                    B_9600   = 3'b001, // Tb Delay = 1562500
                    B_19200  = 3'b010, // Tb Delay = 781250
                    B_38400  = 3'b011, // Tb Delay = 390625
                    B_57600  = 3'b100, // Tb Delay = 260417
                    B_115200 = 3'b101; // Tb Delay = 130208


localparam [2:0]    DATA_BITS_5 = 3'b000,
                    DATA_BITS_6 = 3'b001,
                    DATA_BITS_7 = 3'b010,
                    DATA_BITS_8 = 3'b011,
                    DATA_BITS_9 = 3'b100;



// --------------------------------------------------
// Clock Initialization
// --------------------------------------------------
initial
begin
    Clk_In = 1'b0;
    
    forever
    begin
        #5;
        Clk_In = ~Clk_In;
    end
end



// --------------------------------------------------
// UART_Data_Transaction Task for to provide Test Data Input to the DUT
// --------------------------------------------------
task UART_Data_Transaction(input bit [2:0] UART_Mode, int delay);
    UART_Baud_Rate_Mode_In = UART_Mode;

    UART_Num_Data_Bits_In = $urandom_range(0, 4);
    UART_Parity_Enable_In = $random;
    UART_Even_Oddb_Parity_In = $random;
    UART_Num_Stop_Bits_In = $random;

    Device_0_Data_In = $random;
    Device_1_Data_In = $random;

    Device_0_Start_Signal_In = 1'b1;

    #(delay/5);

    Device_0_Start_Signal_In = 1'b0;

    Device_1_Start_Signal_In = 1'b1;

    #(delay/5);

    Device_1_Start_Signal_In = 1'b0;

    #(delay);
endtask


// --------------------------------------------------
// Run the Input Tests
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        // Baud Rate : 4800
        UART_Data_Transaction(B_4800, 3125000);

        // Baud Rate : 9600
        UART_Data_Transaction(B_9600, 1562500);

        // Baud Rate : 19200
        UART_Data_Transaction(B_19200, 781250);

        // Baud Rate : 38400
        UART_Data_Transaction(B_38400, 390625);

        // Baud Rate : 57600
        UART_Data_Transaction(B_57600, 260417);

        // Baud Rate : 115200
        UART_Data_Transaction(B_115200, 130208);

        $stop;
    end



endmodule