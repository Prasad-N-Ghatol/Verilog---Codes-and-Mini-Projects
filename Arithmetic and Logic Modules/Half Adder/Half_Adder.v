/*
**************************************************
                Half Adder
**************************************************

This is a verilog code, to implement a Half Adder.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/



module Half_Adder (
    input  Data_A_In,
    input  Data_B_In,

    output Sum_Out,
    output Carry_Out
);



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Sum_Out = Data_A_In ^ Data_B_In;

assign Carry_Out = Data_A_In & Data_B_In;



endmodule