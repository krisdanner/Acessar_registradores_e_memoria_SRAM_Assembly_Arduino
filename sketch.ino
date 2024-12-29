/*
##===========================================##
|| Programando em Assembly no Arduino UNO R3 ||
##===========================================||
|| Autor: Christian Danner Ramos de Carvalho ||
|| Universidade Federal do Maranhão - UFMA   ||
|| Data: 28/12/2024                          ||
##===========================================##
*/

#include "asmfunc.h"

// Declara as variáveis globais usadas no Assembly
extern uint8_t num1_output;
extern uint8_t num2_output;
extern uint8_t result_output;

void setup() 
{
  Serial.begin(9600); // Inicializa a comunicação serial
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);

  asmfunc();

  // Exibe o resultado no Serial Monitor 
  Serial.print("Valor 1: ");
  Serial.println(num1_output);
  Serial.print("Valor 2: ");
  Serial.println(num2_output);
  Serial.print("Resultado da soma: ");
  Serial.println(result_output);
}

void loop() 
{

}