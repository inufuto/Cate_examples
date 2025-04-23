    cseg
AsciiPattern: public AsciiPattern
	defb 000H,000H,000H,000H,000H,000H,000H,000H
	defb 018H,018H,018H,018H,018H,000H,018H,000H
	defb 036H,036H,036H,000H,000H,000H,000H,000H
	defb 006H,037H,03eH,077H,03eH,076H,030H,000H
	defb 008H,03fH,048H,03eH,009H,07eH,008H,000H
	defb 000H,032H,054H,068H,016H,02aH,04cH,000H
	defb 038H,06cH,06cH,038H,06bH,066H,03bH,000H
	defb 00cH,018H,030H,000H,000H,000H,000H,000H
	defb 00cH,018H,030H,030H,030H,018H,00cH,000H
	defb 030H,018H,00cH,00cH,00cH,018H,030H,000H
	defb 008H,02aH,01cH,07fH,01cH,02aH,008H,000H
	defb 000H,018H,018H,07eH,018H,018H,000H,000H
	defb 000H,000H,000H,000H,018H,018H,030H,000H
	defb 000H,000H,000H,07eH,000H,000H,000H,000H
	defb 000H,000H,000H,000H,000H,018H,018H,000H
	defb 000H,003H,006H,00cH,018H,030H,060H,000H
	defb 03eH,063H,067H,06bH,073H,063H,03eH,000H
	defb 018H,078H,018H,018H,018H,018H,07eH,000H
	defb 03eH,063H,007H,01eH,03cH,070H,07fH,000H
	defb 03eH,063H,003H,01eH,003H,063H,03eH,000H
	defb 006H,00eH,01eH,036H,066H,07fH,006H,000H
	defb 07fH,060H,07eH,003H,003H,063H,03eH,000H
	defb 01eH,030H,060H,07eH,063H,063H,03eH,000H
	defb 07fH,063H,006H,00cH,018H,018H,018H,000H
	defb 03eH,063H,063H,03eH,063H,063H,03eH,000H
	defb 03eH,063H,063H,03fH,003H,063H,03eH,000H
	defb 000H,000H,018H,000H,000H,018H,000H,000H
	defb 000H,000H,018H,000H,000H,018H,030H,000H
	defb 00cH,018H,030H,060H,030H,018H,00cH,000H
	defb 000H,000H,07eH,000H,07eH,000H,000H,000H
	defb 030H,018H,00cH,006H,00cH,018H,030H,000H
	defb 03eH,063H,003H,00eH,018H,000H,018H,000H
	defb 01eH,021H,04dH,055H,04eH,020H,01eH,000H
	defb 01cH,036H,063H,063H,07fH,063H,063H,000H
	defb 07eH,063H,063H,07eH,063H,063H,07eH,000H
	defb 01eH,033H,060H,060H,060H,033H,01eH,000H
	defb 07cH,066H,063H,063H,063H,066H,07cH,000H
	defb 07eH,060H,060H,07eH,060H,060H,07eH,000H
	defb 07eH,060H,060H,07eH,060H,060H,060H,000H
	defb 01eH,033H,060H,06fH,063H,033H,01fH,000H
	defb 063H,063H,063H,07fH,063H,063H,063H,000H
	defb 07eH,018H,018H,018H,018H,018H,07eH,000H
	defb 006H,006H,006H,006H,006H,066H,03cH,000H
	defb 063H,066H,06cH,078H,06cH,066H,063H,000H
	defb 060H,060H,060H,060H,060H,060H,07eH,000H
	defb 07eH,06bH,06bH,06bH,06bH,06bH,06bH,000H
	defb 063H,073H,07bH,07fH,06fH,067H,063H,000H
	defb 03eH,063H,063H,063H,063H,063H,03eH,000H
	defb 07eH,063H,063H,063H,07eH,060H,060H,000H
	defb 03eH,063H,063H,063H,06bH,066H,03bH,000H
	defb 07eH,063H,063H,067H,07cH,06eH,067H,000H
	defb 03eH,063H,060H,03eH,003H,063H,03eH,000H
	defb 07eH,018H,018H,018H,018H,018H,018H,000H
	defb 063H,063H,063H,063H,063H,063H,03eH,000H
	defb 063H,063H,063H,036H,036H,01cH,01cH,000H
	defb 063H,06bH,06bH,06bH,06bH,06bH,07eH,000H
	defb 063H,063H,036H,01cH,036H,063H,063H,000H
	defb 066H,066H,066H,03cH,018H,018H,018H,000H
	defb 07fH,006H,00cH,018H,030H,060H,07fH,000H
	defb 03cH,020H,020H,020H,020H,020H,03cH,000H
	defb 022H,022H,014H,03eH,008H,03eH,008H,000H
	defb 03cH,004H,004H,004H,004H,004H,03cH,000H
	defb 008H,014H,022H,000H,000H,000H,000H,000H
	defb 000H,000H,000H,000H,000H,000H,07eH,000H

ManPattern: public ManPattern
;	man
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 0fh
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 0c0h
	defb	1fh, 37h, 37h, 04h, 0ch, 0ch, 0ch, 0ch
	defb	0e0h, 0b0h, 0b0h, 80h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 03h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0f0h
	defb	07h, 0dh, 0dh, 01h, 03h, 03h, 03h, 03h
	defb	0f8h, 0ech, 0ech, 20h, 30h, 30h, 30h, 30h
	defb	00h, 00h, 00h, 00h, 3dh, 67h, 7fh, 67h
	defb	00h, 00h, 60h, 0e0h, 8fh, 0ffh, 0e0h, 0e0h
	defb	7fh, 3dh, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 8fh, 0e0h, 60h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3dh, 7fh
	defb	00h, 00h, 00h, 00h, 60h, 0e0h, 8fh, 0ffh
	defb	67h, 7fh, 67h, 3dh, 00h, 00h, 00h, 00h
	defb	0e0h, 0e0h, 0ffh, 8fh, 0e0h, 60h, 00h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	07h, 37h, 37h, 07h, 0eh, 1ch, 38h, 10h
	defb	0e0h, 0f0h, 0b0h, 00h, 0e0h, 0e0h, 00h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	03h, 03h, 07h, 06h, 00h, 06h, 06h, 06h
	defb	00h, 00h, 00h, 00h, 80h, 80h, 80h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	07h, 1eh, 1dh, 03h, 05h, 0eh, 1ch, 08h
	defb	0a0h, 0b0h, 0b0h, 80h, 0f0h, 70h, 00h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	03h, 03h, 07h, 06h, 00h, 05h, 05h, 04h
	defb	00h, 00h, 00h, 00h, 80h, 80h, 80h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	07h, 0fh, 0dh, 00h, 07h, 07h, 00h, 00h
	defb	0e0h, 0ech, 0ech, 0e0h, 70h, 38h, 1ch, 08h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 00h
	defb	0c0h, 0c0h, 0e0h, 60h, 00h, 60h, 60h, 60h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	05h, 0dh, 0dh, 01h, 0fh, 0eh, 00h, 00h
	defb	0e0h, 78h, 0b8h, 0c0h, 0a0h, 70h, 38h, 10h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 00h
	defb	0c0h, 0c0h, 0e0h, 60h, 00h, 0a0h, 0a0h, 20h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 62h, 67h, 0eh, 0fch, 0f8h, 0f0h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ech, 0cch, 0ech, 60h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 00h, 00h, 00h, 37h, 0f7h, 0e0h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0eh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 00h, 62h, 67h, 0eeh, 0d4h, 0b8h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f8h, 0ch, 0ech, 6ch, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 00h, 00h, 00h, 37h, 0f0h, 0e6h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0eh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 60h, 0ech, 0cch, 0ech
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	0f0h, 0f8h, 0fch, 0eh, 67h, 62h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0eh
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	0e0h, 0f7h, 37h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 6ch, 0ech, 0ch, 0f8h
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	0b8h, 0d4h, 0eeh, 67h, 62h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0eh
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	0e6h, 0f0h, 37h, 00h, 00h, 00h, 00h, 00h
	defb	03h, 03h, 03h, 03h, 01h, 0dh, 0dh, 07h
	defb	30h, 30h, 30h, 30h, 20h, 0ech, 0ech, 0f8h
	defb	03h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	0f0h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 00h, 06h, 07h, 0f1h, 0ffh, 07h, 07h
	defb	00h, 00h, 00h, 00h, 0bch, 0e6h, 0feh, 0e6h
	defb	0ffh, 0f1h, 07h, 06h, 00h, 00h, 00h, 00h
	defb	0feh, 0bch, 00h, 00h, 00h, 00h, 00h, 00h

MonPattern: public MonPattern
	; monster
	defb 0h, 0h, 11h, 88h, 33h, 0cch, 66h, 66h, 66h, 66h, 66h, 66h, 33h, 0cch, 11h, 0cch
	defb 0h, 0h, 11h, 88h, 33h, 0cch, 66h, 66h, 66h, 66h, 66h, 66h, 33h, 0cch, 33h, 88h
	defb 0h, 0b8h, 0h, 70h, 10h, 0f0h, 30h, 90h, 30h, 60h, 70h, 0f0h, 70h, 30h, 60h, 10h
	defb 0d1h, 0h, 0e0h, 0h, 0f0h, 80h, 90h, 0c0h, 60h, 0c0h, 0f0h, 0e0h, 0c0h, 0e0h, 80h, 60h
	defb 0h, 0h, 0h, 30h, 0h, 0f0h, 10h, 0f0h, 10h, 0f0h, 30h, 1eh, 30h, 1eh, 30h, 96h
	defb 0h, 0h, 0c0h, 0h, 0f0h, 0h, 0f0h, 80h, 0f0h, 80h, 87h, 0c0h, 87h, 0c0h, 96h, 0c0h
	defb 30h, 0f0h, 30h, 0a0h, 10h, 80h, 10h, 0c0h, 10h, 0f0h, 30h, 0f0h, 70h, 0b0h, 70h, 10h
	defb 0f0h, 0c0h, 50h, 0c0h, 10h, 80h, 30h, 80h, 0f0h, 80h, 0f0h, 0c0h, 0d0h, 0e0h, 80h, 0e0h

GoalPattern: public GoalPattern
	; goal
	defb	00h, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh
	defb	00h, 0fch, 0fch, 0fch, 0fch, 0fch, 0ech, 0d4h
	defb	3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 00h
	defb	0d4h, 0ech, 0fch, 0fch, 0fch, 0fch, 0fch, 00h
	; bang
	defb	00h, 00h, 02h, 10h, 0ah, 05h, 2bh, 07h
	defb	00h, 80h, 0a0h, 84h, 0a8h, 0d0h, 0eah, 0f0h
	defb	7fh, 07h, 2bh, 05h, 0ah, 10h, 02h, 00h
	defb	0ffh, 0f0h, 0eah, 0d0h, 0a8h, 84h, 0a0h, 80h

KnPattern: public KnPattern
	; knife
	defb	00h, 00h, 04h, 7fh, 3fh, 04h, 00h, 00h
	defb	00h, 00h, 20h, 0feh, 0fch, 20h, 00h, 00h
	defb	00h, 08h, 18h, 18h, 18h, 3ch, 18h, 18h
	defb	18h, 18h, 3ch, 18h, 18h, 18h, 08h, 00h
WallPattern: public WallPattern
	; wall
	defb	0aah, 55h, 0aah, 55h, 0aah, 55h, 0aah, 55h

TitlePattern: public TitlePattern
	; title
	defb	3fh, 3fh, 3ch, 3ch, 3ch, 3ch, 3ch, 3ch
	defb	0fch, 0fch, 0cfh, 0cfh, 0cfh, 0cfh, 0cfh, 0cfh
	defb	3ch, 3ch, 3ch, 3ch, 3ch, 3ch, 00h, 00h
	defb	0cfh, 0cfh, 0cfh, 0cfh, 0cfh, 0cfh, 00h, 00h
	defb	03h, 03h, 0fh, 0fh, 3ch, 3ch, 3ch, 3ch
	defb	0f0h, 0f0h, 3ch, 3ch, 0fh, 0fh, 0fh, 0fh
	defb	3fh, 3fh, 3ch, 3ch, 3ch, 3ch, 00h, 00h
	defb	0ffh, 0ffh, 0fh, 0fh, 0fh, 0fh, 00h, 00h
	defb	3fh, 3fh, 00h, 00h, 00h, 00h, 03h, 03h
	defb	0ffh, 0ffh, 3ch, 3ch, 0f0h, 0f0h, 0c0h, 0c0h
	defb	0fh, 0fh, 3ch, 3ch, 3fh, 3fh, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 00h, 00h
	defb	3ch, 3ch, 3ch, 3ch, 3ch, 3ch, 0ch, 0ch
	defb	3ch, 3ch, 3ch, 3ch, 3ch, 3ch, 30h, 30h
	defb	03h, 03h, 03h, 03h, 03h, 03h, 00h, 00h
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 00h, 00h
