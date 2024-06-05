/*
SystemVerilog Testbench for the 4-Bit MOD Counter.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module MOD_Counter_4_Bit_tb ();


reg        Clk_In;
reg        Reset_In;

reg        Start_Stopb_In;
reg  [3:0] MOD_Value_In;
wire [3:0] Count_Out;



// --------------------------------------------------
// 4-Bit MOD Counter DUT Instantiation
// --------------------------------------------------
MOD_Counter_4_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Start_Stopb_In(Start_Stopb_In),
    .MOD_Value_In(MOD_Value_In),
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

        repeat (4)
            begin
                MOD_Value_In = $random;
                Start_Stopb_In = 1'b1;
                #200;

                Start_Stopb_In = 1'b0;
                Reset_In = 1'b1;
                #10;
                Reset_In = 1'b0;
            end

        $stop;
    end



endmodule