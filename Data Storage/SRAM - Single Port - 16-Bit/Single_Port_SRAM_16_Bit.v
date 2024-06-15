/*
Verilog Code, to implement a 16-Bit Single Port SRAM.



Author : Prasad Narayan Ghatol
*/



module Single_Port_SRAM_16_Bit (
    input             Clk_In,
    input             Reset_In,

    input      [15:0] Data_In,
    input      [7:0]  Address_In,
    output reg [15:0] Data_Out,
    input             Write_Enable,
    input             Read_Enable
);



// --------------------------------------------------
// SRAM Memory
// --------------------------------------------------
reg [15:0] SRAM_MEMORY [255:0];



// --------------------------------------------------
// SRAM Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Data_Out <= 16'bZ;
            end
        else if (Read_Enable)
            begin
                Data_Out <= SRAM_MEMORY[Address_In];
            end
        else if (Write_Enable)
            begin
                Data_Out <= 16'bZ;
                SRAM_MEMORY[Address_In] <= Data_In;
            end
        else
            begin
                Data_Out <= 16'bZ;
            end
    end



endmodule