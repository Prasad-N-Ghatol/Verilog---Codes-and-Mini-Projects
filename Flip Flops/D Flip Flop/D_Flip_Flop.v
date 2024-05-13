/*
Verilog Code to implement a D Flip Flop.



Author : Prasad Narayan Ghatol
*/



module D_Flip_Flop (
    input      Clk_In,
    input      Reset_In,

    input      D_In,
    output reg Q_Out,
    output     Qb_Out
);



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Qb_Out = ~Q_Out;



// --------------------------------------------------
// D Flip Flop
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Q_Out <= 1'b0;
            end
        else
            begin
                Q_Out <= D_In;
            end
    end



endmodule