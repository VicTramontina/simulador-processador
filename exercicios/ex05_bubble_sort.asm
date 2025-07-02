; Ex05 - Solicitar números até input vazio e imprimir em ordem crescente (bubble sort)
START:
  ZERA R3            ; Zera R3: índice de elementos lidos
READ_LOOP:
  ENTRADA R0         ; Lê caracter ASCII; retorna 0 se input vazio
  CAR_IMD R1,0       ; Carrega 0 em R1 para verificação de sentinela
  SUBTRAI R0,R1      ; Subtrai para identificar fim da leitura
  SALTA_Z POST_READ  ; Se zero, fim da leitura
  CAR_IMD R1,48      ; Carrega '0' ASCII para conversão
  SUBTRAI R0,R1      ; Converte ASCII para valor numérico
  ES_INDIRETO R0,R3  ; Armazena valor em RAM no endereço R3
  INC R3             ; Incrementa índice R3
  SALTA READ_LOOP    ; Continua leitura

POST_READ:
  DEC R3             ; Bound = total lido - 1
  SALTA_Z PRINT      ; Se 0 ou 1 elementos, vai direto para impressão

OUTER:
  ZERA R2            ; Zera R2: índice interno j
INNER:
  COPIA R1,R2        ; R1 = j
  SUBTRAI R1,R3      ; Verifica se j == bound
  SALTA_Z END_INNER  ; Se sim, fim do inner loop
  LE_INDIRETO R1,R2  ; R1 = A = RAM[j]
  COPIA R0,R2        ; R0 = j
  INC R0             ; R0 = j + 1
  LE_INDIRETO R0,R0  ; R0 = B = RAM[j+1]
  SUBTRAI R1,R0      ; R1 = A - B
  SALTA_C SKIP_SWAP  ; Se A < B, pula troca
  ; Realiza swap de A e B
  LE_INDIRETO R1,R2  ; Recarrega A em R1
  ES_INDIRETO R0,R2  ; RAM[j] = B
  COPIA R0,R2        ; R0 = j
  INC R0             ; R0 = j + 1
  ES_INDIRETO R1,R0  ; RAM[j+1] = A
SKIP_SWAP:
  INC R2             ; j++
  SALTA INNER        ; Próxima iteração interna
END_INNER:
  DEC R3             ; Decrementa bound para próxima passagem
  SALTA_NZ OUTER     ; Se ainda há passes, repete

PRINT:
  ZERA R0            ; Zera R0: índice para impressão
PRINT_LOOP:
  LE_INDIRETO R1,R0  ; R1 = RAM[i]
  CAR_IMD R2,0       ; Carrega 0 para verificar sentinela
  SUBTRAI R1,R2      ; Identifica fim do vetor
  SALTA_Z END        ; Se zero, fim da impressão
  CAR_IMD R2,48      ; Carrega '0' ASCII para conversão
  SOMA R1,R2         ; Converte valor para ASCII
  SAIDA R1           ; Exibe caractere
  INC R0             ; i++
  SALTA PRINT_LOOP   ; Continua impressão
END:
  NADA               ; Finaliza o programa