/*
Verilog Code to implement a 1:2 DEMUX.

This design has a Active High Output.

Author - Prasad Narayan Ghatol
*/

module DEMUX_1_2 (
    input Enable_In,    // Enable Line to enable the DEMUX Circuit.
    input Data_In,      // Data Input to the DEMUX.
    input Select_In,    // Select_In Line, to select the Output Data Line.
    output Data_0_Out,
    output Data_1_Out
);

reg Data_0_Wire;
reg Data_1_Wire;

assign Data_0_Out = Enable_In ? Data_0_Wire : 1'bZ;
assign Data_1_Out = Enable_In ? Data_1_Wire : 1'bZ;

// DEMUX Logic
always @ (*)
    begin
        case (Select_In)
            1'b0 :
                begin
                    Data_0_Wire <= Data_In;
                    Data_1_Wire <= 1'b0;
                end
            1'b1 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= Data_In;
                end
            default :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                end
        endcase
    end

endmodule