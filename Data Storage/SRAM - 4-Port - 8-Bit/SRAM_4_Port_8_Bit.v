/*
**************************************************
                4-Port SRAM - 8-Bit
**************************************************

This is a verilog code, to implement a 8-Bit 4-Port SRAM.

This design has a total of 4 ports, with 2 ports to perform Write Operation, and 2 ports to perform Read Operation
All the 4 ports are able to operate independent of each other.

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/



module SRAM_4_Port_8_Bit (
    input            Clk_In,
    input            Reset_In,

    input      [7:0] Port_W_A_Data_In,
    input      [7:0] Port_W_A_Address_In,
    input            Port_W_A_Write_Enable_In,

    input      [7:0] Port_W_B_Data_In,
    input      [7:0] Port_W_B_Address_In,
    input            Port_W_B_Write_Enable_In,

    output reg [7:0] Port_R_C_Data_Out,
    input      [7:0] Port_R_C_Address_In,
    input            Port_R_C_Read_Enable_In,

    output reg [7:0] Port_R_D_Data_Out,
    input      [7:0] Port_R_D_Address_In,
    input            Port_R_D_Read_Enable_In
);



// --------------------------------------------------
// SRAM Memory
// --------------------------------------------------
reg [7:0] SRAM_MEMORY [255:0];



// --------------------------------------------------
// SRAM Logic
// --------------------------------------------------
// Write - Port A
always @ (negedge Clk_In)
    begin
        if (Port_W_A_Write_Enable_In)
            begin
                SRAM_MEMORY[Port_W_A_Address_In] <= Port_W_A_Data_In;
            end
    end


// Write - Port B
always @ (negedge Clk_In)
    begin
        if (Port_W_B_Write_Enable_In)
            begin
                SRAM_MEMORY[Port_W_B_Address_In] <= Port_W_B_Data_In;
            end
    end


// Read - Port C
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Port_R_C_Data_Out <= 8'bZ;
            end
        else if (Port_R_C_Read_Enable_In)
            begin
                Port_R_C_Data_Out <= SRAM_MEMORY[Port_R_C_Address_In];
            end
        else
            begin
                Port_R_C_Data_Out <= 8'bZ;
            end
    end


// Read - Port D
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Port_R_D_Data_Out <= 8'bZ;
            end
        else if (Port_R_D_Read_Enable_In)
            begin
                Port_R_D_Data_Out <= SRAM_MEMORY[Port_R_D_Address_In];
            end
        else
            begin
                Port_R_D_Data_Out <= 8'bZ;
            end
    end



endmodule