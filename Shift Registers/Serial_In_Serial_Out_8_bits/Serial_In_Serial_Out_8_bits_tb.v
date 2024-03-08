/* 
Testbench file to test the functionality of the Serial-In-Serial-Out (SISO) Shift Register implementation.

Author - Prasad Narayan Ghatol
*/

module Serial_In_Serial_Out_8_bits_tb();

reg Clk_In;
reg Reset_In;
reg Serial_Data_In;
wire Serial_Data_Out;
wire [7:0] SISO_Shift_Register;


// Instantiate the DUT
Serial_In_Serial_Out_8_bits DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Serial_Data_In(Serial_Data_In),
    .Serial_Data_Out(Serial_Data_Out),
    .SISO_Shift_Register(SISO_Shift_Register)
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
        Serial_Data_In = 1'b1; #10;
        Serial_Data_In = 1'b0; #10;
        Serial_Data_In = 1'b0; #10;
        Serial_Data_In = 1'b1; #10;
        Serial_Data_In = 1'b1; #10;
        Serial_Data_In = 1'b1; #10;
        Serial_Data_In = 1'b0; #10;
        Serial_Data_In = 1'b1; #10;
        Serial_Data_In = 1'b0; #10;
        Serial_Data_In = 1'b1; #10;
        Serial_Data_In = 1'b1; #10;
        Serial_Data_In = 1'b0; #10;
        Serial_Data_In = 1'b0; #10;
        Serial_Data_In = 1'b0; #10;
        
        // Stop the Simulation
        $stop;
    end


endmodule
