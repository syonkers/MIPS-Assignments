	.data
		List: .word 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024
		Size: .word 10
		Prompt: .asciiz "Enter an integer target: "
		Result1: .asciiz "The target "
		Result2: .asciiz " is at index "
		notFound: .asciiz " was not found"
		
	.text
		la $a0, Prompt	# prompt for number
		li $v0, 4
		syscall
		
		li $v0, 5	# read number
		syscall
		
		move $a1, $v0	# move number into $a1(second argument of binarySearch)
		
		la $a0, List	# load list into $a0(first argument of binarySearch)
		lw $a2, Size	# load size into $a2(third argument of binarySearch
		jal binarySearch	# call binarySearch function
		
		move $t0, $v0	# move result of binarySearch into $t0
		
		blt $t0, $zero, notF	# if result is less than zero (-1), value was not found
		
		la $a0, Result1	# print the first string of result
		li $v0, 4
		syscall
		
		move $a0, $a1	# print the inputed value
		li $v0, 1
		syscall
		
		la $a0, Result2	# print second string of result
		li $v0, 4
		syscall
		
		move $a0, $t0	# print index of input
		li $v0, 1
		syscall
		
		li $v0, 10	# exit
		syscall
		
	notF:
		
		move $a0, $a1	# print user input
		li $v0, 1
		syscall
		
		la $a0, notFound # print not found string
		li $v0, 4
		syscall
		
		li $v0, 10	# exit
		syscall
		
	binarySearch:
		
		li $t0, 0		# set first index to 0
		addi $t1, $a2, -1	# set last index to size-1
		sw $ra, 0($sp)		# store return to main
	While:	
		bgt $t0, $t1, Exit 	# exit if firstIndex is greater than lastIndex
		add $t2, $t0, $t1	# set the mid index
		srl $t2, $t2, 1		# set the mid index
		sll $t4, $t2, 2		# 
		add $t5, $a0, $t4
		lw $t3, 0($t5)
		beq $a1, $t3, Found	# if value is found, go to Found
		blt $a1, $t3, incLast	# if midIndex is greater than value
		bgt $a1, $t3, incFirst	# if midIndex is smaller than value
		
	Found:		
		move $v0, $t2		# move value to be returned
		lw $ra, 0($sp)		# recover return location
		jr $ra
	Exit:
		li $v0, -1		# if not found, return -1
		lw $ra, 0($sp)
		jr $ra
	incLast:
		addi $t1, $t2, -1	# decrement lastIndex by midIndex - 1
		j While
	incFirst:
		addi $t0, $t2, 1	# increment firstIndex by midIndex + 1
		j While