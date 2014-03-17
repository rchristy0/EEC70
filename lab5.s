#Raymond Christy 997194948
.data  
Class: 
  .asciiz "Bill   "
  .word 934039
  .word 87
  .asciiz "Art    "
  .word 188399
  .word 45
  .asciiz "Peter  "
  .word 184909
  .word 67
	.asciiz "Miller "
  .word 594939
  .word 55
	.asciiz "Wells  "
  .word 849309
  .word 51
	.asciiz "Rahim  "
  .word 859310
  .word 90
  .asciiz "Thomas "
  .word 345698
  .word 67
  .asciiz "Garcia "
  .word 634899
  .word 49
  .asciiz "William" 
  .word 599490
  .word 77
  .asciiz "Janice "
  .word 353849
  .word 55
  .asciiz "Emma   "
  .word 239492
  .word 82
  .asciiz "Susie  "
  .word 239420
  .word 69
  .asciiz "Katie  "
  .word 123424
  .word 59
  .asciiz "Gizelle"
  .word 174351
  .word 59
  .asciiz "Michele"
  .word 112341
  .word 66
  .asciiz "Powell "
  .word 113949
  .word 87
  .asciiz "Marie  "
  .word 107897
  .word 80
  .asciiz "Hannah "
  .word 793714
  .word 71
  .asciiz "Kristen"
  .word 638938
  .word 60
  .asciiz "Jones  "
  .word 439939
  .word 50

NumOfStudents:     .word 20

# Data declarations
start:      .asciiz "Welcome to the Grade Sorting Program"
sorttype:   .asciiz "\nEnter the field to sort by - N for Name, I for Student ID and F for Final Exam Score: "
sortorder:  .asciiz "\nEnter the sort order - A for Ascending or D for Descending: "
typeerr:    .asciiz "\nInvalid field value, select N, I, or F.\n"
ordererr:   .asciiz "\nInvalid sort order, select A, or D.\n"
header:     .asciiz "\nName    ID     Grade\n"
field:      .byte
order:      .byte

.text
__start:
# Prompt for input
    li $v0, 4 
    la $a0, start
    syscall
  input:  
      la $a0, sorttype
      syscall
      li $v0, 12
      syscall
      sb $v0, field
      li $t0, 'N'
      li $t1, 'I'
      li $t2, 'F'
      beq $v0, $t0, goodfield
      beq $v0, $t1, goodfield
      beq $v0, $t2, goodfield
      li $v0, 4 
      la $a0, typeerr
      syscall
      jal input
#if a '\n' is input after the field value it is passed to the order value
## DO NOT use enter after the input; use Ctl-d.
  goodfield:
      li $v0, 4
      la $a0, sortorder
      syscall
      li $v0, 12
      syscall
      sb $v0, order
      li $t0, 'A'
      li $t1, 'D'
      beq $v0, $t0, goodorder
      beq $v0, $t1, goodorder
      li $v0, 4 
      la $a0, ordererr
      syscall
      jal input
  goodorder:
			la $s0, Class
			lw $s1, NumOfStudents
			lb $t0, field
      li $t1, 'I'
      li $t2, 'F'
      beq $t0, $t1, idsort
      beq $t0, $t2, gradesort
    
# Sort by Name
	namesort:
#$t9 = i
			li $t9, 1
		forelemn:
				beq $t9, $s1, check
#set $t0 to address
				mul $t0, $t9, 16
				add $t0, $t0, $s0
#$t2 stores the value at i
				lb $s2, ($t0) 
				lb $s3, 1($t0) 
				lb $s4, 2($t0) 	
				lb $s5, 3($t0) 	
				lb $s6, 4($t0)
				
#$t8 = j
				sub $t8, $t9, 1
			forsiftn:
					bltz $t8, contn
					mul $t0, $t8, 16
					add $t0, $t0, $s0
					lb $t3, ($t0) #a[j]
					lb $t4, 1($t0)
					lb $t5, 2($t0)
					lb $t6, 3($t0)
					lb $t7, 4($t0)
					blt $t3, $s2, contn
					bne $t3, $s2, next
					blt $t4, $s3, contn
					bne $t4, $s3, next
					blt $t5, $s4, contn
					bne $t5, $s4, next
					blt $t6, $s5, contn
					bne $t6, $s5, next
					blt $t7, $s6, contn						
				next:
						move $s7, $t0
						add $t1, $t0, 16
						move $s8, $t1
						jal swap
						sub $t8, 1
						j forsiftn
				contn:
						add $t9, 1
						j forelemn
			
			
# Sort by Id
	idsort:
#$t9 = i
			li $t9, 1
		forelemi:
				bgt $t9, $s1, check
#set $t0 to address
				mul $t0, $t9, 16
				add $t0, $t0, $s0
#$t2 stores the value at i
				lw $t2, 8($t0) 
#$t8 = j
				sub $t8, $t9, 1
			forsifti:
					bltz $t8, conti
					mul $t0, $t8, 16
					add $t0, $t0, $s0
					lw $t3, 8($t0) #a[j]
					ble $t3, $t2, conti
					move $s7, $t0
					add $t1, $t0, 16
					move $s8, $t1
					jal swap
					sub $t8, 1
					j forsifti
				conti:
						add $t9, 1
						j forelemi
			
# Sort by Grade
	gradesort:
#$t9 = i
			li $t9, 1
		forelemg:
				bgt $t9, $s1, check
#set $t0 to address
				mul $t0, $t9, 16
				add $t0, $t0, $s0
#$t2 stores the value at i
				lw $t2, 12($t0) 
#$t8 = j
				sub $t8, $t9, 1
			forsiftg:
					bltz $t8, contg
					mul $t0, $t8, 16
					add $t0, $t0, $s0
					lw $t3, 12($t0) #a[j]
					ble $t3, $t2, contg
					move $s7, $t0
					add $t1, $t0, 16
					move $s8, $t1
					jal swap
					sub $t8, 1
					j forsiftg
				contg:
						add $t9, 1
						j forelemg
			
# Check//Reverse order
	check:
			lb $t0, order
			li $t1, 'A'
			beq $t0, $t1, output
			mul $t0, $s1, 16
			move $t8, $s0
			add $t9, $t8, $t0
			sub $t9, 16
		reverse:
				ble $t9, $t8, output
				move $s7, $t8
				move $s8, $t9
				jal swap
				add $t8, 16
				sub $t9, 16
				j reverse
				
#	Swap the students at $s7 and $s8
	swap:
			lb $t0, ($s7)
			lb $t1,	($s8)
			sb $t0, ($s8)
			sb $t1,	($s7) 
			lb $t0, 1($s7)
			lb $t1,	1($s8)
			sb $t0, 1($s8)
			sb $t1,	1($s7)
			lb $t0, 2($s7)
			lb $t1,	2($s8)
			sb $t0, 2($s8)
			sb $t1,	2($s7)
			lb $t0, 3($s7)
			lb $t1,	3($s8)
			sb $t0, 3($s8)
			sb $t1,	3($s7)
			lb $t0, 4($s7)
			lb $t1,	4($s8)
			sb $t0, 4($s8)
			sb $t1,	4($s7)
			lb $t0, 5($s7)
			lb $t1,	5($s8)
			sb $t0, 5($s8)
			sb $t1,	5($s7)
			lb $t0, 6($s7)
			lb $t1,	6($s8)
			sb $t0, 6($s8)
			sb $t1,	6($s7)
			lb $t0, 7($s7)
			lb $t1,	7($s8)
			sb $t0, 7($s8)
			sb $t1,	7($s7)
			lw $t0, 8($s7)
			lw $t1,	8($s8)
			sw $t0, 8($s8)
			sw $t1,	8($s7) 
			lw $t0, 12($s7)
			lw $t1,	12($s8)
			sw $t0, 12($s8)
			sw $t1,	12($s7) 
			jr $ra

# Answer output
	output:
			li $v0, 4
			la $a0, header
			syscall
			li $t1, 1
		outputloop:
				li $v0, 4
				la $a0, ($s0)
				syscall
				li $v0, 11
				li $a0, ' '
				syscall
				li $v0, 1
				lw $a0, 8($s0)
				syscall
				li $v0, 11
				li $a0, ' '
				syscall
				li $v0, 1
				lw $a0, 12($s0)
				syscall
				li $v0, 11
				li $a0, '\n'
				syscall
				add $t1, 1
				bgt $t1, $s1, end
				add $s0, 16
				jal outputloop
	end:
			li $v0, 10
			syscall
done
