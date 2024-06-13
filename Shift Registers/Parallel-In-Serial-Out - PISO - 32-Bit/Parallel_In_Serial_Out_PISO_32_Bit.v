/*
Verilog Code, to implement a Parallel-In-Serial-Out - PISO - 32-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/



module Parallel_In_Serial_Out_PISO_32_Bit (
    input             Clk_In,
    input             Reset_In,

    input             Load_Shiftb_In,
    input      [31:0] Parallel_Data_In,
    output            Serial_Data_Out,
    output reg [31:0] PISO_Shift_Register
);



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Serial_Data_Out = PISO_Shift_Register[0];



// --------------------------------------------------
// Parallel-In-Serial-Out - PISO - 32-Bit Shift Register Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                PISO_Shift_Register <= 32'b0;
            end
        else if (Load_Shiftb_In)
            begin
                PISO_Shift_Register <= Parallel_Data_In;
            end
        else
            begin
                PISO_Shift_Register[31] <= 1'b0;
                PISO_Shift_Register[30] <= PISO_Shift_Register[31];
                PISO_Shift_Register[29] <= PISO_Shift_Register[30];
                PISO_Shift_Register[28] <= PISO_Shift_Register[29];
                PISO_Shift_Register[27] <= PISO_Shift_Register[28];
                PISO_Shift_Register[26] <= PISO_Shift_Register[27];
                PISO_Shift_Register[25] <= PISO_Shift_Register[26];
                PISO_Shift_Register[24] <= PISO_Shift_Register[25];
                PISO_Shift_Register[23] <= PISO_Shift_Register[24];
                PISO_Shift_Register[22] <= PISO_Shift_Register[23];
                PISO_Shift_Register[21] <= PISO_Shift_Register[22];
                PISO_Shift_Register[20] <= PISO_Shift_Register[21];
                PISO_Shift_Register[19] <= PISO_Shift_Register[20];
                PISO_Shift_Register[18] <= PISO_Shift_Register[19];
                PISO_Shift_Register[17] <= PISO_Shift_Register[18];
                PISO_Shift_Register[16] <= PISO_Shift_Register[17];
                PISO_Shift_Register[15] <= PISO_Shift_Register[16];
                PISO_Shift_Register[14] <= PISO_Shift_Register[15];
                PISO_Shift_Register[13] <= PISO_Shift_Register[14];
                PISO_Shift_Register[12] <= PISO_Shift_Register[13];
                PISO_Shift_Register[11] <= PISO_Shift_Register[12];
                PISO_Shift_Register[10] <= PISO_Shift_Register[11];
                PISO_Shift_Register[9]  <= PISO_Shift_Register[10];
                PISO_Shift_Register[8]  <= PISO_Shift_Register[9];
                PISO_Shift_Register[7]  <= PISO_Shift_Register[8];
                PISO_Shift_Register[6]  <= PISO_Shift_Register[7];
                PISO_Shift_Register[5]  <= PISO_Shift_Register[6];
                PISO_Shift_Register[4]  <= PISO_Shift_Register[5];
                PISO_Shift_Register[3]  <= PISO_Shift_Register[4];
                PISO_Shift_Register[2]  <= PISO_Shift_Register[3];
                PISO_Shift_Register[1]  <= PISO_Shift_Register[2];
                PISO_Shift_Register[0]  <= PISO_Shift_Register[1];
            end
    end



endmodule