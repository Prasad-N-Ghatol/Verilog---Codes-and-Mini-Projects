/*
Verilog Code, to implement a PWM Generator.



Author : Prasad Narayan Ghatol
*/



module PWM_Generator (
    input         Clk_In,
    input         Reset_In,

    input         PWM_Enable_In,
    input         PWM_Normal_Invertedb_In,
    input  [31:0] PWM_Period_ns_In,
    input  [31:0] PWM_Duty_Cycle_ns_In,

    output        PWM_Signal_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
wire        Valid_Duty_Cycle;

reg  [31:0] Signal_Period;
wire [31:0] Signal_On_Period;

reg  [31:0] Counter;

reg         PWM_Signal;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Valid_Duty_Cycle = (PWM_Duty_Cycle_ns_In <= PWM_Period_ns_In) ? 1'b1 : 1'b0;

assign Signal_On_Period = Valid_Duty_Cycle ? PWM_Duty_Cycle_ns_In : 32'b0;

assign PWM_Signal_Out = PWM_Enable_In ? (PWM_Normal_Invertedb_In ? PWM_Signal : ~PWM_Signal) : 1'bZ;



// --------------------------------------------------
// PWM Generator Logic
// --------------------------------------------------
// Latch in the PWM Period
always @ (posedge PWM_Enable_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Signal_Period <= 32'b0;
            end
        else
            begin
                Signal_Period <= PWM_Period_ns_In;
            end
    end


// Generate PWM Signal
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Counter <= 32'b0;
                PWM_Signal <= 1'b0;
            end
        else if (PWM_Enable_In)
            begin
                if (Counter == Signal_Period)
                    begin
                        Counter <= 32'b0;
                        PWM_Signal <= 1'b0;
                    end
                else if (Counter <= Signal_On_Period)
                    begin
                        Counter <= Counter + 1'b1;
                        PWM_Signal <= 1'b1;
                    end
                else
                    begin
                        Counter <= Counter + 1'b1;
                        PWM_Signal <= 1'b0;
                    end
            end
        else
            begin
                Counter <= 32'b0;
                PWM_Signal <= 1'b0;
            end
    end



endmodule