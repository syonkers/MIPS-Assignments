##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 5, Question 2          ###
### Print Array Using Index Addressing ###
###        Due: October 10, 2014       ###
########################################## 

#	$t0: used to store the pointer
#   	$t1: used to keep the index
#	$t2: used to keep the sum
#	$t3: used to keep the max number
#	$t4: used to keep the min number
#	$t5: holds the next array value temporarily
#	$a0: store the array
#	$a1: stores the size of the array
	
	.data
		List: .word 15, 4, 1, 60, 10
		Size: .word 5
		pMax: .asciiz "The max is: "
		pMin: .asciiz "The min is: "
		pSum: .asciiz "The sum is: "
		newLine: .asciiz "\n"
	.text
	
		lw $a1, Size
		la $a0, List
		li $t0, 0
		li $t1, 0
		li $t2, 0
		li $t3, 0
		li $t4, 0x7FFFFFFF
		move $t0, $a0
		
	Main: 	
		beq $t1, $a1, Exit
		lw $t5, ($t0)	
		add $t2, $t2, $t5
		b Max
	B2M:
		b Min
	B2M2: 
		add $t1, $t1, 1
		addu $t0, $t0, 4
	b Main	
	
	Max:
		blt $t5, $t3, B2M
		move $t3, $t5
	b B2M
	
	Min:	
		bgt $t5, $t4, B2M2
		move $t4, $t5
	b B2M2
	
	Exit:
		li $v0, 4
		la $a0, pSum
		syscall
		
		li $v0, 1
		move $a0, $t2
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		li $v0, 4
		la $a0, pMax
		syscall
		
		li $v0, 1
		move $a0, $t3
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		li $v0, 4
		la $a0, pMin
		syscall
		
		li $v0, 1
		move $a0, $t4
		syscall
		
		li $v0, 10
		syscall
	
	
	