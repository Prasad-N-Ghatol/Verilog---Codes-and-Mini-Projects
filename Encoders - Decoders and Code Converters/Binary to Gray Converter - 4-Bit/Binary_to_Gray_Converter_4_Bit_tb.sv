/*
SystemVerilog Testbench for the Binary to Gray Converter - 4-Bit.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Binary_to_Gray_Converter_4_Bit_tb ();


reg  [3:0] Binary_Code_In;
wire [3:0] Gray_Code_Out;



// --------------------------------------------------
// Binary to Gray Converter - 4-Bit DUT Instantiation
// --------------------------------------------------
Binary_to_Gray_Converter_4_Bit DUT (
    .Binary_Code_In(Binary_Code_In),
    .Gray_Code_Out(Gray_Code_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        repeat (20)
            begin
                Binary_Code_In = $random;
                #10;
            end

        $stop;
    end



endmodule