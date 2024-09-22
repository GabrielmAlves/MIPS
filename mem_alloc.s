    .data
prompt:     .asciiz "FIM!\n"

.text
.globl main

main:
    li $v0, 9
    li $a0, 400
    syscall
    move $t0, $v0

    li $t1, 0

fill_loop:
    li $t2, 2
    mul $t3, $t1, $t2
    add $t3, $t3, $t1
    sw $t3, 0($t0)
    
    addi $t0, $t0, 4
    addi $t1, $t1, 1
    li $t4, 100
    bne $t1, $t4, fill_loop

    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 10
    syscall
