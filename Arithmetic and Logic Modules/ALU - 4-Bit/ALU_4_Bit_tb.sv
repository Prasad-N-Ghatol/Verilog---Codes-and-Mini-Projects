/*
**************************************************
            ALU - 4-Bit - Testbench
**************************************************

This is a SystemVerilog Testbench code, for the 4-Bit ALU.

The supported 16 Operations along with their selection input values are :
    1) Arithmetical Operations :
        4'h0 => A
        4'h1 => B
        4'h2 => A + B + Cin
        4'h3 => A - B - Cin
        4'h4 => B - A - Cin
        4'h5 => A + 1
        4'h6 => B + 1
        4'h7 => A - 1

    2) Logical Operations :
        4'h8 => A AND B
        4'h9 => A OR B
        4'hA => A XOR B
        4'hB => A NAND B
        4'hC => A NOR B
        4'hD => A XNOR B
        4'hE => NOT A
        4'hF => NOT B

--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
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
        // Reset the design
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        // Repeat the Test 20 times
        repeat(20)
            begin
                Data_A_In = $random;
                Data_B_In = $random;
                Carry_Borrowb_In = $random;
                Operation_Select_In = $random;
                #10;
            end

        // Stop the Test
        $stop;
    end



endmodule