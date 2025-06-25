; Ex06 - Solicitar um número e imprimir o seu fatorial
START:
  ENTRADA R0           ; lê número ASCII
  CAR_IMD R1,48        ; '0'
  SUBTRAI R0,R1        ; converte ASCII para valor numérico

  ; Inicializar resultado do fatorial
  CAR_IMD R2,1         ; resultado inicial = 1

  ; Caso especial: fatorial de 0 = 1
  COPIA R3,R0          ; copia a entrada para R3
  SALTA_Z PRINT_RESULT ; se entrada é 0, pula direto para impressão (já temos 1 em R2)

FACT_LOOP:
  MULTIPLICA R2,R0     ; resultado *= n
  DEC R0               ; n--
  SALTA_Z PRINT_RESULT ; se chegou a zero, vai para impressão
  SALTA FACT_LOOP      ; senão, continua no loop

PRINT_RESULT:
  ; Agora temos o fatorial em R2 (já calculado)

  ; Caso especial: imprimir 1 (fatorial de 0 ou 1)
  CAR_IMD R3,1
  COPIA R1,R2          ; Preserva o valor de R2
  SUBTRAI R1,R3        ; se R2 == 1, então R1 = 0
  SALTA_NZ CHECK_HUNDREDS

  ; Imprime apenas '1'
  CAR_IMD R0,49        ; '1' em ASCII
  SAIDA R0
  SALTA PROGRAM_END

CHECK_HUNDREDS:
  ; Verifica se temos centenas (>= 100)
  CAR_IMD R3,100
  COPIA R1,R2          ; Copia o valor do fatorial para R1
  SUBTRAI R1,R3        ; Subtrai 100 para verificação
  SALTA_C PRINT_TENS   ; Se menor que 100, vai para dezenas

  ; Temos centenas, imprime o dígito da centena
  CAR_IMD R3,100
  COPIA R1,R2
  DIVIDE R1,R3         ; R1 = R2/100 (dígito da centena)
  CAR_IMD R3,48
  SOMA R1,R3           ; converte para ASCII
  SAIDA R1             ; imprime dígito da centena

  ; Calcula resto após remover centenas
  COPIA R3,R1
  CAR_IMD R1,48
  SUBTRAI R3,R1        ; Recupera o valor numérico do dígito da centena
  CAR_IMD R1,100
  MULTIPLICA R3,R1     ; R3 = dígito da centena * 100
  COPIA R1,R2
  SUBTRAI R1,R3        ; R1 = valor original - centenas
  COPIA R2,R1          ; Guarda o resto em R2

PRINT_TENS:
  ; Verifica se temos dezenas (>= 10)
  CAR_IMD R3,10
  COPIA R1,R2
  SUBTRAI R1,R3
  SALTA_C PRINT_ONES   ; menor que 10, vai para unidades

  ; Temos dezenas, imprime o dígito da dezena
  CAR_IMD R3,10
  COPIA R1,R2
  DIVIDE R1,R3         ; R1 = R2/10 (dígito da dezena)
  CAR_IMD R3,48
  SOMA R1,R3           ; converte para ASCII
  SAIDA R1             ; imprime dígito da dezena

  ; Calcula resto após remover dezenas
  COPIA R3,R1
  CAR_IMD R1,48
  SUBTRAI R3,R1        ; Recupera o valor numérico do dígito da dezena
  CAR_IMD R1,10
  MULTIPLICA R3,R1     ; R3 = dígito da dezena * 10
  COPIA R1,R2
  SUBTRAI R1,R3        ; R1 = valor após centenas - dezenas
  COPIA R2,R1          ; Guarda o resto em R2

PRINT_ONES:
  ; Imprime o dígito da unidade
  CAR_IMD R3,48
  COPIA R1,R2
  SOMA R1,R3           ; converte para ASCII
  SAIDA R1             ; imprime dígito da unidade

PROGRAM_END:
  NADA                 ; finaliza o programa
