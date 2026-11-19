
module controlador_contador_x (
    input wire [2:0] estado_atual,
    input wire reg_full,
    output wire limpar_contador,
    output wire habilitar_contagem
);

    // Fios internos para os sinais invertidos (NOT) e termos intermediários
    wire not_s2, not_s1, not_s0, not_reg_full;
    wire or_s1_s0;
    wire term_en_1, term_en_2;

    // 1. Inversores (Portas NOT) para os bits de estado e reg_full
    not g_not_s2 (not_s2, estado_atual[2]);
    not g_not_s1 (not_s1, estado_atual[1]);
    not g_not_s0 (not_s0, estado_atual[0]);
    not g_not_rf (not_reg_full, reg_full);

    // 2. Lógica para limpar_contador (ativo em INICIO, CALCULA_VERTICE e DES_EIXOS)
    // Expressão simplificada: ~s2 & (~s1 | ~s0)
    or  g_or_negativos (or_s1_s0, not_s1, not_s0);
    and g_and_limpar   (limpar_contador, not_s2, or_s1_s0);

    // 3. Lógica para habilitar_contagem (ativo apenas em CALCULA_PONTOS e reg_full == 0)
    // Expressão: ~s2 & s1 & s0 & ~reg_full
    and g_and_en1 (term_en_1, not_s2, estado_atual[1]);
    and g_and_en2 (term_en_2, estado_atual[0], not_reg_full);
    and g_and_en3 (habilitar_contagem, term_en_1, term_en_2);

endmodule