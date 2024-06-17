/*
Verilog Code, to implement a 2:1 MUX.



Author : Prasad Narayan Ghatol
*/



module MUX_2_1 (
    input  Enable_In,

    input  Select_In,

    input  Data_0_In,
    input  Data_1_In,

    output MUX_Data_Out
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
// 2:1 MUX Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            1'd0 : Multiplexed_Data <= Data_0_In;
            1'd1 : Multiplexed_Data <= Data_1_In;

            default : Multiplexed_Data <= 1'b0;
        endcase
    end



endmodule