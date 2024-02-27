module Control_Unit 
(
    input S_In,
    input [1:0] Mode,
    input [3:0] Op_Code,
    
    output reg Mem_R_En, Mem_W_En, WB_En, B, S_Out,
    output reg [3:0] Exe_CMD
);

    always @(*) 
    begin
        {Mem_R_En, Mem_W_En, WB_En, B, Exe_CMD} = 8'b0000_0000;
        case (Mode)
            2'b10: 
            begin
                Exe_CMD = 4'bxxxx;  //b
                WB_En   = 1'b0;
                B       = 1'b1;
            end
            2'b01:
            begin
                Exe_CMD = 4'b0010; //ldr, str
                {Mem_R_En, Mem_W_En, WB_En} =  S_In ? 3'b101 : 3'b010;
            end     
            2'b00:
            begin
                case (Op_Code)
                    4'b1101:
                    begin
                        Exe_CMD = 4'b0001;//mov 
                        WB_En   = 1'b1;
                    end
                    4'b1111:
                    begin
                        Exe_CMD = 4'b1001;//mvn
                        WB_En   = 1'b1;
                    end 
                    4'b0100:
                    begin
                        Exe_CMD = 4'b0010;//add
                        WB_En   = 1'b1;
                    end 
                    4'b0101:
                    begin
                        Exe_CMD = 4'b0011;//adc
                        WB_En   = 1'b1;
                    end 
                    4'b0010:
                    begin
                        Exe_CMD = 4'b0100;//sub
                        WB_En   = 1'b1;
                    end
                    4'b0110:
                    begin
                        Exe_CMD = 4'b0101;//sbc
                        WB_En   = 1'b1;
                    end 
                    4'b0000:
                    begin
                        Exe_CMD = 4'b0110;//and
                        WB_En   = 1'b1;
                    end
                    4'b1100:
                    begin
                        Exe_CMD = 4'b0111;//orr
                        WB_En   = 1'b1;
                    end 
                    4'b0001:
                    begin
                        Exe_CMD = 4'b1000;//eor
                        WB_En   = 1'b1;
                    end
                    4'b1010: 
                    begin
                        Exe_CMD = 4'b0100;//cmp
                        WB_En   = 1'b0;
                    end
                    4'b1000:
                    begin
                        Exe_CMD = 4'b0110;//tst
                        WB_En   = 1'b0;
                    end
                    default:;
                endcase  
            end
            default:; 
        endcase
    end

    assign  S_Out = S_In;

endmodule
