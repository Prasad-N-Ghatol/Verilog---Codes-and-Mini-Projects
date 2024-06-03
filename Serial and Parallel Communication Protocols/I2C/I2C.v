/*
Verilog Code, to implement a I2C.



Data Transfer Rates supported by this design

Standard-Mode (Sm)        -> 100 kbit/sec
Fast-Mode (Fm)            -> 400 kbit/sec
Fast-Mode Plus (Fm+)      -> 1   Mbit/sec
High-Speed Mode (Hs-mode) -> 3.4 Mbit/sec



This design currently supports 7-bit Slave Device Addressing.


This Design supprts to send the Data, in Single or Burst Mode.
The Burst Mode can send/receive a maximum of 4 Bytes.

The Burst Mode inputs are :
2'h0   =>  1 Byte
2'h1   =>  2 Bytes
2'h2   =>  3 Bytes
2'h3   =>  4 Bytes



Author : Prasad Narayan Ghatol
*/



module I2C 
#(parameter SYS_CLOCK = 100_000_000)
(
    input        Clk_In,
    input        Reset_In,

    input  [2:0] Speed_Mode_In,
    output       I2C_Clock_Out,

    output I2C_SDA,
    output I2C_SCL,

    input I2C_Start_Transfer_In,

    input M_Burst_Singleb_In,
    input [1:0] M_Burst_Length_In,
    input M_Read_Writeb_In,

    input [6:0] M_Slave_Device_Address_In,
    input [7:0] M_Reg_Address_In,
    input [7:0] M_Data_In,

    output [7:0] M_Data_Out,
    output M_Data_Read_Enable_Out,
	
    input [7:0] S_Data_In,

    output [6:0] S_Slave_Device_Address_Out,
    output S_Read_Writeb_Out,
    output [7:0] S_Reg_Address_Out,
    output [7:0] S_Data_Out,
    output S_Data_Read_Enable_Out
);



// --------------------------------------------------
// I2C Clock Generator
// --------------------------------------------------
I2C_Clock_Generator #(.SYS_CLOCK(100_000_000)) I2CCG (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Speed_Mode_In(Speed_Mode_In),
    .I2C_Clock_Out(I2C_Clock_Out)
);



// --------------------------------------------------
// I2C Master
// --------------------------------------------------
I2C_Master Master_0 (
    .I2C_Clk_In(I2C_Clock_Out),
    .Reset_In(Reset_In),
    .I2C_SDA(I2C_SDA),
    .I2C_SCL(I2C_SCL),
    .I2C_Start_Transfer_In(I2C_Start_Transfer_In),
    .M_Burst_Singleb_In(M_Burst_Singleb_In),
    .M_Burst_Length_In(M_Burst_Length_In),
    .M_Read_Writeb_In(M_Read_Writeb_In),
    .M_Slave_Device_Address_In(M_Slave_Device_Address_In),
    .M_Reg_Address_In(M_Reg_Address_In),
    .M_Data_In(M_Data_In),
    .M_Data_Out(M_Data_Out),
    .M_Data_Read_Enable_Out(M_Data_Read_Enable_Out)
);



// --------------------------------------------------
// I2C Slave
// --------------------------------------------------
I2C_Slave #(.DEVICE_ADDRESS(7'h68)) Slave_0 (
    .Reset_In(Reset_In),
    .I2C_SDA(I2C_SDA),
    .I2C_SCL(I2C_SCL),
    .S_Data_In(S_Data_In),
    .S_Slave_Device_Address_Out(S_Slave_Device_Address_Out),
    .S_Read_Writeb_Out(S_Read_Writeb_Out),
    .S_Reg_Address_Out(S_Reg_Address_Out),
    .S_Data_Out(S_Data_Out),
    .S_Data_Read_Enable_Out(S_Data_Read_Enable_Out)
);



endmodule