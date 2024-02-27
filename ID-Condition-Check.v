module Condition_Check 
(
    input [3:0] Cond, SR,
    
    output reg Check
);

       always@(*) 
       begin 
        case (Cond)
            4'b0000: Check =  SR[2];
            4'b0001: Check = ~SR[2];
            4'b0010: Check =  SR[1];
            4'b0011: Check = ~SR[1];
            4'b0100: Check =  SR[3];
            4'b0101: Check = ~SR[3];
            4'b0110: Check =  SR[0];
            4'b0111: Check = ~SR[0];
            4'b1000: Check = (SR[1] & ~SR[2]);
            4'b1001: Check = (~SR[1] | SR[2]);
            4'b1010: Check = (SR[3] & SR[0]) | (~SR[3] & ~SR[0]);
            4'b1011: Check = (SR[3] ^ SR[0]);
            4'b1100: Check = (~SR[2]) & ((SR[3] & SR[0]) | (~SR[3] & ~SR[0]));
            4'b1101: Check = (SR[2]) | (SR[3] ^ SR[0]);
            4'b1110: Check =  1;
            default: Check =  0;
        endcase
	end

endmodule
