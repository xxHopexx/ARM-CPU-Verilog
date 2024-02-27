module Val_Generate 
(
    input Imm, Or_Out,
    input [11:0] Shift_Operand,
    input [31:0] Val_Rm,
    
    output [31:0] Val2 
);
    assign Val2 = (Or_Out) ? {{20{Shift_Operand[11]}},Shift_Operand[11:0]}:
                  (Imm)    ? ({24'b0, Shift_Operand[7:0]} >> (2 * Shift_Operand[11:8])) 
                           + ({24'b0, Shift_Operand[7:0]} << (32 - 2 * Shift_Operand[11:8])):
                  (Shift_Operand[6:5] == 2'b00) ? Val_Rm << Shift_Operand[11:7]:
                  (Shift_Operand[6:5] == 2'b01) ? Val_Rm >> Shift_Operand[11:7]:
                  (Shift_Operand[6:5] == 2'b10) ? Val_Rm >>> Shift_Operand[11:7]:
                  (Shift_Operand[6:5] == 2'b11) ? (Val_Rm >> Shift_Operand[11:7]) 
                                                + (Val_Rm << (32 - Shift_Operand[11:7])):
                  32'b0000_0000_0000_0000_0000_0000_0000_0000;

endmodule
