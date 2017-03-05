
	.data
		List: .word 2, 4, 6, 8, 10
		Size: .word 5
	.text
		la $a0, List
		lw $a1, Size
		li $a2, 4
		jal fillArray
	
		move $a0, $v0
		li $v0, 4
		syscall
		
		li $v0, 10
		syscall
		
	fillArray:
		
		li $t0, 1	# initialize i to 1
		move $t1, $a0	# move list into $t1
		move $t2, $a1	# move size(n) into $t2
		sw $a2, ($t1)	# set elements[0] = starter
	loop:
		blt $t0, $t2, Exit	# if i < n, exit
		
		sw $t0, 0($sp)	# store i value
		sw $t1, 4($sp)	# store list
		sw $t2, 8($sp)	# store size
		
		jal termInt	# jump to termInt function
		
		lw $t0, 0($sp)	# load i value
		lw $t1, 4($sp)	# load list
		lw $t2, 8($sp)	# load size
		
		sw $v0, ($t1)	# set return value from termInt into elements[i]
		
		addi $t0, $t0, 1 # increment i by 1
		addu $t1, $t1, 4 # increment to next list index
		j loop
		
	Exit:
		move $v0, $t1
		jr $ra
		
	termInt:
		
		move $t0, $a0	# move list into $t0
		li $t1, 0	# set i to 0
		li $t2, 0	# set sum to 0
	loop2:
		bgt $t1, $a1, return	# if i is greater than size
		lw $t3, ($t0)
		add $t2, $t2, $t3	# add elements[i] to sum
		addi $t1, $t1, 1	# increment i
		addu $t0, $t0, 4	# increment list
		j loop2
		 
	return:
		move $v0, $t2	# put sum into $v0
		jr $ra		# and return