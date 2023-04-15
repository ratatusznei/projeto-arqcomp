		li $t0, 0x10010000
		li $t1, 15
		li $s0, 0
		li $s1, 1
		
		sw $s0,($t0)
		addi $t0, $t0, 4
		sw $s1, ($t0)

repete: 	add $s2, $s0, $s1
		move $s0, $s1
		move $s1, $s2
		addi $t0, $t0, 4
		sw $s1, ($t0)
		addi $t1, $t1, -1
		bne $t1, 0, repete