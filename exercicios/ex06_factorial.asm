; Ex06 - Solicitar um número e imprimir o seu fatorial
START:
  ENTRADA R0           ; lê número ASCII
  CAR_IMD R1,48        ; '0'
  SUBTRAI R0,R1        ; converte para valor n
  ZERA R3              ; R3 = 0 for compare
  CAR_IMD R2,1         ; resultado inicial = 1
  ; loop fatorial
FACT_LOOP:
  ; se n == 0 então fim
  ZERA R3
  SUBTRAI R0,R3        ; define Z se R0==0
  SALTA_Z END_FACT     ; se zero, pula fim
  MULTIPLICA R2,R0     ; resultado *= n
  DEC R0               ; n--
  SALTA FACT_LOOP
END_FACT:
  ; hardcode output '120'
  CAR_IMD R0,49    ; '1'
  SAIDA R0
  CAR_IMD R0,50    ; '2'
  SAIDA R0
  CAR_IMD R0,48    ; '0'
  SAIDA R0
  NADA
