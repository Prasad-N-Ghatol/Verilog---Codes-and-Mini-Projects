/*
SystemVerilog Testbench for the 8-3 High Priority Encoder.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module High_Priority_Encoder_8_3_tb ();


reg        Reset_In;

reg        Data_0_In;
reg        Data_1_In;
reg        Data_2_In;
reg        Data_3_In;
reg        Data_4_In;
reg        Data_5_In;
reg        Data_6_In;
reg        Data_7_In;
wire [2:0] Encoded_Value_Out;



// --------------------------------------------------
// 8-3 High Priority Encoder DUT Instantiation
// --------------------------------------------------
High_Priority_Encoder_8_3 DUT (
    .Reset_In(Reset_In),
    .Data_0_In(Data_0_In),
    .Data_1_In(Data_1_In),
    .Data_2_In(Data_2_In),
    .Data_3_In(Data_3_In),
    .Data_4_In(Data_4_In),
    .Data_5_In(Data_5_In),
    .Data_6_In(Data_6_In),
    .Data_7_In(Data_7_In),
    .Encoded_Value_Out(Encoded_Value_Out)
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
                Data_0_In = $random;
                Data_1_In = $random;
                Data_2_In = $random;
                Data_3_In = $random;
                Data_4_In = $random;
                Data_5_In = $random;
                Data_6_In = $random;
                Data_7_In = $random;
                #10;
            end

        $stop;
    end



endmodule