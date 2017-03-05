##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 11, Question 3	       ###
###        Due: November 21, 2014      ###
########################################## 
	.kdata
  		a0: .word 0
  		v0: .word 0
  		t0: .word 0
  		error1:	.asciiz "Interrupt "
		error2: .asciiz " occured"
		newLine: .asciiz "\n"
		
    	.ktext 0x80000180
    	
  		move $k0, $at
   		sw $v0, v0   	# Save $v0 value
   		sw $a0, a0   	# Save $a0 value
   		sw $t0, t0	# Save $t0 value	
   		
   		la   $a0, error1  # print first part of error message
   		li   $v0, 4 
   		syscall
   		
   		mfc0 $a0, $13	# $13 is cause register
   		move $t0, $a0	# save cause register
		srl $a0, $a0, 8	
		andi $a0, $a0, 0x2
		sgt $a0, $a0, $zero
		
		bnez $a0, exit
		lb $k1, 0xffff0004
		blt $k1, '0', exit	# checks to make sure 
		ble $k1, '9', print	# its alphanumeric
		blt $k1, 'a', exit	#
		ble $k1, 'z', print	#
		blt $k1, 'A', exit	#
		ble $k1, 'Z', print	#
	exit:
		li $v0, 1	# print error code
		syscall
		
   		la $a0, error2 # print second part of error message
   		li $v0, 4
   		syscall
   		
   		la $a0, newLine	# print new line
   		li $v0, 4
   		syscall
   		
   		lw $v0, v0  	# Restore $v0
   		lw $a0, a0   	# Restore $a0
   		lw $t0, t0	# restore $t0
   		move $at, $k0	# restore at register
   		eret		# return

	print:		
		sb $k1, 0xFFFF000C	# store character to display
		b exit			# branch to exit
		
