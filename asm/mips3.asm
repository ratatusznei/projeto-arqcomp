		addi $s0 $zero 30
start:		addi $s5 $s5 23
		addi $s0 $s0 -1
		bne $s0 $zero start
