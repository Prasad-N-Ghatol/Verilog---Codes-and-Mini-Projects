/*
SystemVerilog Testbench for the 1:16 DEMUX.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module DEMUX_1_16_tb ();



reg        Enable_In;

reg        Data_In;

reg  [3:0] Select_In;

wire       Data_0_Out;
wire       Data_1_Out;
wire       Data_2_Out;
wire       Data_3_Out;
wire       Data_4_Out;
wire       Data_5_Out;
wire       Data_6_Out;
wire       Data_7_Out;
wire       Data_8_Out;
wire       Data_9_Out;
wire       Data_10_Out;
wire       Data_11_Out;
wire       Data_12_Out;
wire       Data_13_Out;
wire       Data_14_Out;
wire       Data_15_Out;



// --------------------------------------------------
// 1:16 DEMUX DUT Instantiation
// --------------------------------------------------
DEMUX_1_16 DUT (
    .Enable_In(Enable_In),

    .Data_In(Data_In),

    .Select_In(Select_In),

    .Data_0_Out(Data_0_Out),
    .Data_1_Out(Data_1_Out),
    .Data_2_Out(Data_2_Out),
    .Data_3_Out(Data_3_Out),
    .Data_4_Out(Data_4_Out),
    .Data_5_Out(Data_5_Out),
    .Data_6_Out(Data_6_Out),
    .Data_7_Out(Data_7_Out),
    .Data_8_Out(Data_8_Out),
    .Data_9_Out(Data_9_Out),
    .Data_10_Out(Data_10_Out),
    .Data_11_Out(Data_11_Out),
    .Data_12_Out(Data_12_Out),
    .Data_13_Out(Data_13_Out),
    .Data_14_Out(Data_14_Out),
    .Data_15_Out(Data_15_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Enable_In = 1'b0;
        #10;
        Enable_In = 1'b1;

        repeat(20)
            begin
                Data_In = $random;
                
                Select_In = $random;
                #10;
            end

        $stop;
    end



endmodule