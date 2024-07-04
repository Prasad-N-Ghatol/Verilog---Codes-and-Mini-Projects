/*
**************************************************
            Multiplier - 2-Bit
**************************************************

This is a verilog code, to implement a 2-Bit Multiplier.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/



module Multiplier_2_Bit (
    input  [1:0] Data_A_In,
    input  [1:0] Data_B_In,

    output [3:0] Multiplied_Result_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
// Sub-Products
wire [3:0] Sub_Products [1:0];


// Additions
wire [3:0] Addition_0;



// --------------------------------------------------
// Sub-Products
// --------------------------------------------------
assign Sub_Products[0] = Data_B_In[0] ? (Data_A_In)      : 2'b0;
assign Sub_Products[1] = Data_B_In[1] ? (Data_A_In << 1) : 2'b0;



// --------------------------------------------------
// Adders
// --------------------------------------------------
assign Addition_0 = Sub_Products[0] + Sub_Products[1];



// --------------------------------------------------
// Final Result
// --------------------------------------------------
assign Multiplied_Result_Out = Addition_0;



endmodule