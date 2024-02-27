module Status_Reg 
(
    input clk, rst, S,
    input [3:0] Status_Bits_In,

    output reg [3:0] Status_Bits_Out
);

    always @(negedge clk, posedge rst) 
    begin
        if (rst) 
        begin
            Status_Bits_Out = 4'b0000;
	    end
        else if (~S) 
        begin
            Status_Bits_Out = Status_Bits_Out;            
        end
        else
        begin
            Status_Bits_Out = Status_Bits_In;
        end
    end
    
endmodule
