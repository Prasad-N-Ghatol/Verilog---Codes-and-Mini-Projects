/*
Verilog Code, to implement a 8-3 High Priority Encoder.



Author : Prasad Narayan Ghatol
*/



module High_Priority_Encoder_8_3 (
    input            Reset_In,

    input            Data_0_In,
    input            Data_1_In,
    input            Data_2_In,
    input            Data_3_In,
    input            Data_4_In,
    input            Data_5_In,
    input            Data_6_In,
    input            Data_7_In,
    output reg [2:0] Encoded_Value_Out
);



// --------------------------------------------------
// 8-3 High Priority Encoder Logic
// --------------------------------------------------
always @ (*)
    begin
        if (Reset_In)
            begin
                Encoded_Value_Out <= 3'bz;
            end
        else
            begin
                casex ({Data_0_In, Data_1_In, Data_2_In, Data_3_In, Data_4_In, Data_5_In, Data_6_In, Data_7_In})
                    8'b1xxxxxxx : // Data 0
                        begin
                            Encoded_Value_Out <= 3'b000;
                        end
                    8'b01xxxxxx : // Data 1
                        begin
                            Encoded_Value_Out <= 3'b001;
                        end
                    8'b001xxxxx : // Data 2
                        begin
                            Encoded_Value_Out <= 3'b010;
                        end
                    8'b0001xxxx : // Data 3
                        begin
                            Encoded_Value_Out <= 3'b011;
                        end
                    8'b00001xxx : // Data 4
                        begin
                            Encoded_Value_Out <= 3'b100;
                        end
                    8'b000001xx : // Data 5
                        begin
                            Encoded_Value_Out <= 3'b101;
                        end
                    8'b0000001x : // Data 6
                        begin
                            Encoded_Value_Out <= 3'b110;
                        end
                    8'b00000001 : // Data 7
                        begin
                            Encoded_Value_Out <= 3'b111;
                        end
                    default: 
                        begin
                            Encoded_Value_Out <= 3'bz;
                        end
                endcase
            end
    end



endmodule