/*
Verilog Code to implement a T Flip Flop.



Author : Prasad Narayan Ghatol
*/



module T_Flip_Flop (
    input      Clk_In,
    input      Reset_In,

    input      T_In,
    output reg Q_Out,
    output     Qb_Out
);



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Qb_Out = ~Q_Out;



// --------------------------------------------------
// T Flip Flop
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Q_Out <= 1'b0;
            end
        else
            begin
                if (T_In)
                    begin
                        Q_Out <= ~Q_Out;
                    end
                else
                    begin
                        Q_Out <= Q_Out;
                    end
            end
    end



endmodule