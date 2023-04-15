.eqv FROM_MEM 0x10010100
.eqv TO_MEM 0x10011100
.eqv WORD_CNT 401

		li $s0 WORD_CNT
		addi $s0 $s0 WORD_CNT
		add $s0 $s0 $s0
		li $s1 FROM_MEM
		li $s2 TO_MEM

loop_start:	
		addi $s0 $s0 -4
		lw $s3 FROM_MEM($s0)
		sw $s3 TO_MEM($s0)
		bne $s0 0 loop_start

.data
.space 0xff
.word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
.word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
.word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
.word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
.word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
.word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
