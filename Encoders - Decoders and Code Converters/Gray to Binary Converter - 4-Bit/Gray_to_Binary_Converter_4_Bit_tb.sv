/*
SystemVerilog Testbench for the Gray to Binary Converter - 4-Bit.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Gray_to_Binary_Converter_4_Bit_tb ();


reg  [3:0] Gray_Code_In;
wire [3:0] Binary_Code_Out;



// --------------------------------------------------
// Gray to Binary Converter - 4-Bit DUT Instantiation
// --------------------------------------------------
Gray_to_Binary_Converter_4_Bit DUT (
    .Gray_Code_In(Gray_Code_In),
    .Binary_Code_Out(Binary_Code_Out)
);



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        repeat (20)
            begin
                Gray_Code_In = $random;
                #10;
            end

        $stop;
    end



endmodule