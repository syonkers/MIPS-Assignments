##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 6, Question 2          ###
### Swap Characters From Input String  ###
###        Due: October 20, 2014       ###
########################################## 
#	Description: Prompt for a string, swap the first and second characters 
# 		     and then do the same for all the following characters and print
#		     out the edited string
#
#	$t0: counter
#   	$t1: store character, x
#	$t2: store character, x + 1
#	$a0: store the string
	
	.data
		Prompt: .asciiz "Enter String(Max 64 characters): "
		Answer: .asciiz "The String is now:\n"
		Size: .space 64
		
	.text
		li $t0, 0	# counter for how many letters are in string
		jal Read	# read function to read string
		move $a0, $v0	# move string into $a0 for swap function 
		jal Swap	# swap function, switches the letters around
		move $t0, $v0	# move result from swap into $t0
	
		la $a0, Answer	# result string
		li $v0, 4
		syscall
		
		move $a0, $t0	# print edited string
		li $v0, 4
		syscall
		
		la $v0, 10	# exit
		syscall
	
	Read:
		la $a0, Prompt 	# prompt for string input
		li $v0, 4
		syscall
		
		la $a0, Size	# create new string
		la $a1, 64
		li $v0, 8
		syscall
		move $v0, $a0	# move new string into $v0 to return
		
		jr $ra		# return to main body
	Swap:
		lb $t1, 0($a0)	# load character that address is pointing to from string into $t1 
		lb $t2, 1($a0)	# load next character into $t2
		sb $t1, 1($a0)	# swap characters
		sb $t2, 0($a0)	
		addi $a0, $a0, 2 # increment the address by two in order to get the next two characters
		addi $t0, $t0, 2 # increment counter by to
		bnez $t2, Swap	# if next character is not the end of string, loop again
		
		sub $a0, $a0, $t2 # return to the start string address
		jr $ra		# return back to main body
		