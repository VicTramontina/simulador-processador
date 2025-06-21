**Desenvolvimento de um Processador Virtual**

O projeto é criar um simulador de um processador virtual no qual os grupos definirão os comandos/OPCODES. Para isso poderá ser utilizado qualquer linguagem de programação, inclusive web. Deve existir um botão para executar o programa e outro passo a passo. Todos os dados do processador devem ser apresentados na tela, assim como entrada, saída e memória.

O que deverá ser entregue: 

1. uma tabela informando o OPCODE, sua função, quais parâmetros recebe e quais registradores são afetados;  
2. os programas escritos em mnômico e em linguagem de máquina (o que vai para a ROM);  
3. código do simulador;  
4. Apresentar funcionando.

	

O processador possui 4 registradores de uso geral, tudo passa por eles, nunca um dispositivo pode acessar um dado de outro dispositivo, sempre deve passar por registradores. A “ideia” é produzir um chip que ocupasse a menor quantidade possível de portas lógicas se fosse comercialmente vendido.

 Programas obrigatórios a serem executados (mínimo):

1) Solicitar um número e imprimir na tela;  
2) Solicitar um número e imprimir o dobro na tela;  
3) Solicitar três números e imprimir o maior na tela;  
4) Solicitar dez números e imprimir o maior na tela;  
5) Solicitar números até o usuário digitar o número 0, imprimir os valores em ordem crescente (bubble sort);  
6) Solicitar um número e imprimir o seu fatorial;  
7) Solicitar um nome e imprimir ao contrário.

Requisitos: 

* somente 4 operações básicas,   
* operadores booleanos;  
* laços de repetição;  
* condições;  
* entrada de um caracter por vez;  
* saída de um caracter por vez;  
* sempre os dados devem passar pelos registradores (somente 4\) de uso geral;  
* registrador especial PC (Program Counter), que sempre aponta para a próxima instrução;  
* registrador especial SP (Stack Pointer), para usar em chamadas de subrotinas.  
* podem ser criadas até 8 flags (negativo, overflow, underflow….).

