/*
SystemVerilog Testbench for the Parallel-In-Serial-Out - PISO - 8-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Parallel_In_Serial_Out_PISO_8_Bit_tb ();



reg        Clk_In;
reg        Reset_In;

reg        Load_Shiftb_In;
reg  [7:0] Parallel_Data_In;
wire       Serial_Data_Out;
wire [7:0] PISO_Shift_Register;



// --------------------------------------------------
// Parallel-In-Serial-Out - PISO - 8-Bit Shift Register DUT Instantiation
// --------------------------------------------------
Parallel_In_Serial_Out_PISO_8_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Load_Shiftb_In(Load_Shiftb_In),
    .Parallel_Data_In(Parallel_Data_In),
    .Serial_Data_Out(Serial_Data_Out),
    .PISO_Shift_Register(PISO_Shift_Register)
);



// --------------------------------------------------
// Clock Initialization
// --------------------------------------------------
initial
    begin
        Clk_In = 1'b0;

        forever
            begin
                #5;
                Clk_In = ~Clk_In;
            end
    end



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        Load_Shiftb_In = 1'b1;
        Parallel_Data_In = $random;
        #10;

        Load_Shiftb_In = 1'b0;
        #100;

        $stop;
    end



endmodule