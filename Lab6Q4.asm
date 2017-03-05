##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 6, Question 4          ###
###     Remove vowels from string      ###
###        Due: October 20, 2014       ###
########################################## 
#	Description: Prompt for a string, loop through all the characters in the string 
# 		     and remove all vowels in the string and then print out the edited string
#
#	$t0: store loaded character
#   	$t1: store vowel to compare to $t0
#	$t3: store characters when shifting
#	$t6: inner counter when shifting
#	$t7: counter for string length
#	$a0: store the string	
	
	.data
		Prompt: .asciiz "Enter String(Max 64 characters): "
		Answer: .asciiz "The String is now:\n"
		Size: .space 64
		
	.text
		li $t6, 0	# set counter to 0
		li $t7, 0	# set counter to 0
		la $a0, Prompt 	# print out prompt string
		li $v0, 4
		syscall
		
		la $a0, Size	# load buffer
		la $a1, 64	# load size
		jal Read	# call Read function
		
		move $a0, $v0	# move string from function into $a0
		
		jal Remove	# remove vowels function
		
		move $t0, $v0	# move edited string into $t0
		
		la $a0, Answer	# print answer string
		li $v0, 4
		syscall
		
		move $a0, $t0	# print edited string
		li $v0, 4
		syscall
		
		la $v0, 10	# exit
		syscall
	Read:			# read function
		li $v0, 8	# read string
		syscall
		
		move $v0, $a0	# move string into $v0 to return
		
		jr $ra		# return string
		
	Remove:			# remove vowels function
		lb $t0, 0($a0)	# load character into $t0
		beqz $t0, Exit	# check if end of string
		
		li $t1, 'a'		# compare to letter 'a'
		beq $t0, $t1, Found
		
		li $t1, 'e'		# compare to letter 'e'
		beq $t0, $t1, Found
		
		li $t1, 'i'		# copare to letter 'i'
		beq $t0, $t1, Found
		
		li $t1, 'o'		# compare to letter 'o'
		beq $t0, $t1, Found
		
		li $t1, 'u'		# compare to letter 'u'
		beq $t0, $t1, Found
		
		addi $a0, $a0, 1	# if not a vowel move to next letter
		addi $t6, $t6, 1	# increment counter
		j Remove		# jump back to top
		
	Found:				# if character is a vowel
		beqz $t0, nextChar	# check if character is end of string
		lb $t3, 1($a0)		# if not, get the following character
		sb $t3, 0($a0)		# replace current character
		addi $a0, $a0, 1	# move address up 1 
		lb $t0, 0($a0)		# load new character
		addi $t7, $t7, 1	# increment counter of inner loop
		j Found			# continue till end of string
		
	nextChar:			# when out of shifting loop
		sub $a0, $a0, $t7	# return back to original vowel location
		li $t7, 0		# reset inner counter
		j Remove		# jump back to check next character
		
	Exit:
		sub $a0, $a0, $t6	# return back to start of the string
		jr $ra			# return the string
			