			.data																											#data - where string values are set
nl: 		.asciiz "\n"																									#ASCII for new line
			.align 2
heading:	.asciiz "CS397: Lab 5 \n\nTravis Dacosta \n\nAssembly Language \n\n~~Max, Min, & Floats~~ \n\n"					#heading		
			.align 2
prompt1:	.asciiz "\nEnter an integer to be the size of the array: "														#prompt for the user to enter the array size	
			.align 2	
prompt2:	.asciiz "\nEnter a float into the array: "																		#prompt for the user to enter floats
			.align 2
invalid:	.asciiz "\nThe input did not meet the requirements that were set... \n"											#error message
			.align 2
psum:		.asciiz "\nPositive float sum: "																				#label to print positive sum
			.align 2
nsum:		.asciiz "\nNegative float sum: "																				#label to print negative sum
			.align 2
max_label:	.asciiz "\nMax: "																								#label to print max
			.align 2
min_label:	.asciiz "\nMin: "																								#label to print min
			.align 2
answer:		.asciiz "\n\t\t\t******* Answer *******\n"			
			
			.text
			.globl main																										#main function


Exit:		li			$v0, 10																								#exit command
			syscall						

err:		la			$a0, invalid																						#loads the address of invalid into a0 register
			li 			$v0, 4																								#prints the string stored the in the a0 register
			syscall
			j			Exit																								#jump to Exit block
				
main: 		la 			$a0, heading																						#loads the address of "name" into a0 register
			li 			$v0, 4																								#prints the string stored in the $a0 register
			syscall
			la 			$a0, prompt1																						#loads the address of "prompt1" into a0
			li 			$v0, 4																								#prints the string stored in the a0 register	
			syscall
			li 			$v0, 5																								#takes an integer as an input from the user
			syscall
			move 		$t0, $v0																							#loads the value of $v0 into the $s0 register
			move		$t1, $t0																							#copy of length				
			blez		$t0, err
			li			$t2, 0 																								#counter for MAX block
			li			$t3, 0 																								#counter for P_SUM block
			li			$t4, 0																								#counter for N_SUM block
			li			$t7, 0
			li.s		$f1, 0.0																							#initialize f1
			li.s		$f2, 0.0																							#sum for positive floats
			li.s		$f3, 0.0																							#sum for negative floats
			li.s		$f4, 0.0																							#constant zero		
			sll			$a0, $t0, 3																							#arr_size = length * 8
			li			$v0, 9																								#create a heap of size "arr_size"			
			syscall
			move		$s0, $v0																							#move the address of array to $s0
			jal			fill																								#go to fill block	

fill:		la			$a0, prompt2																						#load the prompt2 into a0
			li			$v0, 4																								#print the prompt2 to console
			syscall	
			li			$v0, 6																								#read a float value from the user
			syscall
			swc1		$f0, ($s0)																							#store value of $f0 into the array[i]	
			addi		$t0, $t0, -1 																						#decrement counter by 1
			beqz		$t0, P_SUM																							#if (n == 0) go to P_SUM
			addi		$s0, $s0, 8																							#increment array pointer 'i' by 1 word
			jal 		fill																								#jump and link to fill block again
			
			
P_SUM:		lwc1		$f1, ($s0)																							#load the float value of array[size - 1] into f1
			c.lt.s		$f1, $f4																							#if (f1 < 0.0) go to N_SUM
			bc1t		N_SUM																								#if CC is true branch to N_SUM	
			add.s 		$f2, $f2, $f1																						#p_sum = p_sum + array[x]	
			addi		$t3, $t3, 1																							#increment p_counter by 1
			beq			$t3, $t1, MAX_BASE																					#if (p_counter == length) go to MAX_BASE
			addi		$s0, $s0, -8 																						#decrement x by 1 word
			jal 		P_SUM																								#jump and link to the P_SUM block
			
			
N_SUM:		add.s		$f3, $f3, $f1																						#n_sum = n_sum + array[x]	
			addi		$t3, $t3, 1																							#increment n_counter by 1
			beq			$t3, $t1, MAX_BASE																					#if (n_counter == length) go to MAX_BASE
			addi		$s0, $s0, -8 																						#decrement x
			jal 		P_SUM																								#jump and link to P_SUM block	

			
PRINT:		la			$a0, nl																								#new line 
			li			$v0, 4																								#print string
			syscall
			la			$a0, answer																							#answer label 
			li			$v0, 4																								#print string
			syscall
			la 			$a0, psum																							#load the address of the psum string into a0
			li			$v0, 4																								#print the psum string to console
			syscall	
			mov.s		$f12, $f2																							#store the f2 into f12 register	
			li			$v0, 2
			syscall
			la			$a0, nl																								#new line 
			li			$v0, 4																								#print string
			syscall
			la 			$a0, nsum																							#load nsum string label
			li			$v0, 4																								#print string
			syscall	
			mov.s		$f12, $f3																							#store the N_SUM from Negative Sum block into f12
			li			$v0, 2																								#print float
			syscall
			la			$a0, nl																								#new line 
			li			$v0, 4																								#print string
			syscall
			la 			$a0, max_label																						#load MAX string label
			li			$v0, 4																								#print string
			syscall	
			mov.s		$f12, $f5																							#store the max from MAX function into f12
			li			$v0, 2																								#print float
			syscall
			la			$a0, nl																								#new line 
			li			$v0, 4																								#print string
			syscall
			la 			$a0, min_label																						#MIN string label
			li			$v0, 4																								#print string
			syscall	
			mov.s		$f12, $f6																							#store min from MIN function into f12
			li			$v0, 2																								#print contents of f12
			syscall
			jal			Exit
			
			
MAX_BASE:	lwc1		$f5, ($s0)																							#$f4 = array[0] and current_max									
			addi		$t2, $t2, 1																							#increment the counter by 1
			beq			$t2, $t1, MIN_BASE																					#if t2 equals t1 go to MIN_BASE block
			addi 		$s0, $s0, 8 																						#increment array pointer 'x' by 1 word
			jal			MAX																									#jump and link to max_min block

									
MAX:		lwc1		$f7, ($s0)																							#$f5 = array[x]
			c.lt.s		$f5, $f7																							#if current max greater than array[x]
			bc1t		swap_max																							#go to swap max 			
			addi		$t2, $t2, 1																							#increment the counter by 1
			beq			$t1, $t2, MIN_BASE																					#if t2 equals t1 go to MIN_BASE block
			addi		$s0, $s0, 8 																						#increment array pointer 'x' by 1 element
			jal 		MAX																									#jump and link to MAX block
			
			
swap_max:	mov.s		$f5, $f7																							#current_max = array[x]
			addi		$t2, $t2, 1																							#increment the counter by 1
			beq			$t1, $t2, MIN_BASE																					#if t2 equals t1 go to MIN_BASE block
			addi		$s0, $s0, 8 																						#increment array pointer 'x' by 1 element
			jal 		MAX																									#jump and link to MAX block
								
								
MIN_BASE:	lwc1		$f6, ($s0)																							#$f6 = array[len-1] or array[i]						
			addi		$t7, $t7, 1																							#increment the counter for MIN by 1				
			beq			$t7, $t2, PRINT																						#if min_counter == len go to PRINT block
			addi 		$s0, $s0, -8																						#decrement the array pointer by 1 element 
			jal 		MIN																									#go to MIN block

			
MIN:		lwc1		$f8, ($s0)																							#store array[i-1] into f8
			c.lt.s		$f8, $f6																							#if array[i-1] 
			bc1t		swap_min																							#go to swap_min block
			addi		$t7, $t7, 1																							#increment min_counter by 1
			beq 		$t7, $t2, PRINT																						#if min_counter == len go to PRINT block
			addi		$s0, $s0, -8																						#decrement array pointer by 1 element	
			jal 		MIN																									#loop to MIN block again
			
			
swap_min:	mov.s		$f6, $f8																							#current_min = array[x]
			addi		$t7, $t7, 1																							#increment the counter by 1
			beq 		$t7, $t1, PRINT																						#if counter == len go to PRINT block
			addi		$s0, $s0, -8																						#decrement array pointer by 1 element
			jal			MIN																									#loop to MIN block again
