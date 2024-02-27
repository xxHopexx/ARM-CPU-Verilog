module Top_TB();

    reg clk = 1'b0, rst=1'b1;

    Top CUTtop(clk,rst);

    always #10 clk = ~clk;

    initial begin
#3
  //      #30 rst = 1'b1;
        #20 rst = 1'b0;

        #10100 $stop;
    end


endmodule
