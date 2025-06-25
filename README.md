# Simulador de Processador Virtual

Este repositório contém um simulador de processador virtual completo, desenvolvido em HTML/CSS/JavaScript. Ele permite
carregar programas escritos em um conjunto de instruções customizado, suporta definição de labels e execução passo a
passo ou automática, além de exibir registradores, flags, memória e I/O.

---

## Índice

- [Visão Geral](#visão-geral)
- [Instruções Suportadas](#instruções-suportadas)
- [Formato de Programa](#formato-de-programa)
- [Licença](#licença)

---

## Visão Geral

O **Simulador de Processador Virtual** simula um processador de 8 bits com registradores, flags, memória e operações de
I/O. O usuário pode:

- Definir labels para saltos relativos.
- Carregar um arquivo de programa (.txt, .asm ou .md) contendo instruções e labels.
- Visualizar o programa em hexadecimal e como mnemonics.
- Acompanhar a execução em tempo real (modo passo a passo) ou executar até o fim.
- Monitorar registradores (R0–R3, PC, SP), flags de zero (Z) e carry (C).
- Inspecionar a memória de 256 bytes.
- Inserir texto de entrada e coletar saída em ASCII.

---

## Instruções Suportadas

| Mnemonic     | Opcode | Operandos       | Descrição                                                    |
|--------------|--------|-----------------|--------------------------------------------------------------|
| NADA         | 0x00   | —               | Halta o processador                                          |
| CAR\_IMD     | 0x01   | REG, Imm(0–255) | Carrega valor imediato em registrador                        |
| COPIA        | 0x02   | Dest, Orig      | Copia registrador Orig para Dest                             |
| LE\_MEM      | 0x03   | Dest, Addr      | Lê da memória no endereço Addr para Dest                     |
| ES\_MEM      | 0x04   | Orig, Addr      | Escreve Orig na memória no endereço Addr                     |
| SOMA         | 0x05   | Dest, Orig      | Soma Orig em Dest (atualiza Z e C)                           |
| SUBTRAI      | 0x06   | Dest, Orig      | Subtrai Orig de Dest (atualiza Z e C)                        |
| MULTIPLICA   | 0x07   | Dest, Orig      | Multiplica Dest por Orig (Z e C)                             |
| DIVIDE       | 0x08   | Dest, Orig      | Divide Dest por Orig (Z)                                     |
| E\_BIT       | 0x09   | Dest, Orig      | AND bitwise (Z)                                              |
| OU\_BIT      | 0x0A   | Dest, Orig      | OR bitwise (Z)                                               |
| NAO\_BIT     | 0x0B   | Dest            | NOT bitwise em Dest (Z)                                      |
| SALTA        | 0x0C   | Addr            | Salto incondicional                                          |
| SALTA\_Z     | 0x0D   | —, Addr         | Salta se Z = 1                                               |
| SALTA\_NZ    | 0x0E   | —, Addr         | Salta se Z = 0                                               |
| ENTRADA      | 0x0F   | Dest            | Lê um byte ASCII da entrada para Dest                        |
| SAIDA        | 0x10   | Orig            | Escreve byte de Orig no output ASCII                         |
| INC          | 0x11   | Dest            | Incrementa Dest (Z e C)                                      |
| DEC          | 0x12   | Dest            | Decrementa Dest (Z e C)                                      |
| MAIOR        | 0x13   | Dest, R1, R2    | Dest := max(R1, R2) (Z se zero)                              |
| ZERA         | 0x14   | Dest            | Dest := 0 (Z=1)                                              |
| LE\_INDIRETO | 0x15   | Dest, Raddr     | Dest := Mem[ Raddr ]                                         |
| ES\_INDIRETO | 0x16   | Orig, Raddr     | Mem[ Raddr ] := Orig                                         |

---

## Formato de Programa

- **Labels**: quaisquer tokens terminados em dois-pontos `:` são considerados labels. Ex.: `LOOP:`.
- **Tokens**: separados por espaços.
- **Comentários**: após `;`, o texto é ignorado.
- **Operandos**: registradores `R0`–`R3`, valores imediatos `0–255` ou nomes de labels.

---

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

