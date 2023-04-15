		li $s7 0x10010000
		li $s6 80 # 20 * 4
		li $s5 0
		
	
loop:		add $s0 $s6 $s7
		lw $s2 -4($s0)
		lw $s3 0($s0)
		
		bgt $s3 $s2 n_swap
		move $s4 $s2
		move $s2 $s3
		move $s3 $s4
n_swap:		sw $s2 -4($s0)
		sw $s3 0($s0)
		
		addi $s6 $s6 -4
		bne $s6 $s5 loop
		
		addi $s5 $s5 4
		li $s6 80 # 20 * 4
		bne $s6 $s5 loop
