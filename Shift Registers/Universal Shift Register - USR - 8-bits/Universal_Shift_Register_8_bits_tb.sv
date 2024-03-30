/* 
Testbench file to test the functionality of the Universal Shift Register implementation.

Author - Prasad Narayan Ghatol
*/

`timescale 1ns / 1ps

module Universal_Shift_Register_8_bits_tb ();

reg Clk_In;
reg Reset_In;
reg [1:0] Mode_In;
reg Serial_Data_Right_In;
reg Serial_Data_Left_In;
reg [7:0] Parallel_Data_In;
wire Serial_Data_Out;
wire [7:0] Parallel_Data_Out;
wire [7:0] Shift_Register;

// Instantiate the DUT
Universal_Shift_Register_8_bits DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Mode_In(Mode_In),
    .Serial_Data_Right_In(Serial_Data_Right_In),
    .Serial_Data_Left_In(Serial_Data_Left_In),
    .Parallel_Data_In(Parallel_Data_In),
    .Serial_Data_Out(Serial_Data_Out),
    .Parallel_Data_Out(Parallel_Data_Out),
    .Shift_Register(Shift_Register)
);


// Clock
initial
    begin
        Clk_In = 1'b1;

        forever
            begin
                Clk_In = ~Clk_In;
                #5;
            end
    end

initial
    begin
        $monitor("[%0t] : Mode_In = %1b , Serial_Data_Right_In = %1b , Serial_Data_Left_In = %1b , Parallel_Data_In = %8b , Serial_Data_Out = %1b , Parallel_Data_Out : %8b", $time, Mode_In, Serial_Data_Right_In, Serial_Data_Left_In, Parallel_Data_In, Serial_Data_Out, Parallel_Data_Out);
    end

// Testbench Inputs
initial
    begin
        // Apply the Reset Signal, and then remove it,
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        // Inputs to test the Parallel Load Mode
        Mode_In = 2'b11;
        Parallel_Data_In = $random;
        Serial_Data_Left_In = 1'b0;
        Serial_Data_Right_In = 1'b0;
        #10;

        // Inputs to test the Shift Right Mode
        Mode_In = 2'b01;
        Parallel_Data_In = 8'b0;
        Serial_Data_Right_In = 1'b0;
        repeat (10)
            begin
                Serial_Data_Left_In = $random;
                #10;
            end
        #10;

        // Inputs to test the No Change Mode
        Mode_In = 2'b00;
        Parallel_Data_In = 8'b0;
        Serial_Data_Left_In = 1'b0;
        Serial_Data_Right_In = 1'b0;
        #10;

        // Inputs to test the Shift Left Mode
        Mode_In = 2'b10;
        Parallel_Data_In = 8'b0;
        Serial_Data_Left_In = 1'b0;
        repeat (10)
            begin
                Serial_Data_Right_In = $random;
                #10;
            end
        #10;

        // Stop the Simulation
        $stop;
    end


endmodule