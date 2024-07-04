/*
**************************************************
                Full Adder
**************************************************

This is a verilog code, to implement a Full Adder.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/



module Full_Adder (
    input  Data_A_In,
    input  Data_B_In,
    input  Carry_In,

    output Sum_Out,
    output Carry_Out
);



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Sum_Out = Data_A_In ^ Data_B_In ^ Carry_In;

assign Carry_Out = (Data_A_In & Data_B_In) || (Data_B_In & Carry_In) || (Data_A_In && Carry_In);



endmodule