main:		li $v0, 51 # InputDialogInt
		la $a0, prompt_msg
		syscall
		
		# a0 ja tem  N
		jal fat
		
		move $a1, $v0
		li $v0, 56 # MessageDialogInt
		la $a0, result_msg
		syscall
		
		b main		

# a0 --> v0 = a0!
fat:		addi $sp, $sp, -8
		sw $a0, 4($sp)
		sw $ra, 8($sp)
		
		beq $a0, 0, base
		
		addi $a0, $a0, -1
		jal fat
		
		lw $a0, 4($sp)
		lw $ra, 8($sp)
		addi $sp, $sp, 8
		
		mul $v0, $v0, $a0
		jr $ra

base:		li $v0, 1
		lw $a0, 4($sp)
		lw $ra, 8($sp)
		addi $sp, $sp, 8
		jr $ra
	
	
	
.data
prompt_msg: .asciiz "Digite N: "
result_msg: .asciiz "N! = "