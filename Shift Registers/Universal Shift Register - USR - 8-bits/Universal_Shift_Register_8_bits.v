/* 
Verilog Code to implement a Universal Shift Register.

This Universal Shift Register consists of a 8-bit Shift Register.

Author - Prasad Narayan Ghatol
*/
module Universal_Shift_Register_8_bits (
    input Clk_In,                       // Apply the Clock Input to the Design
    input Reset_In,                     // Reset Signal, to reset the Design
    input [1:0] Mode_In,                // Mode to select the operation of the Shift Register.
    input Serial_Data_Right_In,         // Apply the Serial Data Right Input to the Design 
    input Serial_Data_Left_In,          // Apply the Serial Data Left Input to the Design 
    input [7:0] Parallel_Data_In,       // Apply the Parallel Data Input to the Design 
    output Serial_Data_Out,             // Serial Data Output of the Design
    output [7:0] Parallel_Data_Out,     // Parallel Data Output of the Design

    // Debug Port, to see the data getting shifted
    output reg [7:0] Shift_Register    // Debug Port, for displaying the values in the Shift Register
);


// Declaring Constants
localparam  NO_CHANGE = 2'b00,
            SHIFT_RIGHT = 2'b01,
            SHIFT_LEFT = 2'b10,
            LOAD_PARALLEL = 2'b11;


// Assigning values
assign Parallel_Data_Out = Shift_Register;
assign Serial_Data_Out = Shift_Register[0];


// Loop Counter
integer count;


// Universal Shift Register Logic
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Shift_Register <= 8'b0;
            end
        else
            begin
                case (Mode_In)
                    NO_CHANGE : // 2'b00
                        begin
                            Shift_Register <= Shift_Register;
                        end

                    SHIFT_RIGHT : // 2'b01
                        begin
                            Shift_Register[7] <= Serial_Data_Left_In;
                            for (count = 7; count > 0; count = count - 1)
                                begin
                                    Shift_Register[count-1] <= Shift_Register[count];
                                end
                        end

                    SHIFT_LEFT : // 2'b10
                        begin
                            Shift_Register[0] <= Serial_Data_Right_In;
                            for (count = 7; count > 0; count = count - 1)
                                begin
                                    Shift_Register[count] <= Shift_Register[count-1];
                                end
                        end

                    LOAD_PARALLEL : // 2'b11
                        begin
                            Shift_Register <= Parallel_Data_In;
                        end

                    default : 
                        begin
                            Shift_Register <= Shift_Register;
                        end

                endcase
            end
    end


endmodule