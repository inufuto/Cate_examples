cseg
CharPattern: public CharPattern
;   ascii
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
;	wall
	defb	0aah, 55h, 0aah, 55h, 0aah, 55h, 0aah, 55h
;	knife
	defb	00h, 00h, 04h, 7fh, 3fh, 04h, 00h, 00h
	defb	00h, 00h, 20h, 0feh, 0fch, 20h, 00h, 00h
	defb	00h, 08h, 18h, 18h, 18h, 3ch, 18h, 18h
	defb	18h, 18h, 3ch, 18h, 18h, 18h, 10h, 00h
;	16dot
	defb	07h, 08h, 10h, 15h, 15h, 10h, 08h, 1fh
	defb	80h, 40h, 20h, 20h, 20h, 20h, 40h, 0e0h
	defb	20h, 48h, 48h, 3bh, 13h, 13h, 13h, 0ch
	defb	10h, 48h, 48h, 70h, 20h, 20h, 20h, 0c0h
	defb	07h, 08h, 10h, 15h, 15h, 10h, 08h, 07h
	defb	80h, 40h, 20h, 20h, 20h, 20h, 40h, 0e0h
	defb	38h, 48h, 48h, 38h, 11h, 22h, 24h, 18h
	defb	10h, 48h, 48h, 0f0h, 10h, 90h, 60h, 00h
	defb	07h, 08h, 10h, 15h, 15h, 10h, 08h, 07h
	defb	80h, 40h, 20h, 20h, 20h, 20h, 40h, 0c0h
	defb	06h, 08h, 08h, 0fh, 09h, 09h, 09h, 07h
	defb	40h, 40h, 0c0h, 40h, 40h, 40h, 40h, 80h
	defb	07h, 08h, 10h, 15h, 15h, 10h, 08h, 07h
	defb	80h, 40h, 20h, 20h, 20h, 20h, 40h, 0e0h
	defb	38h, 40h, 42h, 3ch, 0ah, 11h, 22h, 1ch
	defb	50h, 48h, 48h, 70h, 10h, 10h, 0e0h, 00h
	defb	07h, 08h, 10h, 15h, 15h, 10h, 08h, 07h
	defb	80h, 40h, 20h, 20h, 20h, 20h, 40h, 0c0h
	defb	06h, 08h, 08h, 0fh, 0ah, 0ah, 0ah, 07h
	defb	40h, 40h, 0c0h, 40h, 40h, 40h, 40h, 80h
	defb	01h, 02h, 04h, 04h, 04h, 04h, 02h, 07h
	defb	0e0h, 10h, 08h, 0a8h, 0a8h, 08h, 10h, 0f8h
	defb	08h, 12h, 12h, 0eh, 04h, 04h, 04h, 03h
	defb	04h, 12h, 12h, 0dch, 0c8h, 0c8h, 0c8h, 30h
	defb	01h, 02h, 04h, 04h, 04h, 04h, 02h, 07h
	defb	0e0h, 10h, 08h, 0a8h, 0a8h, 08h, 10h, 0e0h
	defb	08h, 12h, 12h, 0fh, 08h, 09h, 06h, 00h
	defb	1ch, 12h, 12h, 1ch, 88h, 44h, 24h, 18h
	defb	01h, 02h, 04h, 04h, 04h, 04h, 02h, 03h
	defb	0e0h, 10h, 08h, 0a8h, 0a8h, 08h, 10h, 0e0h
	defb	02h, 02h, 03h, 02h, 02h, 02h, 02h, 01h
	defb	60h, 10h, 10h, 0f0h, 90h, 90h, 90h, 0e0h
	defb	01h, 02h, 04h, 04h, 04h, 04h, 02h, 07h
	defb	0e0h, 10h, 08h, 0a8h, 0a8h, 08h, 10h, 0e0h
	defb	0ah, 12h, 12h, 0eh, 08h, 08h, 07h, 00h
	defb	1ch, 02h, 42h, 3ch, 50h, 88h, 44h, 38h
	defb	01h, 02h, 04h, 04h, 04h, 04h, 02h, 03h
	defb	0e0h, 10h, 08h, 0a8h, 0a8h, 08h, 10h, 0e0h
	defb	02h, 02h, 03h, 02h, 02h, 02h, 02h, 01h
	defb	60h, 10h, 10h, 0f0h, 50h, 50h, 50h, 0e0h
	defb	00h, 00h, 00h, 3dh, 43h, 99h, 81h, 99h
	defb	00h, 60h, 90h, 1eh, 71h, 01h, 1eh, 1eh
	defb	81h, 43h, 3dh, 00h, 00h, 00h, 00h, 00h
	defb	01h, 71h, 1eh, 90h, 60h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3ch, 42h, 99h, 81h, 99h
	defb	00h, 60h, 96h, 99h, 0f1h, 02h, 04h, 08h
	defb	81h, 43h, 3dh, 00h, 00h, 00h, 00h, 00h
	defb	14h, 72h, 12h, 9ch, 60h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3ch, 42h, 99h, 81h, 99h
	defb	00h, 00h, 00h, 00h, 7eh, 91h, 91h, 1fh
	defb	81h, 43h, 3ch, 00h, 00h, 00h, 00h, 00h
	defb	21h, 0feh, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3ch, 42h, 99h, 81h, 99h
	defb	00h, 60h, 92h, 95h, 99h, 11h, 2ah, 04h
	defb	81h, 43h, 3dh, 00h, 00h, 00h, 00h, 00h
	defb	02h, 0f2h, 12h, 9ch, 60h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3ch, 42h, 99h, 81h, 99h
	defb	00h, 00h, 00h, 00h, 7eh, 91h, 9fh, 11h
	defb	81h, 43h, 3ch, 00h, 00h, 00h, 00h, 00h
	defb	21h, 0feh, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 3dh, 43h, 81h
	defb	00h, 00h, 00h, 60h, 90h, 1eh, 71h, 01h
	defb	99h, 81h, 99h, 43h, 3dh, 00h, 00h, 00h
	defb	1eh, 1eh, 01h, 71h, 1eh, 90h, 60h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 3dh, 43h, 81h
	defb	00h, 00h, 00h, 60h, 9ch, 12h, 72h, 14h
	defb	99h, 81h, 99h, 42h, 3ch, 00h, 00h, 00h
	defb	08h, 04h, 02h, 0f1h, 99h, 96h, 60h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 3ch, 43h, 81h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0feh, 21h
	defb	99h, 81h, 99h, 42h, 3ch, 00h, 00h, 00h
	defb	1fh, 91h, 91h, 7eh, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 3dh, 43h, 81h
	defb	00h, 00h, 00h, 60h, 9ch, 12h, 0f2h, 02h
	defb	99h, 81h, 99h, 42h, 3ch, 00h, 00h, 00h
	defb	04h, 2ah, 11h, 99h, 95h, 92h, 60h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 3ch, 43h, 81h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0feh, 21h
	defb	99h, 81h, 99h, 42h, 3ch, 00h, 00h, 00h
	defb	11h, 9fh, 91h, 7eh, 00h, 00h, 00h, 00h
	defb	03h, 04h, 04h, 04h, 0eh, 12h, 12h, 08h
	defb	30h, 0c8h, 0c8h, 0c8h, 0dch, 12h, 12h, 04h
	defb	07h, 02h, 04h, 04h, 04h, 04h, 02h, 01h
	defb	0f8h, 10h, 08h, 0a8h, 0a8h, 08h, 10h, 0e0h
	defb	00h, 06h, 09h, 78h, 8eh, 80h, 78h, 78h
	defb	00h, 00h, 00h, 0bch, 0c2h, 99h, 81h, 99h
	defb	80h, 8eh, 78h, 09h, 06h, 00h, 00h, 00h
	defb	81h, 0c2h, 0bch, 00h, 00h, 00h, 00h, 00h
	defb	38h, 44h, 9ah, 9ah, 9ah, 42h, 24h, 13h
	defb	1ch, 22h, 59h, 59h, 59h, 42h, 24h, 0c8h
	defb	0ch, 10h, 20h, 46h, 49h, 80h, 9eh, 61h
	defb	30h, 08h, 04h, 62h, 92h, 01h, 79h, 86h
	defb	03h, 0ch, 10h, 20h, 2ch, 52h, 56h, 4ch
	defb	0c0h, 30h, 08h, 04h, 34h, 4ah, 6ah, 32h
	defb	40h, 4dh, 2ah, 28h, 27h, 40h, 8eh, 71h
	defb	02h, 0b2h, 54h, 14h, 0e4h, 02h, 71h, 8eh
	defb	00h, 3fh, 20h, 20h, 20h, 20h, 20h, 20h
	defb	00h, 0fch, 04h, 04h, 04h, 04h, 14h, 2ch
	defb	20h, 20h, 20h, 20h, 20h, 20h, 3fh, 00h
	defb	2ch, 14h, 04h, 04h, 04h, 04h, 0fch, 00h
	defb	00h, 00h, 02h, 10h, 0ah, 05h, 2bh, 07h
	defb	00h, 80h, 0a0h, 84h, 0a8h, 0d0h, 0eah, 0f0h
	defb	7fh, 07h, 2bh, 05h, 0ah, 10h, 02h, 00h
	defb	0ffh, 0f0h, 0eah, 0d0h, 0a8h, 84h, 0a0h, 80h
;	title
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
