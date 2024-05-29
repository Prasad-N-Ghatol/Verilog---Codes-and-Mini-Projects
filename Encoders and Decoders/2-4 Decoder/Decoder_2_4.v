/*
Verilog Code, to implement a 2-4 Decoder.



Author : Prasad Narayan Ghatol
*/



module Decoder_2_4 (
    input        Reset_In,

    input  [1:0] Encoded_Value_In,
    output       Data_A_Out,
    output       Data_B_Out,
    output       Data_C_Out,
    output       Data_D_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg [3:0] Decoded_Value;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Data_A_Out = Decoded_Value[3];
assign Data_B_Out = Decoded_Value[2];
assign Data_C_Out = Decoded_Value[1];
assign Data_D_Out = Decoded_Value[0];



// --------------------------------------------------
// 2-4 Decoder Logic
// --------------------------------------------------
always @ (*)
    begin
        if (Reset_In)
            begin
                Decoded_Value <= 4'b0000;
            end
        else
            begin
                case (Encoded_Value_In)
                    2'b00 : // Data A
                        begin
                            Decoded_Value <= 4'b1000;
                        end
                    2'b01 : // Data B
                        begin
                            Decoded_Value <= 4'b0100;
                        end
                    2'b10 : // Data C
                        begin
                            Decoded_Value <= 4'b0010;
                        end
                    2'b11 : // Data D
                        begin
                            Decoded_Value <= 4'b0001;
                        end
                    default: 
                        begin
                            Decoded_Value <= 4'b0000;
                        end
                endcase
            end
    end



endmodule