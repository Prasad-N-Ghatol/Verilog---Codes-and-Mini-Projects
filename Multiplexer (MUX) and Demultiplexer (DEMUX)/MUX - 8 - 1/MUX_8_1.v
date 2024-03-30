/*
Verilog Code to implement a 8:1 MUX.

Author - Prasad Narayan Ghatol
*/

module MUX_8_1 (
    input       Enable_In,  // Enable Line to enable the MUX Circuit.
    input       Data_0_In,
    input       Data_1_In,
    input       Data_2_In,
    input       Data_3_In,
    input       Data_4_In,
    input       Data_5_In,
    input       Data_6_In,
    input       Data_7_In,
    input [2:0] Select_In,  // Select_In Line, to select the Input Data Line.
    output      MUX_Data_Out
);

// Reg to hold the Multiplexed Data
reg Multiplexed_Data;

// Assign the Multiplexed Data to the Output, when Enable_In is enabled
assign MUX_Data_Out = Enable_In ? Multiplexed_Data : 1'bZ;

// MUX Logic
always @ (*)
    begin
        case (Select_In)
            3'b000 :
                begin 
                    Multiplexed_Data <= Data_0_In;
                end
            3'b001 :
                begin 
                    Multiplexed_Data <= Data_1_In;
                end
            3'b010 :
                begin 
                    Multiplexed_Data <= Data_2_In;
                end
            3'b011 :
                begin 
                    Multiplexed_Data <= Data_3_In;
                end
            3'b100 :
                begin 
                    Multiplexed_Data <= Data_4_In;
                end
            3'b101 :
                begin 
                    Multiplexed_Data <= Data_5_In;
                end
            3'b110 :
                begin 
                    Multiplexed_Data <= Data_6_In;
                end
            3'b111 :
                begin 
                    Multiplexed_Data <= Data_7_In;
                end
            default :
                begin 
                    Multiplexed_Data <= 1'b0;
                end
        endcase
    end

endmodule