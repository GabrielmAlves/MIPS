        .data
# Matriz X (4x4)
X:      .float 2.0, 2.0, 3.0, 4.0
        .float 5.0, 6.0, 7.0, 8.0
        .float 9.0, 10.0, 11.0, 12.0
        .float 13.0, 14.0, 15.0, 16.0

# Matriz Y (4x4)
Y:      .float 16.0, 15.0, 14.0, 13.0
        .float 12.0, 11.0, 10.0, 9.0
        .float 8.0, 7.0, 6.0, 5.0
        .float 4.0, 3.0, 2.0, 1.0
		
msg1: .asciiz "====== Matriz Z======\n"

        .text
        .globl main

main:
       
        li      $a0, 64                    # 16 elementos * 4 bytes = 64 bytes
        li      $v0, 9                     # syscall para sbrk (alocação de memória)
        syscall
        move    $t0, $v0                   # Guardar o endereço base de Z em $t0

        # Realizar a multiplicação das matrizes X e Y, e armazenar o resultado em Z
        la      $t1, X                     # Carregar o endereço base de X
        la      $t2, Y                     # Carregar o endereço base de Y
        move    $t3, $t0                   # Z: Guardar o endereço base de Z

        li      $t4, 4                    
        li      $t5, 0                     # i = 0 (linha da matriz)
		li $v0, 4              
		la $a0, msg1
		syscall
mul_loop_i:
        li      $t6, 0                     # j = 0 (coluna da matriz)
mul_loop_j:
        # Inicializar Z[i][j] = 0.0
        li.s    $f0, 0.0
        swc1    $f0, 0($t3)

        li      $t7, 0                     # k = 0 (para somar os produtos das multiplicações)
mul_loop_k:
        # Carregar X[i][k] corretamente
        mul     $t8, $t5, $t4               
        add     $t8, $t8, $t7               
        sll     $t9, $t8, 2                 
        add     $t9, $t1, $t9               
        lwc1    $f1, 0($t9)                 

        # Carregar Y[k][j] corretamente
        mul     $t8, $t7, $t4               
        add     $t8, $t8, $t6               
        sll     $t9, $t8, 2                 
        add     $t9, $t2, $t9               
        lwc1    $f2, 0($t9)                 

        # Multiplicar X[i][k] * Y[k][j]
        mul.s   $f3, $f1, $f2              

        # Somar em Z[i][j]
        lwc1    $f0, 0($t3)                 
        add.s   $f0, $f0, $f3               
        swc1    $f0, 0($t3)                

        # Incrementar k e repetir o loop até k < 4
        addi    $t7, $t7, 1
        blt     $t7, $t4, mul_loop_k

        # Incrementar j e repetir o loop até j < 4
        addi    $t6, $t6, 1
        addi    $t3, $t3, 4                
        blt     $t6, $t4, mul_loop_j

        # Incrementar i e repetir o loop até i < 4
        addi    $t5, $t5, 1
        blt     $t5, $t4, mul_loop_i

        # Exibir a matriz resultante Z na tela (impressão como 4x4)
        move    $t3, $t0                   
        li      $t5, 0                    
print_loop_i:
        li      $t6, 0                    
print_loop_j:
        lwc1    $f12, 0($t3)               # Carregar Z[i][j]
        li      $v0, 2                     # syscall para impressão de ponto flutuante
        syscall

        # Imprimir espaço após o número
        li      $a0, ' '                   # Código ASCII do espaço
        li      $v0, 11                    # syscall para impressão de caractere
        syscall

        # Incrementar j e repetir o loop até j < 4
        addi    $t6, $t6, 1
        addi    $t3, $t3, 4              
        blt     $t6, $t4, print_loop_j
        li      $a0, '\n'   
        li      $v0, 11             
        syscall

        # Incrementar i e repetir o loop até i < 4
        addi    $t5, $t5, 1
        blt     $t5, $t4, print_loop_i

        # Finalizar o programa
        li      $v0, 10                    # syscall para encerrar o programa
        syscall
