##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 9, Question 5          ###
### 	   Calculate square root       ###
###        Due: November 10, 2014      ###
########################################## 
#  Main	Description: Take in a floating point number and call the sqrt function and printing
#			out the returned value
	.data
		Prompt: .asciiz "Please enter a floating point number: "
		Y0: .float 1.00		# starting y value
		constant: .float 0.5	# constant used in sqrt function
		zero: .float 0.00	# float representation of zero
		NAN: .word 0x7F800001
	.text
		li $v0,4  		# load code for print string
		la $a0,Prompt         	# load address for string to print
		syscall
		li $v0, 6		# load code for read float
		syscall
		mov.d $f12,$f0		# move X1 to $f20
		
		jal sqrt		# call sqrt function
		
		mov.s $f12, $f0		# print returned value
		li $v0, 2
		syscall
		
		li $v0, 10		# exit
		syscall
###################################################
###   Square Root Function      	  	###
### $f4 = contains the Yi value(1)		###
### $f6 = contains the constant value(0.5)	###
### $f8 = contains the x/Yi value		###
### $f10 = contains the Yi + (x/Yi) value	###
### $f12 = contains the value passed into func  ###
### $f16 = contains the value 0.00		###
### $t0 = contains the counter			###
### $t1 = max count before exiting		###
###################################################
# Desription: Takes in a floating point number and returns the square root of the number
	sqrt:
		l.s $f16, zero		# load zero into $f16
		c.lt.s $f12, $f16	# if number is less than zero
		bc1t Negative		# go to Negative
		l.s $f4, Y0		# load Yi into $f4
		l.s $f6, constant	# load constant into $f6
		li $t0, 1		# set counter to 1
		li $t1, 10		# set max counter
	loop:
		bgt $t0, $t1, Exit	# if loop is done, go to exit
		div.s $f8, $f12, $f4	# divide X value by Yi
		add.s $f10, $f8, $f4	# add Yi to result above
		mul.s $f4, $f6, $f10	# multiply by constant
		addi $t0, $t0, 1 	# increase counter
		b loop			# loop back up
		
	Exit:
		mov.s $f0, $f4		# put result into $f0 and return
		jr $ra
		
	Negative:
		l.s $f0, NAN		# if negative, load NaN and return
		jr $ra
