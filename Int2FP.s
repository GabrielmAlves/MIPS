.data
entradaNumeroInteiro: .asciiz "Digite um número inteiro sem sinal: "
saidaNumeroConvertido: .asciiz "Número convertido em ponto flutuante: "

.text
.globl main

main:
    li $v0, 4              
    la $a0, entradaNumeroInteiro
    syscall
    li $v0, 5             
    syscall
    move $t0, $v0 
	
    andi $t1, $t0, 0xFF   # $t1 vai ficar com os 8 bits menos significativos, que é a parte fracionária do número
    srl $t2, $t0, 8       # desloca 8 bits para a direita, aí os 24 bits (da parte mais significativa) vão ficar isolados

    
    mtc1 $t2, $f0         
    cvt.s.w $f0, $f0      # converte a parte inteira de inteiro para ponto flutuante
    mtc1 $t1, $f1         # mtc1 vai mover para um registrador de ponto flutuante
    cvt.s.w $f1, $f1      # converte a parte fracionária de inteiro para ponto flutuante
	
    li.s $f2, 256.0       
    div.s $f1, $f1, $f2   # divide a parte fracionária por 256 pra obter o valor disso em decimal 
    add.s $f0, $f0, $f1   

    li $v0, 4              
    la $a0, saidaNumeroConvertido
    syscall

    li $v0, 2              
    mov.s $f12, $f0        
    syscall
    li $v0, 10             
    syscall
