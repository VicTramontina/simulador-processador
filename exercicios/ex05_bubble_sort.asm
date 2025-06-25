; Ex05 - Solicitar números até o usuário enviar um input vazio, imprimir em ordem crescente (bubble sort)
START:
  ZERA R2            ; R2 = count N = 0
READ_LOOP:
  ENTRADA R0         ; read ASCII char or 0
  CAR_IMD R1,0       ; zero sentinel
  SUBTRAI R0,R1      ; if empty input, Z=1
  SALTA_Z SORT       ; go sort on empty
  CAR_IMD R1,48      ; '0'
  SUBTRAI R0,R1      ; convert ASCII to integer
  ES_INDIRETO R0,R2  ; store value at RAM[R2]
  INC R2             ; R2++
  SALTA READ_LOOP

; R2 = N elements stored at 0..N-1
SORT:
  EMPILHA R2         ; push N for printing later
  COPIA R3,R2        ; R3 = N
  DEC R3             ; R3 = N-1 (passes count)
OUTER_LOOP:
  CAR_IMD R1,0        ; prepare zero
  SUBTRAI R3,R1       ; check passes == 0
  SALTA_Z PRINT       ; if done, go print
  ZERA R0             ; index = 0
INNER_LOOP:
  LE_INDIRETO R1,R0  ; load A[i]
  EMPILHA R1         ; save original value
  INC R0             ; index++
  LE_INDIRETO R1,R0  ; load A[i+1]
  DESEMPILHA R2      ; R2 = original A[i]
  SUBTRAI R2,R1      ; compare orig - next
  SALTA_C SKIP_SWAP  ; if orig < next, skip swap
  DEC R0             ; restore index
  ES_INDIRETO R1,R0  ; write larger (next) at A[i]
  INC R0             ; index++
  ES_INDIRETO R2,R0  ; write smaller (orig) at A[i+1]
  DEC R0             ; restore index
SKIP_SWAP:
  INC R0             ; index++
  COPIA R2,R0        ; R2 = index
  SUBTRAI R2,R3      ; compare index vs passes
  SALTA_C INNER_LOOP
  DEC R3             ; passes--
  SALTA OUTER_LOOP

PRINT:
  DESEMPILHA R2      ; pop N into R2
  ZERA R0            ; index = 0
  CAR_IMD R3,48      ; ascii offset
PRINT_LOOP:
  LE_INDIRETO R1,R0  ; load A[index]
  SOMA R1,R3         ; convert to ASCII
  SAIDA R1           ; output char
  INC R0             ; index++
  COPIA R1,R0        ; temp = index
  SUBTRAI R1,R2      ; compare temp vs N
  SALTA_NZ PRINT_LOOP; loop while index < N
END:
  NADA               ; halt
