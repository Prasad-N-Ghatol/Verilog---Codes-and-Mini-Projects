/*
SystemVerilog Testbench for the I2C.



Author : Prasad Narayan Ghatol
*/
`timescale 1ns/1ps



module I2C_tb #(parameter SYS_CLOCK = 100_000_000) ();



reg        Clk_In;
reg        Reset_In;

reg  [2:0] Speed_Mode_In;
wire       I2C_Clock_Out;

wire       I2C_SDA;
wire       I2C_SCL;

reg        I2C_Start_Transfer_In;

reg        M_Burst_Singleb_In;
reg  [1:0] M_Burst_Length_In;
reg        M_Read_Writeb_In;

reg [6:0] M_Slave_Device_Address_In;
reg [7:0] M_Reg_Address_In;
reg [7:0] M_Data_In;

wire [7:0] M_Data_Out;
wire       M_Data_Read_Enable_Out;

reg [7:0] S_Data_In;

wire [6:0] S_Slave_Device_Address_Out;
wire       S_Read_Writeb_Out;
wire [7:0] S_Reg_Address_Out;
wire [7:0] S_Data_Out;
wire       S_Data_Read_Enable_Out;



// --------------------------------------------------
// DUT Instantiation
// --------------------------------------------------
I2C #(.SYS_CLOCK(100_000_000)) DUT (
    .Clk_In(Clk_In),
    .Reset_In(Reset_In),
    .Speed_Mode_In(Speed_Mode_In),
    .I2C_Clock_Out(I2C_Clock_Out),
    .I2C_SDA(I2C_SDA),
    .I2C_SCL(I2C_SCL),
    .I2C_Start_Transfer_In(I2C_Start_Transfer_In),
    .M_Burst_Singleb_In(M_Burst_Singleb_In),
    .M_Burst_Length_In(M_Burst_Length_In),
    .M_Read_Writeb_In(M_Read_Writeb_In),
    .M_Slave_Device_Address_In(M_Slave_Device_Address_In),
    .M_Reg_Address_In(M_Reg_Address_In),
    .M_Data_In(M_Data_In),
    .M_Data_Out(M_Data_Out),
    .M_Data_Read_Enable_Out(M_Data_Read_Enable_Out),
    .S_Data_In(S_Data_In),
    .S_Slave_Device_Address_Out(S_Slave_Device_Address_Out),
    .S_Read_Writeb_Out(S_Read_Writeb_Out),
    .S_Reg_Address_Out(S_Reg_Address_Out),
    .S_Data_Out(S_Data_Out),
    .S_Data_Read_Enable_Out(S_Data_Read_Enable_Out)
);



// --------------------------------------------------
// Constants Declaration
// --------------------------------------------------
localparam [2:0]    I2C_SPEED_SM  = 3'h0, // Standard-Mode (Sm)        -> 100 kbit/sec , Td = 90000
                    I2C_SPEED_FM  = 3'h1, // Fast-Mode (Fm)            -> 400 kbit/sec , Td = 22500
                    I2C_SPEED_FMP = 3'h2, // Fast-Mode Plus (Fm+)      -> 1   Mbit/sec , Td = 9000
                    I2C_SPEED_HSM = 3'h3; // High-Speed Mode (Hs-mode) -> 3.4 Mbit/sec , Td = 2286



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
// Task
// --------------------------------------------------
task I2C_Transaction (input bit [2:0] Speed_Mode, bit Burst_Singleb, bit Read_Writeb, bit [6:0] Slave_Device_Address, int Delay);
    Speed_Mode_In = Speed_Mode;
    #10;

    M_Burst_Singleb_In = Burst_Singleb;
    M_Burst_Length_In = $random;
    M_Read_Writeb_In = Read_Writeb;

    M_Slave_Device_Address_In = Slave_Device_Address;
    M_Reg_Address_In = $random;
    M_Data_In = $random;
    S_Data_In = $random;
    
    #10;
    
    I2C_Start_Transfer_In = 1'b1;
    #(Delay);
    I2C_Start_Transfer_In = 1'b0;
    
    repeat (9)
        begin
            M_Data_In = $random;
            S_Data_In = $random;
            #(Delay);
        end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Reset_In = 1'b1;
        #10;
        Reset_In = 1'b0;

        // Set I2C Operating Speed at : Standard-Mode (Sm) -> 100 kbit/sec
        // Use of incorrect Slave Device Address
        I2C_Transaction(I2C_SPEED_SM, 1'b0, 1'b0, 7'h4A, 90000);
        
        // Set I2C Operating Speed at : Standard-Mode (Sm) -> 100 kbit/sec
        // Use of correct Slave Device Address
        I2C_Transaction(I2C_SPEED_SM, $random, $random, 7'h68, 90000);


        // Set I2C Operating Speed at : Fast-Mode (Fm) -> 400 kbit/sec
        I2C_Transaction(I2C_SPEED_FM, $random, $random, 7'h68, 22500);


        // Set I2C Operating Speed at : Fast-Mode Plus (Fm+)  -> 1   Mbit/sec
        I2C_Transaction(I2C_SPEED_FMP, $random, $random, 7'h68, 9000);


        // Set I2C Operating Speed at : High-Speed Mode (Hs-mode) -> 3.4 Mbit/sec
        I2C_Transaction(I2C_SPEED_HSM, $random, $random, 7'h68, 2286);


        $stop;
    end



endmodule