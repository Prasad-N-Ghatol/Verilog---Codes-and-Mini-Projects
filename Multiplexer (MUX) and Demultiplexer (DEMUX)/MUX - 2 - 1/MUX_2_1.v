/*
Verilog Code to implement a 2:1 MUX.

Author - Prasad Narayan Ghatol
*/

module MUX_2_1 (
    input Enable_In,    // Enable Line to enable the MUX Circuit.
    input Data_0_In,
    input Data_1_In,
    input Select_In,    // Select_In Line, to select the Input Data Line.
    output MUX_Data_Out
);

// Reg to hold the Multiplexed Data
reg Multiplexed_Data;

// Assign the Multiplexed Data to the Output, when Enable_In is enabled
assign MUX_Data_Out = Enable_In ? Multiplexed_Data : 1'bZ;

// MUX Logic
always @ (*)
    begin
        case (Select_In)
            1'b0 :
                begin 
                    Multiplexed_Data <= Data_0_In;
                end
            1'b1 :
                begin 
                    Multiplexed_Data <= Data_1_In;
                end
            default :
                begin 
                    Multiplexed_Data <= 1'b0;
                end
        endcase
    end

endmodule