/*
**************************************************
    Look Ahead Carry Generator - 32-Bit - Testbench
**************************************************

This is a SystemVerilog Testbench code, for the 32-Bit Look Ahead Carry Generator.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Look_Ahead_Carry_Generator_32_Bit_tb ();



reg  [31:0] Data_A_In;
reg  [31:0] Data_B_In;
reg         Carry_In;

wire [31:0] Sum_Out;
wire        Carry_Out;



// --------------------------------------------------
// Look Ahead Carry Generator - 32-Bit DUT Instantiation
// --------------------------------------------------
Look_Ahead_Carry_Generator_32_Bit DUT (
    .Data_A_In(Data_A_In),
    .Data_B_In(Data_B_In),
    .Carry_In(Carry_In),
    .Sum_Out(Sum_Out),
    .Carry_Out(Carry_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        repeat(20)
            begin
                Data_A_In = $random;
                Data_B_In = $random;
                Carry_In = $random;
                #10;
            end

        $stop;
    end



endmodule