module Hazard_Unit
(
    input WB_En_EXE, WB_En_MEM, Two_Src,
    input [3:0] Src1, Src2, Dest_EXE, Dest_MEM,
  
    output reg Hazard
);

    always @(*) 
    begin
        if(WB_En_EXE == 1'b1 & Dest_EXE == Src1) 
        begin
            Hazard = 1'b1;
        end
        else if(WB_En_MEM == 1'b1 & Dest_MEM == Src1)
        begin
            Hazard = 1'b1;
        end
        else if(Two_Src == 1'b1 & WB_En_EXE == 1'b1 & Dest_EXE == Src2)
        begin
            Hazard = 1'b1;
        end
        else if(Two_Src == 1'b1 & WB_En_MEM == 1'b1 & Dest_MEM == Src2)
        begin
            Hazard = 1'b1;
        end
        else
        begin
            Hazard = 1'b0;
        end
    end

endmodule
