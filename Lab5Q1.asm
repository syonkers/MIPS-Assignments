##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 5, Question 1          ###
### Print Array Using Index Addressing ###
###        Due: October 10, 2014       ###
########################################## 

#
#   	$t1: used to store the current index address of the array
#	$t2: used to keep track of index number
#	$a0: store the array
#	$a1: stores the size of the array
#	
	
	.data
		List: .word 2, 4, 6, 8, 10
		Size: .word 5
		newLine: .asciiz "\n"
	.text
		
		li $t1, 0
		li $t2, 0
		lw $a1, Size
		
	Main:	beq $t2, $a1, Exit
		
		lw $a0, List($t1)
		
		li $v0, 1
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		addi $t1, $t1, 4
		addi $t2, $t2, 1
		
	j Main

	Exit:
		li $v0, 10
		syscall
