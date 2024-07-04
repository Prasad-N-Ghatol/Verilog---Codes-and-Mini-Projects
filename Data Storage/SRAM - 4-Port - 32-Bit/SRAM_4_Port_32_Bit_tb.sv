/*
**************************************************
            4-Port SRAM - 32-Bit - Testbench
**************************************************

This is a SystemVerilog Testbench code, for the 32-Bit 4-Port SRAM.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/



module SRAM_4_Port_32_Bit_tb ();

reg         Clk_In;
reg         Reset_In;

reg  [31:0] Port_W_A_Data_In;
reg  [7:0]  Port_W_A_Address_In;
reg         Port_W_A_Write_Enable_In;

reg  [31:0] Port_W_B_Data_In;
reg  [7:0]  Port_W_B_Address_In;
reg         Port_W_B_Write_Enable_In;

wire [31:0] Port_R_C_Data_Out;
reg  [7:0]  Port_R_C_Address_In;
reg         Port_R_C_Read_Enable_In;

wire [31:0] Port_R_D_Data_Out;
reg  [7:0]  Port_R_D_Address_In;
reg         Port_R_D_Read_Enable_In;



// --------------------------------------------------
// 4-Port SRAM DUT Instantiation
// --------------------------------------------------
SRAM_4_Port_32_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),

    .Port_W_A_Data_In(Port_W_A_Data_In),
    .Port_W_A_Address_In(Port_W_A_Address_In),
    .Port_W_A_Write_Enable_In(Port_W_A_Write_Enable_In),

    .Port_W_B_Data_In(Port_W_B_Data_In),
    .Port_W_B_Address_In(Port_W_B_Address_In),
    .Port_W_B_Write_Enable_In(Port_W_B_Write_Enable_In),

    .Port_R_C_Data_Out(Port_R_C_Data_Out),
    .Port_R_C_Address_In(Port_R_C_Address_In),
    .Port_R_C_Read_Enable_In(Port_R_C_Read_Enable_In),

    .Port_R_D_Data_Out(Port_R_D_Data_Out),
    .Port_R_D_Address_In(Port_R_D_Address_In),
    .Port_R_D_Read_Enable_In(Port_R_D_Read_Enable_In)
);



// --------------------------------------------------
// wires
// --------------------------------------------------
reg [7:0] Address_1;
reg [7:0] Address_2;



// --------------------------------------------------
// Clock Initialization
// --------------------------------------------------
initial
    begin
        Clk_In = 1'b0;

        forever
            begin
                #5;
                Clk_In = ~Clk_In;
            end
    end



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;

        Port_W_A_Write_Enable_In = 1'b0;
        Port_W_B_Write_Enable_In = 1'b0;
        Port_R_C_Read_Enable_In = 1'b0;
        Port_R_D_Read_Enable_In = 1'b0;

        #10;
        Reset_In = 1'b0;

        repeat (20)
            begin
                Address_1 = $random;
                Address_2 = $random;

                Port_R_C_Read_Enable_In = 1'b0;
                Port_R_D_Read_Enable_In = 1'b0;

                Port_W_A_Data_In = $random;
                Port_W_A_Address_In = Address_1;
                Port_W_A_Write_Enable_In = 1'b1;

                Port_W_B_Data_In = $random;
                Port_W_B_Address_In = Address_2;
                Port_W_B_Write_Enable_In = 1'b1;

                #10;

                Port_W_A_Write_Enable_In = 1'b0;
                Port_W_B_Write_Enable_In = 1'b0;

                Port_R_C_Address_In = Address_1;
                Port_R_C_Read_Enable_In = 1'b1;


                Port_R_D_Address_In = Address_2;
                Port_R_D_Read_Enable_In = 1'b1;

                #10;
            end

        $stop;
    end



endmodule