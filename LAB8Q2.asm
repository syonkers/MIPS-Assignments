##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 8, Question 2          ###
###        Power function program      ###
###        Due: November 03, 2014      ###
########################################## 
#	Description: Prompt for two intgers and call the function Power and print out the result
#
#	$t0: temporarly hold the base number
#   	$a1: holds the integer power
#	$a0: holds the base integer
	.data
		Prompt: .asciiz "Enter a Base Integer: "
		Prompt2: .asciiz "Enter a Integer Power: "
	.text
	
		la $a0, Prompt		# read m value
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $t0, $v0
	Error:	
		la $a0, Prompt2		# read n value
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $t1, $v0
		blt $t1, $zero, Error	# check if number is less than zero, prompt if it is
		
		move $a0, $t0		# move m into first argument
		move $a1, $t1		# move n into second argument
		jal Power		# call power function
		move $a0, $v0		# move return into address to print
		li $v0, 1
		syscall			
		
		li $v0, 10		# exit
		syscall
##########################################
###           Power Function           ###
########################################## 
#	Description: Takes two integer arguments and recursivly calculates the result of $a0 to the power of $a1
#			
#	$t0: pointer to the integer
#	$a0: stores the base integer
#	$a1: store the integer power
#	$v0: stores the result of power(m, n-1) until returning to main 		
	Power:
		beqz $a1, Return	# while not equal to zero
		subu $sp, $sp, 8	# create space on stack
		sw $ra, 0($sp)		# add return to stack
		sw $a0, 4($sp)		# add m to stack
		addi $a1, $a1, -1	# reduce n by 1
		jal Power		# call power
		lw $ra, 0($sp)		# load return
		lw $a0, 4($sp)		# load m
		addu $sp, $sp, 8	# recover space on stack
		mult $a0, $v0		# multiply m * power(m, n-1)
		mflo $v0		# move to return register
		jr $ra			# return
	Return:
		li $v0, 1		# load 1 to return
		jr $ra
