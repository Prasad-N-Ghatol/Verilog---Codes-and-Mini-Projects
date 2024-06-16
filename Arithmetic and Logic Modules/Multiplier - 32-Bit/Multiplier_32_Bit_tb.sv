/*
SystemVerilog Testbench for the Multiplier - 32-Bit.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Multiplier_32_Bit_tb ();



reg  [31:0] Data_A_In;
reg  [31:0] Data_B_In;
wire [63:0] Multiplied_Result_Out;



// --------------------------------------------------
// Multiplier - 32-Bit DUT Instantiation
// --------------------------------------------------
Multiplier_32_Bit DUT (
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