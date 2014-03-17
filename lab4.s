#Raymond Christy 997194948
.data
		row:		.word
		rtmp:		.word
		roff:		.word
		col:		.word
		ctmp:		.word
		coff:		.word
		base:		.word
		index:	.word
		rsize:	.word			9
		csize:	.word			9
		size:		.word			4
		tmp:		.word
		bit:		.word
		val: 		.word
		check: 	.word
		chval:	.word			511
		nl:			.byte			'\n'
		sp:			.byte			' '
		valid:	.asciiz	 	"The puzzle is valid.\n"
		inval:	.asciiz 	"The puzzle is not valid.\n"
		
		Sudoku:
			.word 5
			.word 3
			.word 4
			.word 6
			.word 7
			.word 8
			.word 9
			.word 1
			.word 2
			
			.word 6
			.word 7
			.word 2
			.word 1
			.word 9
			.word 5
			.word 3
			.word 4
			.word 8
			
			.word 1
			.word 9
			.word 8
			.word 3
			.word 4
			.word 2
			.word 5
			.word 6
			.word 7
			
			.word 8
			.word 5
			.word 9
			.word 7
			.word 6
			.word 1
			.word 4
			.word 2
			.word 3
			
			.word 4
			.word 2
			.word 6
			.word 8
			.word 5
			.word 3
			.word 7
			.word 9
			.word 1
			
			.word 7
			.word 1
			.word 3
			.word 9
			.word 2
			.word 4
			.word 8
			.word 5
			.word 6
			
			.word 9
			.word 6
			.word 1
			.word 5
			.word 3
			.word 7
			.word 2
			.word 8
			.word 4
			
			.word 2
			.word 8
			.word 7
			.word 4
			.word 1
			.word 9
			.word 6
			.word 3
			.word 5
			
			.word 3
			.word 4
			.word 5
			.word 2
			.word 8
			.word 6
			.word 1
			.word 7
			.word 9
					
.text
__start: 
		move row, 0
		move col, 0
		la base, Sudoku
	parserow:
			beq col, rsize, rnext
			mul index, row, rsize
			add index, index, col
			mul index, index, size
			add index, index, base
			move val, m[index]
			sub tmp, val, 1
			sll bit, 1, tmp 
			or check, check, bit
			add col, col, 1			
			b parserow
	rnext:
			bne check, chval, false
			move check, 0
			add row, row, 1
			move col, 0
			beq row, csize, rcont
			b parserow
	rcont:
			move row, 0
			move col, 0
	
	parsecol:
			beq row, csize, cnext
			mul index, row, rsize
			add index, index, col
			mul index, index, size
			add index, index, base
			move val, m[index]
			sub tmp, val, 1
			sll bit, 1, tmp 
			or check, check, bit
			add row, row, 1			
			b parsecol
	cnext:
			bne check, chval, false
			move check, 0
			add col, col, 1
			move row, 0
			beq col, rsize, ccont
			b parsecol
	ccont:		
			move row, 0
			move col, 0
			
	parsebox:
		forr:
				bge rtmp, 3, bnext
			forc:
					bge ctmp, 3, fornext
					add row, rtmp, roff
					add col, ctmp, coff
					mul index, row, rsize
					add index, index, col
					mul index, index, size
					add index, index, base
					move val, m[index]
					sub tmp, val, 1
					sll bit, 1, tmp 
					or check, check, bit
					add ctmp, ctmp, 1			
					b forc
			fornext:
				move ctmp, 0
				add rtmp, rtmp, 1
				b forr		
	bnext:	
		bne check, chval, false
		move check, 0
		move rtmp, 0
		move ctmp, 0
		add coff, coff, 3
		bgt coff, 6, biter
		b parsebox
	biter:
		move coff, 0
		add roff, roff, 3
		bgt roff, 6, true
		b parsebox
	true:
			puts valid
			b end
	false:
			puts inval
	end:
done
