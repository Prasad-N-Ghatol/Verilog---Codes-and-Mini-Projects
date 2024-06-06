/*
Verilog Code, to implement a Comparator - 1-Bit.



Author : Prasad Narayan Ghatol
*/



module Comparator_1_Bit (
    input      Reset_In,

    input      Data_A_In,
    input      Data_B_In,
    output reg A_Less_Than_B_Out,
    output reg A_Equal_To_B_Out,
    output reg A_Greater_Than_B_Out
);



// --------------------------------------------------
// Comparator - 1-Bit Logic
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