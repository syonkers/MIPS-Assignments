##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 6, Question 3          ###
###   Switch Characters to Uppercase   ###
###        Due: October 20, 2014       ###
########################################## 
#	Description: Prompt for a string, loop through all the characters in the string 
# 		     and replace all lowercase letter into thier uppercase counterpart,
#		     final print out the edited string
#
#	$t0: counter
#   	$t1: store character 'a' to check range of lowercase letters
#	$t2: store character,'z' to check range of lowercase letters
#	$t3: store loaded character
#	$a0: store the string
	
	.data
		Prompt: .asciiz "Enter String(Max 64 characters): "
		Answer: .asciiz "The String is now:\n"
		Size: .space 64
	
	.text
		li $t0, 0	# set counter to 0 
		li $t1, 'a'	# set lower boundary to lowercase a
		li $t2, 'z'	# set upper boundary to lowercase z
		jal Read	# read function
		move $a0, $v0	# move return from read into $a0 
		jal toUpper	# change string to uppercase
		move $t0, $v0	# move uppercase string to $t0
		
		la $a0, Answer	# print Answer string
		li $v0, 4
		syscall
		
		move $a0, $t0	# print uppercase string
		li $v0, 4
		syscall
			
		la $v0, 10	# exit
		syscall
	Read:
		la $a0, Prompt 	# prompt for string
		li $v0, 4
		syscall
		
		la $a0, Size	
		la $a1, 64	
		li $v0, 8	# read in string
		syscall
		move $v0, $a0	# move string into $v0 to return
		
		jr $ra		# return
		
	toUpper:
		lb $t3, 0($a0)	# load character
		beqz $t3, Exit	# check if it is end of string
		
		bge $t3, $t1, Continue	# check if letter is lower than lowercase 'z'
		addi $t0, $t0, 1	# if not, increment counter 
		addi $a0, $a0, 1	# if not, increment to next character
		j toUpper		# continue through loop
		
	Continue:
		ble $t3, $t2, Change	# check if letter is higher than lowercase 'a' = (is a lower case letter)
		addi $t0, $t0, 1	# if not, increment counter
		addi $a0, $a0, 1	# if not, increment to next character
		j toUpper		# continue through loop
		
	Change:
		subi $t3, $t3, 32	# change ascii of lowercase letter into uppercase counterpart 
		sb $t3, 0($a0)		# store uppercase in position of lowercase 
		addi $t0, $t0, 1	# increment counter
		addi $a0, $a0, 1	# increment to next character
		j toUpper		# jump back to start of loop
		
	Exit:
		sub $a0, $a0, $t0	# go back to address of start of the string
		jr $ra			# return the string
		
		