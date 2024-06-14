/*
Verilog Code, to implement a 1:32 DEMUX.



Author : Prasad Narayan Ghatol
*/



module DEMUX_1_32 (
    input        Enable_In,

    input        Data_In,
    
    input  [4:0] Select_In,
    
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
    output       Data_15_Out,
    output       Data_16_Out,
    output       Data_17_Out,
    output       Data_18_Out,
    output       Data_19_Out,
    output       Data_20_Out,
    output       Data_21_Out,
    output       Data_22_Out,
    output       Data_23_Out,
    output       Data_24_Out,
    output       Data_25_Out,
    output       Data_26_Out,
    output       Data_27_Out,
    output       Data_28_Out,
    output       Data_29_Out,
    output       Data_30_Out,
    output       Data_31_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
wire DEMUX_1_Result;
wire DEMUX_2_Result;
wire DEMUX_3_Result;
wire DEMUX_4_Result;



// --------------------------------------------------
// 1:32 DEMUX Logic
// --------------------------------------------------
DEMUX_1_4 DEMUX_1 (
    .Enable_In(Enable_In),

    .Data_In(Data_In),
    
    .Select_In(Select_In[4:3]),
    
    .Data_0_Out(DEMUX_1_Result),
    .Data_1_Out(DEMUX_2_Result),
    .Data_2_Out(DEMUX_3_Result),
    .Data_3_Out(DEMUX_4_Result)
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


DEMUX_1_8 DEMUX_4 (
    .Enable_In(Enable_In),

    .Data_In(DEMUX_3_Result),
    
    .Select_In(Select_In[2:0]),
    
    .Data_0_Out(Data_16_Out),
    .Data_1_Out(Data_17_Out),
    .Data_2_Out(Data_18_Out),
    .Data_3_Out(Data_19_Out),
    .Data_4_Out(Data_20_Out),
    .Data_5_Out(Data_21_Out),
    .Data_6_Out(Data_22_Out),
    .Data_7_Out(Data_23_Out)
);


DEMUX_1_8 DEMUX_5 (
    .Enable_In(Enable_In),

    .Data_In(DEMUX_4_Result),
    
    .Select_In(Select_In[2:0]),
    
    .Data_0_Out(Data_24_Out),
    .Data_1_Out(Data_25_Out),
    .Data_2_Out(Data_26_Out),
    .Data_3_Out(Data_27_Out),
    .Data_4_Out(Data_28_Out),
    .Data_5_Out(Data_29_Out),
    .Data_6_Out(Data_30_Out),
    .Data_7_Out(Data_31_Out)
);



endmodule