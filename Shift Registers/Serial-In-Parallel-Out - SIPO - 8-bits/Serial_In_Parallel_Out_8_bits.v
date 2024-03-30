/* 
Verilog Code to implement a Serial-In-Parallel-Out (SIPO) Shift Register.

This SIPO consists of a 8-bit Shift Register.

Author - Prasad Narayan Ghatol
*/

module Serial_In_Parallel_Out_8_bits(
    input Clk_In,                   // Apply the Clock Input to the Design
    input Reset_In,                 // Reset Signal, to reset the Design
    input Serial_Data_In,           // Apply the Serial Data Input to the Design 
    output [7:0] Parallel_Data_Out, // Parallel Data Output of the Design

    // Debug Port, to see the data getting shifted
    output reg [7:0] SIPO_Shift_Register    // Debug Port, for displaying the values in the Shift Register
);


// Loop Counter
integer count;


// Assigning values Parallel Data Out Port
assign Parallel_Data_Out = SIPO_Shift_Register;


// Implement the SIPO Shift Register
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In == 1'b1)
            begin
                SIPO_Shift_Register <= 8'h0;
            end
        else
            begin
                SIPO_Shift_Register[7] <= Serial_Data_In;
                
                for (count = 7; count > 0; count = count - 1)
                    begin
                        SIPO_Shift_Register[count-1] <= SIPO_Shift_Register[count];
                    end
            end
    end


endmodule