		addi $s0 $zero 20 # s0 = i
sum_loop:
		#$s1 <- $s0 * $s0, s2 = contador
		addi $s1 $zero 0
		addi $s2 $zero 0
mult_loop:	add $s1 $s1 $s0
		addi $s2 $s2 1
		bne $s2 $s0 mult_loop
		
		add $s3 $s3 $s1
		addi $s0 $s0 -1
		bne $s0 $zero sum_loop