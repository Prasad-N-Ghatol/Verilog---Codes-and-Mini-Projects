/*
Verilog Code for Baud Rate Generator



This Design has an input Clock Frequency of 100 MHz.
The Baud_Rate_Generator module, will adjust the input clock frequency, to meet the required frequency needed for UART Communication.

This design supports for 16 times over sampling for the receiver side.



Supported Baud Rates : 4800, 9600, 19200, 38400, 57600, 115200.



Author : Prasad Narayan Ghatol
*/



module Baud_Rate_Generator
#(parameter SYS_CLOCK = 100_000_000)
(
    input       Clk_In,
    input       Reset_In,

    input [2:0] UART_Baud_Rate_Mode_In, // Select the Baud Rate for the Communication

    output      TX_UART_Clk_Out,        // TX Clock for the UART Data Transfer
    output      RX_UART_Clk_Out         // RX Clock for the UART Data Transfer
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg  [31:0] Baud_Rate;
wire [31:0] BAUD_COUNTER_VALUE;

reg  [31:0] RX_Counter;
reg  [3:0]  TX_Count_Divider;

reg Baud_Clk;



// --------------------------------------------------
// Baud Rate Value Decoder
// --------------------------------------------------
always @ (UART_Baud_Rate_Mode_In)
    begin
        case (UART_Baud_Rate_Mode_In)
            3'b000 : // Baud Rate = 4800
                begin
                    Baud_Rate <= 32'd4800;
                end
            3'b001 : // Baud Rate = 9600
                begin
                    Baud_Rate <= 32'd9600;
                end
            3'b010 : // Baud Rate = 19200
                begin
                    Baud_Rate <= 32'd19200;
                end
            3'b011 : // Baud Rate = 38400
                begin
                    Baud_Rate <= 32'd38400;
                end
            3'b100 : // Baud Rate = 57600
                begin
                    Baud_Rate <= 32'd57600;
                end
            3'b101 : // Baud Rate = 115200
                begin
                    Baud_Rate <= 32'd115200;
                end
            default : // Baud Rate = 115200
                begin
                    Baud_Rate <= 32'd115200;
                end
        endcase
    end



// --------------------------------------------------
// Assignment Statements
// --------------------------------------------------
assign BAUD_COUNTER_VALUE = SYS_CLOCK / (2 * 16 * Baud_Rate);

assign TX_UART_Clk_Out = TX_Count_Divider[3];
assign RX_UART_Clk_Out = Baud_Clk;



// --------------------------------------------------
// Divide RX CLock by 16, for TX Clock
// 8 cycle for ON and OFF Period of the Clock respectively, for a Duty Cycle of 50%.
// --------------------------------------------------
always @ (negedge Baud_Clk or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                TX_Count_Divider <= 4'b0;
            end
        else
            begin
                TX_Count_Divider <= TX_Count_Divider + 1'b1;
            end
    end



// --------------------------------------------------
// Logic to generate the required RX Clock, from the Input Clock.
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                RX_Counter <= 32'b0;
                Baud_Clk <= 1'b0;
            end
        else
            begin
                if (RX_Counter >= BAUD_COUNTER_VALUE)
                    begin
                        Baud_Clk <= Baud_Clk + 1'b1;
                        RX_Counter <= 32'b0;
                    end
                else
                    begin
                        RX_Counter <= RX_Counter + 1'b1;
                        Baud_Clk <= Baud_Clk;
                    end
            end
    end



endmodule