/*
SystemVerilog Testbench for the 8-Bit LIFO (Stack).



Author : Prasad Narayan Ghatol
*/



module LIFO_Stack_8_Bit_tb ();



reg        Clk_In;
reg        Reset_In;

reg  [7:0] Data_In;
wire [7:0] Data_Out;
reg        Push_In;
reg        Pop_In;
reg        Peek_In;

wire       LIFO_Empty;
wire       LIFO_Full;



// --------------------------------------------------
// LIFO DUT Instantiation
// --------------------------------------------------
LIFO_Stack_8_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),

    .Data_In(Data_In),
    .Data_Out(Data_Out),
    .Push_In(Push_In),
    .Pop_In(Pop_In),
    .Peek_In(Peek_In),

    .LIFO_Empty(LIFO_Empty),
    .LIFO_Full(LIFO_Full)
);



// --------------------------------------------------
// Clock Initialization
// --------------------------------------------------
initial
    begin
        Clk_In = 1'b0;

        forever
            begin
                #5;
                Clk_In = ~Clk_In;
            end
    end



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        // Read from an empty LIFO
        Push_In = 1'b0;
        Pop_In = 1'b0;
        Peek_In = 1'b1;
        #10;

        Push_In = 1'b0;
        Pop_In = 1'b1;
        Peek_In = 1'b0;
        #10;

        // Write 8 Bytes of Data into LIFO
        repeat (8)
            begin
                Data_In = $random;
                Push_In = 1'b1;
                Pop_In = 1'b0;
                Peek_In = 1'b0;
                #10;
            end

        // Write into a full LIFO
        Data_In = $random;
        Push_In = 1'b1;
        Pop_In = 1'b0;
        Peek_In = 1'b0;
        #10;

        // Read 8 Bytes of Data from LIFO
        repeat (8)
            begin
                Push_In = 1'b0;
                Pop_In = 1'b0;
                Peek_In = 1'b1;
                #10;

                Push_In = 1'b0;
                Pop_In = 1'b1;
                Peek_In = 1'b0;
                #10;
            end

        // Read from an empty LIFO
            Push_In = 1'b0;
            Pop_In = 1'b0;
            Peek_In = 1'b1;
            #10;

            Pop_In = 1'b1;
            Peek_In = 1'b0;
            #10;
    
        $stop;
    end



endmodule