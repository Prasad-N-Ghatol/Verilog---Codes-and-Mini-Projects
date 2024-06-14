/*
SystemVerilog Testbench for the 1:32 DEMUX.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module DEMUX_1_32_tb ();



reg        Enable_In;

reg        Data_In;

reg  [4:0] Select_In;

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
wire       Data_16_Out;
wire       Data_17_Out;
wire       Data_18_Out;
wire       Data_19_Out;
wire       Data_20_Out;
wire       Data_21_Out;
wire       Data_22_Out;
wire       Data_23_Out;
wire       Data_24_Out;
wire       Data_25_Out;
wire       Data_26_Out;
wire       Data_27_Out;
wire       Data_28_Out;
wire       Data_29_Out;
wire       Data_30_Out;
wire       Data_31_Out;



// --------------------------------------------------
// 1:32 DEMUX DUT Instantiation
// --------------------------------------------------
DEMUX_1_32 DUT (
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
    .Data_15_Out(Data_15_Out),
    .Data_16_Out(Data_16_Out),
    .Data_17_Out(Data_17_Out),
    .Data_18_Out(Data_18_Out),
    .Data_19_Out(Data_19_Out),
    .Data_20_Out(Data_20_Out),
    .Data_21_Out(Data_21_Out),
    .Data_22_Out(Data_22_Out),
    .Data_23_Out(Data_23_Out),
    .Data_24_Out(Data_24_Out),
    .Data_25_Out(Data_25_Out),
    .Data_26_Out(Data_26_Out),
    .Data_27_Out(Data_27_Out),
    .Data_28_Out(Data_28_Out),
    .Data_29_Out(Data_29_Out),
    .Data_30_Out(Data_30_Out),
    .Data_31_Out(Data_31_Out)
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