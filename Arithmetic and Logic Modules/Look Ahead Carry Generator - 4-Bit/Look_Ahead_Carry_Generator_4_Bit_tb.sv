/*
SystemVerilog Testbench for the Look Ahead Carry Generator - 4-Bit.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Look_Ahead_Carry_Generator_4_Bit_tb ();



reg  [3:0] Data_A_In;
reg  [3:0] Data_B_In;
reg        Carry_In;

wire [3:0] Sum_Out;
wire       Carry_Out;



// --------------------------------------------------
// Look Ahead Carry Generator - 4-Bit DUT Instantiation
// --------------------------------------------------
Look_Ahead_Carry_Generator_4_Bit DUT (
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
        repeat(10)
            begin
                Data_A_In = $random;
                Data_B_In = $random;
                Carry_In = $random;
                #10;
            end

        $stop;
    end



endmodule