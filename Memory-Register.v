module MEM_Reg
(
    input clk, rst, WB_En_In, Mem_R_En_In,
    input [3:0] Dest_In,
    input [31:0] ALU_Res_In, Mem_Res_In,
  
    output reg WB_En_Out, Mem_R_En_Out,
    output reg [3:0] Dest_Out,
    output reg [31:0] ALU_Res_Out, Mem_Res_Out
    
);

    always @(posedge clk, posedge rst) 
    begin
        if(rst) 
        begin    
            Mem_R_En_Out <=  1'b0; 
            WB_En_Out    <=  1'b0;
            ALU_Res_Out  <= 32'b0;
            Mem_Res_Out  <= 32'b0;   
        end  
        else 
        begin
            Mem_R_En_Out <= Mem_R_En_In; 
            Dest_Out     <=     Dest_In;
            WB_En_Out    <=    WB_En_In;
            ALU_Res_Out  <=  ALU_Res_In;
            Mem_Res_Out  <=  Mem_Res_In; 
        end      
    end   
    
endmodule      
