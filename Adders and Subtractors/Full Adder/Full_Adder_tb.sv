/*
SystemVerilog Testbench for the Full Adder.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Full_Adder_tb ();



reg  Data_A_In;
reg  Data_B_In;
reg  Carry_In;

wire Sum_Out;
wire Carry_Out;



// --------------------------------------------------
// Full Adder DUT Instantiation 
// --------------------------------------------------
Full_Adder DUT (
    .Data_A_In(Data_A_In),
    .Data_B_In(Data_B_In),
    .Carry_In(Carry_In),
    
    .Sum_Out(Sum_Out),
    .Carry_Out(Carry_Out)
);
    


// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        repeat (20)
            begin
                Data_A_In = $random;
                Data_B_In = $random;
                Carry_In = $random;
                #10;
            end
        
        $stop;
    end



endmodule