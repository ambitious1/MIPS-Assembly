			.data																											#data - where string values are set
nl: 		.asciiz "\n"																									#ASCII for new line
			.align 2
heading:	.asciiz "CS397: Lab 4 \n\nTravis Dacosta \n\nAssembly Language \n\n~~Convert from any base to Decimal~~ \n\n"	#heading		
			.align 2
prompt1:	.asciiz "\nEnter an integer to be converted, make sure the each digit is less than the radix: "					#prompt for the user to enter the base	
			.align 2	
prompt2:	.asciiz "\nEnter an integer to be the radix, must be greater than 1 and less than or equal to 17: "				#prompt for the user to enter the radix
			.align 2	
invalid:	.asciiz "\nThe input did not meet the requirements that were set... \n"											#error message
			.align 2
answer:		.asciiz "\nAnswer: "
			.align 2
array:		.byte  1024			
			.align 2
			
			.text
			.globl main																										#main function
	
main: 		la 			$a0, heading																						#loads the address of "name" into $a0 register
			li 			$v0, 4																								#prints the string stored in the $a0 register
			syscall
			la 			$a0, prompt1																						#loads the address of "prompt1" into $a0
			li 			$v0, 4																								#prints the string stored in the $a0 register	
			syscall
			li 			$v0, 5																								#takes an integer as an input from the user
			syscall
			addi 		$t0, $v0, 0																							#loads the value of $v0 into the $s0 register
			bltz		$t0, error																							#if (N < 0) go to the error block
			la 			$a0, prompt2																						#loads the address of "prompt2" into $a0 register
			li			$v0, 4																								#print the string stored in the $a0 register
			syscall
			li 			$v0, 5																								#takes an integer as an input from the user		
			syscall
			addi		$t1, $v0, 0																							#loads the value of $v0 into $t1 register			
			blt			$t1, 2, error																						#if (radix < 2) go to error block
			bgt			$t1, 16, error																						#if (radix >16) go to error block
			li			$t2, 1																								#initialize the "length" variable to 1, since 0 has 1 digit
			addi		$t3, $t0, 0																							#copy of the N to calculate the quotient of an iteration in a loop
			li			$t4, 1																								#return value for N^0 = 1
			li			$t5, 0																								#counter for exponent
			li			$t6, 0																								#reinitialize $t6 to 0 for later use
			addi		$t7, $t0, 0																							#copy of the N to calculate the quotient/mod of an iteration in a loop
			addi		$t8, $t0, 0																							#copy of the N to calculate the quotient/mod of an iteration in a loop
			li			$t9, 0																								#initialize counter "i" for convert block to 0
			li			$s1, 0																								#initialize counter "n" for array pointer to 0
			li			$s2, 10																								#store 10 as a constant, for conversion
			li			$s3, 0																								#initialize counter for array pointer to 0
			li			$s4, 0																								#initialize variable to store a word to array	
			j 			len																									#go to the length block
		
			
len:		div  		$t3, $s2																							#copy of N/10 		
			mflo		$t3																									#set the quotient to $t3
			beqz		$t3, fill_array																						#if ($t3 == 0) go to arr_alloc block
			addi		$t2, $t2, 1																							#increment the length variable every iteration
			jal			len																									#once the copy of N is 0, then go to the base_pow block
		
			
fill_array:	div			$t7, $s2																							#(N%10)
			mfhi		$s6																									#set $t7 to (N%10)
			bgt			$s6, $t1, error																						#if ((N%10) > radix) go to error block	
			sw			$s6, array($s1)																						#s1[i] = $t7
			div			$t8, $s2																							#(N/10)
			mflo		$t8																									#set the quotient to $t8
			beqz 		$t8, convert																						#if ($t8 == 0) go to convert block
			addi		$s1, $s1, 4																							#else increment i by 4 bytes
			move		$t7, $t8																							#set $t7 to the new value of $t8		
			jal			fill_array																							#loop through fill_array block again
	
			
convert:	lw			$s4, array($s3)																						#$t3 = s1[0]
			mult		$s4, $t4 																							#$t5 = $t4 * $t3
			mflo		$t5																									#store product into $s5
			add			$t6, $t6, $t5																						#sum = sum + $t5
			add 		$t9, $t9, 1																							#counter is incremented by 1
			beq			$t9, $t2, print																						#if (counter == len) go to print block 	
			mult		$t4, $t1																							#else $t4 = $t4 * radix (serves as the exponent)	
			mflo		$t4																									#store the product into $t4
			addi		$s3, $s3, 4																							#increment the "n" by 4 bytes	
			
			jal			convert																								#return value		
			
			
print:		la			$a0, nl																								#load the address of nl(new line) to $a0		
			li			$v0, 4																								#print string "nl" to console		
			syscall
			la			$a0, answer																							#load the address of Answer to $a0
			li			$v0, 4																								#print the string "answer" to console
			syscall
			addi		$a0, $t6, 0																							#load the sum accumulated in the convert block to $a0	
			li			$v0, 1																								#print the integer "sum" to console	
			syscall
			j			Exit																								#go to Exit block
			
			
error:		la			$a0, invalid																						#loads the address of the "invalid" into $a0 register
			li 			$v0, 4																								#prints the string stored the in the $a0 register
			syscall
			li			$v0, 10																								#exit command
			syscall
			
			
Exit:		li			$v0, 10																								#exit command
			syscall			
				
