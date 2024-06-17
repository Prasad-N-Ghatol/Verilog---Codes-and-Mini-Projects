/*
Verilog Code, to implement a 1:4 DEMUX.



Author : Prasad Narayan Ghatol
*/



module DEMUX_1_4 (
    input        Enable_In,

    input        Data_In,
    
    input  [1:0] Select_In,
    
    output       Data_0_Out,
    output       Data_1_Out,
    output       Data_2_Out,
    output       Data_3_Out
);



// --------------------------------------------------
// 1:4 DEMUX Logic
// --------------------------------------------------
assign Data_0_Out = Enable_In ? ((Select_In == 2'd0) ? Data_In : 1'b0) : 1'bZ;
assign Data_1_Out = Enable_In ? ((Select_In == 2'd1) ? Data_In : 1'b0) : 1'bZ;
assign Data_2_Out = Enable_In ? ((Select_In == 2'd2) ? Data_In : 1'b0) : 1'bZ;
assign Data_3_Out = Enable_In ? ((Select_In == 2'd3) ? Data_In : 1'b0) : 1'bZ;



endmodule