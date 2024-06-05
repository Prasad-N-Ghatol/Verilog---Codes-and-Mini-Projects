/*
Verilog Code, to implement a 4-Bit Up-Down Counter.



Author : Prasad Narayan Ghatol
*/



module Up_Down_Counter_4_Bit (
    input            Clk_In,
    input            Reset_In,

    input            Start_Stopb_In,
    input            Up_Downb_In,
    output reg [3:0] Count_Out
);



// --------------------------------------------------
// 4-Bit Up-Down Counter Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Count_Out <= 4'b0;
            end
        else if (Start_Stopb_In)
            begin
                if (Up_Downb_In)
                    begin
                        Count_Out <= Count_Out + 1'b1;
                    end
                else
                    begin
                        Count_Out <= Count_Out - 1'b1;
                    end
            end
        else
            begin
                Count_Out <= Count_Out;
            end
    end



endmodule