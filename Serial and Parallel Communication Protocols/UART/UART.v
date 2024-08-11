/*
Verilog Code to implement UART Protocol.



Operating Modes Supported in this Design :

Baud Rates : 4800, 9600, 19200, 38400, 57600, 115200.

Data Bit Length : 5, 6, 7, 8, 9 bits.

Parity : Enable, Disable.
Parity Type : Even, Odd.

Number of Stop bits : 1, 2 bits.



In this Code, 2 Devices are available for communication.



Author : Prasad Narayan Ghatol
*/



module UART 
#(parameter SYS_CLOCK = 100_000_000)
(
    // UART Lines for communication
    output       UART_TX,
    output       UART_RX,

    // Design and UART Control Signals
    input        Clk_In,
    input        Reset_In,

    output       TX_UART_Clk_Out,               // TX Clock for the UART Data Transfer
    output       RX_UART_Clk_Out,               // RX Clock for the UART Data Transfer

    input  [2:0] UART_Baud_Rate_Mode_In,        // Select the Baud Rate for the Communication

    input  [2:0] UART_Num_Data_Bits_In,         // Length of the data in bits
    input        UART_Parity_Enable_In,         // Send the Parity bit or not (0 = Disable , 1 = Enable)
    input        UART_Even_Oddb_Parity_In,      // Send Even or Odd Parity (0 = Odd Parity , 1 = Even Parity)
    input        UART_Num_Stop_Bits_In,         // Number of Stop Bits to Send (0 = 1 Stop bit , 1 = 2 Stop bits)
    
    // Device 0 Signals
    input        Device_0_Start_Signal_In,      // Signal to Start the Data Transfer
    input  [8:0] Device_0_Data_In,              // Data to be sent on the TX
    output [8:0] Device_0_Data_Out,             // Data Received from RX
    output       Device_0_Data_Read_Enable_Out, // Enable Signal to read the Data on Data_Out
    output       Device_0_TX_Busy_Indicator,    // Indicator to specify, if the TX is in progress or not
    output       Device_0_RX_Busy_Indicator,    // Indicator to specify, if the RX is in progress or not

    // Device 1 Signals
    input        Device_1_Start_Signal_In,      // Signal to Start the Data Transfer
    input  [8:0] Device_1_Data_In,              // Data to be sent on the TX
    output [8:0] Device_1_Data_Out,             // Data Received from RX
    output       Device_1_Data_Read_Enable_Out, // Enable Signal to read the Data on Data_Out
    output       Device_1_TX_Busy_Indicator,    // Indicator to specify, if the TX is in progress or not
    output       Device_1_RX_Busy_Indicator     // Indicator to specify, if the RX is in progress or not
);



// --------------------------------------------------
// Baud_Rate_Generator
// --------------------------------------------------
Baud_Rate_Generator #(.SYS_CLOCK(100_000_000)) BRG (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .UART_Baud_Rate_Mode_In(UART_Baud_Rate_Mode_In),
    .TX_UART_Clk_Out(TX_UART_Clk_Out),
    .RX_UART_Clk_Out(RX_UART_Clk_Out)
);



// --------------------------------------------------
// UART_Devices
// --------------------------------------------------
UART_Device Device_0 (
    .UART_TX(UART_TX),
    .UART_RX(UART_RX),

    .Reset_In(Reset_In),

    .UART_Num_Data_Bits_In(UART_Num_Data_Bits_In),
    .UART_Parity_Enable_In(UART_Parity_Enable_In),
    .UART_Even_Oddb_Parity_In(UART_Even_Oddb_Parity_In),
    .UART_Num_Stop_Bits_In(UART_Num_Stop_Bits_In),

    .Start_Signal_In(Device_0_Start_Signal_In),
    .Data_In(Device_0_Data_In),
    .Data_Out(Device_0_Data_Out),
    .Data_Read_Enable_Out(Device_0_Data_Read_Enable_Out),

    .TX_UART_Clk_In(TX_UART_Clk_Out),
    .RX_UART_Clk_In(RX_UART_Clk_Out),

    .TX_Busy_Indicator(Device_0_TX_Busy_Indicator),
    .RX_Busy_Indicator(Device_0_RX_Busy_Indicator)
);


UART_Device Device_1 (
    .UART_TX(UART_RX),
    .UART_RX(UART_TX),

    .Reset_In(Reset_In),

    .UART_Num_Data_Bits_In(UART_Num_Data_Bits_In),
    .UART_Parity_Enable_In(UART_Parity_Enable_In),
    .UART_Even_Oddb_Parity_In(UART_Even_Oddb_Parity_In),
    .UART_Num_Stop_Bits_In(UART_Num_Stop_Bits_In),

    .Start_Signal_In(Device_1_Start_Signal_In),
    .Data_In(Device_1_Data_In),
    .Data_Out(Device_1_Data_Out),
    .Data_Read_Enable_Out(Device_1_Data_Read_Enable_Out),

    .TX_UART_Clk_In(TX_UART_Clk_Out),
    .RX_UART_Clk_In(RX_UART_Clk_Out),

    .TX_Busy_Indicator(Device_1_TX_Busy_Indicator),
    .RX_Busy_Indicator(Device_1_RX_Busy_Indicator)
);



endmodule