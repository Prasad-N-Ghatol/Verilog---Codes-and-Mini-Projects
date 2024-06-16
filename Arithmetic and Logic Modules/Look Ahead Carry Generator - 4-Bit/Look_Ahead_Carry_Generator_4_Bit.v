/*
Verilog Code, to implement a Look Ahead Carry Generator - 4-Bit.



Author : Prasad Narayan Ghatol
*/



module Look_Ahead_Carry_Generator_4_Bit (
    input  [3:0] Data_A_In,
    input  [3:0] Data_B_In,
    input        Carry_In,

    output [3:0] Sum_Out,
    output       Carry_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
wire [3:0] P;
wire [3:0] G;
wire [3:0] C;



// --------------------------------------------------
// Carry Propogate
// --------------------------------------------------
assign P[0] = Data_A_In[0] ^ Data_B_In[0];
assign P[1] = Data_A_In[1] ^ Data_B_In[1];
assign P[2] = Data_A_In[2] ^ Data_B_In[2];
assign P[3] = Data_A_In[3] ^ Data_B_In[3];



// --------------------------------------------------
// Carry Generate
// --------------------------------------------------
assign G[0] = Data_A_In[0] & Data_B_In[0];
assign G[1] = Data_A_In[1] & Data_B_In[1];
assign G[2] = Data_A_In[2] & Data_B_In[2];
assign G[3] = Data_A_In[3] & Data_B_In[3];



// --------------------------------------------------
// Look Ahead Carry Generator - 4-Bit Logic
// --------------------------------------------------
assign C[0] = (P[0] & Carry_In) + G[0];
assign C[1] = (P[1] & ((P[0] & Carry_In) + G[0])) + G[1];
assign C[2] = (P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2];
assign C[3] = (P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3];


assign Carry_Out = C[3];


assign Sum_Out[0] = P[0] ^ Carry_In;
assign Sum_Out[1] = P[1] ^ C[0];
assign Sum_Out[2] = P[2] ^ C[1];
assign Sum_Out[3] = P[3] ^ C[2];



endmodule