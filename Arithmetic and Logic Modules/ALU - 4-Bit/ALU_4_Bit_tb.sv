/*
SystemVerilog Testbench for the ALU - 4-Bit.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module ALU_4_Bit_tb ();



reg        Reset_In;

reg  [3:0] Data_A_In;
reg  [3:0] Data_B_In;
reg        Carry_Borrowb_In;
reg  [3:0] Operation_Select_In;

wire [3:0] Result_Out;
wire       Carry_Out;



// --------------------------------------------------
// ALU - 4-Bit DUT Instantiation
// --------------------------------------------------
ALU_4_Bit DUT (
    .Reset_In(Reset_In),
    .Data_A_In(Data_A_In),
    .Data_B_In(Data_B_In),
    .Carry_Borrowb_In(Carry_Borrowb_In),
    .Operation_Select_In(Operation_Select_In),
    .Result_Out(Result_Out),
    .Carry_Out(Carry_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        repeat(20)
            begin
                Data_A_In = $random;
                Data_B_In = $random;
                Carry_Borrowb_In = $random;
                Operation_Select_In = $random;
                #10;
            end

        $stop;
    end



endmodule