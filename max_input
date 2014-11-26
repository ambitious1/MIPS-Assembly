.text 
.align 2 
.globl main 

main: # this program prints out the largest two of three numbers input 

li $v0, 4 
la $a0, prompt1 
syscall 

li $v0, 5 # read keyboard into $v0 (number x is number to test) 
syscall 
move $t0,$v0 # first number in $t0 

li $v0, 4 
la $a0, prompt2 
syscall 

li $v0, 5 # read keyboard into $v0 (number x is number to test) 
syscall 
move $t1,$v0 # second number in $t1 

li $v0, 4 
la $a0, prompt3 
syscall 

li $v0, 5 # read keyboard into $v0 (number x is number to test) 
syscall 
move $t2,$v0 # third number in $t2 

bge $t1, $t0, CMP2 
move $t1, $t0 # largest number in $t1 

CMP2: 
bge $t1, $t2, L1 
move $t1, $t2 

L1: 
li $v0, 4 # print answer 
la $a0, answer 
syscall 

li $v0, 1 # print integer function call 1 
move $a0, $t1 # integer to print 
syscall 

end: jr $ra 

.data 

prompt1: .asciiz "Enter the first number " 
prompt2: .asciiz "Enter the second number " 
prompt3: .asciiz "Enter the third number " 
answer: .asciiz "The largest number is "
