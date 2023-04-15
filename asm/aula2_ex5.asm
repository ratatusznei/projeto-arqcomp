.eqv MEM_START 0x10011234
.eqv WORD_CNT 1000

		li $s0 WORD_CNT
		mul $s0 $s0 4
		li $s1 1000
loop_start:
		addi $s0 $s0 -4
		sw $s1 MEM_START($s0)
		addi $s1 $s1 -1
		bne $s0 0 loop_start