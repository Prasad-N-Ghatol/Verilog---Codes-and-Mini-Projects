/*
Verilog Code, to implement a Serial-In-Parallel-Out - SIPO - 8-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/



module Serial_In_Parallel_Out_SIPO_8_Bit (
    input            Clk_In,
    input            Reset_In,

    input            Serial_Data_In,
    output reg [7:0] SIPO_Shift_Register
);



// --------------------------------------------------
// Serial-In-Parallel-Out - SIPO - 8-Bit Shift Register Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                SIPO_Shift_Register <= 8'b0;
            end
        else
            begin
                SIPO_Shift_Register[7] <= Serial_Data_In;
                SIPO_Shift_Register[6] <= SIPO_Shift_Register[7];
                SIPO_Shift_Register[5] <= SIPO_Shift_Register[6];
                SIPO_Shift_Register[4] <= SIPO_Shift_Register[5];
                SIPO_Shift_Register[3] <= SIPO_Shift_Register[4];
                SIPO_Shift_Register[2] <= SIPO_Shift_Register[3];
                SIPO_Shift_Register[1] <= SIPO_Shift_Register[2];
                SIPO_Shift_Register[0] <= SIPO_Shift_Register[1];
            end
    end



endmodule