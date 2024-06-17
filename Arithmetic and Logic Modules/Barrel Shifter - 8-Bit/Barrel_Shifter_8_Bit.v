/*
Verilog Code, to implement a Barrel Shifter - 8-Bit.



Author : Prasad Narayan Ghatol
*/



module Barrel_Shifter_8_Bit (
    input        Enable_In,

    input  [2:0] Shifter_Mode_In,

    input  [2:0] Shift_Bits_Length_In,
    input        Carry_In,
    input  [7:0] Data_In,

    output [7:0] Shifted_Data_Out,
    output       Carry_Out
);



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
// wires and regs
// --------------------------------------------------
reg [8:0] Shift_Rotate_Bits_4;
reg [8:0] Shift_Rotate_Bits_2;
reg [8:0] Shift_Rotate_Bits_1;



// --------------------------------------------------
// Assignment
// --------------------------------------------------
assign Shifted_Data_Out = Enable_In ? Shift_Rotate_Bits_1[7:0] : 8'bZ;
assign Carry_Out        = Enable_In ? Shift_Rotate_Bits_1[8]   : 1'bZ;



// --------------------------------------------------
// Barrel Shifter - 8-Bit Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Shifter_Mode_In)
            LOGICAL_SHIFT_LEFT         : // 3'h0
                begin
                    Shift_Rotate_Bits_4[8] <= 1'b0;
                    Shift_Rotate_Bits_2[8] <= 1'b0;
                    Shift_Rotate_Bits_1[8] <= 1'b0;
                    
                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[0];
                    Shift_Rotate_Bits_4[1] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[1];
                    Shift_Rotate_Bits_4[2] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[2];
                    Shift_Rotate_Bits_4[3] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[3];
                    Shift_Rotate_Bits_4[4] <= Shift_Bits_Length_In[2] ? Data_In[0] : Data_In[4];
                    Shift_Rotate_Bits_4[5] <= Shift_Bits_Length_In[2] ? Data_In[1] : Data_In[5];
                    Shift_Rotate_Bits_4[6] <= Shift_Bits_Length_In[2] ? Data_In[2] : Data_In[6];
                    Shift_Rotate_Bits_4[7] <= Shift_Bits_Length_In[2] ? Data_In[3] : Data_In[7];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? 1'b0                   : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? 1'b0                   : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0] : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1] : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2] : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3] : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4] : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5] : Shift_Rotate_Bits_4[7];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? 1'b0                   : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5] : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6] : Shift_Rotate_Bits_2[7];
                end

            LOGICAL_SHIFT_RIGHT        : // 3'h1
                begin
                    Shift_Rotate_Bits_4[8] <= 1'b0;
                    Shift_Rotate_Bits_2[8] <= 1'b0;
                    Shift_Rotate_Bits_1[8] <= 1'b0;
                    
                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0] <= Shift_Bits_Length_In[2] ? Data_In[4] : Data_In[0];
                    Shift_Rotate_Bits_4[1] <= Shift_Bits_Length_In[2] ? Data_In[5] : Data_In[1];
                    Shift_Rotate_Bits_4[2] <= Shift_Bits_Length_In[2] ? Data_In[6] : Data_In[2];
                    Shift_Rotate_Bits_4[3] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[3];
                    Shift_Rotate_Bits_4[4] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[4];
                    Shift_Rotate_Bits_4[5] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[5];
                    Shift_Rotate_Bits_4[6] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[6];
                    Shift_Rotate_Bits_4[7] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[7];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3] : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4] : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5] : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6] : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7] : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6] <= Shift_Bits_Length_In[1] ? 1'b0                   : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7] <= Shift_Bits_Length_In[1] ? 1'b0                   : Shift_Rotate_Bits_4[7];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5] : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6] : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7] : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7] <= Shift_Bits_Length_In[0] ? 1'b0                   : Shift_Rotate_Bits_2[7];
                end

            ARITHMETIC_SHIFT_LEFT      : // 3'h2
                begin
                    Shift_Rotate_Bits_4[8] <= 1'b0;
                    Shift_Rotate_Bits_2[8] <= 1'b0;
                    Shift_Rotate_Bits_1[8] <= 1'b0;
                    
                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[0];
                    Shift_Rotate_Bits_4[1] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[1];
                    Shift_Rotate_Bits_4[2] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[2];
                    Shift_Rotate_Bits_4[3] <= Shift_Bits_Length_In[2] ? 1'b0       : Data_In[3];
                    Shift_Rotate_Bits_4[4] <= Shift_Bits_Length_In[2] ? Data_In[0] : Data_In[4];
                    Shift_Rotate_Bits_4[5] <= Shift_Bits_Length_In[2] ? Data_In[1] : Data_In[5];
                    Shift_Rotate_Bits_4[6] <= Shift_Bits_Length_In[2] ? Data_In[2] : Data_In[6];
                    Shift_Rotate_Bits_4[7] <= Shift_Bits_Length_In[2] ? Data_In[3] : Data_In[7];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? 1'b0                   : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? 1'b0                   : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0] : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1] : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2] : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3] : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4] : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5] : Shift_Rotate_Bits_4[7];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? 1'b0                   : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5] : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6] : Shift_Rotate_Bits_2[7];
                end

            ARITHMETIC_SHIFT_RIGHT     : // 3'h3
                begin
                    Shift_Rotate_Bits_4[8] <= 1'b0;
                    Shift_Rotate_Bits_2[8] <= 1'b0;
                    Shift_Rotate_Bits_1[8] <= 1'b0;
                    
                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0] <= Shift_Bits_Length_In[2] ? Data_In[4] : Data_In[0];
                    Shift_Rotate_Bits_4[1] <= Shift_Bits_Length_In[2] ? Data_In[5] : Data_In[1];
                    Shift_Rotate_Bits_4[2] <= Shift_Bits_Length_In[2] ? Data_In[6] : Data_In[2];
                    Shift_Rotate_Bits_4[3] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[3];
                    Shift_Rotate_Bits_4[4] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[4];
                    Shift_Rotate_Bits_4[5] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[5];
                    Shift_Rotate_Bits_4[6] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[6];
                    Shift_Rotate_Bits_4[7] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[7];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3] : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4] : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5] : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6] : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7] : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6] <= Shift_Bits_Length_In[1] ? Data_In[7]             : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7] <= Shift_Bits_Length_In[1] ? Data_In[7]             : Shift_Rotate_Bits_4[7];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5] : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6] : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7] : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7] <= Shift_Bits_Length_In[0] ? Data_In[7]             : Shift_Rotate_Bits_2[7];
                end

            ROTATE_LEFT                : // 3'h4
                begin
                    Shift_Rotate_Bits_4[8] <= 1'b0;
                    Shift_Rotate_Bits_2[8] <= 1'b0;
                    Shift_Rotate_Bits_1[8] <= 1'b0;
                    
                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0] <= Shift_Bits_Length_In[2] ? Data_In[4] : Data_In[0];
                    Shift_Rotate_Bits_4[1] <= Shift_Bits_Length_In[2] ? Data_In[5] : Data_In[1];
                    Shift_Rotate_Bits_4[2] <= Shift_Bits_Length_In[2] ? Data_In[6] : Data_In[2];
                    Shift_Rotate_Bits_4[3] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[3];
                    Shift_Rotate_Bits_4[4] <= Shift_Bits_Length_In[2] ? Data_In[0] : Data_In[4];
                    Shift_Rotate_Bits_4[5] <= Shift_Bits_Length_In[2] ? Data_In[1] : Data_In[5];
                    Shift_Rotate_Bits_4[6] <= Shift_Bits_Length_In[2] ? Data_In[2] : Data_In[6];
                    Shift_Rotate_Bits_4[7] <= Shift_Bits_Length_In[2] ? Data_In[3] : Data_In[7];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7] : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0] : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1] : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2] : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3] : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4] : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5] : Shift_Rotate_Bits_4[7];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5] : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6] : Shift_Rotate_Bits_2[7];
                end

            ROTATE_RIGHT               : // 3'h5
                begin
                    Shift_Rotate_Bits_4[8] <= 1'b0;
                    Shift_Rotate_Bits_2[8] <= 1'b0;
                    Shift_Rotate_Bits_1[8] <= 1'b0;
                    
                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0] <= Shift_Bits_Length_In[2] ? Data_In[4] : Data_In[0];
                    Shift_Rotate_Bits_4[1] <= Shift_Bits_Length_In[2] ? Data_In[5] : Data_In[1];
                    Shift_Rotate_Bits_4[2] <= Shift_Bits_Length_In[2] ? Data_In[6] : Data_In[2];
                    Shift_Rotate_Bits_4[3] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[3];
                    Shift_Rotate_Bits_4[4] <= Shift_Bits_Length_In[2] ? Data_In[0] : Data_In[4];
                    Shift_Rotate_Bits_4[5] <= Shift_Bits_Length_In[2] ? Data_In[1] : Data_In[5];
                    Shift_Rotate_Bits_4[6] <= Shift_Bits_Length_In[2] ? Data_In[2] : Data_In[6];
                    Shift_Rotate_Bits_4[7] <= Shift_Bits_Length_In[2] ? Data_In[3] : Data_In[7];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3] : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4] : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5] : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6] : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7] : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0] : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1] : Shift_Rotate_Bits_4[7];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5] : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6] : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7] : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[7];
                end

            ROTATE_LEFT_THROUGH_CARRY  : // 3'h6
                begin
                    
                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0] <= Shift_Bits_Length_In[2] ? Data_In[5] : Data_In[0];
                    Shift_Rotate_Bits_4[1] <= Shift_Bits_Length_In[2] ? Data_In[6] : Data_In[1];
                    Shift_Rotate_Bits_4[2] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[2];
                    Shift_Rotate_Bits_4[3] <= Shift_Bits_Length_In[2] ? Carry_In   : Data_In[3];
                    Shift_Rotate_Bits_4[4] <= Shift_Bits_Length_In[2] ? Data_In[0] : Data_In[4];
                    Shift_Rotate_Bits_4[5] <= Shift_Bits_Length_In[2] ? Data_In[1] : Data_In[5];
                    Shift_Rotate_Bits_4[6] <= Shift_Bits_Length_In[2] ? Data_In[2] : Data_In[6];
                    Shift_Rotate_Bits_4[7] <= Shift_Bits_Length_In[2] ? Data_In[3] : Data_In[7];
                    Shift_Rotate_Bits_4[8] <= Shift_Bits_Length_In[2] ? Data_In[4] : Carry_In;

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8] : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0] : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1] : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2] : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3] : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4] : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5] : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6] : Shift_Rotate_Bits_4[8];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5] : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6] : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7] : Shift_Rotate_Bits_2[8];
                end

            ROTATE_RIGHT_THROUGH_CARRY : // 3'h7
                begin
                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0] <= Shift_Bits_Length_In[2] ? Data_In[4] : Data_In[0];
                    Shift_Rotate_Bits_4[1] <= Shift_Bits_Length_In[2] ? Data_In[5] : Data_In[1];
                    Shift_Rotate_Bits_4[2] <= Shift_Bits_Length_In[2] ? Data_In[6] : Data_In[2];
                    Shift_Rotate_Bits_4[3] <= Shift_Bits_Length_In[2] ? Data_In[7] : Data_In[3];
                    Shift_Rotate_Bits_4[4] <= Shift_Bits_Length_In[2] ? Carry_In   : Data_In[4];
                    Shift_Rotate_Bits_4[5] <= Shift_Bits_Length_In[2] ? Data_In[0] : Data_In[5];
                    Shift_Rotate_Bits_4[6] <= Shift_Bits_Length_In[2] ? Data_In[1] : Data_In[6];
                    Shift_Rotate_Bits_4[7] <= Shift_Bits_Length_In[2] ? Data_In[2] : Data_In[7];
                    Shift_Rotate_Bits_4[8] <= Shift_Bits_Length_In[2] ? Data_In[3] : Carry_In;

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3] : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4] : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5] : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6] : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7] : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8] : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0] : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1] : Shift_Rotate_Bits_4[8];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5] : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6] : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7] : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8] : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[8];
                end
    
            default: 
                begin
                    Shift_Rotate_Bits_4 <= 9'b0;
                    Shift_Rotate_Bits_2 <= 9'b0;
                    Shift_Rotate_Bits_1 <= 9'b0;
                end
        endcase
    end



endmodule