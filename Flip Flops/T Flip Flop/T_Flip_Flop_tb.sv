/*
SystemVerilog Testbench for T Flip Flop.



Author : Prasad Narayan Ghatol
*/



module T_Flip_Flop_tb ();



reg  Clk_In;
reg  Reset_In;

reg  T_In;
wire Q_Out;
wire Qb_Out;



// --------------------------------------------------
// T_Flip_Flop DUT Instantiation
// --------------------------------------------------
T_Flip_Flop DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),

    .T_In(T_In),
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
                T_In = $random;
                #10;
            end
        
        $stop;
    end



    endmodule