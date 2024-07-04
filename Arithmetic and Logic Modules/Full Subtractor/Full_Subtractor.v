/*
**************************************************
                Full Subtractor
**************************************************

This is a verilog code, to implement a Full Subtractor.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/



module Full_Subtractor (
    input  Data_A_In,
    input  Data_B_In,
    input  Borrow_In,

    output Sum_Out,
    output Borrow_Out
);



// --------------------------------------------------
// wires
// --------------------------------------------------
wire Data_Ab;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Data_Ab = ~Data_A_In;

assign Sum_Out = Data_A_In ^ Data_B_In ^ Borrow_In;

assign Borrow_Out = (Data_Ab & Data_B_In) || (Data_B_In & Borrow_In) || (Data_Ab && Borrow_In);



endmodule