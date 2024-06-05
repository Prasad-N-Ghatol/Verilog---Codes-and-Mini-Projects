/*
Verilog Code, to implement a 4-2 High Priority Encoder.



Author : Prasad Narayan Ghatol
*/



module High_Priority_Encoder_4_2 (
    input            Reset_In,

    input            Data_0_In,
    input            Data_1_In,
    input            Data_2_In,
    input            Data_3_In,
    output reg [1:0] Encoded_Value_Out
);



// --------------------------------------------------
// 4-2 High Priority Encoder Logic
// --------------------------------------------------
always @ (*)
    begin
        if (Reset_In)
            begin
                Encoded_Value_Out <= 2'bz;
            end
        else
            begin
                casex ({Data_0_In, Data_1_In, Data_2_In, Data_3_In})
                    4'b1xxx : // Data 0
                        begin
                            Encoded_Value_Out <= 2'b00;
                        end
                    4'b01xx : // Data 1
                        begin
                            Encoded_Value_Out <= 2'b01;
                        end
                    4'b001x : // Data 2
                        begin
                            Encoded_Value_Out <= 2'b10;
                        end
                    4'b0001 : // Data 3
                        begin
                            Encoded_Value_Out <= 2'b11;
                        end
                    default: 
                        begin
                            Encoded_Value_Out <= 2'bz;
                        end
                endcase
            end
    end



endmodule