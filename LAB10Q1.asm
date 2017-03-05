##########################################
###             Shaun Yonkers          ###
###               1650692              ###
###         Lab 10, Question 1         ###
###        Due: November 14, 2014      ###
########################################## 
	.data
		String: .asciiz "Hello World"
	.text
		la $a0, String	# load string into argument 1
		jal prints	# call prints function
		
	prints:
		lb $t0, ($a0)	# load first charater into $t0
		beqz $t0, exit	# if char is null terminator, exit
		li $a3, 0xffff0000 # I/O base-address
	disLoop:
		lw $t1, 8($a3) # read dis ctrl reg
		andi $t1, $t1, 1 # extract ready bit
		beqz $t1, disLoop
		sw $t0, 12($a3) # write character
		addi $a0, $a0, 1 # go to next character
		j prints	# jump back to prints
	exit:
		li $v0, 10	# exit
		syscall
