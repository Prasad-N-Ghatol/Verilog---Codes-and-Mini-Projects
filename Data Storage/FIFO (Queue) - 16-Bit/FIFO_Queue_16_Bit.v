/*
Verilog Code, to implement a 16-Bit FIFO (Queue).



Author : Prasad Narayan Ghatol
*/



module FIFO_Queue_16_Bit (
    input             Clk_In,
    input             Reset_In,

    input      [15:0] Data_In,
    output reg [15:0] Data_Out,
    input             Write_Enable_In,
    input             Read_Enable_In,

    output            FIFO_Empty,
    output            FIFO_Full
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg [3:0] Write_Pointer;
reg [3:0] Read_Pointer;



// --------------------------------------------------
// FIFO Memory
// --------------------------------------------------
reg [15:0] FIFO_MEMORY [7:0];



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign FIFO_Empty = (Write_Pointer == Read_Pointer);

assign FIFO_Full = ({~Write_Pointer[3], Write_Pointer[2:0]} == Read_Pointer);



// --------------------------------------------------
// FIFO Logic
// --------------------------------------------------
// FIFO Write
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Write_Pointer <= 4'b0;
            end
        else if (Write_Enable_In && ~FIFO_Full)
            begin
                FIFO_MEMORY[Write_Pointer] <= Data_In;
                Write_Pointer <= Write_Pointer + 1'b1;
            end
        else
            begin
                Write_Pointer <= Write_Pointer;
            end
    end


// FIFO Read
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Read_Pointer <= 4'b0;
                Data_Out <= 16'bZ;
            end
        else if (Read_Enable_In && ~FIFO_Empty)
            begin
                Data_Out <= FIFO_MEMORY[Read_Pointer];
                Read_Pointer <= Read_Pointer + 1'b1;
            end
        else
            begin
                Read_Pointer <= Read_Pointer;
                Data_Out <= 16'bZ;
            end
    end



endmodule