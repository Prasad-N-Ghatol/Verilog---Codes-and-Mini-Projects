/*
SystemVerilog Testbench for the 2-4 Decoder.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Decoder_2_4_tb ();


reg        Reset_In;

reg  [1:0] Encoded_Value_In;
wire       Data_0_Out;
wire       Data_1_Out;
wire       Data_2_Out;
wire       Data_3_Out;



// --------------------------------------------------
// 2-4 Decoder DUT Instantiation
// --------------------------------------------------
Decoder_2_4 DUT (
    .Reset_In(Reset_In),
    .Encoded_Value_In(Encoded_Value_In),
    .Data_0_Out(Data_0_Out),
    .Data_1_Out(Data_1_Out),
    .Data_2_Out(Data_2_Out),
    .Data_3_Out(Data_3_Out)
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
                Encoded_Value_In = $random;
                #10;
            end

        $stop;
    end



endmodule