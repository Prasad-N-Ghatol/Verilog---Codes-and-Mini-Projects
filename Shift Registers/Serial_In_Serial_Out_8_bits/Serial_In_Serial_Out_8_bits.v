/* 
Verilog Code to implement a Serial-In-Serial-Out (SISO) Shift Register.

This SISO consists of a 8-bit Shift Register.

Author - Prasad Narayan Ghatol
*/

module Serial_In_Serial_Out_8_bits(
    input Clk_In,                   // Apply the Clock Input to the Design
    input Reset_In,                 // Reset Signal, to reset the Design
    input Serial_Data_In,           // Apply the Serial Data Input to the Design 
    output reg Serial_Data_Out,     // Serial Data Output of the Design

    // Debug Port, to see the data getting shifted
    output reg [7:0] SISO_Shift_Register    // Debug Port, for displaying the values in the Sifht Register
);


// Loop Counter
integer count;


// Implement the SISO Shift Register
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In == 1'b1)
            begin
                SISO_Shift_Register <= 8'h0;
            end
        else
            begin
                SISO_Shift_Register[7] <= Serial_Data_In;
                
                for (count = 7; count > 0; count = count - 1)
                    begin
                        SISO_Shift_Register[count-1] <= SISO_Shift_Register[count];
                    end
                
                Serial_Data_Out <= SISO_Shift_Register[0];
            end
    end


endmodule