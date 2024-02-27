module Top
(
    input clk, rst
);
    //IF Wires
    wire [31:0] PC_IF, Instruction_IF; 
    //ID Wires
    wire        WB_En_ID, Mem_R_En_ID, Mem_W_En_ID, B_ID, S_ID, Imm_ID;
    wire [ 3:0] Exe_CMD_ID, Dest_ID;
    wire [11:0] Shift_Operand_ID;
    wire [23:0] Sign_Imm_24_ID;
    wire [31:0] PC_ID, Instruction_ID, Val_Rn_ID, Val_Rm_ID;
    //EXE Wires                         B_EXE = Branch_Tacken = Flush
    wire        WB_En_EXE, Mem_R_En_EXE, Mem_W_En_EXE, B_EXE, Imm_EXE, Carry_EXE;
    wire [ 3:0] Exe_CMD_EXE, Dest_EXE;
    wire [11:0] Shift_Operand_EXE;
    wire [23:0] Sign_Imm_24_EXE;
    wire [31:0] PC_EXE, Val_Rn_EXE, Val_Rm_EXE, ALU_Res_EXE, B_Address_EXE;
    //MEM Wires
    wire        WB_En_MEM, Mem_R_En_MEM, Mem_W_En_MEM;
    wire [ 3:0] Dest_MEM;
    wire [31:0] Val_Rm_MEM, ALU_Res_MEM, Mem_Res_MEM;
    //WB Wires
    wire        WB_En_WB, Mem_R_En_WB;
    wire [ 3:0] Dest_WB;
    wire [31:0] ALU_Res_WB, Mem_Res_WB, WB_Value_WB;
    //SR Wires                          Status_Bits_In[1] = Carry_In
    wire        S_SR;
    wire [ 3:0] Status_Bits_In, Status_Bits_Out; 
    //Hazard Wires                      Hazard = Freeze
    wire        Two_Src, Hazard;
    wire [ 3:0] Src1_HAZ, Src2_HAZ;
    assign Src1_HAZ = Instruction_ID[19:16];
    assign Src2_HAZ = Mem_W_En_ID ? Instruction_ID[15:12] : Instruction_ID[3:0];
    //IF
    IF_Stage IF_inst    (clk, rst, Hazard, B_EXE, B_Address_EXE, PC_IF, Instruction_IF);
    //IF Reg
    IF_Reg IFReg_inst   (clk, rst, Hazard, B_EXE, PC_IF, Instruction_IF, PC_ID, Instruction_ID);
    //ID
    ID_Stage ID_inst    (clk, rst, WB_En_WB, Hazard, Dest_WB, Status_Bits_Out, Instruction_ID,
                        WB_Value_WB, WB_En_ID, Mem_R_En_ID, Mem_W_En_ID, B_ID, S_ID, Imm_ID, 
                        Two_Src, Exe_CMD_ID, Dest_ID, Shift_Operand_ID, Sign_Imm_24_ID, 
                        Val_Rn_ID, Val_Rm_ID);
    //ID Reg
    ID_Reg IDReg_inst   (clk, rst, B_EXE, WB_En_ID, Mem_R_En_ID, Mem_W_En_ID, Status_Bits_In[1],
                        B_ID, S_ID, Imm_ID, Exe_CMD_ID, Dest_ID, Shift_Operand_ID, Sign_Imm_24_ID,
                        PC_ID, Val_Rn_ID, Val_Rm_ID, WB_En_EXE, Mem_R_En_EXE, Mem_W_En_EXE, B_EXE,
                        S_SR, Imm_EXE, Carry_EXE, Exe_CMD_EXE, Dest_EXE, Shift_Operand_EXE, 
                        Sign_Imm_24_EXE, PC_EXE,Val_Rn_EXE, Val_Rm_EXE);
    //EXE
    EXE_Stage EXE_inst  (clk, rst, Mem_R_En_EXE, Mem_W_En_EXE, Imm_EXE, Carry_EXE, 
                        Exe_CMD_EXE, Shift_Operand_EXE, Sign_Imm_24_EXE, PC_EXE, 
                        Val_Rn_EXE, Val_Rm_EXE, Status_Bits_In, ALU_Res_EXE, B_Address_EXE);   
    //Status Reg
    Status_Reg SR_inst  (clk, rst, S_SR, Status_Bits_In, Status_Bits_Out);
    //EXE Reg
    EXE_Reg EXEReg_inst (clk, rst, WB_En_EXE, Mem_R_En_EXE, Mem_W_En_EXE, Dest_EXE, ALU_Res_EXE, 
                        Val_Rm_EXE, WB_En_MEM, Mem_R_En_MEM, Mem_W_En_MEM,  Dest_MEM, ALU_Res_MEM, 
                        Val_Rm_MEM);
    //MEM
    MEM_Stage MEM_inst  (clk, rst, Mem_R_En_MEM, Mem_W_En_MEM, ALU_Res_MEM, Val_Rm_MEM, Mem_Res_MEM); 
    //MEM Reg
    MEM_Reg MEMReg_inst (clk, rst, WB_En_MEM, Mem_R_En_MEM, Dest_MEM, ALU_Res_MEM, Mem_Res_MEM,
                        WB_En_WB, Mem_R_En_WB, Dest_WB, ALU_Res_WB, Mem_Res_WB); 
    //WB
    WB_Stage wb_inst    (clk, rst, Mem_R_En_WB, ALU_Res_WB, Mem_Res_WB, WB_Value_WB);  
    //HAZARD
    Hazard_Unit Hazard_inst(WB_En_EXE, WB_En_MEM, Two_Src, Src1_HAZ, Src2_HAZ, Dest_EXE, Dest_MEM, Hazard);                
endmodule
