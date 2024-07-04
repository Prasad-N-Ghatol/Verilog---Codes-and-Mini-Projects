/*
**************************************************
        Multiplier - 2-Bit - Testbench
**************************************************

This is a SystemVerilog Testbench code, for the 2-Bit Multiplier.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Multiplier_2_Bit_tb ();



reg  [1:0] Data_A_In;
reg  [1:0] Data_B_In;
wire [3:0] Multiplied_Result_Out;



// --------------------------------------------------
// Multiplier - 2-Bit DUT Instantiation
// --------------------------------------------------
Multiplier_2_Bit DUT (
    .Data_A_In(Data_A_In),
    .Data_B_In(Data_B_In),
    .Multiplied_Result_Out(Multiplied_Result_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        repeat (10)
            begin
                Data_A_In = $random;
                Data_B_In = $random;
                #10;
            end

        $stop;
    end



endmodule