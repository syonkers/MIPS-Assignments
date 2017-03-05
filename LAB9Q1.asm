##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 9, Question 1          ###
### 	   +/- Infinity & NaN	       ###
###        Due: November 10, 2014       ###
########################################## 
#  Main	Description: Print out infinity, negative infinity, and NaN

	.data
		Infin: .word 0x7F800000
		nInfin: .word 0xFF800000
		NAN: .word 0xFF800001
		newLine: .asciiz "\n"
	.text

		l.s $f12, Infin
		li $v0, 2
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall

		l.s $f12, nInfin
		li $v0, 2
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall

		l.s $f12, NAN
		li $v0, 2
		syscall
		
		li $v0, 10
		syscall
