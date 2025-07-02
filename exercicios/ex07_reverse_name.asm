; Ex07 - Solicitar um nome e imprimir ao contrário
START:
  CAR_IMD R2,0        ; Carrega 0 em R2 para inicializar índice do buffer
INPUT_LOOP:
  ENTRADA R0          ; Lê caractere ASCII do usuário em R0
  CAR_IMD R1,0        ; Carrega 0 em R1 para comparação de sentinela
  SUBTRAI R0,R1       ; Subtrai R1 de R0: Z=1 se R0==0 (fim da string)
  SALTA_Z PRINT_LOOP  ; Se fim da string, inicia impressão reversa
  ES_INDIRETO R0,R2   ; Armazena o caractere em memória no endereço R2
  INC R2              ; Incrementa índice do buffer
  SALTA INPUT_LOOP    ; Continua lendo caracteres
PRINT_LOOP:
  DEC R2              ; Decrementa índice para último caractere válido
  LE_INDIRETO R0,R2   ; Carrega caractere de memória do endereço R2
  CAR_IMD R1,0        ; Carrega 0 em R1 para comparação
  SUBTRAI R0,R1       ; Subtrai R1 de R0: Z=1 se caractere é zero
  SALTA_Z END         ; Se sentinela, termina impressão
  SAIDA R0            ; Exibe caractere na saída
  SALTA PRINT_LOOP    ; Continua imprimindo em ordem reversa
END:
  NADA                ; Finaliza a execução do programa
