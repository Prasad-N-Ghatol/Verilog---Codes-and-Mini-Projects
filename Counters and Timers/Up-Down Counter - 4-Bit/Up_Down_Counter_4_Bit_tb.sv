/*
SystemVerilog Testbench for the 4-Bit Up-Down Counter.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Up_Down_Counter_4_Bit_tb ();


reg        Clk_In;
reg        Reset_In;

reg        Start_Stopb_In;
reg        Up_Downb_In;
wire [3:0] Count_Out;



// --------------------------------------------------
// 4-Bit Up-Down Counter DUT Instantiation
// --------------------------------------------------
Up_Down_Counter_4_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Start_Stopb_In(Start_Stopb_In),
    .Up_Downb_In(Up_Downb_In),
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

        Up_Downb_In = 1'b1;
        #100;

        Up_Downb_In = 1'b0;
        #150;

        Up_Downb_In = 1'b1;
        #50;

        $stop;
    end



endmodule