##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 9, Question 3          ###
### 	   Round a number	       ###
###        Due: November 10, 2014      ###
########################################## 
#  Main	Description: Take in a floating point number and call the round function to round the number, 
#			then print out the number
	.data
		Prompt: .asciiz "Enter a floating point number: "
		
	.text
		li $v0, 4	# prompt and read floating point number
		la $a0, Prompt
		syscall
		li $v0, 6
		syscall
		
		mov.s $f12, $f0	# move number into argument address $f12
		jal round	# call round function
		
		move $a0, $v0	# move value returned from round function into $a0
		li $v0, 1	# print return value
		syscall
		
		li $v0, 10	# exit
		syscall
###################################################
###   Round Float Function      	  	###
### $f5 = holds the converted number as a word	###
###################################################
# Desription:Takes in a floating point number and convert it to an integer then return
		
	round:
		cvt.w.s $f5, $f12 # convert from floating point to word
		mfc1.d $v0, $f5	# move converted number into $v0
		jr $ra	# return number
