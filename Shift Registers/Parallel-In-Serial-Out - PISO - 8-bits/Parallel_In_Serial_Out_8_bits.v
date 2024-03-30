/* 
Verilog Code to implement a Parallel-In-Serial-Out (PISO) Shift Register.

This PISO consists of a 8-bit Shift Register.

Author - Prasad Narayan Ghatol
*/

module Parallel_In_Serial_Out_8_bits(
    input Clk_In,                   // Apply the Clock Input to the Design
    input Reset_In,                 // Reset Signal, to reset the Design
    input Load_Shiftb_In,           // Load / Shift Signal to Load the Input value into the Register, or Shift the Data Serially Out
    input [7:0] Parallel_Data_In,   // Apply the Parallel Data Input to the Design 
    output Serial_Data_Out,     // Serial Data Output of the Design

    // Debug Port, to see the data getting shifted
    output reg [7:0] PISO_Shift_Register    // Debug Port, for displaying the values in the Shift Register
);


// Loop Counter
integer count;


// Assigning the value to the Serial_Data_Out
assign Serial_Data_Out = PISO_Shift_Register[0];


// Implement the PISO Shift Register
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In == 1'b1)
            begin
                PISO_Shift_Register <= 8'h0;
            end
        else if (Load_Shiftb_In == 1'b1)
            begin
                PISO_Shift_Register <= Parallel_Data_In;
            end
        else
            begin
                PISO_Shift_Register[7] <= 1'b1;
                
                for (count = 7; count > 0; count = count - 1)
                    begin
                        PISO_Shift_Register[count-1] <= PISO_Shift_Register[count];
                    end
            end
    end


endmodule