	.data															#data - where string values are set
nl: 	.asciiz "\n"											#ASCII for new Line
	.align 2
name:	.asciiz "Cs397: Lab Assignment 1\n\n Travis Dacosta \n\n\n"		
	.align 2
msg1:	.asciiz "Fibonacci Series Element "
	.align 2
msg2:	.asciiz " is "
	.align 2
	
saved:.space 20
	.align 2
comma: .asciiz ", "
	.align 2
arrayMessage: .asciiz "Array: "
	.align 2
arraybracket1: .asciiz "[ "		
	.align 2
arraybracket2: .asciiz " ]"
	.align 2
word:	.word	 5	
	
	
	.text															#code - where the actual code and function definitions are written
	.globl main													#declares the main to be global
	
main:	la	$a0, name											#load the address of name into the $a0 register
	li	$v0,4														#system call, type 4 print an string from $a0
	syscall														#call the OS- sends the $v0 register command to the OS so it can occur 
	li	$t2,0														#$t2 is set to equal 0. initial value of F(n-2) 
	li	$t1,1														#$t1 is set to point to 1. initial value F(n-1)
	li	$t4,0														#$t4, is set to equal 1. this is the index in which traverses over the loop elements. for (i=0;i<50;i++)
	li $t5, 45													#max amount
	la $s0, saved												#set the address of the array to s0
	li $s1, 0													#counter for array = 0, like x(i) or s0(0)
	li	$s2, 0													#array offset is set to 0
	li	$s3, 0													#i counter to print array
	li	$s4, 0													#array offset to print array
	lw	$s5, word 												#set the amount of words in the array to 5, .space 20/4 bytes = 5 words
	
baseCase1:	
	addi $t4, 1													#increment $t4 by 1
	j loop	
baseCase2:	
	addi $t4, 1													#increment $t4 by 1
	j loop				
																	#then points to the loop function if there is anymore after the current t4
loop:																#starts from 2 and on, so it excludes the base cases		
	beq 	$t4, 0, baseCase1										#base case for 0
	beq 	$t4, 1, baseCase2										#base case for 1
	add 	$t0, $t1, $t2										#sum of the numbers
	sub 	$t6, $t5, $t4										#difference between the max and current index
	blt 	$t6, 5, print										#when difference is less than or equal to 5, go to print function	
	addi 	$t4,1													#increments the value of $t4 or F(n) by 1
	move 	$t2,$t1												#shifts the position of F(n-2) to F(n-1)
	move 	$t1,$t0												#shifts the position of F(n-1) to F(n)
	
	j	loop														#branch unconditionally to loop when ($t4 < $t5)
	
print:
#fill the array in the background of the program starting from where $t4>5
	bge	$s1,$s5, printarray1								#if the i counter is equal to the max size of the array go to print array function now	
	sw		$t0, saved($s2)									#put the contents in $t0 into the array starting position
	addi 	$s1, $s1, 1											#increment array counter by 4 so it can enter each number
	addi	$s2, $s2, 4	

#print the message for each fib number greater than 5	
	la		$a0, msg1											#$a0 address of msg1
	li		$v0, 4												#syscall of type 4 is to print a string, so it prints, msg1
	syscall														#call the OS
	move 	$a0,$t4												#$t4 contains the current value of n
	li   	$v0,1													#system call, type 1, print an integer from the $a0 register
	syscall														#call the OS - sends the $v0 register to the OS so it can take action
	la 	$a0,msg2												#loads msg2 to the $a0 register
	li 	$v0,4													#loads the print string instruction into the $v0 register
	syscall																
	move	$a0,$t0												#loads the value of F(n) into the $a0 register
	li		$v0,1													#system call, type 1, print an integer 
	syscall
	la		$a0,nl												#loads the new line variable to $a0 register to be used
	li		$v0,4													#loads the print string instruction to $v0		
	syscall
	addi	$t4,1													#increments the value of $t4 or F(n) by 1
	move	$t2,$t1												#shifts the position of F(n-2) to F(n-1)
	move	$t1,$t0
		j loop
	
	
printarray1: 													
#prints the Array header and starting brackets	
	la 	$a0, nl												#start a new line
	li 	$v0, 4
	syscall
	la 	$a0, arrayMessage									#Print the header for array	
	li 	$v0, 4
	syscall
	la 	$a0, arraybracket1								#print the common brackets associated with arrays
	li 	$v0, 4
	syscall
	j arraybody													#go to the body of the array function	
   

arraybody:	
#starts printing the array	
	beq	$s3, 4, printarrayb								#if counter is equal to 4 then go other print funct w/o comma 	
	bge 	$s3, $s5, printarray2 							#if the counter is equal to max, then it is the end of the array so go to final print, a[last]==a[max-1]
	
	lw		$a0, saved($s4)									#print the value at the current array pointer
	li		$v0, 1
	syscall
	la 	$a0, comma											#comma to separate the array entries											
	li 	$v0, 4
	syscall
	addi 	$s3, $s3, 1											#increment the counter for the array by 1 until it reaches max-1
	addi	$s4, $s4, 4											# 
	j arraybody

printarray2:
	la 	$a0, arraybracket2
	li 	$v0, 4
	syscall
	j Exit
	
printarrayb:
	lw		$a0, saved($s4)									#print the value at the current array pointer
	li		$v0, 1
	syscall
	addi 	$s3, $s3, 1											#increment the counter for the array by 1 until it reaches max-1
	addi	$s4, $s4, 4											#increment the array index by 1 word, or 4 bytes
	j arraybody
			
Exit:	li		$v0,10											#system call to exit or return 0;
	syscall														#call the OS

