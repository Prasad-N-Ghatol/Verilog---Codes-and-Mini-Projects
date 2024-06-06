/*
Verilog Code, to implement a Multiplier - 4-Bit.



Author : Prasad Narayan Ghatol
*/



module Multiplier_4_Bit (
    input  [3:0] Data_A_In,
    input  [3:0] Data_B_In,

    output [7:0] Multiplied_Result_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
// Sub-Products
wire [7:0] Sub_Products [3:0];


// Additions
wire [7:0] Addition_0 [1:0];
wire [7:0] Addition_1;



// --------------------------------------------------
// Sub-Products
// --------------------------------------------------
assign Sub_Products[0] = Data_B_In[0] ? (Data_A_In)      : 8'b0;
assign Sub_Products[1] = Data_B_In[1] ? (Data_A_In << 1) : 8'b0;
assign Sub_Products[2] = Data_B_In[2] ? (Data_A_In << 2) : 8'b0;
assign Sub_Products[3] = Data_B_In[3] ? (Data_A_In << 3) : 8'b0;



// --------------------------------------------------
// Adders
// --------------------------------------------------
assign Addition_0[0] = Sub_Products[0] + Sub_Products[1];
assign Addition_0[1] = Sub_Products[2] + Sub_Products[3];

assign Addition_1 = Addition_0[0] + Addition_0[1];



// --------------------------------------------------
// Final Result
// --------------------------------------------------
assign Multiplied_Result_Out = Addition_1;



endmodule