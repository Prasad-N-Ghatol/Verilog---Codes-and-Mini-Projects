/*
SystemVerilog Testbench for the Decade Counter.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Decade_Counter_tb ();


reg        Clk_In;
reg        Reset_In;

reg        Start_Stopb_In;
wire [3:0] Count_Out;



// --------------------------------------------------
// Decade Counter DUT Instantiation
// --------------------------------------------------
Decade_Counter DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Start_Stopb_In(Start_Stopb_In),
    .Count_Out(Count_Out)
);



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
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        Start_Stopb_In = 1'b1;
        #150;

        $stop;
    end



endmodule