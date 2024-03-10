/// Это документация, а не комментарий. И она встроена по умолчанию
// А это комментарий к коду
/// Шагающее среднее за SIZE
module hello_StepAverage #(
    parameter  int unsigned WIDTH     = 8                   , /// Разрядность входных и выходных данных
    parameter  int unsigned SIZE      = 4                   , /// Размер окна для расчета, только степень двойки
    localparam int unsigned CNT_SIZE  = $clog2(SIZE)        , // Почти все функции SystemVerilog доступны. Об этом будет позже в недостатках
    localparam int unsigned SUMM_SIZE = $clog2(SIZE) + WIDTH
) (
    input  logic                    clk    , /// Клоки данных
    input  logic                    reset  , /// Сигнал сброса. Уровень определяется по умолчанию для проекта
    input  bit   signed [WIDTH-1:0] data   , /// Знаковые входные данные
    output logic                    sync   , /// Сигнал синхронизации среднего
    output logic signed [WIDTH-1:0] average /// Среднее за окно
);
    logic [SUMM_SIZE-1:0] summ;
    assign summ = 0;
    logic [CNT_SIZE-1:0]  cnt ;
    assign cnt = 0;

    /// Основной блок расчетов
    always_ff @ (posedge clk) begin
        if (!reset) begin // А вот тут хитро. Второй параметр always_ff должен быть reset, поэтому это условие обязательно, без него ошибка.
            summ    <= 0;
            cnt     <= 0;
            average <= 0;
            sync    <= 0;
        end else begin
            summ <= summ + (data);
            cnt  <= cnt  + (1);
            sync <=  0; // Интересно, что все присвоение внутри always_ff будет <=, об этом написано в документации. Как по мне это минус, что это нельзя контролировать, бывает нужно.
            if (cnt == SIZE) begin // Интересный момент, что для оператора меньше\больше нужно использовать "<:"\">:".
                average <= summ / SIZE;
                sync    <= 1;
                summ    <= 0;
                cnt     <= 0;
            end
        end
    end
endmodule
