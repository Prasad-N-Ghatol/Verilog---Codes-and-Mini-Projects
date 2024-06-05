/*
SystemVerilog Testbench for the 4-Bit Gray Counter.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Gray_Counter_4_Bit_tb ();


reg        Clk_In;
reg        Reset_In;

reg        Start_Stopb_In;
wire [3:0] Gray_Count_Out;



// --------------------------------------------------
// 4-Bit Gray Counter DUT Instantiation
// --------------------------------------------------
Gray_Counter_4_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Start_Stopb_In(Start_Stopb_In),
    .Gray_Count_Out(Gray_Count_Out)
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
        #250;

        $stop;
    end



endmodule