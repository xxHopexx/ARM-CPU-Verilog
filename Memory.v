module MEM_Stage
(
    input clk, rst, Mem_R_En, Mem_W_En, 
    input[31:0] ALU_Res, Val_Rm, 

    output [31:0] Mem_Res
);

    //Data_Memory
    reg[31:0] Memory [0:63];

    //  Memory adr 
    wire [31:0]  mem_address = (ALU_Res - 32'd1024) >> 2;

    //  read data
    assign Mem_Res = Mem_R_En ? Memory[mem_address] : 32'b0000_0000_0000_0000_0000_0000_0000_0000;

    always @(posedge clk) 
    begin 
        if(Mem_W_En)
        begin
            Memory[mem_address] = Val_Rm;
        end
    end
    
endmodule
