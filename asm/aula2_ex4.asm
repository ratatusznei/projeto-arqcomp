.eqv MEM_START 0x10000000
.eqv MEM_END 0x1000FFFC

		li $s0 MEM_START
		li $s2 0
loop_start:
		lw $s1 ($s0)
		add $s2 $s2 $s1
		addi $s0 $s0 4
		ble $s0 MEM_END loop_start
		
