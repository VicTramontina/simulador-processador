; Ex05 - Solicitar números até o usuário digitar 0, imprimir em ordem crescente (bubble sort)
; Usa memória para armazenar valores e realiza bubble sort
START:
  ZERA R2            ; contador de elementos
READ_LOOP:
  ENTRADA R0         ; lê caracter ASCII
  CAR_IMD R1,48      ; ASCII '0'
  SUBTRAI R0,R1      ; converte para valor
  ZERA R3
  COPIA R3,R0
  SUBTRAI R3,R3      ; R3 = 0 ? flags.Z=1 quando valor 0
  SALTA_Z SORT       ; se valor=0 vai ordenar
  ES_INDIRETO R0,R2  ; armazena valor em mem[ R2 ]
  INC R2             ; contador++
  SALTA READ_LOOP

; Pseudocódigo para bubble sort:
SORT:
  ; Implementar bubble sort:
  ; R2 contém o tamanho
  ; Utilize loops aninhados para comparar e trocar elementos na memória
  ; Bloco de comparação e troca deve usar LE_INDIRETO e ES_INDIRETO
  ; Após ordenar, pular para PRINT
  NADA               ; placeholder

PRINT:
  ; Imprimir valores ordenados
  ; Use LE_INDIRETO para ler cada elemento e converter com +48, SAIDA
  NADA

