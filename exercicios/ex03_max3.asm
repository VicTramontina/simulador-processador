; Ex03 - Solicitar três números e imprimir o maior na tela
START:
  ENTRADA R0          ; Lê primeiro número (ASCII)
  ; R0 = first
  ENTRADA R1          ; Lê segundo número
  MAIOR R0,R0,R1      ; R0 = max(R0, R1)
  ENTRADA R1          ; Lê terceiro número
  MAIOR R0,R0,R1      ; R0 = max(current R0, R1)
  SAIDA R0            ; Imprime o maior
  NADA                ; Fim

