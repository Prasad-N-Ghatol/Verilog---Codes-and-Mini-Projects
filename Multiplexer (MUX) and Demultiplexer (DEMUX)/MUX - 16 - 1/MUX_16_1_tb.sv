/*
SystemVerilog Testbench for the 16:1 MUX.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module MUX_16_1_tb ();



reg        Enable_In;

reg  [3:0] Select_In;

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

wire       MUX_Data_Out;



// --------------------------------------------------
// 16:1 MUX DUT Instantiation
// --------------------------------------------------
MUX_16_1 DUT (
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
                #10;
            end

        $stop;
    end



endmodule