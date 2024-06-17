/*
SystemVerilog Testbench for the Barrel Shifter - 32-Bit.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Barrel_Shifter_32_Bit_tb ();



reg         Enable_In;

reg  [2:0]  Shifter_Mode_In;

reg  [4:0]  Shift_Bits_Length_In;
reg         Carry_In;
reg  [31:0] Data_In;

wire [31:0] Shifted_Data_Out;
wire        Carry_Out;



// --------------------------------------------------
// Constants
// --------------------------------------------------
localparam [2:0]    LOGICAL_SHIFT_LEFT         = 3'h0,
                    LOGICAL_SHIFT_RIGHT        = 3'h1,
                    ARITHMETIC_SHIFT_LEFT      = 3'h2,
                    ARITHMETIC_SHIFT_RIGHT     = 3'h3,
                    ROTATE_LEFT                = 3'h4,
                    ROTATE_RIGHT               = 3'h5,
                    ROTATE_LEFT_THROUGH_CARRY  = 3'h6,
                    ROTATE_RIGHT_THROUGH_CARRY = 3'h7;



// --------------------------------------------------
// Barrel Shifter - 32-Bit DUT Instantiation
// --------------------------------------------------
Barrel_Shifter_32_Bit DUT (
    .Enable_In(Enable_In),

    .Shifter_Mode_In(Shifter_Mode_In),

    .Shift_Bits_Length_In(Shift_Bits_Length_In),
    .Carry_In(Carry_In),
    .Data_In(Data_In),
    
    .Shifted_Data_Out(Shifted_Data_Out),
    .Carry_Out(Carry_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Enable_In = 1'b0;
        #10;
        Enable_In = 1'b1;


        Shifter_Mode_In = LOGICAL_SHIFT_LEFT;         // 3'h0
        repeat(3)
            begin
                Shift_Bits_Length_In = $random;
                Carry_In = $random;
                Data_In = $random;
                #10;
            end


        Shifter_Mode_In = LOGICAL_SHIFT_RIGHT;        // 3'h1
        repeat(3)
            begin
                Shift_Bits_Length_In = $random;
                Carry_In = $random;
                Data_In = $random;
                #10;
            end


        Shifter_Mode_In = ARITHMETIC_SHIFT_LEFT;      // 3'h2
        repeat(3)
            begin
                Shift_Bits_Length_In = $random;
                Carry_In = $random;
                Data_In = $random;
                #10;
            end


        Shifter_Mode_In = ARITHMETIC_SHIFT_RIGHT;     // 3'h3
        repeat(3)
            begin
                Shift_Bits_Length_In = $random;
                Carry_In = $random;
                Data_In = $random;
                #10;
            end


        Shifter_Mode_In = ROTATE_LEFT;                // 3'h4
        repeat(3)
            begin
                Shift_Bits_Length_In = $random;
                Carry_In = $random;
                Data_In = $random;
                #10;
            end


        Shifter_Mode_In = ROTATE_RIGHT;               // 3'h5
        repeat(3)
            begin
                Shift_Bits_Length_In = $random;
                Carry_In = $random;
                Data_In = $random;
                #10;
            end


        Shifter_Mode_In = ROTATE_LEFT_THROUGH_CARRY;  // 3'h6
        repeat(3)
            begin
                Shift_Bits_Length_In = $random;
                Carry_In = $random;
                Data_In = $random;
                #10;
            end


        Shifter_Mode_In = ROTATE_RIGHT_THROUGH_CARRY; // 3'h7
        repeat(3)
            begin
                Shift_Bits_Length_In = $random;
                Carry_In = $random;
                Data_In = $random;
                #10;
            end


        $stop;
    end



endmodule