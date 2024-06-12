/*
Verilog Code, to implement a 2-4 Decoder.



Author : Prasad Narayan Ghatol
*/



module Decoder_2_4 (
    input        Reset_In,

    input  [1:0] Encoded_Value_In,
    output       Data_0_Out,
    output       Data_1_Out,
    output       Data_2_Out,
    output       Data_3_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg [3:0] Decoded_Value;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Data_0_Out = Decoded_Value[0];
assign Data_1_Out = Decoded_Value[1];
assign Data_2_Out = Decoded_Value[2];
assign Data_3_Out = Decoded_Value[3];



// --------------------------------------------------
// 2-4 Decoder Logic
// --------------------------------------------------
always @ (*)
    begin
        if (Reset_In)
            begin
                Decoded_Value <= 4'h0;
            end
        else
            begin
                case (Encoded_Value_In)
                    2'b00 : // Data 0
                        begin
                            Decoded_Value <= 4'h1;
                        end
                    2'b01 : // Data 1
                        begin
                            Decoded_Value <= 4'h2;
                        end
                    2'b10 : // Data 2
                        begin
                            Decoded_Value <= 4'h4;
                        end
                    2'b11 : // Data 3
                        begin
                            Decoded_Value <= 4'h8;
                        end
                    default: 
                        begin
                            Decoded_Value <= 4'h0;
                        end
                endcase
            end
    end



endmodule