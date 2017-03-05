##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 9, Question 4          ###
### 	   Calulate equation of a line ###
###        Due: November 10, 2014      ###
########################################## 
#  Main	Description: Take in two coordinates (x,y) and calulate the equation of a line in the form of
#			y = mx + b
#
#	$f20 = holds the first x coordinate
#	$f22 = holds the first y coordinate
#	$f24 = holds the second x coordinate
#	$f26 = holds the second y coordinate
#	$f4 = holds the rise value (y2 - y1)
#	$f6 = holds the run value (x2 - x1)
#	$f8 = holds the slope(m)
#	$f10 = holds the (m * x) value
#	$f16 = holds the b value

	.data

		promptX1: .asciiz "Please enter the first point,  X coordinate: "
		promptX2: .asciiz "Please enter the second point,  X coordinate: "
		promptY1: .asciiz "Please enter the first point, Y coordinate: "
		promptY2: .asciiz "Please enter the second point,  Y coordinate: "
		finalPT1: .asciiz "The equation of the line is: y = "
		finalPT2: .asciiz " x + "

	.text

	##### Prompts ##### 
		li $v0,4  		# load code for print string
		la $a0,promptX1         # load address for string to print
		syscall
		li $v0, 6		# load code for read float
		syscall
		mov.d $f20,$f0		# move X1 to $f20

		li $v0,4		# load code for print string
		la $a0, promptY1	# load address for string to print
		syscall
		li $v0, 6		# load codefor read float
		syscall
		mov.d $f22,$f0		# move Y1 to $f22

		li $v0,4		# load code for print string
		la $a0, promptX2	# load address for string to print
		syscall
		li $v0, 6		# load codefor read float
		syscall
		mov.d $f24,$f0		# move X2 to $f24

		li $v0,4		# load code for print string
		la $a0, promptY2	# load address for string to print
		syscall
		li $v0, 6		# load codefor read float
		syscall
		mov.d $f26,$f0		# move Y2 to $f26
		
	##### Calculate m #####
		sub.s $f4, $f26, $f22   # Subtract Y2-Y1 (rise) and place in $f4
		sub.s $f6, $f24, $f20	# Subtract X2-X1 (run) and place in $f6
		div.s $f8, $f4, $f6	# Calculate slope using (Y2-Y1)/(X2-X1)

	###### Calculate b #####
		mul.s $f10, $f8, $f20	# multiple first X value and slope together( m * x)
		sub.s $f16, $f22, $f10	# subtract mx from y (b = (y - (m * x)))

	##### Print Statement ##### 

		li $v0,4		# load code for print string
		la $a0, finalPT1	# load address for string to print first part of sentance
		syscall

		li $v0, 2		# load code for print float
		mov.d $f12, $f8		# move m into address to print
		syscall

		li $v0,4		# load code for print string
		la $a0, finalPT2	# load address for string to print "x + "
		syscall

		li $v0,2		# load code for print float
		mov.d $f12, $f16	# move b into address to print
		syscall

	##### END #####
		li $v0, 10		# exit
		syscall