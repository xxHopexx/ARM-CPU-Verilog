module ID_Stage
(
	input clk, rst, WB_En_WB, Hazard,
	input [3:0] Dest_WB, SR,
	input [31:0] Instruction, WB_Value_WB, 
	
	output WB_En, Mem_R_En, Mem_W_En, B, S, Imm, Two_Src,
    output [3:0] Exe_CMD, Dest, 
	output [11:0] Shift_Operand,
	output [23:0] Sign_Imm_24,
    output [31:0] Value_Rn, Value_Rm
);
	//Control Unit Signals
	wire control_wb_en, mem_read, mem_write, control_B, control_S;
	wire [3:0] control_exe, src1, src2;
	//Condition Check Signals
	wire condition_out, or_condition;

	assign src1          = Instruction[19:16];
	assign src2      	 = mem_write ? Instruction[15:12] : Instruction[3:0];
	assign Imm           = Instruction[25];
	assign Shift_Operand = Instruction[11:0];
	assign Sign_Imm_24   = Instruction[23:0];
	assign Dest          = Instruction[15:12];
	//Condition Check
	Condition_Check ConCheck(Instruction[31:28], SR, condition_out);
	//OR (Mux Select)
	or ID_Or(or_condition, Hazard, ~condition_out);
	//Control Unit
	Control_Unit CUnit(Instruction[20], Instruction[27:26], Instruction[24:21], mem_read, mem_write, control_wb_en, control_B, control_S, control_exe);
	//Register File
	RegisterFile RegFile(clk, rst, WB_En_WB, src1, src2, Dest_WB, WB_Value_WB, Value_Rn, Value_Rm);
	//Mux
	assign {WB_En, Mem_R_En, Mem_W_En, B, S, Exe_CMD} = or_condition ? 9'b0_0000_0000 :{control_wb_en, mem_read, mem_write, control_B, control_S, control_exe};
	//OR (Hazard Two_Src)
	or Two_Src_Or(Two_Src, Mem_W_En, ~Instruction[25]);

endmodule
