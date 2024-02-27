module IF_Reg 
(
    input clk, rst, freeze, flush,
    input [31:0] PC_In, Instruction_In,

    output reg [31:0] PC, Instruction
);

    always @(posedge clk, posedge rst) 
    begin
        if (rst) 
        begin
           PC          = 32'b0000_0000_0000_0000_0000_0000_0000_0000; 
           Instruction = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
        end
        else if(flush) 
        begin
			PC          = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			Instruction = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
		end
        else if(freeze) 
        begin
            PC          = PC;
            Instruction = Instruction;
        end
        else 
        begin
            PC          = PC_In;
            Instruction = Instruction_In;
        end
    end

endmodule
