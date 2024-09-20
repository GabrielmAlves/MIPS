.text

.globl main

main:
	li 	 $t0, 15
	li 	 $t1, 36
	li 	 $t2, 12
	li 	 $t3, 19
	add  $t4, $t0, $t1
	add  $t5, $t2, $t3
	sub  $s0, $t4, $t5
	add  $v0, $zero, $s0
	jr   $ra