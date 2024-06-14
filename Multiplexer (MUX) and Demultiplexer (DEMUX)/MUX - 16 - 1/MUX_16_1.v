/*
Verilog Code, to implement a 16:1 MUX.



Author : Prasad Narayan Ghatol
*/



module MUX_16_1 (
    input        Enable_In,

    input  [3:0] Select_In,

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

    output       MUX_Data_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
wire MUX_1_Result;
wire MUX_2_Result;

wire Multiplexed_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign MUX_Data_Out = Enable_In ? Multiplexed_Data : 1'bZ;



// --------------------------------------------------
// 16:1 MUX Logic
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


MUX_2_1 MUX_3 (
    .Enable_In(Enable_In),
    .Select_In(Select_In[3]),
    .Data_0_In(MUX_1_Result),
    .Data_1_In(MUX_2_Result),
    .MUX_Data_Out(Multiplexed_Data)
);



endmodule