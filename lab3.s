#Raymond Christy 997194948
.data
		headr:	.asciiz "Please enter expression in specified format\n"
		intro:	.asciiz " Enter expression: "
		err:		.asciiz "ERROR: Please input numbers in specified format."
		bye:		.asciiz "Thanks for using CoolCalc written in a Assembly Language"
		ch: 		.byte
		op:		.byte ' '
		new:		.byte '\n'
		prev:		.byte
		nega:		.float
		ans:		.float
		real: 	.float
		ten:		.float
		dec: 		.float
		dvr:		.float 
		int: 		.word 0
		dtmp:		.word 0
		digit: 	.word 0
		
.text
__start: 
	top:
		move int, 0
		move dtmp, 0
		move op, ' '
		cvt ten, 10
		cvt dvr, 1
		cvt nega, 1
		puts headr
		puts intro
	cyc:
		get ch
		beq ch, new, cyc
		beq ch, 'q', end
		beq ch, 'x', end
		bne ch, '-', procch
		cvt nega, -1
		move prev, ch
		get ch
	procch: 
			beq ch, '.', decimal
			bgt ch, '9', notadigit
			sub digit, ch, '0'
			bltz digit, notadigit
			mul int, int, 10
			add int, int, digit
			move prev, ch
			get ch
			b procch
		decimal:
				beq prev, '.', noerr
				bgt prev, '9', error
				blt prev, '0', error
			noerr:
					move prev, ch 
					get ch
					bgt ch, '9', notadigit
					sub digit, ch, '0'
					bltz digit, notadigit
					mul dvr, dvr, ten
					mul dtmp, dtmp, 10
					add dtmp, dtmp, digit
					b decimal
		notadigit:
				beq prev, '.', error
				cvt real, int
				move int, 0
				beqz dtmp, skip
				cvt dec, dtmp
				move dtmp, 0
				div dec, dec, dvr
				add real, real, dec
			skip:
					cvt dvr, 1
					mul real, real, nega
					cvt nega, 1
					beq ch, new, error
					beq op, ' ', first
					beq op, '+', addition
					beq op, '-', subtraction
					beq op, '*', multiplication
					beq op, '/', division
					beq op, '=', print
					b error
				first:
						move ans, real
						move op, ch
						move prev, ch 
						get ch
						b procch
				addition:	
						add ans, ans, real
						move op, ch
						move prev, ch 
						get ch
						b procch
				subtraction:
						sub ans, ans, real
						move op, ch
						move prev, ch 
						get ch
						b procch
				multiplication:
						mul ans, ans, real
						move op, ch
						move prev, ch 
						get ch
						b procch
				division:
						div ans, ans, real
						move op, ch
						move prev, ch 
						get ch
						b procch
				print:
						put ans
						put new
						put new
						b top
				error:
						beq op, '=', print
					reset:
							get ch
							beq ch, new, brk
							b reset
					brk:
						puts err
						put new
						put new
						b top
				end:
						puts bye
						put new
done
