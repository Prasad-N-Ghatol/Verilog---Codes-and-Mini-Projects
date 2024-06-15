/*
SystemVerilog Testbench for the 32-Bit FIFO (Queue).



Author : Prasad Narayan Ghatol
*/



module FIFO_Queue_32_Bit_tb ();



reg         Clk_In;
reg         Reset_In;

reg  [31:0] Data_In;
wire [31:0] Data_Out;
reg         Write_Enable_In;
reg         Read_Enable_In;

wire        FIFO_Empty;
wire        FIFO_Full;



// --------------------------------------------------
// FIFO DUT Instantiation
// --------------------------------------------------
FIFO_Queue_32_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),

    .Data_In(Data_In),
    .Data_Out(Data_Out),
    .Write_Enable_In(Write_Enable_In),
    .Read_Enable_In(Read_Enable_In),

    .FIFO_Empty(FIFO_Empty),
    .FIFO_Full(FIFO_Full)
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


        // Read from an empty FIFO
        Write_Enable_In = 1'b0;
        Read_Enable_In = 1'b1;
        #10;


        // Write 8 Bytes of Data into FIFO
        repeat (8)
            begin
                Data_In = $random;
                Write_Enable_In = 1'b1;
                Read_Enable_In = 1'b0;
                #10;
            end


        // Write into a full FIFO
        Data_In = $random;
        Write_Enable_In = 1'b1;
        Read_Enable_In = 1'b0;
        #10;


        // Read 8 Bytes of Data from FIFO
        repeat (8)
            begin
                Write_Enable_In = 1'b0;
                Read_Enable_In = 1'b1;
                #10;
            end


        // Read from an empty FIFO
        Write_Enable_In = 1'b0;
        Read_Enable_In = 1'b1;
        #10;
    
        $stop;
    end



endmodule