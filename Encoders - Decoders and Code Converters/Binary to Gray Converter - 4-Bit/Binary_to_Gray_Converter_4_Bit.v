/*
Verilog Code, to implement a Binary to Gray Converter - 4-Bit.



Author : Prasad Narayan Ghatol
*/



module Binary_to_Gray_Converter_4_Bit (
    input  [3:0] Binary_Code_In,
    output [3:0] Gray_Code_Out
);



// --------------------------------------------------
// Binary to Gray Converter - 4-Bit Logic
// --------------------------------------------------
assign Gray_Code_Out[3] = Binary_Code_In[3];
assign Gray_Code_Out[2] = Binary_Code_In[3] ^ Binary_Code_In[2];
assign Gray_Code_Out[1] = Binary_Code_In[2] ^ Binary_Code_In[1];
assign Gray_Code_Out[0] = Binary_Code_In[1] ^ Binary_Code_In[0];



endmodule