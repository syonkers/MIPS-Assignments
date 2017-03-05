##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 11, Question 1 & 2     ###
###        Due: November 21, 2014      ###
########################################## 

################################
###	  Question 1	     ###
################################
#
# setMonInt.s: M
#
# setKbInt.s: Runtime exception at 0x0040002c: External Interrupt
#
#
#################################
###     Question 2	      ###
#################################
#
#
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
   		sw $t0, t0	
   		
   		la   $a0, error1  # print first part of error message
   		li   $v0, 4 
   		syscall
   		
   		mfc0 $a0, $13	# $13 is cause register
   		move $t0, $a0	# save cause register
		srl $a0, $a0, 8
		andi $a0, $a0, 0x2
		sgt $a0, $a0, $zero
		
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
   		
   		mfc0 $k0,$14    # get address for $14
   		addi $k0,$k0,4	# add 4 to point to next instruction
   		mtc0 $k0,$14	# store new address back into $14
   		eret		# return

	
