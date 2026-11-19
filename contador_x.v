
module contador_x (
    input wire clk,
    input wire reset,
    input wire clear,     // Zera o contador ao iniciar o processo de cálculo
    input wire en,        // Habilita o incremento (quando o ponto atual foi processado)
    output reg [9:0] x,   // Valor da coluna atual (de 0 a 639)
    output wire fim_x     // Fica em nível alto quando x atingir o limite de 639
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            x <= 10'd0;
        end else if (clear) begin
            x <= 10'd0;
        end else if (en) begin
            if (x < 10'd639) begin
                x <= x + 10'd1;
            end else begin
                x <= 10'd639; // Mantém no limite máximo se habilitado além do fim
            end
        end
    end

    // Sinaliza para a FSM que todos os 640 pixels visíveis foram percorridos
    assign fim_x = (x == 10'd639);

endmodule