/* 
Testbench file to test the functionality of the Parallel-In-Parallel-Out (PIPO) Shift Register implementation.

Author - Prasad Narayan Ghatol
*/

`timescale 1ns / 1ps

module Parallel_In_Parallel_Out_8_bits_tb ();

reg Clk_In;
reg Reset_In;
reg [7:0] Parallel_Data_In;
wire [7:0] Parallel_Data_Out;

// Instantiate the DUT
Parallel_In_Parallel_Out_8_bits DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Parallel_Data_In(Parallel_Data_In),
    .Parallel_Data_Out(Parallel_Data_Out)
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
        $monitor("[%0t] : Parallel_Data_In = %8b , Parallel_Data_Out : %1b", $time, Parallel_Data_In, Parallel_Data_Out);
    end


// Testbench Inputs
initial
    begin
        // Apply the Reset Signal, and then remove it,
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;


        // Apply the Test Data
        Parallel_Data_In = $random;
        #10;

        Parallel_Data_In = $random;
        #10;

        Parallel_Data_In = $random;
        #10;

        Parallel_Data_In = $random;
        #10;

        Parallel_Data_In = $random;
        #10;

        // Stop the Simulation
        $stop;
    end

endmodule
