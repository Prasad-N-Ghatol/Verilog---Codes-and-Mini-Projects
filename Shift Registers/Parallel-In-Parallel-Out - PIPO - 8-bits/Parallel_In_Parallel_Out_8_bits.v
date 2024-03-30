/* 
Verilog Code to implement a Parallel-In-Parallel-Out (PIPO) Shift Register.

This PIPO consists of a 8-bit Shift Register.

Author - Prasad Narayan Ghatol
*/
module Parallel_In_Parallel_Out_8_bits(
    input Clk_In,                   // Apply the Clock Input to the Design
    input Reset_In,                 // Reset Signal, to reset the Design
    input [7:0] Parallel_Data_In,   // Apply the Parallel Data Input to the Design 
    output reg [7:0] Parallel_Data_Out  // Parallel Data Output of the Design
);

// Loop Counter
integer count;

// Implement the PIPO Shift Register
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Parallel_Data_Out <= 8'b0;
            end
        else
            begin
                for (count = 7; count >= 0; count = count - 1)
                    begin
                        Parallel_Data_Out[count] <= Parallel_Data_In[count];
                    end
            end
    end

endmodule