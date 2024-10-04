        .data
array:  .word 179, 104, 247, 122, 191, 56, 59, 88, 117, 162, 44, 70, 78, 242, 202, 217  # vetor fornecido
n:      .word 16  # tamanho do vetor
newline: .asciiz "\n"
comma_space: .asciiz ", "  # Vírgula e espaço
msg1: .asciiz "Vetor original:\n"
msg2: .asciiz "Vetor ordenado:\n"

        .text
        .globl main

main:
        
        lw $t0, n              
        la $a0, array          
        move $a1, $t0          
        li $v0, 4 			   # mensagem do vetor original
        la $a0, msg1    
        syscall
        la $t0, array          # coloca o end base em $t0
        li $t1, 0              # índice que vai começar

print_array:
        lw $t2, 0($t0)         
        li $v0, 1              
        move $a0, $t2
        syscall
        addi $t0, $t0, 4       
        addi $t1, $t1, 1       
        lw $t3, n              
        bge $t1, $t3, fim_impressao_array # acaba a impressão
        li $v0, 4
        la $a0, comma_space
        syscall
        b print_array           

fim_impressao_array:
        
        li $v0, 4
        la $a0, newline
        syscall
        la $t0, array           
        lw $t1, n               

bubble_sort:
        addi $t1, $t1, -1       
        blez $t1, end_sort      
        li $t2, 0               # j = 0
inner_loop:
        lw $t3, 0($t0)          # array[j]
        lw $t4, 4($t0)          # array[j+1]
        ble $t3, $t4, no_swap   # array[j] <= array[j+1], não troca
        move $t5, $t3           # t5 = array[j]
        sw $t4, 0($t0)          # array[j] = array[j+1]
        sw $t5, 4($t0)          # array[j+1] = t5 (ou array[j])

no_swap:
        addi $t0, $t0, 4        
        addi $t2, $t2, 1        
        lw $t6, n               
        sub $t6, $t6, 1         
        blt $t2, $t6, inner_loop # j < n - 1, continua o loop interno
        la $t0, array           
        b bubble_sort           

end_sort:

        li $v0, 4
        la $a0, msg2    
        syscall
        la $t0, array           
        li $t1, 0               

print_array_ordenado:
        lw $t2, 0($t0)          
        li $v0, 1               
        move $a0, $t2
        syscall
        addi $t0, $t0, 4        
        addi $t1, $t1, 1        
        lw $t3, n               
        bge $t1, $t3, fim_impressao_array_ordenado 	# índice >= tamanho, fim da impressão
        li $v0, 4
        la $a0, comma_space
        syscall

        b print_array_ordenado     

fim_impressao_array_ordenado:

        li $v0, 4
        la $a0, newline
        syscall
        li $v0, 10              
        syscall
