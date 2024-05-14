/*
Verilog Code, to implement a 8-Bit Dual Port SRAM.



Author : Prasad Narayan Ghatol
*/



module Dual_Port_SRAM_8_Bit (
    input            Clk_In,
    input            Reset_In,

    input      [7:0] Port_A_Data_In,
    input      [7:0] Port_A_Address_In,
    output reg [7:0] Port_A_Data_Out,
    input            Port_A_Write_Enable,
    input            Port_A_Read_Enable,

    input      [7:0] Port_B_Data_In,
    input      [7:0] Port_B_Address_In,
    output reg [7:0] Port_B_Data_Out,
    input            Port_B_Write_Enable,
    input            Port_B_Read_Enable
);



// --------------------------------------------------
// SRAM Memory
// --------------------------------------------------
reg [7:0] SRAM_MEMORY [255:0];



// --------------------------------------------------
// SRAM Logic
// --------------------------------------------------
// Port A
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Port_A_Data_Out <= 8'bZ;
            end
        else if (Port_A_Read_Enable)
            begin
                Port_A_Data_Out <= SRAM_MEMORY[Port_A_Address_In];
            end
        else if (Port_A_Write_Enable)
            begin
                Port_A_Data_Out <= 8'bZ;
                SRAM_MEMORY[Port_A_Address_In] <= Port_A_Data_In;
            end
        else
            begin
                Port_A_Data_Out <= 8'bZ;
            end
    end



// Port B
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Port_B_Data_Out <= 8'bZ;
            end
        else if (Port_B_Read_Enable)
            begin
                Port_B_Data_Out <= SRAM_MEMORY[Port_B_Address_In];
            end
        else if (Port_B_Write_Enable)
            begin
                Port_B_Data_Out <= 8'bZ;
                SRAM_MEMORY[Port_B_Address_In] <= Port_B_Data_In;
            end
        else
            begin
                Port_B_Data_Out <= 8'bZ;
            end
    end



endmodule