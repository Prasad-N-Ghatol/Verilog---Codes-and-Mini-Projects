/*
Verilog Code, to implement a Universal Shift Register - USR - 16-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/



module Universal_Shift_Register_USR_16_Bit (
    input             Clk_In,
    input             Reset_In,

    input      [1:0]  USR_Mode_In,
    input             Serial_Data_Left_In,
    input             Serial_Data_Right_In,
    input      [15:0] Parallel_Data_In,

    output            Serial_Data_Right_Out,
    output            Serial_Data_Left_Out,
    output     [15:0] Parallel_Data_Out,

    output reg [15:0] USR_Shift_Register
);



// --------------------------------------------------
// Constants
// --------------------------------------------------
localparam [1:0]    LOAD_PARALLEL = 2'h0,
                    SHIFT_RIGHT   = 2'h1,
                    SHIFT_LEFT    = 2'h2,
                    NO_CHANGE     = 2'h3;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Parallel_Data_Out = USR_Shift_Register;

assign Serial_Data_Right_Out = USR_Shift_Register[0];

assign Serial_Data_Left_Out = USR_Shift_Register[15];



// --------------------------------------------------
// Universal Shift Register - USR - 16-Bit Shift Register Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                USR_Shift_Register <= 16'b0;
            end
        else
            begin
                case (USR_Mode_In)
                    LOAD_PARALLEL : // 2'h0
                        begin
                            USR_Shift_Register <= Parallel_Data_In;
                        end

                    SHIFT_RIGHT   : // 2'h1
                        begin
                            USR_Shift_Register[15] <= Serial_Data_Left_In;
                            USR_Shift_Register[14] <= USR_Shift_Register[15];
                            USR_Shift_Register[13] <= USR_Shift_Register[14];
                            USR_Shift_Register[12] <= USR_Shift_Register[13];
                            USR_Shift_Register[11] <= USR_Shift_Register[12];
                            USR_Shift_Register[10] <= USR_Shift_Register[11];
                            USR_Shift_Register[9]  <= USR_Shift_Register[10];
                            USR_Shift_Register[8]  <= USR_Shift_Register[9];
                            USR_Shift_Register[7]  <= USR_Shift_Register[8];
                            USR_Shift_Register[6]  <= USR_Shift_Register[7];
                            USR_Shift_Register[5]  <= USR_Shift_Register[6];
                            USR_Shift_Register[4]  <= USR_Shift_Register[5];
                            USR_Shift_Register[3]  <= USR_Shift_Register[4];
                            USR_Shift_Register[2]  <= USR_Shift_Register[3];
                            USR_Shift_Register[1]  <= USR_Shift_Register[2];
                            USR_Shift_Register[0]  <= USR_Shift_Register[1];
                        end

                    SHIFT_LEFT    : // 2'h2
                        begin
                            USR_Shift_Register[0]  <= Serial_Data_Right_In;
                            USR_Shift_Register[1]  <= USR_Shift_Register[0];
                            USR_Shift_Register[2]  <= USR_Shift_Register[1];
                            USR_Shift_Register[3]  <= USR_Shift_Register[2];
                            USR_Shift_Register[4]  <= USR_Shift_Register[3];
                            USR_Shift_Register[5]  <= USR_Shift_Register[4];
                            USR_Shift_Register[6]  <= USR_Shift_Register[5];
                            USR_Shift_Register[7]  <= USR_Shift_Register[6];
                            USR_Shift_Register[8]  <= USR_Shift_Register[7];
                            USR_Shift_Register[9]  <= USR_Shift_Register[8];
                            USR_Shift_Register[10] <= USR_Shift_Register[9];
                            USR_Shift_Register[11] <= USR_Shift_Register[10];
                            USR_Shift_Register[12] <= USR_Shift_Register[11];
                            USR_Shift_Register[13] <= USR_Shift_Register[12];
                            USR_Shift_Register[14] <= USR_Shift_Register[13];
                            USR_Shift_Register[15] <= USR_Shift_Register[14];
                        end

                    NO_CHANGE     : // 2'h3
                        begin
                            USR_Shift_Register <= USR_Shift_Register;
                        end

                    default :
                        begin
                            USR_Shift_Register <= USR_Shift_Register;
                        end
                endcase
            end
    end



endmodule