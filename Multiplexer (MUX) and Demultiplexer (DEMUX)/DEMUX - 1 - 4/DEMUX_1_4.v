/*
Verilog Code to implement a 1:4 DEMUX.

This design has a Active High Output.

Author - Prasad Narayan Ghatol
*/

module DEMUX_1_4 (
    input       Enable_In,  // Enable Line to enable the DEMUX Circuit.
    input       Data_In,    // Data Input to the DEMUX.
    input [1:0] Select_In,  // Select_In Line, to select the Output Data Line.
    output      Data_0_Out,
    output      Data_1_Out,
    output      Data_2_Out,
    output      Data_3_Out
);

reg Data_0_Wire;
reg Data_1_Wire;
reg Data_2_Wire;
reg Data_3_Wire;

assign Data_0_Out = Enable_In ? Data_0_Wire : 1'bZ;
assign Data_1_Out = Enable_In ? Data_1_Wire : 1'bZ;
assign Data_2_Out = Enable_In ? Data_2_Wire : 1'bZ;
assign Data_3_Out = Enable_In ? Data_3_Wire : 1'bZ;

// DEMUX Logic
always @ (*)
    begin
        case (Select_In)
            2'b00 :
                begin
                    Data_0_Wire <= Data_In;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                end
            2'b01 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= Data_In;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                end
            2'b10 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= Data_In;
                    Data_3_Wire <= 1'b0;
                end
            2'b11 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= Data_In;
                end
            default :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                end
        endcase
    end

endmodule