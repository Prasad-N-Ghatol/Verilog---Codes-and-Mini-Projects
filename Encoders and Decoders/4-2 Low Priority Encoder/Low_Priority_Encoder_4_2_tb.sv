/*
SystemVerilog Testbench for the 4-2 Low Priority Encoder.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Low_Priority_Encoder_4_2_tb ();


reg        Reset_In;

reg        Data_0_In;
reg        Data_1_In;
reg        Data_2_In;
reg        Data_3_In;
wire [1:0] Encoded_Value_Out;



// --------------------------------------------------
// 4-2 Low Priority Encoder DUT Instantiation
// --------------------------------------------------
Low_Priority_Encoder_4_2 DUT (
    .Reset_In(Reset_In),
    .Data_0_In(Data_0_In),
    .Data_1_In(Data_1_In),
    .Data_2_In(Data_2_In),
    .Data_3_In(Data_3_In),
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
                #10;
            end

        $stop;
    end



endmodule