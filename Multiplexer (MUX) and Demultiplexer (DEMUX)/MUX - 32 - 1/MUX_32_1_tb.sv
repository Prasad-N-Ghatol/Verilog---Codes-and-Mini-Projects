/*
SystemVerilog Testbench for the 32:1 MUX.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module MUX_32_1_tb ();



reg        Enable_In;

reg  [4:0] Select_In;

reg        Data_0_In;
reg        Data_1_In;
reg        Data_2_In;
reg        Data_3_In;
reg        Data_4_In;
reg        Data_5_In;
reg        Data_6_In;
reg        Data_7_In;
reg        Data_8_In;
reg        Data_9_In;
reg        Data_10_In;
reg        Data_11_In;
reg        Data_12_In;
reg        Data_13_In;
reg        Data_14_In;
reg        Data_15_In;
reg        Data_16_In;
reg        Data_17_In;
reg        Data_18_In;
reg        Data_19_In;
reg        Data_20_In;
reg        Data_21_In;
reg        Data_22_In;
reg        Data_23_In;
reg        Data_24_In;
reg        Data_25_In;
reg        Data_26_In;
reg        Data_27_In;
reg        Data_28_In;
reg        Data_29_In;
reg        Data_30_In;
reg        Data_31_In;

wire       MUX_Data_Out;



// --------------------------------------------------
// 32:1 MUX DUT Instantiation
// --------------------------------------------------
MUX_32_1 DUT (
    .Enable_In(Enable_In),
    
    .Select_In(Select_In),

    .Data_0_In(Data_0_In),
    .Data_1_In(Data_1_In),
    .Data_2_In(Data_2_In),
    .Data_3_In(Data_3_In),
    .Data_4_In(Data_4_In),
    .Data_5_In(Data_5_In),
    .Data_6_In(Data_6_In),
    .Data_7_In(Data_7_In),
    .Data_8_In(Data_8_In),
    .Data_9_In(Data_9_In),
    .Data_10_In(Data_10_In),
    .Data_11_In(Data_11_In),
    .Data_12_In(Data_12_In),
    .Data_13_In(Data_13_In),
    .Data_14_In(Data_14_In),
    .Data_15_In(Data_15_In),
    .Data_16_In(Data_16_In),
    .Data_17_In(Data_17_In),
    .Data_18_In(Data_18_In),
    .Data_19_In(Data_19_In),
    .Data_20_In(Data_20_In),
    .Data_21_In(Data_21_In),
    .Data_22_In(Data_22_In),
    .Data_23_In(Data_23_In),
    .Data_24_In(Data_24_In),
    .Data_25_In(Data_25_In),
    .Data_26_In(Data_26_In),
    .Data_27_In(Data_27_In),
    .Data_28_In(Data_28_In),
    .Data_29_In(Data_29_In),
    .Data_30_In(Data_30_In),
    .Data_31_In(Data_31_In),

    .MUX_Data_Out(MUX_Data_Out)
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
                Select_In = $random;

                Data_0_In = $random;
                Data_1_In = $random;
                Data_2_In = $random;
                Data_3_In = $random;
                Data_4_In = $random;
                Data_5_In = $random;
                Data_6_In = $random;
                Data_7_In = $random;
                Data_8_In = $random;
                Data_9_In = $random;
                Data_10_In = $random;
                Data_11_In = $random;
                Data_12_In = $random;
                Data_13_In = $random;
                Data_14_In = $random;
                Data_15_In = $random;
                Data_16_In = $random;
                Data_17_In = $random;
                Data_18_In = $random;
                Data_19_In = $random;
                Data_20_In = $random;
                Data_21_In = $random;
                Data_22_In = $random;
                Data_23_In = $random;
                Data_24_In = $random;
                Data_25_In = $random;
                Data_26_In = $random;
                Data_27_In = $random;
                Data_28_In = $random;
                Data_29_In = $random;
                Data_30_In = $random;
                Data_31_In = $random;
                #10;
            end

        $stop;
    end



endmodule