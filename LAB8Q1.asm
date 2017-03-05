##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 8, Question 1          ###
###         TwoByFour Program          ###
###        Due: November 03, 2014       ###
########################################## 
#	Description: Prompt for an integer, call function to multiply the integer by 2
# 		     and add 4, then return result
#
#	$a0: store the integer
	.data
		Prompt: .asciiz "Enter an Integer: "
	.text
		la $a0, Prompt	# prompt user for integer
		li $v0, 4
		syscall
		li $v0, 5	# read int
		syscall
		
		move $a0, $v0	# move int into first argument
		jal TwoByFour	# call TwoByFour function
		move $a0, $v0	# move result from function into $a0
		li $v0, 1	
		syscall		# print result
		
		li $v0, 10	# exit
		syscall
##########################################
###          TwoByFour Function        ###
########################################## 
#	Description: Takes an integer argument, and passes the address of the integer into the TimesTwo function
#			and then adds 4 to the result
#	$t0: pointer to the integer
#	$a0: store the integer argument		
	TwoByFour:
		move $t0, $a0	# move integer into $t0
		subu $sp, $sp, 8 # create space on stack
		sw $ra, 0($sp)	# store return address
		sw $t0, 4($sp)	# store the integer onto stack
		la $a0, 4($sp)	# load address of the integer into $a0
		jal TimesTwo	# call TimesTwo function
		lw $ra, 0($sp)	# load return address
		addi $v0, $v0, 4 # add 4 to result of TimesTwo function
		jr $ra		# return
		
##########################################
###          TimesTwo Function        ###
########################################## 
#	Description: Takes an address argument, multiplies the value at the address by two and returns the value
#	$t0: the integer held in address of argument $a0	
		
	TimesTwo:
		lw $t0, 4($sp)	# load the value at pointer into $t0
		sll $t0, $t0, 1	# multiply first argument by 2
		move $v0, $t0	# move to return
		jr $ra		# return
