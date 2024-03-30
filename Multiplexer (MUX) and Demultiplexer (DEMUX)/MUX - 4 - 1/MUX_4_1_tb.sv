/*
Testbench file to test the implementation of the 4:1 MUX.

Author - Prasad Narayan Ghatol
*/

module MUX_4_1_tb ();

reg         Enable_In;
reg         Data_0_In;
reg         Data_1_In;
reg         Data_2_In;
reg         Data_3_In;
reg [1:0]   Select_In;

wire        MUX_Data_Out;

// DUT Instantiation
MUX_4_1 DUT (
    .Enable_In(Enable_In),
    .Data_0_In(Data_0_In),
    .Data_1_In(Data_1_In),
    .Data_2_In(Data_2_In),
    .Data_3_In(Data_3_In),
    .Select_In(Select_In),
    .MUX_Data_Out(MUX_Data_Out)
);

// Testbench Logic
initial
    begin
        Enable_In = 1'b0;
        Data_0_In = 1'b0;
        Data_1_In = 1'b0;
        Data_2_In = 1'b0;
        Data_3_In = 1'b0;
        Select_In = 2'b0;
        #10;
        
        repeat (10)
            begin
                Enable_In = 1'b1;
                Data_0_In = $random;
                Data_1_In = $random;
                Data_2_In = $random;
                Data_3_In = $random;
                Select_In = $random;
                #10;
            end
    end

endmodule