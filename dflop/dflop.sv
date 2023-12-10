module dflop(      clk,
                        reset,
                        in_1,
                        out_1
                );

        input           clk;
        input           reset;
        input           in_1;
        output          out_1;

        reg             out_1;

        // ------- Design implementation -------

        always @(posedge clk or posedge reset) 
                begin
                        if(reset)
                                out_1 <= 1'b0;
                        else
                                out_1 <= in_1;
                end

endmodule
