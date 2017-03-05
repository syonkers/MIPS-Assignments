##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 8, Question 3          ###
###        Greatest Common Divisor     ###
###        Due: November 03, 2014      ###
########################################## 
#	Description: Prompt for two intgers and call the function GCD and print out the result
#
#	$t0: temporarly hold the base number
#   	$a1: holds the second integer
#	$a0: holds the first integer
#	$v0: result from GCD

	.data
		Prompt1: .asciiz "Please enter an integer: "
		Prompt2: .asciiz "Please enter a second integer: "
		
	.text
		la $a0, Prompt1	# prompt for first integer
		li $v0, 4
		syscall
		li $v0, 5	# read 
		syscall
		
		move $t0, $v0
		
		la $a0, Prompt2
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		
		move $a1, $v0
		move $a0, $t0
		
		jal GCD
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
		
	GCD:
		div $a0, $a1
		mfhi $t0
		beqz $t0, Exit
		move $a0, $a1
		move $a1, $t0
		subu $sp, $sp, 4
		sw $ra 0($sp)
		jal GCD
		lw $ra, 0($sp)
		addu $sp, $sp, 4
		jr $ra
		
	Exit:
		move $v0, $a1
		jr $ra
