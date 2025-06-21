; Ex07 - Solicitar um nome e imprimir ao contrário
START:
  ZERA R2            ; contador de caracteres
READ_CHAR:
  ENTRADA R0         ; lê caracter ASCII em R0
  ZERA R3
  SUBTRAI R0,R3      ; set Z if char == 0
  SALTA_Z REVERSE    ; se zero (fim da entrada), vai inverter
  ES_INDIRETO R0,R2  ; armazena em memória
  INC R2             ; contador++
  SALTA READ_CHAR

REVERSE:
  COPIA R1,R2        ; R1 = contador
REV_LOOP:
  DEC R1             ; R1--
  LE_INDIRETO R0,R1  ; lê mem[R1]
  SAIDA R0           ; imprime caracter
  SALTA_NZ REV_LOOP  ; repete até R1==0 processado
NADA                   ; fim do programa
