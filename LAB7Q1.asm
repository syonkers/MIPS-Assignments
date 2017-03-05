	
	
	.data
	
	.text
		li $a0, 1
		li $a1, 2
		jal pos
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
	
	pos:
		sw $ra 0($sp)
		jal addit
		lw $ra, 0($sp)
		bgtz $v0, GTZ
		li $v0, 0
		jr $ra
		
	GTZ:
		li $v0, 1
		jr $ra
		
	addit:
		add $v0, $a0, $a1
		jr $ra