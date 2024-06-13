/*
Verilog Code, to implement a Serial-In-Serial-Out - SISO - 8-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/



module Serial_In_Serial_Out_SISO_8_Bit (
    input            Clk_In,
    input            Reset_In,

    input            Serial_Data_In,
    output           Serial_Data_Out,
    output reg [7:0] SISO_Shift_Register
);



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Serial_Data_Out = SISO_Shift_Register[0];



// --------------------------------------------------
// Serial-In-Serial-Out - SISO - 8-Bit Shift Register Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                SISO_Shift_Register <= 8'b0;
            end
        else
            begin
                SISO_Shift_Register[7] <= Serial_Data_In;
                SISO_Shift_Register[6] <= SISO_Shift_Register[7];
                SISO_Shift_Register[5] <= SISO_Shift_Register[6];
                SISO_Shift_Register[4] <= SISO_Shift_Register[5];
                SISO_Shift_Register[3] <= SISO_Shift_Register[4];
                SISO_Shift_Register[2] <= SISO_Shift_Register[3];
                SISO_Shift_Register[1] <= SISO_Shift_Register[2];
                SISO_Shift_Register[0] <= SISO_Shift_Register[1];
            end
    end



endmodule