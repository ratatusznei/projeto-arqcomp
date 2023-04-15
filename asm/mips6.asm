		addi $s5 $zero 8 # i
		addi $s1 $zero 1 # acc

fact_loop:	
		add $s2 $zero $s5
		
		#$s0 <- $s1 * $s2, s3 = contador
		addi $s0 $zero 0
		addi $s3 $zero 0
mult_loop:	add $s0 $s0 $s1
		addi $s3 $s3 1
		bne $s3 $s2 mult_loop
		
		add $s1 $zero $s0
		addi $s5 $s5 -1
		bne $s5 $zero fact_loop