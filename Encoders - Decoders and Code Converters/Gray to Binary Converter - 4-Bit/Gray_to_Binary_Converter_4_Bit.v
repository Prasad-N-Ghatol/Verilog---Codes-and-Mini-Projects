/*
Verilog Code, to implement a Gray to Binary Converter - 4-Bit.



Author : Prasad Narayan Ghatol
*/



module Gray_to_Binary_Converter_4_Bit (
    input  [3:0] Gray_Code_In,
    output [3:0] Binary_Code_Out
);



// --------------------------------------------------
// Gray to Binary Converter - 4-Bit Logic
// --------------------------------------------------
assign Binary_Code_Out[3] = Gray_Code_In[3];
assign Binary_Code_Out[2] = Gray_Code_In[2] ^ Binary_Code_Out[3];
assign Binary_Code_Out[1] = Gray_Code_In[1] ^ Binary_Code_Out[2];
assign Binary_Code_Out[0] = Gray_Code_In[0] ^ Binary_Code_Out[1];



endmodule