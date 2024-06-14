/*
Verilog Code, to implement a 32:1 MUX.



Author : Prasad Narayan Ghatol
*/



module MUX_32_1 (
    input        Enable_In,

    input  [4:0] Select_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,
    input        Data_4_In,
    input        Data_5_In,
    input        Data_6_In,
    input        Data_7_In,
    input        Data_8_In,
    input        Data_9_In,
    input        Data_10_In,
    input        Data_11_In,
    input        Data_12_In,
    input        Data_13_In,
    input        Data_14_In,
    input        Data_15_In,
    input        Data_16_In,
    input        Data_17_In,
    input        Data_18_In,
    input        Data_19_In,
    input        Data_20_In,
    input        Data_21_In,
    input        Data_22_In,
    input        Data_23_In,
    input        Data_24_In,
    input        Data_25_In,
    input        Data_26_In,
    input        Data_27_In,
    input        Data_28_In,
    input        Data_29_In,
    input        Data_30_In,
    input        Data_31_In,

    output       MUX_Data_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
wire MUX_1_Result;
wire MUX_2_Result;
wire MUX_3_Result;
wire MUX_4_Result;

wire Multiplexed_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign MUX_Data_Out = Enable_In ? Multiplexed_Data : 1'bZ;



// --------------------------------------------------
// 32:1 MUX Logic
// --------------------------------------------------
MUX_8_1 MUX_1 (
    .Enable_In(Enable_In),
    .Select_In(Select_In[2:0]),
    .Data_0_In(Data_0_In),
    .Data_1_In(Data_1_In),
    .Data_2_In(Data_2_In),
    .Data_3_In(Data_3_In),
    .Data_4_In(Data_4_In),
    .Data_5_In(Data_5_In),
    .Data_6_In(Data_6_In),
    .Data_7_In(Data_7_In),
    .MUX_Data_Out(MUX_1_Result)
);


MUX_8_1 MUX_2 (
    .Enable_In(Enable_In),
    .Select_In(Select_In[2:0]),
    .Data_0_In(Data_8_In),
    .Data_1_In(Data_9_In),
    .Data_2_In(Data_10_In),
    .Data_3_In(Data_11_In),
    .Data_4_In(Data_12_In),
    .Data_5_In(Data_13_In),
    .Data_6_In(Data_14_In),
    .Data_7_In(Data_15_In),
    .MUX_Data_Out(MUX_2_Result)
);


MUX_8_1 MUX_3 (
    .Enable_In(Enable_In),
    .Select_In(Select_In[2:0]),
    .Data_0_In(Data_16_In),
    .Data_1_In(Data_17_In),
    .Data_2_In(Data_18_In),
    .Data_3_In(Data_19_In),
    .Data_4_In(Data_20_In),
    .Data_5_In(Data_21_In),
    .Data_6_In(Data_22_In),
    .Data_7_In(Data_23_In),
    .MUX_Data_Out(MUX_3_Result)
);


MUX_8_1 MUX_4 (
    .Enable_In(Enable_In),
    .Select_In(Select_In[2:0]),
    .Data_0_In(Data_24_In),
    .Data_1_In(Data_25_In),
    .Data_2_In(Data_26_In),
    .Data_3_In(Data_27_In),
    .Data_4_In(Data_28_In),
    .Data_5_In(Data_29_In),
    .Data_6_In(Data_30_In),
    .Data_7_In(Data_31_In),
    .MUX_Data_Out(MUX_4_Result)
);


MUX_4_1 MUX_5 (
    .Enable_In(Enable_In),
    .Select_In(Select_In[4:3]),
    .Data_0_In(MUX_1_Result),
    .Data_1_In(MUX_2_Result),
    .Data_2_In(MUX_3_Result),
    .Data_3_In(MUX_4_Result),
    .MUX_Data_Out(Multiplexed_Data)
);



endmodule