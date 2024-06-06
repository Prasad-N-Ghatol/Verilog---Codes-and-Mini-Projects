/*
SystemVerilog Testbench for the Comparator - 2-Bit.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Comparator_2_Bit_tb ();


reg        Reset_In;

reg  [1:0] Data_A_In;
reg  [1:0] Data_B_In;
wire       A_Less_Than_B_Out;
wire       A_Equal_To_B_Out;
wire       A_Greater_Than_B_Out;



// --------------------------------------------------
// Comparator - 2-Bit DUT Instantiation
// --------------------------------------------------
Comparator_2_Bit DUT (
    .Reset_In(Reset_In),
    .Data_A_In(Data_A_In),
    .Data_B_In(Data_B_In),
    .A_Less_Than_B_Out(A_Less_Than_B_Out),
    .A_Equal_To_B_Out(A_Equal_To_B_Out),
    .A_Greater_Than_B_Out(A_Greater_Than_B_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        repeat (10)
            begin
                Data_A_In = $random;
                Data_B_In = $random;
                #10;
            end

        $stop;
    end



endmodule