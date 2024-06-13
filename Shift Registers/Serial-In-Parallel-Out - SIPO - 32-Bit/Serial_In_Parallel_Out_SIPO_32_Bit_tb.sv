/*
SystemVerilog Testbench for the Serial-In-Parallel-Out - SIPO - 32-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Serial_In_Parallel_Out_SIPO_32_Bit_tb ();



reg         Clk_In;
reg         Reset_In;

reg         Serial_Data_In;
wire [31:0] SIPO_Shift_Register;



// --------------------------------------------------
// Serial-In-Parallel-Out - SIPO - 32-Bit Shift Register DUT Instantiation
// --------------------------------------------------
Serial_In_Parallel_Out_SIPO_32_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Serial_Data_In(Serial_Data_In),
    .SIPO_Shift_Register(SIPO_Shift_Register)
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

        repeat(32)
            begin
                Serial_Data_In = $random;
                #10;
            end

        $stop;
    end



endmodule