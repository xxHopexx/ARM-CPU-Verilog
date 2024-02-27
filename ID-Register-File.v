module RegisterFile
(
    input clk, rst, WB_En, 
    input [3:0] src1, src2, Dest_WB,
    input [31:0] WB_Value,
    
    output [31:0] Val_Rn, Val_Rm
);

    reg [31:0]Register_File[0:14];//15 * 32bit_Regs
    
    integer i;

    assign Val_Rn = Register_File[src1];
    assign Val_Rm = Register_File[src2];

    always@(negedge clk, posedge rst)
    begin
        if(rst)
        begin
            for (i = 0 ; i < 15 ; i = i + 1) 
            begin
                Register_File[i] = i;
            end
        end
        else if(WB_En)
        begin
            Register_File[Dest_WB] = WB_Value;
        end
    end

endmodule
