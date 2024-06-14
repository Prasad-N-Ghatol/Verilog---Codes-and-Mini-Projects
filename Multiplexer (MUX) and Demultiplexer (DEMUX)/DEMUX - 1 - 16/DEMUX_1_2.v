/*
Verilog Code, to implement a 1:2 DEMUX.



Author : Prasad Narayan Ghatol
*/



module DEMUX_1_2 (
    input  Enable_In,

    input  Data_In,
    
    input  Select_In,
    
    output Data_0_Out,
    output Data_1_Out
);



// --------------------------------------------------
// 1:2 DEMUX Logic
// --------------------------------------------------
assign Data_0_Out = Enable_In ? ((Select_In == 1'd0) ? Data_In : 1'b0) : 1'bZ;
assign Data_1_Out = Enable_In ? ((Select_In == 1'd1) ? Data_In : 1'b0) : 1'bZ;



endmodule