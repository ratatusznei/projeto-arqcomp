		li $s1 0
		li $s2 31
		
		li $s7 32
		
		slt $s0 $s1 $zero
		bne $s0 $zero s1_n_negativo

		# s1 negativo
		li $s3 1
		slt $s0 $s7 $s2
		bne $s0 $zero fim
		
		li $s3 2
		beq $s7 $s2 fim
		
		li $s3 3
		b fim

s1_n_negativo:	li $s3 4
		slt $s0 $s7 $s2
		bne $s0 $zero fim
		
		li $s3 5
		beq $s7 $s2 fim
		
		li $s3 6
						
fim: