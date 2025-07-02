; Ex03 - Solicitar três números e imprimir o maior na tela
START:
  ENTRADA R0         ; Lê o primeiro número (ASCII) do usuário para R0
  ENTRADA R1         ; Lê o segundo número (ASCII) para R1
  MAIOR R0,R0,R1     ; R0 recebe o maior valor entre R0 e R1 (ASCII)
  ENTRADA R1         ; Lê o terceiro número (ASCII) para R1
  MAIOR R0,R0,R1     ; R0 recebe o maior valor entre R0 (atual) e R1
  SAIDA R0           ; Exibe o maior número (ASCII) armazenado em R0
  NADA               ; Finaliza a execução do programa
