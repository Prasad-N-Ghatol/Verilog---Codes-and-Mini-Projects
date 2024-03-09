/* 
Testbench file to test the functionality of the Parallel-In-Serial-Out (PISO) Shift Register implementation.

Author - Prasad Narayan Ghatol
*/

module Parallel_In_Serial_Out_8_bits_tb();

reg Clk_In;
reg Reset_In;
reg Load_Shiftb_In;
reg [7:0] Parallel_Data_In;
wire Serial_Data_Out;
wire [7:0] PISO_Shift_Register;


// Instantiate the DUT
Parallel_In_Serial_Out_8_bits DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Load_Shiftb_In(Load_Shiftb_In),
    .Parallel_Data_In(Parallel_Data_In),
    .Serial_Data_Out(Serial_Data_Out),
    .PISO_Shift_Register(PISO_Shift_Register)
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


// Testbench Inputs
initial
    begin
        // Apply the Reset Signal, and then remove it,
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;


        // Apply the Test Data
        Parallel_Data_In = 8'h6D;
        Load_Shiftb_In = 1'b1;

        #10;

        Load_Shiftb_In = 1'b0;

        #50;

        Parallel_Data_In = 8'hA1;
        Load_Shiftb_In = 1'b1;

        #10;

        Load_Shiftb_In = 1'b0;
        
        #80;

        // Stop the Simulation
        $stop;
    end


endmodule
