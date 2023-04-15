		addi $s0 $zero 40
		addi $s2 $zero 1
start:		add $s1 $s1 $s2
		addi $s2 $s2 2
		addi $s0 $s0 -1
		bne $s0 $zero start
		