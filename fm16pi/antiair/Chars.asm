cseg
CharPattern: public CharPattern
;   ascii
	defb 000H,000H,000H,000H,000H,000H,000H,000H
	; defb 080H,040H,020H,010H,008H,004H,002H,001H
	; defb 001H,002H,004H,008H,010H,020H,040H,080H
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
;	logo
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0fh, 0fh, 0fh, 0fh
	defb	0fh, 0fh, 0fh, 0fh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
;	8dot
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;	16dot
	defb	01h, 02h, 02h, 04h, 04h, 08h, 08h, 08h
	defb	00h, 80h, 80h, 40h, 40h, 20h, 20h, 20h
	defb	31h, 71h, 0f1h, 0f1h, 0efh, 00h, 0ffh, 7ch
	defb	18h, 1ch, 1eh, 1eh, 0eeh, 00h, 0feh, 7ch
	defb	00h, 7fh, 80h, 0bfh, 0a0h, 0a0h, 0a0h, 0a0h
	defb	00h, 0fch, 02h, 0fah, 0ah, 0ah, 0ah, 0ah
	defb	0a0h, 0a0h, 0a0h, 0a0h, 0a0h, 0bfh, 80h, 7fh
	defb	0ah, 0ah, 0ah, 0ah, 0ah, 0fah, 02h, 0fch
	defb	00h, 0e1h, 0f3h, 7dh, 39h, 11h, 10h, 20h
	defb	00h, 0eh, 9eh, 7ch, 78h, 10h, 10h, 08h
	defb	20h, 35h, 20h, 20h, 10h, 10h, 0ch, 03h
	defb	08h, 58h, 08h, 08h, 10h, 10h, 60h, 80h
	defb	00h, 01h, 02h, 02h, 05h, 0fh, 1fh, 3fh
	defb	00h, 0c0h, 34h, 02h, 08h, 80h, 40h, 0a0h
	defb	7fh, 7fh, 7fh, 7fh, 7fh, 3fh, 1fh, 0fh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	; ufo 20
	; A45
	defb 0a0h,0a0h,0a0h,0a0h,0a0h,0bfh,80h,7fh
	defb 0a8h,28h,0a8h,0a8h,0a8h,2fh,20h,1fh
	defb 0eah,0cah,6ah,6ah,2ah,0bh,08h,07h
	defb 3ah,32h,1ah,1ah,0ah,02h,02h,01h
	; A56
	defb 0ah,0ah,0ah,0ah,0ah,0fah,02h,0fch
	defb 02h,02h,02h,02h,02h,0feh,00h,0ffh
	defb 00h,00h,00h,00h,00h,0ffh,00h,0ffh
	defb 80h,80h,80h,80h,80h,0ffh,00h,0ffh
	; A67
	defb 0e0h,60h,0c0h,0c0h,80h,00h,00h,00h
	defb 0b8h,98h,0b0h,0b0h,0a0h,80h,80h,00h
	defb 0aeh,0a6h,0ach,0ach,0a8h,0a0h,20h,0c0h
	defb 2bh,29h,2bh,2bh,2ah,0e8h,08h,0f0h
	; B45
	defb 20h,35h,20h,20h,10h,10h,0ch,03h
	defb 88h,0dh,88h,88h,84h,04h,03h,00h
	defb 0e2h,0c3h,62h,62h,21h,01h,00h,00h
	defb 38h,30h,18h,18h,08h,00h,00h,00h
	; B56
	defb 08h,58h,08h,08h,10h,10h,60h,80h
	defb 02h,56h,02h,02h,04h,04h,18h,0e0h
	defb 00h,55h,00h,00h,01h,01h,0c6h,38h
	defb 80h,0d5h,80h,80h,40h,40h,31h,0eh
	; B67
	defb 0e0h,60h,0c0h,0c0h,80h,00h,00h,00h
	defb 38h,18h,30h,30h,20h,00h,00h,00h
	defb 8eh,86h,8ch,8ch,08h,00h,00h,00h
	defb 23h,61h,23h,23h,42h,40h,80h,00h
	; C45
	defb 7fh,7fh,7fh,7fh,7fh,3fh,1fh,0fh
	defb 9fh,1fh,9fh,9fh,9fh,0fh,07h,03h
	defb 0e7h,0c7h,67h,67h,27h,03h,01h,00h
	defb 39h,31h,19h,19h,09h,00h,00h,00h
	; C56
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0e0h,0c0h,80h
	defb 0fch,0fch,0fch,0fch,0fch,0f8h,0f0h,0e0h
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0fch,0f8h
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,7fh,3eh
	; C67
	defb 0e0h,60h,0c0h,0c0h,80h,00h,00h,00h
	defb 38h,18h,30h,30h,20h,00h,00h,00h
	defb 0eh,06h,0ch,0ch,08h,00h,00h,00h
	defb 0c3h,0c1h,0c3h,0c3h,0c2h,80h,00h,00h
	; O01
	defb 3fh,0c0h,02h,02h,02h,00h,0ffh,00h
	defb 0fh,70h,80h,00h,00h,00h,0ffh,80h
	defb 03h,1ch,60h,80h,00h,0c0h,7fh,60h
	defb 00h,07h,18h,20h,40h,30h,1fh,18h
	; O12
	defb 0f8h,07h,80h,80h,80h,00h,0ffh,00h
	defb 0feh,01h,0a0h,0a0h,0a0h,00h,0ffh,00h
	defb 0ffh,00h,28h,28h,28h,00h,0ffh,00h
	defb 0ffh,00h,0ah,0ah,0ah,00h,0ffh,00h
	; O23
	defb 00h,00h,0c0h,20h,10h,60h,0c0h,0c0h
	defb 00h,0c0h,30h,08h,04h,18h,0f0h,30h
	defb 80h,70h,0ch,02h,01h,06h,0fch,0ch
	defb 0e0h,1ch,03h,00h,00h,01h,0ffh,03h
	; O30
	defb 00h,01h,06h,08h,10h,0ch,07h,06h
	defb 00h,00h,01h,02h,04h,03h,01h,01h
	defb 00h,00h,00h,00h,01h,00h,00h,00h
	defb 00h,00h,00h,80h,40h,80h,00h,00h
	; O3S
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,80h,40h,80h,00h,00h
	; O45
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 80h,00h,80h,80h,80h,00h,00h,00h
	defb 0e0h,0c0h,60h,60h,20h,00h,00h,00h
	defb 38h,30h,18h,18h,08h,00h,00h,00h
	; O67
	defb 0e0h,60h,0c0h,0c0h,80h,00h,00h,00h
	defb 38h,18h,30h,30h,20h,00h,00h,00h
	defb 0eh,06h,0ch,0ch,08h,00h,00h,00h
	defb 03h,01h,03h,03h,02h,00h,00h,00h
	; O74
	defb 0eh,0ch,06h,06h,02h,00h,00h,00h
	defb 03h,03h,01h,01h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 80h,80h,00h,00h,00h,00h,00h,00h
	; O7S
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 80h,80h,00h,00h,00h,00h,00h,00h
	; OS0
	defb 00h,01h,06h,08h,10h,0ch,07h,06h
	defb 00h,00h,01h,02h,04h,03h,01h,01h
	defb 00h,00h,00h,00h,01h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	; OS4
	defb 0eh,0ch,06h,06h,02h,00h,00h,00h
	defb 03h,03h,01h,01h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h

SpritePattern: public SpritePattern
;	sprite
	defb	01h, 01h, 00h, 00h, 03h, 02h, 80h, 80h
	defb	03h, 02h, 80h, 80h, 07h, 04h, 0c0h, 40h
	defb	07h, 04h, 0c0h, 40h, 0fh, 08h, 0e0h, 20h
	defb	0fh, 08h, 0e0h, 20h, 0fh, 08h, 0e0h, 20h
	defb	3fh, 31h, 0f8h, 18h, 7fh, 71h, 0fch, 1ch
	defb	0ffh, 0f1h, 0feh, 1eh, 0ffh, 0f1h, 0feh, 1eh
	defb	0efh, 0efh, 0eeh, 0eeh, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0feh, 0feh, 7ch, 7ch, 7ch, 7ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0feh, 0feh, 7ch, 7ch, 7ch, 7ch
	defb	01h, 01h, 00h, 00h, 03h, 02h, 80h, 80h
	defb	03h, 02h, 80h, 80h, 07h, 04h, 0c0h, 40h
	defb	07h, 04h, 0c0h, 40h, 0fh, 08h, 0e0h, 20h
	defb	0fh, 08h, 0e0h, 20h, 0fh, 08h, 0e0h, 20h
	defb	3fh, 31h, 0f8h, 18h, 7fh, 71h, 0fch, 1ch
	defb	0ffh, 0f1h, 0feh, 1eh, 0ffh, 0f1h, 0feh, 1eh
	defb	0efh, 0efh, 0eeh, 0eeh, 07h, 04h, 0c0h, 40h
	defb	03h, 02h, 80h, 80h, 01h, 01h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 7fh, 7fh, 0fch, 0fch
	defb	0ffh, 80h, 0feh, 02h, 0ffh, 0bfh, 0feh, 0fah
	defb	0ffh, 0a0h, 0feh, 0ah, 0ffh, 0a0h, 0feh, 0ah
	defb	0ffh, 0a0h, 0feh, 0ah, 0ffh, 0a0h, 0feh, 0ah
	defb	0ffh, 0a0h, 0feh, 0ah, 0ffh, 0a0h, 0feh, 0ah
	defb	0ffh, 0a0h, 0feh, 0ah, 0ffh, 0a0h, 0feh, 0ah
	defb	0ffh, 0a0h, 0feh, 0ah, 0ffh, 0bfh, 0feh, 0fah
	defb	0ffh, 80h, 0feh, 02h, 7fh, 7fh, 0fch, 0fch
	defb	00h, 00h, 00h, 00h, 0e1h, 0e1h, 0eh, 0eh
	defb	0f3h, 0f3h, 9eh, 9eh, 7fh, 7dh, 0fch, 7ch
	defb	3fh, 39h, 0f8h, 78h, 1fh, 11h, 0f0h, 10h
	defb	1fh, 10h, 0f0h, 10h, 3fh, 20h, 0f8h, 08h
	defb	3fh, 20h, 0f8h, 08h, 3fh, 35h, 0f8h, 58h
	defb	3fh, 20h, 0f8h, 08h, 3fh, 20h, 0f8h, 08h
	defb	1fh, 10h, 0f0h, 10h, 1fh, 10h, 0f0h, 10h
	defb	0fh, 0ch, 0e0h, 60h, 03h, 03h, 80h, 80h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 0c0h, 0c0h
	defb	02h, 02h, 34h, 34h, 02h, 02h, 02h, 02h
	defb	07h, 05h, 08h, 08h, 0fh, 0fh, 80h, 80h
	defb	1fh, 1fh, 0c0h, 40h, 3fh, 3fh, 0e0h, 0a0h
	defb	7fh, 7fh, 0f0h, 0f0h, 7fh, 7fh, 0f0h, 0f0h
	defb	7fh, 7fh, 0f0h, 0f0h, 7fh, 7fh, 0f0h, 0f0h
	defb	7fh, 7fh, 0f0h, 0f0h, 3fh, 3fh, 0e0h, 0e0h
	defb	1fh, 1fh, 0c0h, 0c0h, 0fh, 0fh, 80h, 80h
	defb	01h, 01h, 04h, 04h, 21h, 21h, 9ch, 9ch
	defb	33h, 33h, 0f8h, 0f8h, 3fh, 3eh, 0f9h, 0f9h
	defb	3fh, 24h, 0ffh, 6fh, 0ffh, 0e1h, 0feh, 0eh
	defb	7fh, 77h, 0fch, 9ch, 3fh, 3bh, 0f8h, 0b8h
	defb	1fh, 1bh, 0fch, 0dch, 3fh, 30h, 0ffh, 0cfh
	defb	0ffh, 0e2h, 0feh, 0eh, 7fh, 6eh, 0f8h, 48h
	defb	3fh, 3eh, 0fch, 0ech, 1bh, 1bh, 0fch, 0fch
	defb	11h, 11h, 8ch, 8ch, 01h, 01h, 00h, 00h
	defb	00h, 00h, 02h, 02h, 00h, 00h, 07h, 07h
	defb	08h, 08h, 07h, 07h, 0eh, 0eh, 0fh, 0fh
	defb	07h, 07h, 9fh, 9dh, 07h, 07h, 0ffh, 0fch
	defb	07h, 06h, 0ffh, 78h, 03h, 03h, 0ffh, 38h
	defb	03h, 03h, 0ffh, 12h, 1fh, 1fh, 0ffh, 82h
	defb	0ffh, 0f3h, 0ffh, 9fh, 7fh, 78h, 0ffh, 3bh
	defb	3fh, 3eh, 0ffh, 79h, 1fh, 1fh, 0ffh, 19h
	defb	0fh, 0fh, 0ffh, 98h, 07h, 06h, 0ffh, 30h
	defb	00h, 00h, 60h, 60h, 00h, 00h, 0e0h, 0e0h
	defb	01h, 01h, 0c0h, 0c0h, 87h, 87h, 0c0h, 0c0h
	defb	8fh, 8fh, 0c0h, 0c0h, 0dfh, 0dfh, 80h, 80h
	defb	0ffh, 0fdh, 8eh, 8eh, 0ffh, 79h, 0bch, 0bch
	defb	0ffh, 71h, 0f8h, 0f8h, 0ffh, 25h, 0f8h, 0f8h
	defb	0ffh, 0ch, 0f0h, 30h, 0ffh, 9ch, 0e0h, 0e0h
	defb	0ffh, 0f8h, 0c0h, 0c0h, 0ffh, 19h, 0c0h, 0c0h
	defb	0ffh, 11h, 0e0h, 0e0h, 0ffh, 38h, 0f0h, 0f0h
	defb	07h, 04h, 0ffh, 64h, 0fh, 09h, 0ffh, 0ceh
	defb	3fh, 39h, 0ffh, 9eh, 7fh, 73h, 0ffh, 0ffh
	defb	0ffh, 0e0h, 0ffh, 7dh, 7fh, 7fh, 0ffh, 21h
	defb	3fh, 3fh, 0ffh, 61h, 0fh, 0eh, 0ffh, 1ch
	defb	07h, 06h, 0ffh, 7ch, 03h, 02h, 0efh, 0eeh
	defb	03h, 03h, 0cfh, 0ceh, 03h, 03h, 07h, 06h
	defb	02h, 02h, 07h, 07h, 00h, 00h, 03h, 03h
	defb	00h, 00h, 03h, 03h, 00h, 00h, 02h, 02h
	defb	0ffh, 7fh, 0f8h, 38h, 0ffh, 60h, 0fch, 0ch
	defb	0ffh, 0f0h, 0feh, 0feh, 0ffh, 0f3h, 0ffh, 0ffh
	defb	0ffh, 9bh, 0f0h, 0f0h, 0ffh, 09h, 80h, 80h
	defb	0ffh, 21h, 80h, 80h, 0ffh, 38h, 0c0h, 0c0h
	defb	0ffh, 7ch, 0c0h, 0c0h, 0ffh, 0ffh, 0c0h, 0c0h
	defb	0e3h, 0e3h, 0e0h, 0e0h, 0c1h, 0c1h, 0e0h, 0e0h
	defb	80h, 80h, 60h, 60h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
