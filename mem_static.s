.data
msg_prompt:     .asciiz "\nDigite o índice:"
msg_invalid:    .asciiz "Índice inválido. Encerrando o programa.\n"

vetor:          .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
vetor_size:     .word 15

.text
.globl main

main:
	li $t0, 0

loop:
	li $v0, 4
	la $a0, msg_prompt
	syscall
    li $v0, 5
    syscall
    move $t1, $v0
    la $t2, vetor_size
    lw $t2, 0($t2)
    bge $t1, $t2, end_program
    bltz $t1, end_program
    la $t3, vetor
    sll $t1, $t1, 2
    add $t3, $t3, $t1
    lw $t4, 0($t3)
    li $v0, 1
    move $a0, $t4
    syscall
    j loop
	
end_program:
    li $v0, 4
    la $a0, msg_invalid
    syscall
    li $v0, 10
    syscall