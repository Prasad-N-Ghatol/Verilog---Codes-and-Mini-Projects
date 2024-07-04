/*
**************************************************
        Look Ahead Carry Generator - 16-Bit
**************************************************

This is a verilog code, to implement a 16-Bit Look Ahead Carry Generator.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/



module Look_Ahead_Carry_Generator_16_Bit (
    input  [15:0] Data_A_In,
    input  [15:0] Data_B_In,
    input         Carry_In,

    output [15:0] Sum_Out,
    output        Carry_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
wire [15:0] P;
wire [15:0] G;
wire [15:0] C;



// --------------------------------------------------
// Carry Propogate
// --------------------------------------------------
assign P[0]  = Data_A_In[0]  ^ Data_B_In[0];
assign P[1]  = Data_A_In[1]  ^ Data_B_In[1];
assign P[2]  = Data_A_In[2]  ^ Data_B_In[2];
assign P[3]  = Data_A_In[3]  ^ Data_B_In[3];
assign P[4]  = Data_A_In[4]  ^ Data_B_In[4];
assign P[5]  = Data_A_In[5]  ^ Data_B_In[5];
assign P[6]  = Data_A_In[6]  ^ Data_B_In[6];
assign P[7]  = Data_A_In[7]  ^ Data_B_In[7];

assign P[8]  = Data_A_In[8]  ^ Data_B_In[8];
assign P[9]  = Data_A_In[9]  ^ Data_B_In[9];
assign P[10] = Data_A_In[10] ^ Data_B_In[10];
assign P[11] = Data_A_In[11] ^ Data_B_In[11];
assign P[12] = Data_A_In[12] ^ Data_B_In[12];
assign P[13] = Data_A_In[13] ^ Data_B_In[13];
assign P[14] = Data_A_In[14] ^ Data_B_In[14];
assign P[15] = Data_A_In[15] ^ Data_B_In[15];



// --------------------------------------------------
// Carry Generate
// --------------------------------------------------
assign G[0]  = Data_A_In[0]  & Data_B_In[0];
assign G[1]  = Data_A_In[1]  & Data_B_In[1];
assign G[2]  = Data_A_In[2]  & Data_B_In[2];
assign G[3]  = Data_A_In[3]  & Data_B_In[3];
assign G[4]  = Data_A_In[4]  & Data_B_In[4];
assign G[5]  = Data_A_In[5]  & Data_B_In[5];
assign G[6]  = Data_A_In[6]  & Data_B_In[6];
assign G[7]  = Data_A_In[7]  & Data_B_In[7];

assign G[8]  = Data_A_In[8]  & Data_B_In[8];
assign G[9]  = Data_A_In[9]  & Data_B_In[9];
assign G[10] = Data_A_In[10] & Data_B_In[10];
assign G[11] = Data_A_In[11] & Data_B_In[11];
assign G[12] = Data_A_In[12] & Data_B_In[12];
assign G[13] = Data_A_In[13] & Data_B_In[13];
assign G[14] = Data_A_In[14] & Data_B_In[14];
assign G[15] = Data_A_In[15] & Data_B_In[15];



// --------------------------------------------------
// Look Ahead Carry Generator - 16-Bit Logic
// --------------------------------------------------
assign C[0] = (P[0] & Carry_In) + G[0];
assign C[1] = (P[1] & ((P[0] & Carry_In) + G[0])) + G[1];
assign C[2] = (P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2];
assign C[3] = (P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3];
assign C[4] = (P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4];
assign C[5] = (P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5];
assign C[6] = (P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6];
assign C[7] = (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7];

assign C[8] = (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8];
assign C[9] = (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9];
assign C[10] = (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10];
assign C[11] = (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11];
assign C[12] = (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12];
assign C[13] = (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13];
assign C[14] = (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14];
assign C[15] = (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15];


assign Carry_Out = C[15];


assign Sum_Out[0]  = P[0]  ^ Carry_In;
assign Sum_Out[1]  = P[1]  ^ C[0];
assign Sum_Out[2]  = P[2]  ^ C[1];
assign Sum_Out[3]  = P[3]  ^ C[2];
assign Sum_Out[4]  = P[4]  ^ C[3];
assign Sum_Out[5]  = P[5]  ^ C[4];
assign Sum_Out[6]  = P[6]  ^ C[5];
assign Sum_Out[7]  = P[7]  ^ C[6];

assign Sum_Out[8]  = P[8]  ^ C[7];
assign Sum_Out[9]  = P[9]  ^ C[8];
assign Sum_Out[10] = P[10] ^ C[9];
assign Sum_Out[11] = P[11] ^ C[10];
assign Sum_Out[12] = P[12] ^ C[11];
assign Sum_Out[13] = P[13] ^ C[12];
assign Sum_Out[14] = P[14] ^ C[13];
assign Sum_Out[15] = P[15] ^ C[14];



endmodule