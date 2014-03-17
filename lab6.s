#Raymond Christy 997194948

.data  
list:
	.word -1073725016  #20 random ints, should work for any valid 32 bit int
	.word -791266574
	.word 548908250
	.word -88798165
	.word 70367107
	.word -603530551
	.word -972714279
	.word 384109055
	.word 385036100
	.word 933495886
	.word -250177383
	.word 41696342
	.word 710742669
	.word -999498781
	.word -958933836
	.word 63780680
	.word 367540504
	.word -1057210094
	.word -250362983
	.word -930199211

randmsg:
	.asciiz "\nList of Random Values:\n"
sortedmsg:
	.asciiz "\nList of Sorted Values:\n"
eoln:
    .ascii '\n'

# Initialize data here
auxlist: .space 80
lo: .word
hi: .word
m: .word

.text
__start:

    la $s0, randmsg     # Store message address for print
    jal print           # Call the array print procedure


		la $s0, list
		la $s1, auxlist
		li $t0, 0
		li $t1, 19
		la $s2, lo
		la $s3, hi
		la $s4, m
		sw $t0, ($s2)
		sw $t1, ($s3)
		jal mergesort


    la $s0, sortedmsg   # Store message address for print
    jal print           # Call the array print procedure

done

#############################
#	$s0 = a 
#	$s1 = b
# $t0 = lo
# $t1 = hi
# $t2 = m

mergesort:
	sw $ra, ($sp)
	add $sp, -4
	lw $t0, ($s2)
	lw $t1,	($s3)
	bge $t0, $t1, next
	add $t2, $t0, $t1
	div $t2, $t2, 2
	sw $t0,	($s2)
	sw $t2, ($s3)
	jal mergesort
	add $t2, 1
	sw $t2, ($s2)
	sw $t1, ($s3)
	jal mergesort
	sw $t0,	($s2)
	sw $t1, ($s3)
	sw $t2,	($s4)
	jal merge
	
#	$s0 = a 
#	$s1 = b
# $t0 = lo
# $t1 = hi
# $t2 = m 
# $t3 = i
# $t4 = j
# $t5 = k 
	
merge:
	lw $t0,	($s2)
	lw $t1, ($s3)
	lw $t2,	($s4)
	move $t3, $t0
for:
	bgt $t3, $t1, endfor
	mul $t6, $t3, 4
	add $t7, $s0, $t6
	lw $t8, ($t7)
	add $t7, $t6, $s1
	sw $t8, ($t7)
	add $t3, 1
	j for
endfor:
	move $t3, $t0
	add $t6, $t2, 1
	move $t4, $t6
	move $t5, $t0
while:
	bgt $t3, $t2, endwhile
	bgt $t4, $t1, endwhile
	mul $t6, $t3, 4
	add $t6, $t6, $s1
	lw $t7, ($t6)
	mul $t6, $t4, 4
	add $t6, $t6, $s1
	lw $t8, ($t6)
	bgt $t7, $t8, else
	mul $t6, $t3, 4
	add $t7, $t6, $s1
	lw $t8, ($t7)
	mul $t6, $t5, 4
	add $t7, $t6, $s0
	sw $t8, ($t7)
	add $t3, 1
	add $t5, 1
else:
	mul $t6, $t4, 4
	add $t7, $t6, $s1
	lw $t8, ($t7)
	mul $t6, $t5, 4
	add $t7, $t6, $s0
	sw $t8, ($t7)
	add $t4, 1
	add $t5, 1
endwhile:	
	bgt $t3, $t2, next
	mul $t6, $t3, 4
	add $t7, $t6, $s1
	lw $t8, ($t7)
	mul $t6, $t5, 4
	add $t7, $t6, $s0
	sw $t8, ($t7)
	add $t3, 1
	add $t5, 1
	j endwhile

next:
	add $sp, 4
	lw $ra, ($sp)
	jr $ra

#######################
	
	
#- Array Print Procedure -#

print:
    li $v0, 4           # Print list title message
    move $a0, $s0       # Load message address
    syscall

    la	$8, list        # Load array starting address
    add $9, $8, 80      # Last array address

printloop:
    li	$v0, 1		# Set for print_int
    lw	$a0, ($8)	# Print number from array
    syscall

    li $v0, 11          # Print line return
    lb $a0, eoln 
    syscall

    add $8, $8, 4       # Increment address pointer

    bne $8, $9, printloop # Loop until the end
  
    jr $31              # Jump to the return register
