module EXE_Reg
    (
	input clk, rst, WB_En_In, Mem_R_En_In, Mem_W_En_In,
    input [3:0]Dest_in,
	input [31:0] ALU_Res_In, Val_Rm_In,
	
	output reg WB_En_Out, Mem_R_En_Out, Mem_W_En_Out,  
    output reg [3:0] Dest_Out,
	output reg [31:0] ALU_Res_Out, Val_Rm_Out
    );
	
	always@(posedge clk, posedge rst)
    begin
		if (rst)
			{WB_En_Out, Mem_R_En_Out, Mem_W_En_Out, ALU_Res_Out, Val_Rm_Out, Dest_Out} = 71'd0;
		else 
        begin 
			WB_En_Out    =    WB_En_In;
			Mem_R_En_Out = Mem_R_En_In;
			Mem_W_En_Out = Mem_W_En_In;
			ALU_Res_Out  =  ALU_Res_In;
			Val_Rm_Out   =   Val_Rm_In;
			Dest_Out     =     Dest_in;
		end		
	end

endmodule
	
