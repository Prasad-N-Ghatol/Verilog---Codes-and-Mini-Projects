/*
Verilog Code, to implement a I2C Clock Generator.



Data Transfer Rates supported by this design

Standard-Mode (Sm)        -> 100 kbit/sec
Fast-Mode (Fm)            -> 400 kbit/sec
Fast-Mode Plus (Fm+)      -> 1   Mbit/sec
High-Speed Mode (Hs-mode) -> 3.4 Mbit/sec



Author : Prasad Narayan Ghatol
*/



module I2C_Clock_Generator 
#(parameter SYS_CLOCK = 100_000_000)
(
    input            Clk_In,
    input            Reset_In,

    input      [2:0] Speed_Mode_In,
    output reg       I2C_Clock_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg  [31:0] I2C_Speed;              // Keeps the count for the I2C Clock
reg  [9:0]  I2C_Counter;            // Counter to be used for generating the desired frequency Clock for I2C Transmission

wire [31:0] I2C_Half_Period_Value;  // Half Period Value, for each On and Off Part of the CLock

reg  [2:0] Latched_Speed_Mode_In;   // Latched value of Speed Mode
wire       Speed_Changed;           // To check if I2C Speed has to be changed or not



// --------------------------------------------------
// Speed Decoder
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In or posedge Speed_Changed)
    begin
        if (Reset_In)
            begin
                I2C_Speed <= 32'd400_000;
            end
        else
            begin
                case (Speed_Mode_In)
                    3'b000 : // Standard-Mode (Sm)        -> 100 kbit/sec
                        begin
                            I2C_Speed <= 32'd100_000;
                        end
                    3'b001 : // Fast-Mode (Fm)            -> 400 kbit/sec
                        begin
                            I2C_Speed <= 32'd400_000;
                        end
                    3'b010 : // Fast-Mode Plus (Fm+)      -> 1   Mbit/sec
                        begin
                            I2C_Speed <= 32'd1000_000;
                        end
                    3'b011 : // High-Speed Mode (Hs-mode) -> 3.4 Mbit/sec
                        begin
                            I2C_Speed <= 32'd3400_000;
                        end
                    default : // Fast-Mode (Fm)            -> 400 kbit/sec
                        begin
                            I2C_Speed <= 32'd400_000;
                        end
                endcase
            end
    end



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign I2C_Half_Period_Value = SYS_CLOCK / (I2C_Speed * 2);

assign Speed_Changed = (Latched_Speed_Mode_In == Speed_Mode_In) ? 1'b0 : 1'b1;



// --------------------------------------------------
// Other Modules
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Latched_Speed_Mode_In <= 2'b0;
            end
        else
            begin
                Latched_Speed_Mode_In <= Speed_Mode_In;
            end
    end



// --------------------------------------------------
// Clock Generator Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In or posedge Speed_Changed)
    begin
        if (Reset_In)
            begin
                I2C_Counter <= 10'b0;
                I2C_Clock_Out <= 1'b0;
            end
        else if (Speed_Changed)
            begin
                I2C_Counter <= 10'b0;
                I2C_Clock_Out <= 1'b0;
            end
        else
            begin
                if (I2C_Counter == I2C_Half_Period_Value)
                    begin
                        I2C_Counter <= 10'b0;
                        I2C_Clock_Out <= ~I2C_Clock_Out;
                    end
                else
                    begin
                        I2C_Counter <= I2C_Counter + 1'b1;
                        I2C_Clock_Out <= I2C_Clock_Out;
                    end
            end
    end



endmodule