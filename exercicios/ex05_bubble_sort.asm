; Ex05 - Solicitar números até o usuário enviar um input vazio, imprimir em ordem crescente (bubble sort)
START:
  ZERA R3            ; R3 = index
READ_LOOP:
  ENTRADA R0         ; lê caractere ASCII (0 se vazio)
  CAR_IMD R1,0       ; valor zero
  SUBTRAI R0,R1      ; verifica vazio
  SALTA_Z POST_READ  ; se vazio, fim leitura
  CAR_IMD R1,48      ; '0' ASCII
  SUBTRAI R0,R1      ; converte para valor
  ES_INDIRETO R0,R3  ; armazena em RAM[R3]
  INC R3             ; R3++
  SALTA READ_LOOP    ; ler próximo

POST_READ:
  DEC R3             ; R3 = bound = count-1
  SALTA_Z PRINT      ; if <=1 element, skip sort

OUTER:
  ZERA R2            ; R2 = inner index j
INNER:
  COPIA R1,R2        ; R1 = j (index)
  SUBTRAI R1,R3      ; if j==bound, end inner
  SALTA_Z END_INNER

  LE_INDIRETO R1,R2  ; R1 = A = mem[j]
  COPIA R0,R2        ; R0 = j
  INC R0             ; R0 = j+1
  LE_INDIRETO R0,R0  ; R0 = B = mem[j+1]

  SUBTRAI R1,R0      ; R1 = A-B. B está salvo em R0.
  SALTA_C SKIP_SWAP  ; se A-B < 0 (A < B), pula troca

  ; Do swap
  LE_INDIRETO R1,R2  ; Recarrega A (mem[j]) em R1
  ES_INDIRETO R0,R2  ; mem[j] = B (de R0)
  COPIA R0,R2        ; R0 = j
  INC R0             ; R0 = j+1
  ES_INDIRETO R1,R0  ; mem[j+1] = A (de R1)

SKIP_SWAP:
  INC R2             ; move to next element
  SALTA INNER        ; continue inner loop
END_INNER:
  DEC R3             ; reduce bound
  SALTA_NZ OUTER     ; more passes?

PRINT:
  ZERA R0            ; R0 = index i
PRINT_LOOP:
  LE_INDIRETO R1,R0  ; R1 = mem[i]
  CAR_IMD R2,0       ; 0
  SUBTRAI R1,R2      ; Z se mem[i]==0
  SALTA_Z END        ; fim ao encontrar sentinel
  CAR_IMD R2,48      ; '0' ASCII
  SOMA R1,R2         ; converte para ASCII
  SAIDA R1           ; imprime
  INC R0             ; i++
  SALTA PRINT_LOOP
END:
  NADA               ; fim
