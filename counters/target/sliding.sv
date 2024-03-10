/// Скользящее среднее за окно
module hello_SlidingAverage #(
    parameter  int unsigned WIDTH     = 8                   , /// Разрядность входных и выходных данных
    parameter  int unsigned SIZE      = 4                   , /// Размер окна. Только степень двойки
    localparam int unsigned CNT_SIZE  = $clog2(SIZE)        ,
    localparam int unsigned SUMM_SIZE = $clog2(SIZE) + WIDTH
) (
    input  logic                    clk    ,
    input  logic                    reset  , /// Сигнал сброса
    input  bit   signed [WIDTH-1:0] data   , /// Знаковые входные данные
    output logic signed [WIDTH-1:0] average /// Среднее за окно на каждом шаге
);
    logic [WIDTH-1:0] cache [0:SIZE-1];
    assign cache = {{SIZE{0}}};

    always_ff @ (posedge clk) begin
        if (!reset) begin
            cache   <= {{SIZE{0}}};
            average <= 0;
        end else begin
            cache[((SIZE) - 1) - 1:0] <= {data, cache[((SIZE) - 1) - 1:1]};
            average          <= 0;
            for (int unsigned i = 0; i < SIZE; i++) begin
                average <= average + (cache[i]);
            end
        end
    end
endmodule
