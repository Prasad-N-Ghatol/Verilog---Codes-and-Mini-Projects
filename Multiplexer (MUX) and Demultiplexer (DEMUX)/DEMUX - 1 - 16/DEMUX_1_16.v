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
// wires and regs
// --------------------------------------------------
wire DEMUX_1_Result;
wire DEMUX_2_Result;



// --------------------------------------------------
// 1:16 DEMUX Logic
// --------------------------------------------------
DEMUX_1_2 DEMUX_1 (
    .Enable_In(Enable_In),

    .Data_In(Data_In),
    
    .Select_In(Select_In[3]),
    
    .Data_0_Out(DEMUX_1_Result),
    .Data_1_Out(DEMUX_2_Result)
);


DEMUX_1_8 DEMUX_2 (
    .Enable_In(Enable_In),

    .Data_In(DEMUX_1_Result),
    
    .Select_In(Select_In[2:0]),
    
    .Data_0_Out(Data_0_Out),
    .Data_1_Out(Data_1_Out),
    .Data_2_Out(Data_2_Out),
    .Data_3_Out(Data_3_Out),
    .Data_4_Out(Data_4_Out),
    .Data_5_Out(Data_5_Out),
    .Data_6_Out(Data_6_Out),
    .Data_7_Out(Data_7_Out)
);


DEMUX_1_8 DEMUX_3 (
    .Enable_In(Enable_In),

    .Data_In(DEMUX_2_Result),
    
    .Select_In(Select_In[2:0]),
    
    .Data_0_Out(Data_8_Out),
    .Data_1_Out(Data_9_Out),
    .Data_2_Out(Data_10_Out),
    .Data_3_Out(Data_11_Out),
    .Data_4_Out(Data_12_Out),
    .Data_5_Out(Data_13_Out),
    .Data_6_Out(Data_14_Out),
    .Data_7_Out(Data_15_Out)
);



endmodule