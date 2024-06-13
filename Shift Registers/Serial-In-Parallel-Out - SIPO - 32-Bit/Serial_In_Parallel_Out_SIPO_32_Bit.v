/*
Verilog Code, to implement a Serial-In-Parallel-Out - SIPO - 32-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/



module Serial_In_Parallel_Out_SIPO_32_Bit (
    input             Clk_In,
    input             Reset_In,

    input             Serial_Data_In,
    output reg [31:0] SIPO_Shift_Register
);



// --------------------------------------------------
// Serial-In-Parallel-Out - SIPO - 32-Bit Shift Register Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                SIPO_Shift_Register <= 32'b0;
            end
        else
            begin
                SIPO_Shift_Register[31] <= Serial_Data_In;
                SIPO_Shift_Register[30] <= SIPO_Shift_Register[31];
                SIPO_Shift_Register[29] <= SIPO_Shift_Register[30];
                SIPO_Shift_Register[28] <= SIPO_Shift_Register[29];
                SIPO_Shift_Register[27] <= SIPO_Shift_Register[28];
                SIPO_Shift_Register[26] <= SIPO_Shift_Register[27];
                SIPO_Shift_Register[25] <= SIPO_Shift_Register[26];
                SIPO_Shift_Register[24] <= SIPO_Shift_Register[25];
                SIPO_Shift_Register[23] <= SIPO_Shift_Register[24];
                SIPO_Shift_Register[22] <= SIPO_Shift_Register[23];
                SIPO_Shift_Register[21] <= SIPO_Shift_Register[22];
                SIPO_Shift_Register[20] <= SIPO_Shift_Register[21];
                SIPO_Shift_Register[19] <= SIPO_Shift_Register[20];
                SIPO_Shift_Register[18] <= SIPO_Shift_Register[19];
                SIPO_Shift_Register[17] <= SIPO_Shift_Register[18];
                SIPO_Shift_Register[16] <= SIPO_Shift_Register[17];
                SIPO_Shift_Register[15] <= SIPO_Shift_Register[16];
                SIPO_Shift_Register[14] <= SIPO_Shift_Register[15];
                SIPO_Shift_Register[13] <= SIPO_Shift_Register[14];
                SIPO_Shift_Register[12] <= SIPO_Shift_Register[13];
                SIPO_Shift_Register[11] <= SIPO_Shift_Register[12];
                SIPO_Shift_Register[10] <= SIPO_Shift_Register[11];
                SIPO_Shift_Register[9]  <= SIPO_Shift_Register[10];
                SIPO_Shift_Register[8]  <= SIPO_Shift_Register[9];
                SIPO_Shift_Register[7]  <= SIPO_Shift_Register[8];
                SIPO_Shift_Register[6]  <= SIPO_Shift_Register[7];
                SIPO_Shift_Register[5]  <= SIPO_Shift_Register[6];
                SIPO_Shift_Register[4]  <= SIPO_Shift_Register[5];
                SIPO_Shift_Register[3]  <= SIPO_Shift_Register[4];
                SIPO_Shift_Register[2]  <= SIPO_Shift_Register[3];
                SIPO_Shift_Register[1]  <= SIPO_Shift_Register[2];
                SIPO_Shift_Register[0]  <= SIPO_Shift_Register[1];
            end
    end



endmodule