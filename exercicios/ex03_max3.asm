; Ex03 - Solicitar três números e imprimir o maior na tela
START:
  ENTRADA R0         ; Lê o primeiro número (ASCII) do usuário
  ENTRADA R1         ; Lê o segundo número (ASCII)
  COPIA R2,R0        ; R2 = R0 para comparar com R1
  SUBTRAI R2,R1      ; R2 = R0 - R1 (C=1 se R0 < R1)
  SALTA_C USE_R1_1   ; Se R0 < R1, usa R1 como maior
  SALTA AFTER1       ; Caso contrário, mantém R0
USE_R1_1:
  COPIA R0,R1        ; R0 = R1 (novo maior)
AFTER1:
  ENTRADA R1         ; Lê o terceiro número (ASCII)
  COPIA R2,R0        ; R2 = R0 para comparar com R1
  SUBTRAI R2,R1      ; R2 = R0 - R1
  SALTA_C USE_R1_2   ; Se R0 < R1, R1 é o maior
  SALTA AFTER2       ; Caso contrário, mantém R0
USE_R1_2:
  COPIA R0,R1        ; R0 = R1
AFTER2:
  SAIDA R0           ; Exibe o maior número
  NADA               ; Finaliza a execução do programa
