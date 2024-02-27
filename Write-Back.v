module WB_Stage
(
    input clk, rst, Mem_R_En,
    input [31:0] ALU_Res, Mem_Res,
    
    output [31:0] WB_Value
);

    assign WB_Value = Mem_R_En ? Mem_Res : ALU_Res;
    
endmodule
