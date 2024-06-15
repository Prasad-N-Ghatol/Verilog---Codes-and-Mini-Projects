/*
Verilog Code, to implement a 32-Bit LIFO (Stack).



Author : Prasad Narayan Ghatol
*/



module LIFO_Stack_32_Bit (
    input             Clk_In,
    input             Reset_In,

    input      [31:0] Data_In,
    output reg [31:0] Data_Out,
    input             Push_In,
    input             Pop_In,
    input             Peek_In,

    output            LIFO_Empty,
    output            LIFO_Full
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg [3:0] Pointer_Top;



// --------------------------------------------------
// FIFO Memory
// --------------------------------------------------
reg [31:0] LIFO_MEMORY [7:0];



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign LIFO_Empty = (Pointer_Top == 4'b0);

assign LIFO_Full = (Pointer_Top == 4'b1000);



// --------------------------------------------------
// LIFO Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Data_Out <= 32'bZ;
                Pointer_Top <= 4'b0;
            end
        else if (Peek_In && ~LIFO_Empty)
            begin
                Data_Out <= LIFO_MEMORY[Pointer_Top - 1'b1];
                Pointer_Top <= Pointer_Top;
            end
        else if (Pop_In && ~LIFO_Empty)
            begin
                Data_Out = LIFO_MEMORY[Pointer_Top - 1'b1];
                Pointer_Top = Pointer_Top - 1'b1;
            end
        else if (Push_In && ~LIFO_Full)
            begin
                Pointer_Top = Pointer_Top + 1'b1;
                LIFO_MEMORY[Pointer_Top - 1'b1] = Data_In;
                Data_Out = 32'bZ;
            end
        else
            begin
                Data_Out <= 32'bZ;
                Pointer_Top <= Pointer_Top;
            end
    end



endmodule