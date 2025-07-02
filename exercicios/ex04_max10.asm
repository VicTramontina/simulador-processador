; Ex04 - Solicitar dez números e imprimir o maior na tela
START:
  ZERA R2            ; Armazena o maior valor (inicia em 0)
  CAR_IMD R1,10      ; Contador de entradas
LOOP_READ:
  ENTRADA R0         ; Lê um número em ASCII
  CAR_IMD R3,48      ; '0' para conversão
  SUBTRAI R0,R3      ; Converte para valor numérico
  COPIA R3,R2        ; R3 = maior atual
  SUBTRAI R3,R0      ; Compara maior atual com novo valor
  SALTA_C UPDATE_MAX ; Se R2 < R0, atualiza maior
  SALTA AFTER_UPDATE ; Caso contrário, segue
UPDATE_MAX:
  COPIA R2,R0        ; R2 recebe o novo maior
AFTER_UPDATE:
  DEC R1             ; Decrementa o contador
  SALTA_NZ LOOP_READ ; Continua até ler 10 números
  CAR_IMD R3,48      ; Reconversão para ASCII
  SOMA R2,R3         ; Converte maior para ASCII
  SAIDA R2           ; Exibe o maior número
  NADA               ; Finaliza o programa
