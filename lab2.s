.data
msg0: .asciiz "Enter a value for N: "
msg10: .asciiz "Enter "
msg11: .asciiz " numbers: \n"
msg2: .asciiz "=> "
msg3: .asciiz "\nAverage = "
msg4: .asciiz "\nMinimum = "
msg5: .asciiz "\nMaximum = "
avg: .word 0
min: .word 0
max: .word 0
N: .word 0
x: .word 0
count: .word 0
ret_add: .word 0

.text

__start: 
				puts msg0
				get N
				move count, N
				puts msg10
				put N
				puts msg11
				puts msg2
				#gets first value and initializes outputs.
				get x
				move avg, x
				move min, x
				move max, x
				sub count, count, 1
				la ret_add, next
		next:
						blez count, print
						puts msg2
						get x
						#adds x to the average.
						add avg, avg, x
						#if is not larger than max skip move.
						ble x, max, elif1
							move max, x
				elif1:
						#if is not smaller than min skip move.
						bge x, min, elif2
							move min, x
				elif2:
						#decrement count and repeat while.
						sub count, count, 1
						b (ret_add)
		print:
						#divide average by N and output results.
						div avg, avg, N
						puts msg3
						put avg
						puts msg4
						put min
						puts msg5
						put max
done