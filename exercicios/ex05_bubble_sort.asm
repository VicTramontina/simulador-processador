; Ex05 - Solicitar números até o usuário enviar um input vazio, imprimir em ordem crescente (bubble sort)
START:
  ZERA R3            ; R3 = index
READ_LOOP:
  ENTRADA R0         ; lê caractere ASCII
  CAR_IMD R1,48      ; '0' ASCII
  SUBTRAI R0,R1      ; converte para valor
  ES_INDIRETO R0,R3  ; armazena em RAM[R3]
  INC R3             ; R3++
  CAR_IMD R1,0       ; 0
  SUBTRAI R0,R1      ; Z se valor==0
  SALTA_NZ READ_LOOP ; repetir até 0

  DEC R3             ; R3 = count
  DEC R3             ; R3 = bound (count-1)
  SALTA_Z PRINT      ; se só 1 elemento, pular sort

OUTER:
  ZERA R0            ; R0 = index i
INNER:
  COPIA R1,R0        ; R1 = i
  SUBTRAI R1,R3      ; se i == bound, fim inner
  SALTA_Z END_INNER
  LE_INDIRETO R1,R0  ; R1 = mem[i]
  CAR_IMD R2,1       ; constante 1
  SOMA R0,R2         ; R0 = i+1
  LE_INDIRETO R2,R0  ; R2 = mem[i+1]
  SUBTRAI R1,R2      ; comparar R1-R2
  SALTA_C SKIP_SWAP  ; se R1<R2, pular swap
    ES_INDIRETO R1,R0 ; mem[i+1] = R1
    DEC R0            ; R0 = i
    ES_INDIRETO R2,R0 ; mem[i] = R2
    INC R0            ; restaurar R0 = i+1
SKIP_SWAP:
  SALTA INNER
END_INNER:
  DEC R3             ; R3-- outer bound
  SALTA_NZ OUTER

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
