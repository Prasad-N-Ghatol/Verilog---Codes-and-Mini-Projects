/*
SystemVerilog Testbench for the Universal Shift Register - USR - 32-Bit Shift Register.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Universal_Shift_Register_USR_32_Bit_tb ();



reg         Clk_In;
reg         Reset_In;

reg  [1:0]  USR_Mode_In;
reg         Serial_Data_Left_In;
reg         Serial_Data_Right_In;
reg  [31:0] Parallel_Data_In;

wire        Serial_Data_Right_Out;
wire        Serial_Data_Left_Out;
wire [31:0] Parallel_Data_Out;

wire [31:0] USR_Shift_Register;



// --------------------------------------------------
// Universal Shift Register - USR - 32-Bit Shift Register DUT Instantiation
// --------------------------------------------------
Universal_Shift_Register_USR_32_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .USR_Mode_In(USR_Mode_In),
    .Serial_Data_Left_In(Serial_Data_Left_In),
    .Serial_Data_Right_In(Serial_Data_Right_In),
    .Parallel_Data_In(Parallel_Data_In),
    .Serial_Data_Right_Out(Serial_Data_Right_Out),
    .Serial_Data_Left_Out(Serial_Data_Left_Out),
    .Parallel_Data_Out(Parallel_Data_Out),
    .USR_Shift_Register(USR_Shift_Register)
);



// --------------------------------------------------
// Constants
// --------------------------------------------------
localparam [1:0]    LOAD_PARALLEL = 2'h0,
                    SHIFT_RIGHT   = 2'h1,
                    SHIFT_LEFT    = 2'h2,
                    NO_CHANGE     = 2'h3;



// --------------------------------------------------
// Clock Initialization
// --------------------------------------------------
initial
    begin
        Clk_In = 1'b0;

        forever
            begin
                #5;
                Clk_In = ~Clk_In;
            end
    end



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        // Load Parallel Data
        USR_Mode_In = LOAD_PARALLEL;
        Serial_Data_Left_In = $random;
        Serial_Data_Right_In = $random;
        Parallel_Data_In = $random;
        #10;

        // Shift Data Right
        repeat(5)
            begin
                USR_Mode_In = SHIFT_RIGHT;
                Serial_Data_Left_In = $random;
                Serial_Data_Right_In = $random;
                Parallel_Data_In = $random;
                #10;
            end

        // Shift Data Left
        repeat(8)
            begin
                USR_Mode_In = SHIFT_LEFT;
                Serial_Data_Left_In = $random;
                Serial_Data_Right_In = $random;
                Parallel_Data_In = $random;
                #10;
            end

        // No Change in Data
        USR_Mode_In = NO_CHANGE;
        Serial_Data_Left_In = $random;
        Serial_Data_Right_In = $random;
        Parallel_Data_In = $random;
        #10;

        $stop;
    end



endmodule