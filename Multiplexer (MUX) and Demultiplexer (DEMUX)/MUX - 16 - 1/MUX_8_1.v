/*
Verilog Code, to implement a 8:1 MUX.



Author : Prasad Narayan Ghatol
*/



module MUX_8_1 (
    input        Enable_In,

    input  [2:0] Select_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,
    input        Data_4_In,
    input        Data_5_In,
    input        Data_6_In,
    input        Data_7_In,

    output       MUX_Data_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg Multiplexed_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign MUX_Data_Out = Enable_In ? Multiplexed_Data : 1'bZ;



// --------------------------------------------------
// 8:1 MUX Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            3'h0 :
                begin 
                    Multiplexed_Data <= Data_0_In;
                end

            3'h1 :
                begin 
                    Multiplexed_Data <= Data_1_In;
                end

            3'h2 :
                begin 
                    Multiplexed_Data <= Data_2_In;
                end

            3'h3 :
                begin 
                    Multiplexed_Data <= Data_3_In;
                end

            3'h4 :
                begin 
                    Multiplexed_Data <= Data_4_In;
                end

            3'h5 :
                begin 
                    Multiplexed_Data <= Data_5_In;
                end

            3'h6 :
                begin 
                    Multiplexed_Data <= Data_6_In;
                end

            3'h7 :
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