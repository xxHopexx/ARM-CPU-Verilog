module ALU (
    input Carry_In,
    input [3:0] Exe_CMD,
    input [31:0] Val1, Val2,

    output reg [3:0] Status_Bits,
    output reg [31:0] Alu_Res
);

    wire [3:0] Not_Carry;
    assign Not_Carry = ~Carry_In;

    //wire [31:0] Val2_Minus;
    //assign Val2_Minus = - Val2;

    always @(*) 
    begin
        Alu_Res = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
        Status_Bits = 4'b0000;
        case (Exe_CMD)
        4'b0001: 
        begin
            Alu_Res = Val2;
            {Status_Bits[3], Status_Bits[1:0]} = {Val2[31], 2'b00};
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
        end
        4'b1001: 
        begin
            Alu_Res = ~Val2;
            {Status_Bits[3], Status_Bits[1:0]} = {~Val2[31], 2'b00};
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
        end
        4'b0010: 
        begin
            {Status_Bits[1], Alu_Res} = Val1 + Val2;
            Status_Bits[0] = (Val1[31] & Val2[31] & ~Alu_Res[31]) || (~Val1[31] & ~Val2[31] & Alu_Res[31]);
            Status_Bits[3] = Alu_Res[31];
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
        end
        4'b0011: 
        begin
            {Status_Bits[1], Alu_Res} = Val1 + Val2 + Carry_In;
            Status_Bits[0] = (Val1[31] & Val2[31] & ~Alu_Res[31]) || (~Val1[31] & ~Val2[31] & Alu_Res[31]);
            Status_Bits[3] = Alu_Res[31];
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
        end
        4'b0100: //(~Val2[31])???
        begin
            {Status_Bits[1], Alu_Res} = Val1 - Val2;
            Status_Bits[0] = (Val1[31] & (~Val2[31]) & ~Alu_Res[31] ) || (~Val1[31] & Val2[31] & Alu_Res[31]);
            Status_Bits[3] = Alu_Res[31];
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
        end
        4'b0101: //(~Val2[31])???
        begin
            {Status_Bits[1], Alu_Res} = Val1 - Val2 - Not_Carry[0];
            Status_Bits[0] = (Val1[31] & (~Val2[31]) & ~Alu_Res[31] ) || (~Val1[31] & Val2[31] & Alu_Res[31]);
            Status_Bits[3] = Alu_Res[31];
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
        end
        4'b0110: 
        begin
            Alu_Res = Val1 & Val2;
            Status_Bits[3] = Alu_Res[31];
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
            Status_Bits[1:0] = 2'b00;
        end
        4'b0111: 
        begin
            Alu_Res = Val1 | Val2;
            Status_Bits[3] = Alu_Res[31];
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
            Status_Bits[1:0] = 2'b00;
        end
        4'b1000: 
        begin
            Alu_Res = Val1 ^ Val2;
            Status_Bits[3] = Alu_Res[31];
            Status_Bits[2] = |Alu_Res ? 1'b0 : 1'b1;
            Status_Bits[1:0] = 2'b00;
        end
        default:;//{Alu_Res, Status_Bits} = 36'b0000_0000_0000_0000_0000_0000_0000_0000_0000;
        endcase
    end

endmodule
	
