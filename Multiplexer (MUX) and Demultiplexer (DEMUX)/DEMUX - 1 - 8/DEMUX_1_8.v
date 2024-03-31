/*
Verilog Code to implement a 1:8 DEMUX.

This design has a Active High Output.

Author - Prasad Narayan Ghatol
*/

module DEMUX_1_8 (
    input       Enable_In,  // Enable Line to enable the DEMUX Circuit.
    input       Data_In,    // Data Input to the DEMUX.
    input [2:0] Select_In,  // Select_In Line, to select the Output Data Line.
    output      Data_0_Out,
    output      Data_1_Out,
    output      Data_2_Out,
    output      Data_3_Out,
    output      Data_4_Out,
    output      Data_5_Out,
    output      Data_6_Out,
    output      Data_7_Out
);

reg Data_0_Wire;
reg Data_1_Wire;
reg Data_2_Wire;
reg Data_3_Wire;
reg Data_4_Wire;
reg Data_5_Wire;
reg Data_6_Wire;
reg Data_7_Wire;

assign Data_0_Out = Enable_In ? Data_0_Wire : 1'bZ;
assign Data_1_Out = Enable_In ? Data_1_Wire : 1'bZ;
assign Data_2_Out = Enable_In ? Data_2_Wire : 1'bZ;
assign Data_3_Out = Enable_In ? Data_3_Wire : 1'bZ;
assign Data_4_Out = Enable_In ? Data_4_Wire : 1'bZ;
assign Data_5_Out = Enable_In ? Data_5_Wire : 1'bZ;
assign Data_6_Out = Enable_In ? Data_6_Wire : 1'bZ;
assign Data_7_Out = Enable_In ? Data_7_Wire : 1'bZ;

// DEMUX Logic
always @ (*)
    begin
        case (Select_In)
            3'b000 :
                begin
                    Data_0_Wire <= Data_In;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                    Data_4_Wire <= 1'b0;
                    Data_5_Wire <= 1'b0;
                    Data_6_Wire <= 1'b0;
                    Data_7_Wire <= 1'b0;
                end
            3'b001 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= Data_In;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                    Data_4_Wire <= 1'b0;
                    Data_5_Wire <= 1'b0;
                    Data_6_Wire <= 1'b0;
                    Data_7_Wire <= 1'b0;
                end
            3'b010 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= Data_In;
                    Data_3_Wire <= 1'b0;
                    Data_4_Wire <= 1'b0;
                    Data_5_Wire <= 1'b0;
                    Data_6_Wire <= 1'b0;
                    Data_7_Wire <= 1'b0;
                end
            3'b011 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= Data_In;
                    Data_4_Wire <= 1'b0;
                    Data_5_Wire <= 1'b0;
                    Data_6_Wire <= 1'b0;
                    Data_7_Wire <= 1'b0;
                end
            3'b100 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                    Data_4_Wire <= Data_In;
                    Data_5_Wire <= 1'b0;
                    Data_6_Wire <= 1'b0;
                    Data_7_Wire <= 1'b0;
                end
            3'b101 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                    Data_4_Wire <= 1'b0;
                    Data_5_Wire <= Data_In;
                    Data_6_Wire <= 1'b0;
                    Data_7_Wire <= 1'b0;
                end
            3'b110 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                    Data_4_Wire <= 1'b0;
                    Data_5_Wire <= 1'b0;
                    Data_6_Wire <= Data_In;
                    Data_7_Wire <= 1'b0;
                end
            3'b111 :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                    Data_4_Wire <= 1'b0;
                    Data_5_Wire <= 1'b0;
                    Data_6_Wire <= 1'b0;
                    Data_7_Wire <= Data_In;
                end
            default :
                begin
                    Data_0_Wire <= 1'b0;
                    Data_1_Wire <= 1'b0;
                    Data_2_Wire <= 1'b0;
                    Data_3_Wire <= 1'b0;
                    Data_4_Wire <= 1'b0;
                    Data_5_Wire <= 1'b0;
                    Data_6_Wire <= 1'b0;
                    Data_7_Wire <= 1'b0;
                end
        endcase
    end

endmodule