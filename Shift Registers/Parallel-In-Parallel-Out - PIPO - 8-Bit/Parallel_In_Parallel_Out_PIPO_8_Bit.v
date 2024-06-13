/* 
Verilog Code to implement a ParParallel-In-Parallel-Out - PIPO - 8-Bit Shift Register.



Author - Prasad Narayan Ghatol
*/



module Parallel_In_Parallel_Out_PIPO_8_Bit(
    input            Clk_In,
    input            Reset_In,

    input      [7:0] Parallel_Data_In,
    output reg [7:0] Parallel_Data_Out
);



// --------------------------------------------------
// Parallel-In-Parallel-Out - PIPO - 8-Bit Shift Register Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Parallel_Data_Out <= 8'b0;
            end
        else
            begin
                Parallel_Data_Out[0] <= Parallel_Data_In[0];
                Parallel_Data_Out[1] <= Parallel_Data_In[1];
                Parallel_Data_Out[2] <= Parallel_Data_In[2];
                Parallel_Data_Out[3] <= Parallel_Data_In[3];
                Parallel_Data_Out[4] <= Parallel_Data_In[4];
                Parallel_Data_Out[5] <= Parallel_Data_In[5];
                Parallel_Data_Out[6] <= Parallel_Data_In[6];
                Parallel_Data_Out[7] <= Parallel_Data_In[7];
            end
    end



endmodule