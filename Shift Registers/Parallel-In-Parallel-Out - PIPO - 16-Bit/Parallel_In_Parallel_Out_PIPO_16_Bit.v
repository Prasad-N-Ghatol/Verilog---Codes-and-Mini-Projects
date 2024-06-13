/* 
Verilog Code to implement a ParParallel-In-Parallel-Out - PIPO - 16-Bit Shift Register.



Author - Prasad Narayan Ghatol
*/



module Parallel_In_Parallel_Out_PIPO_16_Bit(
    input             Clk_In,
    input             Reset_In,

    input      [15:0] Parallel_Data_In,
    output reg [15:0] Parallel_Data_Out
);



// --------------------------------------------------
// Parallel-In-Parallel-Out - PIPO - 16-Bit Shift Register Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Parallel_Data_Out <= 16'b0;
            end
        else
            begin
                Parallel_Data_Out[0]  <= Parallel_Data_In[0];
                Parallel_Data_Out[1]  <= Parallel_Data_In[1];
                Parallel_Data_Out[2]  <= Parallel_Data_In[2];
                Parallel_Data_Out[3]  <= Parallel_Data_In[3];
                Parallel_Data_Out[4]  <= Parallel_Data_In[4];
                Parallel_Data_Out[5]  <= Parallel_Data_In[5];
                Parallel_Data_Out[6]  <= Parallel_Data_In[6];
                Parallel_Data_Out[7]  <= Parallel_Data_In[7];
                Parallel_Data_Out[8]  <= Parallel_Data_In[8];
                Parallel_Data_Out[9]  <= Parallel_Data_In[9];
                Parallel_Data_Out[10] <= Parallel_Data_In[10];
                Parallel_Data_Out[11] <= Parallel_Data_In[11];
                Parallel_Data_Out[12] <= Parallel_Data_In[12];
                Parallel_Data_Out[13] <= Parallel_Data_In[13];
                Parallel_Data_Out[14] <= Parallel_Data_In[14];
                Parallel_Data_Out[15] <= Parallel_Data_In[15];
            end
    end



endmodule