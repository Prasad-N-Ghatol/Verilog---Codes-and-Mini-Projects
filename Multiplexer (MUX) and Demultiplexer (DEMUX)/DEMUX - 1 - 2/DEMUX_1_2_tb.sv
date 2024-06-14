/*
SystemVerilog Testbench for the 1:2 DEMUX.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module DEMUX_1_2_tb ();



reg  Enable_In;

reg  Data_In;

reg  Select_In;

wire Data_0_Out;
wire Data_1_Out;



// --------------------------------------------------
// 1:2 DEMUX DUT Instantiation
// --------------------------------------------------
DEMUX_1_2 DUT (
    .Enable_In(Enable_In),

    .Data_In(Data_In),

    .Select_In(Select_In),

    .Data_0_Out(Data_0_Out),
    .Data_1_Out(Data_1_Out)
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