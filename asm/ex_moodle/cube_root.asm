		li $s0, 0
		li $s1, 100
		
		li $v0, 51 # read int
		la $a0, prompt_msg 
		syscall
		move $s2, $a0 # ENTRADA N, RETORN cubr(N)

incrementa:	move $a0, $s0
		jal cube
		addi $s0, $s0, 1
		addi $s1, $s1, -1
		ble $v0, $s2, incrementa
		
		addi $s0, $s0, -2
		
		# print
		li $v0 56
		la $a0, result_msg
		move $a1, $s0
		syscall
		
		
fim:		b fim


cube:		move $v0, $a0
		mul $v0, $v0, $a0
		mul $v0, $v0, $a0
		jr $ra

.data
prompt_msg: .asciiz "Digite n^3"
result_msg: .asciiz "Resultado n: "