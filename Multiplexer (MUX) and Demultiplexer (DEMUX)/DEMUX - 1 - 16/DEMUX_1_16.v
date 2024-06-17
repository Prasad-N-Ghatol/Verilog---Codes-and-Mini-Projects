/*
Verilog Code, to implement a 1:16 DEMUX.



Author : Prasad Narayan Ghatol
*/



module DEMUX_1_16 (
    input        Enable_In,

    input        Data_In,
    
    input  [3:0] Select_In,
    
    output       Data_0_Out,
    output       Data_1_Out,
    output       Data_2_Out,
    output       Data_3_Out,
    output       Data_4_Out,
    output       Data_5_Out,
    output       Data_6_Out,
    output       Data_7_Out,
    output       Data_8_Out,
    output       Data_9_Out,
    output       Data_10_Out,
    output       Data_11_Out,
    output       Data_12_Out,
    output       Data_13_Out,
    output       Data_14_Out,
    output       Data_15_Out
);



// --------------------------------------------------
// 1:16 DEMUX Logic
// --------------------------------------------------
assign Data_0_Out  = Enable_In ? ((Select_In == 4'd0)  ? Data_In : 1'b0) : 1'bZ;
assign Data_1_Out  = Enable_In ? ((Select_In == 4'd1)  ? Data_In : 1'b0) : 1'bZ;
assign Data_2_Out  = Enable_In ? ((Select_In == 4'd2)  ? Data_In : 1'b0) : 1'bZ;
assign Data_3_Out  = Enable_In ? ((Select_In == 4'd3)  ? Data_In : 1'b0) : 1'bZ;
assign Data_4_Out  = Enable_In ? ((Select_In == 4'd4)  ? Data_In : 1'b0) : 1'bZ;
assign Data_5_Out  = Enable_In ? ((Select_In == 4'd5)  ? Data_In : 1'b0) : 1'bZ;
assign Data_6_Out  = Enable_In ? ((Select_In == 4'd6)  ? Data_In : 1'b0) : 1'bZ;
assign Data_7_Out  = Enable_In ? ((Select_In == 4'd7)  ? Data_In : 1'b0) : 1'bZ;

assign Data_8_Out  = Enable_In ? ((Select_In == 4'd8)  ? Data_In : 1'b0) : 1'bZ;
assign Data_9_Out  = Enable_In ? ((Select_In == 4'd9)  ? Data_In : 1'b0) : 1'bZ;
assign Data_10_Out = Enable_In ? ((Select_In == 4'd10) ? Data_In : 1'b0) : 1'bZ;
assign Data_11_Out = Enable_In ? ((Select_In == 4'd11) ? Data_In : 1'b0) : 1'bZ;
assign Data_12_Out = Enable_In ? ((Select_In == 4'd12) ? Data_In : 1'b0) : 1'bZ;
assign Data_13_Out = Enable_In ? ((Select_In == 4'd13) ? Data_In : 1'b0) : 1'bZ;
assign Data_14_Out = Enable_In ? ((Select_In == 4'd14) ? Data_In : 1'b0) : 1'bZ;
assign Data_15_Out = Enable_In ? ((Select_In == 4'd15) ? Data_In : 1'b0) : 1'bZ;



endmodule