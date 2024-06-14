/*
Verilog Code, to implement a 4:1 MUX.



Author : Prasad Narayan Ghatol
*/



module MUX_4_1 (
    input        Enable_In,

    input  [1:0] Select_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,

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
// 4:1 MUX Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            2'h0 :
                begin 
                    Multiplexed_Data <= Data_0_In;
                end

            2'h1 :
                begin 
                    Multiplexed_Data <= Data_1_In;
                end

            2'h2 :
                begin 
                    Multiplexed_Data <= Data_2_In;
                end

            2'h3 :
                begin 
                    Multiplexed_Data <= Data_3_In;
                end

            default :
                begin 
                    Multiplexed_Data <= 1'b0;
                end
        endcase
    end



endmodule