/*
Verilog Code, to implement a 4-Bit MOD Counter.



Author : Prasad Narayan Ghatol
*/



module MOD_Counter_4_Bit (
    input            Clk_In,
    input            Reset_In,

    input            Start_Stopb_In,
    input      [3:0] MOD_Value_In,
    output reg [3:0] Count_Out
);



// --------------------------------------------------
// 4-Bit MOD Counter Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Count_Out <= 4'b0;
            end
        else if (Start_Stopb_In)
            begin
                Count_Out <= Count_Out + 1'b1;

                if (Count_Out == (MOD_Value_In-1'b1))
                    begin
                        Count_Out <= 4'b0;
                    end
            end
        else
            begin
                Count_Out <= Count_Out;
            end
    end



endmodule