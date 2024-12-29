/*
##===========================================##
|| Programando em Assembly no Arduino UNO R3 ||
##===========================================||
|| Autor: Christian Danner Ramos de Carvalho ||
|| Universidade Federal do Maranhão - UFMA   ||
|| Data: 28/12/2024                          ||
##===========================================##

  *** Características básicas de memória ***
###############################################
##        MEMÓRIA DE DADOS ATMEGA328P        ##
##===========================================##
##     REGISTRADORES DE PROPÓSITO GERAL      ##
##             0X0000 ... 0X001F             ##
##===========================================##
## REGISTRADORES DE ENTRADA E SAÍDA DE DADOS ##
##             0x0020 ... 0x005F             ##
##===========================================##
##  REGISTRADORES DE ESPECIAIS (PERIFÉRICOS) ##
##             0x0060 ... 0x00FF             ##
##===========================================##
##                SRAM (2 kB)                ##
##             0x0100 ... 0x08FF             ##
###############################################
*/

#include <avr/io.h>

.global asmfunc

asmfunc:
  // Configurações dos endereços
  #define NUM1_ADDR 0x0100  // Endereço 256 na SRAM para o primeiro número
  #define NUM2_ADDR 0x0101  // Endereço 257 na SRAM para o segundo número
  #define RESULT_ADDR 0x102 // Endereço 258 na SRAM para armazenar o resultado

  // Inicialização dos valores
  ldi r16, 5             // Carrega o número 5 no registrador R16
  sts NUM1_ADDR, r16      // Armazena R16 no endereço NUM1_ADDR (0x0100)

  // Passar o valor de NUM1_ADDR para uma variável global
  lds r25, NUM1_ADDR    // Carrega o resultado no registrador R25
  sts num1_output, r25  // Armazena em uma variável global

  ldi r17, 3             // Carrega o número 3 no registrador R17
  sts NUM2_ADDR, r17      // Armazena R17 no endereço NUM2_ADDR 0x0101)

  // Passar o valor de NUM2_ADDR para uma variável global
  lds r26, NUM2_ADDR    // Carrega o resultado no registrador R26
  sts num2_output, r26  // Armazena em uma variável global

  // Realizar a soma usando valores da SRAM
  lds r16, NUM1_ADDR      // Carrega o valor do endereço NUM1_ADDR para R16
  lds r17, NUM2_ADDR      // Carrega o valor do endereço NUM2_ADDR para R17
  add r16, r17            // Soma os valores em R16 e R17, resultado em R16
  sts RESULT_ADDR, r16    // Armazena o resultado no endereço RESULT_ADDR (0x102)

  // Exibir o resultado no pino 13
  lds r16, RESULT_ADDR    // Carrega o valor do endereço RESULT_ADDR para R16

  // Passar o resultado para uma variável global
  lds r24, RESULT_ADDR    // Carrega o resultado no registrador R24
  sts result_output, r24  // Armazena em uma variável global

  cpi r16, 0             // Compara R16 com zero
  breq zero_result       // Se R16 == 0, pula para o rótulo "zero_result"
  sbi (PORTB-0x20), 5           // Caso contrário, define PB5 (pino 13) como HIGH
  rjmp end               // Pula para o fim do programa

  zero_result:
  cbi (PORTB-0x20), 5            // Define PB5 (pino 13) como LOW

  end:
  ret                    // Retorno da função

  .data
  .global num1_output
  num1_output:
  .byte 1                 // Aloca um byte para armazenar o valor 1

  .global num2_output
  num2_output:
  .byte 1                 // Aloca um byte para armazenar o valor 2
  
  .global result_output
  result_output:
  .byte 1                 // Aloca um byte para armazenar o resultado

  

