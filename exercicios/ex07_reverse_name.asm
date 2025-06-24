; Ex07 - Solicitar um nome e imprimir ao contrário
START:
  CAR_IMD R2,0        ; initialize buffer index
INPUT_LOOP:
  ENTRADA R0          ; read char (ASCII)
  CAR_IMD R1,0        ; load zero for comparison
  SUBTRAI R0,R1       ; set Z if input is zero (end signal)
  SALTA_Z PRINT_LOOP  ; if zero, proceed to printing
  ES_INDIRETO R0,R2   ; store char into RAM at address in R2
  INC R2              ; increment index
  SALTA INPUT_LOOP
PRINT_LOOP:
  DEC R2              ; decrement index to last valid char
  LE_INDIRETO R0,R2   ; load char from RAM at address in R2
  CAR_IMD R1,0        ; prepare zero
  SUBTRAI R0,R1       ; check for zero sentinel
  SALTA_Z END         ; if zero, end printing
  SAIDA R0            ; output char
  SALTA PRINT_LOOP
END:
  NADA                ; halt processor
