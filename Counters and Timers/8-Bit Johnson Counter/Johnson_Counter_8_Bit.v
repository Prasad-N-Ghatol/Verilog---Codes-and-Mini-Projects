/*
Verilog Code, to implement a 8-Bit Johnson Counter.



Author : Prasad Narayan Ghatol
*/



module Johnson_Counter_8_Bit (
    input            Clk_In,
    input            Reset_In,

    input            Start_Stopb_In,
    output reg [7:0] Count_Out
);



// --------------------------------------------------
// 8-Bit Johnson Counter Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Count_Out <= 8'b10000000;
            end
        else if (Start_Stopb_In)
            begin
                Count_Out[7] <= ~Count_Out[0];
                Count_Out[6] <= Count_Out[7];
                Count_Out[5] <= Count_Out[6];
                Count_Out[4] <= Count_Out[5];
                Count_Out[3] <= Count_Out[4];
                Count_Out[2] <= Count_Out[3];
                Count_Out[1] <= Count_Out[2];
                Count_Out[0] <= Count_Out[1];
            end
        else
            begin
                Count_Out <= Count_Out;
            end
    end



endmodule