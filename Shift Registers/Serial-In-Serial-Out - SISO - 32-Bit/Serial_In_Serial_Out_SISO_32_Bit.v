/*
Verilog Code, to implement a Serial-In-Serial-Out - SISO - 32-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/



module Serial_In_Serial_Out_SISO_32_Bit (
    input             Clk_In,
    input             Reset_In,

    input             Serial_Data_In,
    output            Serial_Data_Out,
    output reg [31:0] SISO_Shift_Register
);



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Serial_Data_Out = SISO_Shift_Register[0];



// --------------------------------------------------
// Serial-In-Serial-Out - SISO - 32-Bit Shift Register Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                SISO_Shift_Register <= 32'b0;
            end
        else
            begin
                SISO_Shift_Register[31] <= Serial_Data_In;
                SISO_Shift_Register[30] <= SISO_Shift_Register[31];
                SISO_Shift_Register[29] <= SISO_Shift_Register[30];
                SISO_Shift_Register[28] <= SISO_Shift_Register[29];
                SISO_Shift_Register[27] <= SISO_Shift_Register[28];
                SISO_Shift_Register[26] <= SISO_Shift_Register[27];
                SISO_Shift_Register[25] <= SISO_Shift_Register[26];
                SISO_Shift_Register[24] <= SISO_Shift_Register[25];
                SISO_Shift_Register[23] <= SISO_Shift_Register[24];
                SISO_Shift_Register[22] <= SISO_Shift_Register[23];
                SISO_Shift_Register[21] <= SISO_Shift_Register[22];
                SISO_Shift_Register[20] <= SISO_Shift_Register[21];
                SISO_Shift_Register[19] <= SISO_Shift_Register[20];
                SISO_Shift_Register[18] <= SISO_Shift_Register[19];
                SISO_Shift_Register[17] <= SISO_Shift_Register[18];
                SISO_Shift_Register[16] <= SISO_Shift_Register[17];
                SISO_Shift_Register[15] <= SISO_Shift_Register[16];
                SISO_Shift_Register[14] <= SISO_Shift_Register[15];
                SISO_Shift_Register[13] <= SISO_Shift_Register[14];
                SISO_Shift_Register[12] <= SISO_Shift_Register[13];
                SISO_Shift_Register[11] <= SISO_Shift_Register[12];
                SISO_Shift_Register[10] <= SISO_Shift_Register[11];
                SISO_Shift_Register[9]  <= SISO_Shift_Register[10];
                SISO_Shift_Register[8]  <= SISO_Shift_Register[9];
                SISO_Shift_Register[7]  <= SISO_Shift_Register[8];
                SISO_Shift_Register[6]  <= SISO_Shift_Register[7];
                SISO_Shift_Register[5]  <= SISO_Shift_Register[6];
                SISO_Shift_Register[4]  <= SISO_Shift_Register[5];
                SISO_Shift_Register[3]  <= SISO_Shift_Register[4];
                SISO_Shift_Register[2]  <= SISO_Shift_Register[3];
                SISO_Shift_Register[1]  <= SISO_Shift_Register[2];
                SISO_Shift_Register[0]  <= SISO_Shift_Register[1];
            end
    end



endmodule