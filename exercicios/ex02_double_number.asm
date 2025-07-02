; Ex02 - Solicitar um número e imprimir o dobro na tela
START:
  ENTRADA R0         ; Lê um caracter ASCII (dígito de 0 a 9) em R0
  CAR_IMD R1,48      ; Carrega ASCII '0' em R1 para conversão
  SUBTRAI R0,R1      ; Converte ASCII para valor numérico (0-9)
  COPIA R2,R0        ; Armazena o valor original em R2
  SOMA R0,R2         ; Calcula dobro: R0 = valor + valor
  CAR_IMD R1,48      ; Carrega ASCII '0' em R1 para reconversão
  SOMA R0,R1         ; Converte o resultado de volta para ASCII
  SAIDA R0           ; Imprime o caracter resultante (ASCII)
  NADA               ; Finaliza o programa
