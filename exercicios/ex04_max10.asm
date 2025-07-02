; Ex04 - Solicitar dez números e imprimir o maior na tela
START:
  ZERA R2            ; Zera R2 para armazenar o maior valor inicial (0)
  CAR_IMD R1,10      ; Carrega o contador de entradas (10) em R1
LOOP_READ:
  ENTRADA R0         ; Lê um número em ASCII do usuário para R0
  CAR_IMD R3,48      ; Carrega ASCII '0' em R3 para conversão
  SUBTRAI R0,R3      ; Converte R0 de ASCII para valor numérico
  MAIOR R2,R2,R0     ; Atualiza R2 com o maior entre R2 (atual) e R0
  DEC R1             ; Decrementa o contador de entradas
  SALTA_NZ LOOP_READ ; Se ainda não leu 10, volta para ler o próximo

  ; Impressão do maior valor
  CAR_IMD R3,48      ; Carrega ASCII '0' em R3 para reconversão
  SOMA R2,R3         ; Converte R2 de valor numérico para ASCII
  SAIDA R2           ; Exibe o maior número em ASCII
  NADA               ; Finaliza o programa
