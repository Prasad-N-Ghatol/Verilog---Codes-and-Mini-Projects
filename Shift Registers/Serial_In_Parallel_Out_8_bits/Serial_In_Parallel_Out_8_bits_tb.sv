/* 
Testbench file to test the functionality of the Serial-In-Parallel-Out (SIPO) Shift Register implementation.

Author - Prasad Narayan Ghatol
*/

`timescale 1ns/1ps

module Serial_In_Parallel_Out_8_bits_tb();

reg Clk_In;
reg Reset_In;
reg Serial_Data_In;
wire [7:0] Parallel_Data_Out;
wire [7:0] SIPO_Shift_Register;


// Instantiate the DUT
Serial_In_Parallel_Out_8_bits DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Serial_Data_In(Serial_Data_In),
    .Parallel_Data_Out(Parallel_Data_Out),
    .SIPO_Shift_Register(SIPO_Shift_Register)
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
        $monitor("[%0t] : Serial_Data_In = %1b , Parallel_Data_Out : %8b", $time, Serial_Data_In, Parallel_Data_Out);
    end

// Testbench Inputs
initial
    begin
        // Apply the Reset Signal, and then remove it,
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;


        // Apply the Test Data
        repeat (15)
            begin
                Serial_Data_In = $random; #10;
            end
        
        // Stop the Simulation
        $stop;
    end


endmodule
