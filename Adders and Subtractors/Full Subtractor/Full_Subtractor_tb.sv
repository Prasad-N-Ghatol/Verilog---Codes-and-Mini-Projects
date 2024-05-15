/*
SystemVerilog Testbench for the Full Subtractor.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module Full_Subtractor_tb ();



reg  Data_A_In;
reg  Data_B_In;
reg  Borrow_In;

wire Sum_Out;
wire Borrow_Out;



// --------------------------------------------------
// Full Subtractor DUT Instantiation 
// --------------------------------------------------
Full_Subtractor DUT (
    .Data_A_In(Data_A_In),
    .Data_B_In(Data_B_In),
    .Borrow_In(Borrow_In),
    
    .Sum_Out(Sum_Out),
    .Borrow_Out(Borrow_Out)
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
                Borrow_In = $random;
                #10;
            end
        
        $stop;
    end



endmodule