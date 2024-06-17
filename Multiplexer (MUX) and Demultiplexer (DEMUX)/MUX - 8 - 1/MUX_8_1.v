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
            3'd0 : Multiplexed_Data <= Data_0_In;
            3'd1 : Multiplexed_Data <= Data_1_In;
            3'd2 : Multiplexed_Data <= Data_2_In;
            3'd3 : Multiplexed_Data <= Data_3_In;
            3'd4 : Multiplexed_Data <= Data_4_In;
            3'd5 : Multiplexed_Data <= Data_5_In;
            3'd6 : Multiplexed_Data <= Data_6_In;
            3'd7 : Multiplexed_Data <= Data_7_In;

            default : Multiplexed_Data <= 1'b0;
        endcase
    end



endmodule