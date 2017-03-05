##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 10, Question 2         ###
###        Due: November 14, 2014      ###
########################################## 
	.data
		Buffer: .space 5
	.text
		la $a0, Buffer		# load buffer
		la $a1, 5		# load size
		jal reads		# call reads function
		
		#move $a0, $v0		# print the return value
		#li $v0, 1
		#syscall
		
		la $a0, Buffer		# load the string into $a0 and print
		li $v0, 4
		syscall
		
		li $v0, 10		# exit
		syscall
		
	reads:
		li $t2, 0xA		# value of enter key
		li $t3, 0		# counter
		addi $t4, $a1, -1	# max number of characters that can be added to string
	loop:
		beq $t0, $t2, exit	# exit if enter key is pushed
		li $a3, 0xffff0000 	# I/O base-address
	kbLoop:
		lw $t1, 0($a3) 		# read kb ctrl reg
		andi $t1, $t1, 1 	# extract ready bit
		beqz $t1, kbLoop
		lw $t0, 4($a3) 		# read kb data reg
		beq $t3, $t4, loop	# stop inputting keys if the max have been stored
		sb $t0, 0($a0)		# store the character
		addi $a0, $a0, 1	# incremenet to next address space
		addi $t3, $t3, 1	# increment counter
		j loop	
	exit:
		ble $t3, $t4, ok	# if there were more characters pressed then space, go to overrun 
		li $v0, 0		# return 1
		jr $ra
	ok:
		li $v0, 1		# return 0
		jr $ra
		
