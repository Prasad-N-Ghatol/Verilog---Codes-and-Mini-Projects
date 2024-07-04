/*
**************************************************
                Comparator - 8-Bit
**************************************************

This is a verilog code, to implement a 8-Bit Comparator.

The comparator compares 2 words Data_A and Data_B, and produces the results :
A_Less_Than_B = 1'b1, when A is less the B
A_Equal_To_B = 1'b1, when A is equal to B
A_Greater_Than_B = 1'b1, when A is greater than B

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/



module Comparator_8_Bit (
    input            Reset_In,

    input      [7:0] Data_A_In,
    input      [7:0] Data_B_In,

    output reg       A_Less_Than_B_Out,   // A < B
    output reg       A_Equal_To_B_Out,    // A = B
    output reg       A_Greater_Than_B_Out // A > B
);



// --------------------------------------------------
// Comparator - 8-Bit Logic
// --------------------------------------------------
always @ (*)
    begin
        if (Reset_In)
            begin
                A_Less_Than_B_Out <= 1'bZ;
                A_Equal_To_B_Out <= 1'bZ;
                A_Greater_Than_B_Out <= 1'bZ;
            end
        else if (Data_A_In < Data_B_In)
            begin
                A_Less_Than_B_Out <= 1'b1;
                A_Equal_To_B_Out <= 1'b0;
                A_Greater_Than_B_Out <= 1'b0;
            end
        else if (Data_A_In == Data_B_In)
            begin
                A_Less_Than_B_Out <= 1'b0;
                A_Equal_To_B_Out <= 1'b1;
                A_Greater_Than_B_Out <= 1'b0;
            end
        else if (Data_A_In > Data_B_In)
            begin
                A_Less_Than_B_Out <= 1'b0;
                A_Equal_To_B_Out <= 1'b0;
                A_Greater_Than_B_Out <= 1'b1;
            end
        else
            begin
                A_Less_Than_B_Out <= 1'bZ;
                A_Equal_To_B_Out <= 1'bZ;
                A_Greater_Than_B_Out <= 1'bZ;
            end
    end



endmodule