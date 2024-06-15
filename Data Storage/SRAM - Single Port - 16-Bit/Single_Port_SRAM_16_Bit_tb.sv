/*
SystemVerilog Testbench for the 16-Bit Single Port SRAM.



Author : Prasad Narayan Ghatol
*/



module Single_Port_SRAM_16_Bit_tb ();

reg         Clk_In;
reg         Reset_In;

reg  [15:0] Data_In;
reg  [7:0]  Address_In;
wire [15:0] Data_Out;
reg         Write_Enable;
reg         Read_Enable;



// --------------------------------------------------
// Single Port SRAM DUT Instantiation
// --------------------------------------------------
Single_Port_SRAM_16_Bit DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),

    .Data_In(Data_In),
    .Address_In(Address_In),
    .Data_Out(Data_Out),
    .Write_Enable(Write_Enable),
    .Read_Enable(Read_Enable)
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

        repeat (20)
            begin
                Data_In = $random;
                Address_In = $random;
                
                Write_Enable = 1'b1;
                Read_Enable = 1'b0;

                #10;
                
                Write_Enable = 1'b0;
                Read_Enable = 1'b1;

                #10;
            end

        $stop;
    end



endmodule