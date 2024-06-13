/*
SystemVerilog Testbench for the Serial-In-Serial-Out - SISO - 8-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Serial_In_Serial_Out_SISO_8_Bit_tb ();



reg        Clk_In;
reg        Reset_In;

reg        Serial_Data_In;
wire       Serial_Data_Out;
wire [7:0] SISO_Shift_Register;



// --------------------------------------------------
// Serial-In-Serial-Out - SISO - 8-Bit Shift Register DUT Instantiation
// --------------------------------------------------
Serial_In_Serial_Out_SISO_8_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Serial_Data_In(Serial_Data_In),
    .Serial_Data_Out(Serial_Data_Out),
    .SISO_Shift_Register(SISO_Shift_Register)
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

        repeat(10)
            begin
                Serial_Data_In = $random;
                #10;
            end

        $stop;
    end



endmodule