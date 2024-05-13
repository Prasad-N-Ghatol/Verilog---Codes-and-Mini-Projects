/*
Verilog Code to implement a JK Flip Flop.



Author : Prasad Narayan Ghatol
*/



module JK_Flip_Flop (
    input      Clk_In,
    input      Reset_In,

    input      J_In,
    input      K_In,
    output reg Q_Out,
    output     Qb_Out
);



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Qb_Out = ~Q_Out;



// --------------------------------------------------
// JK Flip Flop
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Q_Out <= 1'b0;
            end
        else
            begin
                case ({J_In, K_In})
                    2'b00 :
                        begin
                            Q_Out <= Q_Out;
                        end
                    2'b01 :
                        begin
                            Q_Out <= 1'b0;
                        end
                    2'b10 :
                        begin
                            Q_Out <= 1'b1;
                        end
                    2'b11 :
                        begin
                            Q_Out <= ~Q_Out;
                        end
                    default :
                        begin
                            Q_Out <= 1'b0;
                        end
                endcase
            end
    end



endmodule