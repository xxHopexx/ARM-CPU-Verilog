module ID_Reg 
(
    input clk, rst, flush, WB_En_IN, MEM_R_EN_IN, MEM_W_EN_IN, carry_in,
	input B_IN, S_IN, imm_IN,
	input [3:0] Exe_CMD_IN,Dest_IN,	
	input [11:0] Shift_operand_IN,
	input [23:0] Signed_imm_24_IN,
	input [31:0] PC_in, Val_Rn_IN, Val_Rm_IN,
	output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm, carry_in_out,
	output reg [3:0] Exe_CMD, Dest,
	output reg [11:0] shift_operand,
	output reg [23:0] signed_im_24,
	output reg [31:0] PC, value_Rn, value_Rm
);

	always@(posedge clk, posedge rst)
    begin
		if (rst) 
		begin
			PC = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			value_Rm = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			value_Rn = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			signed_im_24 = 24'b0000_0000_0000_0000_0000_0000;
			shift_operand = 12'b000_000_000_000;
			{Exe_CMD, Dest} = 8'b0000_0000;
			{WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm} = 6'b0000_00;
			carry_in_out = 1'b0;
		end
		else if (flush) 
		begin
			PC = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			value_Rm = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			value_Rn = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			signed_im_24 = 24'b0000_0000_0000_0000_0000_0000;
			shift_operand = 12'b000_000_000_000;
			{Exe_CMD, Dest} = 8'b0000_0000;
			{WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm} = 6'b0000_00;
			carry_in_out = 1'b0;
		end
		else 
        begin
			PC = PC_in;
			value_Rm = Val_Rm_IN;
			value_Rn = Val_Rn_IN;
			signed_im_24 = Signed_imm_24_IN;
			shift_operand = Shift_operand_IN;
			Exe_CMD = Exe_CMD_IN;
			Dest = Dest_IN;
			{WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm} = {WB_En_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN, imm_IN};
			carry_in_out = carry_in;
        end
	end

endmodule
	
