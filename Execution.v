module EXE_Stage
(
	input clk, rst, Mem_R_En, Mem_W_En, Imm, Carry_In, 
	input [3:0] Exe_CMD,
	input [11:0] Shift_Operand,
	input [23:0] Signed_Imm_24,
    input [31:0] PC_In, Val_Rn, Val_Rm, 
    
	output [3:0] Status_Bits,
	output [31:0] ALU_Res, Br_Addr
);

	wire Exe_Or_Out;
	wire [31:0] Val2;

	or Exe_Or(Exe_Or_Out, Mem_R_En, Mem_W_En);

	Val_Generate Val2Gen(Imm, Exe_Or_Out, Shift_Operand, Val_Rm, Val2);

	ALU Alu(Carry_In, Exe_CMD, Val_Rn, Val2, Status_Bits, ALU_Res);

	assign Br_Addr = ({{8{Signed_Imm_24[23]}}, Signed_Imm_24} << 2) + PC_In;

endmodule
