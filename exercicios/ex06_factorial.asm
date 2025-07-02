; Ex06 - Solicitar um número e imprimir o seu fatorial
START:
  ENTRADA R0           ; Lê número ASCII do usuário para R0
  CAR_IMD R1,48        ; Carrega ASCII '0' em R1 para conversão
  SUBTRAI R0,R1        ; Converte ASCII para valor numérico

  ; Inicializar resultado do fatorial em R2
  CAR_IMD R2,1         ; R2 = 1 (resultado inicial)

  ; Caso especial: fatorial de 0 = 1
  COPIA R3,R0          ; Copia n para R3
  SALTA_Z PRINT_RESULT ; Se n == 0, pula para impressão do resultado

FACT_LOOP:
  MULTIPLICA R2,R0     ; R2 = R2 * n
  DEC R0               ; n = n - 1
  SALTA_Z PRINT_RESULT ; Se n == 0, fim do loop
  SALTA FACT_LOOP      ; Continua calculando

PRINT_RESULT:
  ; R2 contém o valor do fatorial

  ; Verificar e imprimir centena (>=100)
  CAR_IMD R3,100       ; Carrega 100 em R3
  COPIA R1,R2          ; Copia resultado para R1
  SUBTRAI R1,R3        ; R1 = R2 - 100
  SALTA_C SKIP_HUNDRED ; Se R2 < 100, pula centenas
  COPIA R1,R2          ; R1 = R2
  DIVIDE R1,R3         ; R1 = dígito da centena
  CAR_IMD R3,48        ; '0' ASCII
  SOMA R1,R3           ; Converte para ASCII
  SAIDA R1             ; Imprime dígito da centena
  ; Atualiza resto
  CAR_IMD R3,100
  MULTIPLICA R1,R3     ; R1 = centena * 100
  COPIA R1,R2
  SUBTRAI R2,R1        ; R2 = resto após remover centenas
SKIP_HUNDRED:

  ; Verificar e imprimir dezena (>=10)
  CAR_IMD R3,10        ; Carrega 10 em R3
  COPIA R1,R2
  SUBTRAI R1,R3        ; R1 = R2 - 10
  SALTA_C SKIP_TEN     ; Se R2 < 10, pula dezenas
  COPIA R1,R2          ; R1 = R2
  DIVIDE R1,R3         ; R1 = dígito da dezena
  CAR_IMD R3,48        ; '0' ASCII
  SOMA R1,R3           ; Converte para ASCII
  SAIDA R1             ; Imprime dígito da dezena
  ; Atualiza resto
  CAR_IMD R3,10
  MULTIPLICA R1,R3     ; R1 = dezena * 10
  COPIA R1,R2
  SUBTRAI R2,R1        ; R2 = resto após remover dezenas
SKIP_TEN:

  ; Imprimir unidade
  CAR_IMD R3,48        ; '0' ASCII
  COPIA R1,R2          ; R1 = resto (0-9)
  SOMA R1,R3           ; Converte para ASCII
  SAIDA R1             ; Imprime dígito da unidade

PROGRAM_END:
  NADA                 ; Finaliza o programa
