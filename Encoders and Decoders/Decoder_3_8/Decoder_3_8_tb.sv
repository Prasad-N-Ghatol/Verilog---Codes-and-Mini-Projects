/*
SystemVerilog Testbench for the 3-8 Decoder.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Decoder_3_8_tb ();


reg        Reset_In;

reg  [2:0] Encoded_Value_In;
wire       Data_0_Out;
wire       Data_1_Out;
wire       Data_2_Out;
wire       Data_3_Out;
wire       Data_4_Out;
wire       Data_5_Out;
wire       Data_6_Out;
wire       Data_7_Out;



// --------------------------------------------------
// 3-8 Decoder DUT Instantiation
// --------------------------------------------------
Decoder_3_8 DUT (
    .Reset_In(Reset_In),
    .Encoded_Value_In(Encoded_Value_In),
    .Data_0_Out(Data_0_Out),
    .Data_1_Out(Data_1_Out),
    .Data_2_Out(Data_2_Out),
    .Data_3_Out(Data_3_Out),
    .Data_4_Out(Data_4_Out),
    .Data_5_Out(Data_5_Out),
    .Data_6_Out(Data_6_Out),
    .Data_7_Out(Data_7_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        repeat (20)
            begin
                Encoded_Value_In = $random;
                #10;
            end

        $stop;
    end



endmodule