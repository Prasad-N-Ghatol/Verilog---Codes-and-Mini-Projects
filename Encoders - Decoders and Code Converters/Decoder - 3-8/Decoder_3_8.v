/*
Verilog Code, to implement a 3-8 Decoder.



Author : Prasad Narayan Ghatol
*/



module Decoder_3_8 (
    input        Reset_In,

    input  [2:0] Encoded_Value_In,
    output       Data_0_Out,
    output       Data_1_Out,
    output       Data_2_Out,
    output       Data_3_Out,
    output       Data_4_Out,
    output       Data_5_Out,
    output       Data_6_Out,
    output       Data_7_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg [7:0] Decoded_Value;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Data_0_Out = Decoded_Value[0];
assign Data_1_Out = Decoded_Value[1];
assign Data_2_Out = Decoded_Value[2];
assign Data_3_Out = Decoded_Value[3];
assign Data_4_Out = Decoded_Value[4];
assign Data_5_Out = Decoded_Value[5];
assign Data_6_Out = Decoded_Value[6];
assign Data_7_Out = Decoded_Value[7];



// --------------------------------------------------
// 3-8 Decoder Logic
// --------------------------------------------------
always @ (*)
    begin
        if (Reset_In)
            begin
                Decoded_Value <= 8'h00;
            end
        else
            begin
                case (Encoded_Value_In)
                    3'b000 : // Data 0
                        begin
                            Decoded_Value <= 8'h01;
                        end
                    3'b001 : // Data 1
                        begin
                            Decoded_Value <= 8'h02;
                        end
                    3'b010 : // Data 2
                        begin
                            Decoded_Value <= 8'h04;
                        end
                    3'b011 : // Data 3
                        begin
                            Decoded_Value <= 8'h08;
                        end
                    3'b100 : // Data 4
                        begin
                            Decoded_Value <= 8'h10;
                        end
                    3'b101 : // Data 5
                        begin
                            Decoded_Value <= 8'h20;
                        end
                    3'b110 : // Data 6
                        begin
                            Decoded_Value <= 8'h40;
                        end
                    3'b111 : // Data 7
                        begin
                            Decoded_Value <= 8'h80;
                        end
                    default: 
                        begin
                            Decoded_Value <= 8'h00;
                        end
                endcase
            end
    end



endmodule