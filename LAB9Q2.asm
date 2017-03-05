##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 9, Question 2          ###
### 	   Degrees to Radians	       ###
###        Due: November 10, 2014      ###
########################################## 
#  Main	Description: Take in a number representing the degrees of an angle and convert the number
#			to radians.
#	
	.data
		Prompt: .asciiz "Enter an angle: "
		Reply: .asciiz "In radians: "
		pi: .double 3.14
		val: .double 180.00
	
	.text
		la $a0, Prompt	# prompt for and read double
		li $v0, 4
		syscall
		li $v0, 7
		syscall
		mov.d $f12, $f0	# move read angle into argument address
		jal DegsToRads 	# call DegsToRads function
		
		la $a0, Reply
		li $v0, 4
		syscall
		
		mov.d $f12, $f0	# move calculated radians into $f12
		li $v0, 3	# print radians
		syscall
		
		li $v0, 10	# exit
		syscall
#############################################
###   Degrees to Radians Function      	  ###
### $f4 = pi				  ###
### $f6 = 180 degrees(used for conversion)###
### $f2 = pi(f4) / 180(F6)		  ###
### $f0 = radian value to be returned	  ###
#############################################
# Desription:Takes in an angle as a double value and converts it to radians

		
	DegsToRads:
		l.d $f4, pi	# load pi into $f4
		l.d $f6, val	# load 180 degrees into $f6
		div.d $f2, $f4, $f6	# excecute pi / 180
		mul.d $f0, $f2, $f12	# multiply answer above by inputted angle to get radians
		
		
		jr $ra	# return radians
