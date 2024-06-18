/*
SystemVerilog Testbench for the PWM Generator.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module PWM_Generator_tb ();



reg         Clk_In;
reg         Reset_In;

reg         PWM_Enable_In;
reg         PWM_Normal_Invertedb_In;
reg  [31:0] PWM_Period_ns_In;
reg  [31:0] PWM_Duty_Cycle_ns_In;

wire        PWM_Signal_Out;



// --------------------------------------------------
// PWM Generator DUT Instantiation
// --------------------------------------------------
PWM_Generator DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),

    .PWM_Enable_In(PWM_Enable_In),
    .PWM_Normal_Invertedb_In(PWM_Normal_Invertedb_In),
    .PWM_Period_ns_In(PWM_Period_ns_In),
    .PWM_Duty_Cycle_ns_In(PWM_Duty_Cycle_ns_In),

    .PWM_Signal_Out(PWM_Signal_Out)
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
        PWM_Enable_In = 1'b0;
        #10;
        Reset_In = 1'b0;

        PWM_Period_ns_In     = 32'd2_000;
        PWM_Duty_Cycle_ns_In = 32'd1_500;
        
        PWM_Enable_In = 1'b1;
        
        PWM_Normal_Invertedb_In = 1'b1;
        #100_000;
        PWM_Normal_Invertedb_In = 1'b0;
        #100_000;
        
        PWM_Duty_Cycle_ns_In = 32'd700;
        PWM_Normal_Invertedb_In = 1'b1;
        #100_000;
        PWM_Normal_Invertedb_In = 1'b0;
        #100_000;
        
        PWM_Enable_In = 1'b0;
        #10;
        PWM_Period_ns_In     = 32'd5_000;
        PWM_Duty_Cycle_ns_In = 32'd4_000;
        #10;
        PWM_Enable_In = 1'b1;
        
        PWM_Normal_Invertedb_In = 1'b1;
        #250_000;
        PWM_Normal_Invertedb_In = 1'b0;
        #250_000;
        
        PWM_Duty_Cycle_ns_In = 32'd2_250;
        PWM_Normal_Invertedb_In = 1'b1;
        #250_000;
        PWM_Normal_Invertedb_In = 1'b0;
        #250_000;

        PWM_Enable_In = 1'b0;

        $stop;
    end



endmodule