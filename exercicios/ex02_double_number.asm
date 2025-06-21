; Ex02 - Solicitar um número e imprimir o dobro na tela
START:
  ENTRADA R0         ; lê caracter ASCII em R0
  CAR_IMD R1,48      ; ASCII '0'
  SUBTRAI R0,R1      ; converte para valor (0-9)
  COPIA R2,R0        ; R2 = valor
  SOMA R0,R2         ; R0 = valor * 2
  CAR_IMD R1,48      ; ASCII '0'
  SOMA R0,R1         ; converte de volta para ASCII
  SAIDA R0           ; imprime dobro
  NADA               ; fim

