/*
SystemVerilog Testbench for the 32-Bit Dual Port SRAM.



Author : Prasad Narayan Ghatol
*/



module Dual_Port_SRAM_32_Bit_tb ();

reg         Clk_In;
reg         Reset_In;

reg  [31:0] Port_A_Data_In;
reg  [7:0]  Port_A_Address_In;
wire [31:0] Port_A_Data_Out;
reg         Port_A_Write_Enable;
reg         Port_A_Read_Enable;

reg  [31:0] Port_B_Data_In;
reg  [7:0]  Port_B_Address_In;
wire [31:0] Port_B_Data_Out;
reg         Port_B_Write_Enable;
reg         Port_B_Read_Enable;



// --------------------------------------------------
// Dual Port SRAM DUT Instantiation
// --------------------------------------------------
Dual_Port_SRAM_32_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    
    .Port_A_Data_In(Port_A_Data_In),
    .Port_A_Address_In(Port_A_Address_In),
    .Port_A_Data_Out(Port_A_Data_Out),
    .Port_A_Write_Enable(Port_A_Write_Enable),
    .Port_A_Read_Enable(Port_A_Read_Enable),
    
    .Port_B_Data_In(Port_B_Data_In),
    .Port_B_Address_In(Port_B_Address_In),
    .Port_B_Data_Out(Port_B_Data_Out),
    .Port_B_Write_Enable(Port_B_Write_Enable),
    .Port_B_Read_Enable(Port_B_Read_Enable)
);



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
        #10;
        Reset_In = 1'b0;

        repeat (20)
            begin
                Port_A_Data_In = $random;
                Port_A_Address_In = $random;

                Port_B_Data_In = $random;
                Port_B_Address_In = $random;
                
                Port_A_Write_Enable = 1'b1;
                Port_A_Read_Enable = 1'b0;

                Port_B_Write_Enable = 1'b1;
                Port_B_Read_Enable = 1'b0;

                #10;
                
                Port_A_Write_Enable = 1'b0;
                Port_A_Read_Enable = 1'b1;

                Port_B_Write_Enable = 1'b0;
                Port_B_Read_Enable = 1'b1;

                #10;
            end

        $stop;
    end



endmodule