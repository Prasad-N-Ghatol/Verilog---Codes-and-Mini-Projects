/*
Verilog Code, to implement a 32:1 MUX.



Author : Prasad Narayan Ghatol
*/



module MUX_32_1 (
    input        Enable_In,

    input  [4:0] Select_In,

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
    input        Data_16_In,
    input        Data_17_In,
    input        Data_18_In,
    input        Data_19_In,
    input        Data_20_In,
    input        Data_21_In,
    input        Data_22_In,
    input        Data_23_In,
    input        Data_24_In,
    input        Data_25_In,
    input        Data_26_In,
    input        Data_27_In,
    input        Data_28_In,
    input        Data_29_In,
    input        Data_30_In,
    input        Data_31_In,

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
// 32:1 MUX Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            5'd0  : Multiplexed_Data <= Data_0_In;
            5'd1  : Multiplexed_Data <= Data_1_In;
            5'd2  : Multiplexed_Data <= Data_2_In;
            5'd3  : Multiplexed_Data <= Data_3_In;
            5'd4  : Multiplexed_Data <= Data_4_In;
            5'd5  : Multiplexed_Data <= Data_5_In;
            5'd6  : Multiplexed_Data <= Data_6_In;
            5'd7  : Multiplexed_Data <= Data_7_In;

            5'd8  : Multiplexed_Data <= Data_8_In;
            5'd9  : Multiplexed_Data <= Data_9_In;
            5'd10 : Multiplexed_Data <= Data_10_In;
            5'd11 : Multiplexed_Data <= Data_11_In;
            5'd12 : Multiplexed_Data <= Data_12_In;
            5'd13 : Multiplexed_Data <= Data_13_In;
            5'd14 : Multiplexed_Data <= Data_14_In;
            5'd15 : Multiplexed_Data <= Data_15_In;

            5'd16 : Multiplexed_Data <= Data_16_In;
            5'd17 : Multiplexed_Data <= Data_17_In;
            5'd18 : Multiplexed_Data <= Data_18_In;
            5'd19 : Multiplexed_Data <= Data_19_In;
            5'd20 : Multiplexed_Data <= Data_20_In;
            5'd21 : Multiplexed_Data <= Data_21_In;
            5'd22 : Multiplexed_Data <= Data_22_In;
            5'd23 : Multiplexed_Data <= Data_23_In;

            5'd24 : Multiplexed_Data <= Data_24_In;
            5'd25 : Multiplexed_Data <= Data_25_In;
            5'd26 : Multiplexed_Data <= Data_26_In;
            5'd27 : Multiplexed_Data <= Data_27_In;
            5'd28 : Multiplexed_Data <= Data_28_In;
            5'd29 : Multiplexed_Data <= Data_29_In;
            5'd30 : Multiplexed_Data <= Data_30_In;
            5'd31 : Multiplexed_Data <= Data_31_In;

            default : Multiplexed_Data <= 1'b0;
        endcase
    end



endmodule