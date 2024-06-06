/*
Verilog Code, to implement a Multiplier - 2-Bit.



Author : Prasad Narayan Ghatol
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
wire [3:0] Sub_Product_0;
wire [3:0] Sub_Product_1;


// Additions
wire [3:0] Addition_0;



// --------------------------------------------------
// Sub-Products
// --------------------------------------------------
assign Sub_Product_0 = Data_B_In[0] ? (Data_A_In)      : 4'b0;
assign Sub_Product_1 = Data_B_In[1] ? (Data_A_In << 1) : 4'b0;



// --------------------------------------------------
// Adders
// --------------------------------------------------
assign Addition_0 = Sub_Product_0 + Sub_Product_1;



// --------------------------------------------------
// Final Result
// --------------------------------------------------
assign Multiplied_Result_Out = Addition_0;



endmodule