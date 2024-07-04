/*
**************************************************
                ALU - 4-Bit
**************************************************

This is a verilog code, to implement a 4-Bit ALU.

This ALU operates on 2 4-Bit Words (Data_A and Data_B) along with a Carry_In,
and the result is a 4-Bit Word (Result) along with a Carry_Out.

There are 16 operations available, which can be selected with the help of Operation_Select.
The supported Operations along with their selection input values are :
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



module ALU_4_Bit (
    input        Reset_In,

    input  [3:0] Data_A_In,
    input  [3:0] Data_B_In,
    input        Carry_Borrowb_In,
    input  [3:0] Operation_Select_In,   // Select the operation to be performed by the ALU

    output [3:0] Result_Out,
    output       Carry_Out
);



// --------------------------------------------------
// Constants
// --------------------------------------------------
localparam [3:0]    SEND_A      = 4'h0, // A
                    SEND_B      = 4'h1, // B
                    A_PLUS_B    = 4'h2, // A + B + Cin
                    A_MINUS_B   = 4'h3, // A - B - Cin
                    B_MINUS_A   = 4'h4, // B - A - Cin
                    A_PLUS_1    = 4'h5, // A + 1
                    B_PLUS_1    = 4'h6, // B + 1
                    A_MINUS_1   = 4'h7, // A - 1
                    A_AND_B     = 4'h8, // A AND B
                    A_OR_B      = 4'h9, // A OR B
                    A_XOR_B     = 4'hA, // A XOR B
                    A_NAND_B    = 4'hB, // A NAND B
                    A_NOR_B     = 4'hC, // A NOR B
                    A_XNOR_B    = 4'hD, // A XNOR B
                    NOT_A       = 4'hE, // NOT A
                    NOT_B       = 4'hF; // NOT B



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg [4:0] Temp_Arithmetic_Result;
reg [3:0] Temp_Logical_Result;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Result_Out = Reset_In ? 4'bZ : (Operation_Select_In[3] ? Temp_Logical_Result : Temp_Arithmetic_Result[3:0]);
assign Carry_Out  = Reset_In ? 1'bZ : (Operation_Select_In[3] ? 1'bZ : Temp_Arithmetic_Result[4]);



// --------------------------------------------------
// ALU - 4-Bit Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Operation_Select_In)
            SEND_A      : // 4'h0 -> A
                begin
                    Temp_Arithmetic_Result <= Data_A_In;
                    Temp_Logical_Result <= 4'b0;
                end

            SEND_B      : // 4'h1 -> B
                begin
                    Temp_Arithmetic_Result <= Data_B_In;
                    Temp_Logical_Result <= 4'b0;
                end

            A_PLUS_B    : // 4'h2 -> A + B + Cin
                begin
                    Temp_Arithmetic_Result <= Data_A_In + Data_B_In + Carry_Borrowb_In;
                    Temp_Logical_Result <= 4'b0;
                end

            A_MINUS_B   : // 4'h3 -> A - B - Cin
                begin
                    Temp_Arithmetic_Result <= Data_A_In - Data_B_In - Carry_Borrowb_In;
                    Temp_Logical_Result <= 4'b0;
                end

            B_MINUS_A   : // 4'h4 -> B - A - Cin
                begin
                    Temp_Arithmetic_Result <= Data_B_In - Data_A_In - Carry_Borrowb_In;
                    Temp_Logical_Result <= 4'b0;
                end

            A_PLUS_1    : // 4'h5 -> A + 1
                begin
                    Temp_Arithmetic_Result <= Data_A_In + 1'b1;
                    Temp_Logical_Result <= 4'b0;
                end

            B_PLUS_1    : // 4'h6 -> B + 1
                begin
                    Temp_Arithmetic_Result <= Data_B_In + 1'b1;
                    Temp_Logical_Result <= 4'b0;
                end

            A_MINUS_1   : // 4'h7 -> A - 1
                begin
                    Temp_Arithmetic_Result <= Data_A_In - 1'b1;
                    Temp_Logical_Result <= 4'b0;
                end

            A_AND_B     : // 4'h8 -> A AND B
                begin
                    Temp_Arithmetic_Result <= 5'b0;
                    Temp_Logical_Result <= Data_A_In && Data_B_In;
                end

            A_OR_B      : // 4'h9 -> A OR B
                begin
                    Temp_Arithmetic_Result <= 5'b0;
                    Temp_Logical_Result <= Data_A_In || Data_B_In;
                end

            A_XOR_B     : // 4'hA -> A XOR B
                begin
                    Temp_Arithmetic_Result <= 5'b0;
                    Temp_Logical_Result <= Data_A_In ^ Data_B_In;
                end

            A_NAND_B    : // 4'hB -> A NAND B
                begin
                    Temp_Arithmetic_Result <= 5'b0;
                    Temp_Logical_Result <= ~(Data_A_In && Data_B_In);
                end

            A_NOR_B     : // 4'hC -> A NOR B
                begin
                    Temp_Arithmetic_Result <= 5'b0;
                    Temp_Logical_Result <= ~(Data_A_In || Data_B_In);
                end

            A_XNOR_B    : // 4'hD -> A XNOR B
                begin
                    Temp_Arithmetic_Result <= 5'b0;
                    Temp_Logical_Result <= ~(Data_A_In ^ Data_B_In);
                end

            NOT_A       : // 4'hE -> NOT A
                begin
                    Temp_Arithmetic_Result <= 5'b0;
                    Temp_Logical_Result <= ~Data_A_In;
                end

            NOT_B       : // 4'hF -> NOT B
                begin
                    Temp_Arithmetic_Result <= 5'b0;
                    Temp_Logical_Result <= ~Data_B_In;
                end
    
            default: 
                begin
                    Temp_Arithmetic_Result <= Data_A_In;
                end
        endcase
    end



endmodule