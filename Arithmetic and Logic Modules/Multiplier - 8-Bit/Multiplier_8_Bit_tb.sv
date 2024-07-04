/*
**************************************************
        Multiplier - 8-Bit - Testbench
**************************************************

This is a SystemVerilog Testbench code, for the 8-Bit Multiplier.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Multiplier_8_Bit_tb ();



reg  [7:0]  Data_A_In;
reg  [7:0]  Data_B_In;
wire [15:0] Multiplied_Result_Out;



// --------------------------------------------------
// Multiplier - 8-Bit DUT Instantiation
// --------------------------------------------------
Multiplier_8_Bit DUT (
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