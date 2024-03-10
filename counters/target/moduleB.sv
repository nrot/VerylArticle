module hello_ModuleB #(
    parameter int unsigned A = 4 ,
    parameter string       D = ""
) (
    input logic clk
);
    hello_ModuleA #(
        .A (A             ),
        .B ("строка"),
        .D (D             )
    ) instB (
        .clk (clk)
    );
endmodule
