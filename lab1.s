.data
msg1: .asciiz "Welcome to EEC 70 in Winter Quarter 2012 \n"
msg:  .asciiz "This program subtracts two numbers specified by the 
user\n"
msg2: .asciiz "X = "
eoln: .asciiz "\n"
msg3: .asciiz "Y = "
msg4: .asciiz "X + Y = "
msg5: .asciiz "Goodbye!"
x :   .word 0
y :   .word 0
diff: .word 0

.text

puts msg1
puts msg
puts msg2
get x
puts eoln
puts msg3
get y
sub diff, x, y
puts eoln
puts msg4
put diff
puts eoln
puts msg5
done
