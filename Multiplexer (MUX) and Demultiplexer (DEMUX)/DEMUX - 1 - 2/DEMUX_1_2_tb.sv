/*
Testbench file to test the implementation of the 1:2 DEMUX.

Author - Prasad Narayan Ghatol
*/

module DEMUX_1_2_tb ();

reg Enable_In;
reg Data_In;
reg Select_In;

wire Data_0_Out;
wire Data_1_Out;

// DUT Instantiation
DEMUX_1_2 DUT (
    .Enable_In(Enable_In),
    .Data_In(Data_In),
    .Select_In(Select_In),
    .Data_0_Out(Data_0_Out),
    .Data_1_Out(Data_1_Out)
);

// Testbench Logic
initial
    begin
        Enable_In = 1'b0;
        Data_In = 1'b0;
        Select_In = 1'b0;
        #10;
        
        repeat (10)
            begin
                Enable_In = 1'b1;
                Data_In = $random;
                Select_In = $random;
                #10;
            end
    end

endmodule