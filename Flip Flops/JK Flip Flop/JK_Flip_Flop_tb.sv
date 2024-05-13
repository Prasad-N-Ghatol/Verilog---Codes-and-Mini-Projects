/*
SystemVerilog Testbench for JK Flip Flop.



Author : Prasad Narayan Ghatol
*/



module JK_Flip_Flop_tb ();



reg  Clk_In;
reg  Reset_In;

reg  J_In;
reg  K_In;
wire Q_Out;
wire Qb_Out;



// --------------------------------------------------
// JK_Flip_Flop DUT Instantiation
// --------------------------------------------------
JK_Flip_Flop DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),

    .J_In(J_In),
    .K_In(K_In),
    .Q_Out(Q_Out),
    .Qb_Out(Qb_Out)
);



// --------------------------------------------------
// Clock Initialization
// --------------------------------------------------
initial 
    begin
        Clk_In = 1'b0;

        forever
            begin
                #5;
                Clk_In = ~Clk_In;
            end
    end



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        repeat (10)
            begin
                J_In = $random;
                K_In = $random;
                #10;
            end
        
        $stop;
    end



    endmodule