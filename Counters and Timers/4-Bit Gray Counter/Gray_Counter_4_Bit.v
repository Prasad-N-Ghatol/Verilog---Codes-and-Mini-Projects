/*
Verilog Code, to implement a 4-Bit Gray Counter.



Author : Prasad Narayan Ghatol
*/



module Gray_Counter_4_Bit (
    input        Clk_In,
    input        Reset_In,

    input        Start_Stopb_In,
    output [3:0] Gray_Count_Out
);



// --------------------------------------------------
// wires and regs
// --------------------------------------------------
reg  [3:0] Binary_Counter;

wire [3:0] Gray_Value;


// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Gray_Count_Out = Gray_Value;



// --------------------------------------------------
// Binary to Gray Converter
// --------------------------------------------------
assign Gray_Value[3] = Binary_Counter[3];
assign Gray_Value[2] = Binary_Counter[3] ^ Binary_Counter[2];
assign Gray_Value[1] = Binary_Counter[2] ^ Binary_Counter[1];
assign Gray_Value[0] = Binary_Counter[1] ^ Binary_Counter[0];



// --------------------------------------------------
// Binary Counter
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                Binary_Counter <= 4'b0;
            end
        else
            begin
                if (Start_Stopb_In)
                    begin
                        Binary_Counter <= Binary_Counter + 1'b1;
                    end
                else
                    begin
                        Binary_Counter <= Binary_Counter;
                    end
            end
    end



endmodule