/*
Verilog Code, to implement a 16:1 MUX.



Author : Prasad Narayan Ghatol
*/



module MUX_16_1 (
    input        Enable_In,

    input  [3:0] Select_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,
    input        Data_4_In,
    input        Data_5_In,
    input        Data_6_In,
    input        Data_7_In,
    input        Data_8_In,
    input        Data_9_In,
    input        Data_10_In,
    input        Data_11_In,
    input        Data_12_In,
    input        Data_13_In,
    input        Data_14_In,
    input        Data_15_In,

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
// 16:1 MUX Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            4'd0  : Multiplexed_Data <= Data_0_In;
            4'd1  : Multiplexed_Data <= Data_1_In;
            4'd2  : Multiplexed_Data <= Data_2_In;
            4'd3  : Multiplexed_Data <= Data_3_In;
            4'd4  : Multiplexed_Data <= Data_4_In;
            4'd5  : Multiplexed_Data <= Data_5_In;
            4'd6  : Multiplexed_Data <= Data_6_In;
            4'd7  : Multiplexed_Data <= Data_7_In;

            4'd8  : Multiplexed_Data <= Data_8_In;
            4'd9  : Multiplexed_Data <= Data_9_In;
            4'd10 : Multiplexed_Data <= Data_10_In;
            4'd11 : Multiplexed_Data <= Data_11_In;
            4'd12 : Multiplexed_Data <= Data_12_In;
            4'd13 : Multiplexed_Data <= Data_13_In;
            4'd14 : Multiplexed_Data <= Data_14_In;
            4'd15 : Multiplexed_Data <= Data_15_In;

            default : Multiplexed_Data <= 1'b0;
        endcase
    end



endmodule