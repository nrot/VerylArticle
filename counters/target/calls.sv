module hello_ModuleCall (
    input logic clk
);
    hello_ModuleB modB (
        .clk (clk)
    );
endmodule
