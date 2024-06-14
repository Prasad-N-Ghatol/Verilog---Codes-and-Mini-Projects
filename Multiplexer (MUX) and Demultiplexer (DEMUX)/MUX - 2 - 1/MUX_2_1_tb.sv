/*
SystemVerilog Testbench for the 2:1 MUX.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module MUX_2_1_tb ();



reg  Enable_In;

reg  Select_In;

reg  Data_0_In;
reg  Data_1_In;

wire MUX_Data_Out;



// --------------------------------------------------
// 2:1 MUX DUT Instantiation
// --------------------------------------------------
MUX_2_1 DUT (
    .Enable_In(Enable_In),

    .Select_In(Select_In),

    .Data_0_In(Data_0_In),
    .Data_1_In(Data_1_In),

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
                #10;
            end

        $stop;
    end



endmodule