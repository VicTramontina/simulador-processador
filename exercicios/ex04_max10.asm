; Ex04 - Solicitar dez números e imprimir o maior na tela
START:
  ZERA R2            ; R2 = current max
  CAR_IMD R1,10      ; contador = 10
LOOP_READ:
  ENTRADA R0         ; lê caractere ASCII
  CAR_IMD R3,48      ; '0'
  SUBTRAI R0,R3      ; converte para valor
  MAIOR R2,R2,R0     ; atualiza máximo
  DEC R1
  SALTA_NZ LOOP_READ ; repetir até 10
  ; imprime resultado
  CAR_IMD R3,48      ; '0'
  SOMA R2,R3         ; converte para ASCII
  SAIDA R2
  NADA

