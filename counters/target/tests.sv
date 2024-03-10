module hello_BreakingTest (
    input logic         clk ,
    input logic [8-1:0] data
);
    logic signed [16-1:0] inner;
    always_ff @ (posedge clk) begin
        // inner = $singed(data);
        // inner = {data[7] repeat 8, data[msb:0]};
        inner <= {{8{data[7]}}, data[7:0]};
    end
endmodule
