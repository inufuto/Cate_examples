cseg

MonoPattern_: public MonoPattern_
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

ColorPattern_: public ColorPattern_
	; 8dot
	defb 5ah, 5ah, 0a5h, 0a5h, 5ah, 5ah, 0a5h, 0a5h, 5ah, 5ah, 0a5h, 0a5h, 5ah, 5ah, 0a5h, 0a5h
	defb 0h, 10h, 0h, 21h, 0h, 12h, 0h, 25h, 0h, 5ah, 1h, 0a5h, 12h, 5ah, 0a5h, 0a5h
	defb 0h, 0h, 80h, 0h, 4ah, 0h, 0a5h, 0h, 5ah, 8h, 0a5h, 84h, 5ah, 48h, 0a5h, 0a4h
	defb 66h, 0h, 0ffh, 0h, 0ffh, 0h, 66h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 66h, 0h, 0ffh, 0h, 0ffh, 0h, 66h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 66h, 0h, 0ffh, 0h, 0ffh, 0h, 66h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 66h, 0h, 0ffh, 0h, 0ffh, 0h, 66h
	defb 42h, 0h, 0a5h, 0h, 5ah, 0h, 24h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 42h, 0h, 0a5h, 0h, 5ah, 0h, 24h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 42h, 0h, 0a5h, 0h, 5ah, 0h, 24h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 42h, 0h, 0a5h, 0h, 5ah, 0h, 24h
	; 16dot
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 66h, 11h, 66h, 33h, 77h, 55h, 77h, 0ffh
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0cch, 0h, 22h, 0h, 22h, 22h, 0ffh, 0aah
	defb 77h, 0ffh, 33h, 0cch, 0h, 0bbh, 0h, 33h, 0h, 11h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0ffh, 0bbh, 33h, 0bbh, 0ddh, 0aah, 0cch, 22h, 88h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 44h, 0h, 0eeh, 11h, 0cch, 33h, 0cch, 33h, 0ddh, 11h, 0eeh, 11h, 0ffh, 0h, 33h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0cch, 0h, 0eeh, 0h, 99h, 0h, 99h, 0h
	defb 0h, 0ddh, 0h, 0eeh, 0h, 0eeh, 0h, 66h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0eeh, 0h, 0eeh, 0h, 0ffh, 66h, 0eeh, 0cch, 55h, 88h, 33h, 88h, 66h, 0h, 44h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0h, 44h, 0h, 0cch, 0h, 0ffh
	defb 0h, 0h, 22h, 0h, 33h, 0h, 11h, 0cch, 22h, 0cch, 0ffh, 66h, 0ffh, 0bbh, 0ffh, 0h
	defb 0h, 0bbh, 44h, 77h, 0ffh, 0eeh, 77h, 0eeh, 33h, 0eeh, 11h, 88h, 0h, 0h, 0h, 0h
	defb 88h, 0h, 77h, 0h, 0ffh, 0h, 0eeh, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 30h, 0h, 40h, 40h, 40h, 50h, 0f0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 80h, 60h, 0c0h, 60h, 0a0h, 0e0h, 0f0h, 0e0h
	defb 0d0h, 0f0h, 0d0h, 0c0h, 50h, 0b0h, 40h, 30h, 0h, 10h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0f0h, 0e0h, 30h, 0c0h, 0d0h, 0h, 0c0h, 0h, 80h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 60h, 10h, 60h, 30h, 70h, 50h, 70h, 0f0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0c0h, 0h, 20h, 0h, 20h, 20h, 0f0h, 0a0h
	defb 70h, 0f0h, 30h, 0c0h, 0h, 0b0h, 0h, 30h, 0h, 10h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0f0h, 0b0h, 30h, 0b0h, 0d0h, 0a0h, 0c0h, 20h, 80h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 2h, 0h, 7h, 0h, 0fh, 1h, 0fh, 0h, 0fh, 0h, 7h, 7h, 0bh, 9h, 9h
	defb 0h, 0h, 0h, 0h, 8h, 0h, 0ch, 0h, 0eh, 0h, 0fh, 0h, 0eh, 8h, 0dh, 0ch
	defb 9h, 8h, 0fh, 8h, 0fh, 0eh, 8h, 0h, 7h, 0fh, 3bh, 0h, 8h, 11h, 7h, 0fh
	defb 0bh, 0ch, 16h, 84h, 1eh, 84h, 0h, 0h, 0fh, 0eh, 0h, 0cdh, 88h, 1h, 0fh, 0eh
	defb 0h, 11h, 0h, 33h, 0h, 33h, 0h, 77h, 0h, 77h, 0h, 77h, 0h, 88h, 0h, 0ffh
	defb 88h, 0h, 0cch, 0h, 0cch, 0h, 0eeh, 0h, 0eeh, 0h, 0eeh, 0h, 11h, 0h, 0ffh, 0h
	defb 0h, 0ffh, 0h, 0ffh, 0h, 0ffh, 10h, 0feh, 30h, 0feh, 70h, 0feh, 0f0h, 0feh, 0e0h, 76h
	defb 0ffh, 0h, 0ffh, 0h, 0ffh, 0h, 0f7h, 80h, 0f7h, 0c0h, 0f7h, 0e0h, 0f7h, 0f0h, 0e6h, 70h
	defb 0h, 10h, 20h, 10h, 30h, 30h, 30h, 0e0h, 20h, 40h, 0e0h, 1h, 70h, 52h, 30h, 0a1h
	defb 0h, 40h, 90h, 0c0h, 0f0h, 80h, 0f0h, 90h, 60h, 0f0h, 0h, 0e0h, 18h, 0c0h, 0b0h, 80h
	defb 10h, 92h, 30h, 0h, 0e0h, 20h, 60h, 0e0h, 30h, 0e0h, 10h, 0b0h, 10h, 10h, 0h, 10h
	defb 58h, 0c0h, 84h, 0f0h, 0h, 0e0h, 40h, 80h, 0e0h, 0c0h, 0f0h, 0c0h, 80h, 0c0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 80h, 0h, 0e0h, 0h, 70h, 0h, 70h, 0h, 60h, 0h, 30h
	defb 0h, 20h, 0h, 70h, 0h, 70h, 0h, 0f0h, 90h, 0d0h, 0f0h, 0c0h, 70h, 80h, 30h, 80h
	defb 0h, 30h, 10h, 0f0h, 0f0h, 30h, 70h, 80h, 30h, 0e0h, 10h, 0f0h, 0h, 0f0h, 0h, 60h
	defb 10h, 2h, 80h, 20h, 90h, 5ah, 21h, 0a1h, 52h, 18h, 1h, 81h, 90h, 8h, 21h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 10h, 80h, 70h, 80h, 0f0h, 0d0h, 0f0h, 0f0h, 0d0h, 70h, 90h
	defb 60h, 0h, 0e0h, 0h, 0c0h, 0h, 0c0h, 0h, 0c0h, 0h, 80h, 0h, 80h, 0e0h, 0b0h, 0c0h
	defb 70h, 10h, 20h, 14h, 0h, 48h, 81h, 84h, 5ah, 8h, 1h, 90h, 10h, 10h, 21h, 80h
	defb 0f0h, 80h, 0f0h, 80h, 30h, 0h, 0e0h, 0h, 0c0h, 0h, 0c0h, 0h, 0e0h, 0h, 0f0h, 0h
	defb 0h, 40h, 0h, 81h, 30h, 90h, 70h, 21h, 0e0h, 0h, 70h, 0f0h, 30h, 0f0h, 0h, 0e0h
	defb 42h, 40h, 84h, 0a4h, 18h, 4ah, 0a5h, 0a5h, 52h, 58h, 20h, 1h, 42h, 10h, 10h, 0c0h
	defb 0h, 60h, 0h, 20h, 0h, 30h, 0h, 30h, 0h, 20h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 70h, 0c0h, 0e0h, 0e0h, 0c0h, 0e0h, 0h, 60h, 0h, 70h, 0h, 30h, 0h, 30h, 0h, 20h
	defb 52h, 5ah, 24h, 0h, 5ah, 0h, 0a5h, 30h, 18h, 38h, 0h, 90h, 20h, 10h, 30h, 80h
	defb 30h, 80h, 0h, 0c0h, 0f0h, 0e0h, 0f0h, 0f0h, 0f0h, 0h, 80h, 0h, 80h, 0h, 0c0h, 0h
	defb 70h, 0c0h, 0f0h, 0f0h, 0e0h, 30h, 0c0h, 10h, 80h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0c0h, 0h, 0c0h, 0h, 0e0h, 0h, 0e0h, 0h, 60h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 3h, 0fh, 7h, 0fh, 0dh, 0bh, 9h, 0bh, 0dh, 0bh
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0fh, 8h, 0fh, 0ch, 4h, 6h, 5h, 0ah, 5h, 0ah
	defb 0dh, 0bh, 0dh, 0bh, 8h, 0ch, 7h, 0fh, 3h, 0fh, 0h, 0h, 0h, 0h, 0h, 0h
	defb 4h, 6h, 5h, 0eh, 0dh, 0eh, 0fh, 0ch, 0fh, 8h, 0h, 0h, 0h, 0h, 0h, 0h
	; fort
	defb 0h, 0h, 0h, 1h, 0h, 7h, 1h, 0fh, 3h, 78h, 16h, 87h, 69h, 0fh, 0fh, 0fh
	defb 3h, 0fh, 0eh, 0fh, 0fh, 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh, 0dh, 0fh, 0dh, 0fh, 0fh
	defb 0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh, 0fh, 7h, 0fh, 0fh, 0fh, 0fh
	defb 0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0fh, 0fh, 0eh, 0fh, 0eh, 0fh, 0eh, 0fh, 0fh, 0fh
	defb 0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh, 0eh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb 0fh, 8h, 0eh, 0eh, 0e1h, 0fh, 1eh, 0c3h, 7h, 3ch, 7h, 0fh, 0fh, 0fh, 0fh, 0fh
	defb 0h, 30h, 0h, 0f0h, 18h, 0f0h, 0eh, 70h, 87h, 28h, 69h, 0ch, 1eh, 86h, 0fh, 0eh
	defb 78h, 0f0h, 0fh, 0fh, 69h, 0fh, 16h, 87h, 3h, 78h, 1h, 0fh, 0h, 7h, 0h, 1h
	defb 0f0h, 0e1h, 0fh, 0fh, 0fh, 0fh, 0fh, 0dh, 0fh, 0dh, 0f0h, 0fh, 0fh, 0f0h, 0eh, 0fh
	defb 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh, 0fh, 7h, 0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0fh, 0fh
	defb 0f0h, 0f0h, 0fh, 0fh, 0eh, 0fh, 0eh, 0fh, 0eh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0fh, 0fh
	defb 0f0h, 0d2h, 0fh, 0fh, 0fh, 0fh, 0eh, 0fh, 0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0fh, 0fh
	defb 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh, 7h, 0fh, 7h, 3ch, 1eh, 0c3h, 0e1h, 0fh, 0eh, 0eh
	defb 0f0h, 0c2h, 0fh, 0eh, 1eh, 86h, 69h, 0ch, 87h, 28h, 0eh, 60h, 18h, 0f0h, 0h, 0f0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 3h, 0fh, 0h, 77h, 0h, 0ffh, 11h, 0ffh, 33h, 0eeh, 0h, 0h, 11h, 0ffh, 11h, 0ffh
	defb 0fh, 0fh, 0bbh, 0ffh, 77h, 0ffh, 77h, 0h, 0ffh, 0ffh, 0h, 0h, 0cch, 33h, 0cch, 33h
	defb 0fh, 0fh, 0ffh, 0ffh, 0ffh, 0ffh, 88h, 99h, 0ffh, 0ffh, 0h, 0h, 0ffh, 0h, 0ffh, 0h
	defb 0fh, 0fh, 0ffh, 0ddh, 0ffh, 0ddh, 0cch, 0eeh, 0ffh, 0eeh, 0h, 0h, 77h, 0ffh, 77h, 0ffh
	defb 0fh, 8h, 88h, 0h, 0cch, 0h, 0eeh, 0h, 0eeh, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 30h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 11h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0ffh, 33h, 77h, 0ffh, 0h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0cch, 0ffh, 88h, 11h, 0h, 77h, 0h, 0h, 0h, 33h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0ffh, 88h, 0ffh, 88h, 0ffh, 88h, 0ffh, 88h, 0ffh, 0h, 70h, 0h, 70h, 0h, 30h, 0h
	defb 77h, 0eeh, 33h, 0ddh, 0h, 11h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 88h, 0h, 0eeh, 0h, 77h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h

AsciiPattern_: public AsciiPattern_
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

TerrainPattern_: public TerrainPattern_
	; terrain
	;	0
	defb 80h,80h,80h,80h,80h,80h,80h,80h
	;	1
	defb 0ffh,01h,01h,01h,01h,01h,01h,01h
	;	2
	defb 01h,01h,01h,01h,01h,01h,01h,0ffh
	;	3
	defb 01h,01h,01h,01h,01h,01h,01h,01h
	;	4
	defb 04h,40h,01h,10h,04h,40h,01h,10h
	;	5
	defb 00h,60h,00h,06h,00h,60h,00h,06h
	;	6
	defb 00h,00h,00h,00h,00h,00h,00h,0ffh
	;	7
	defb 0ffh,80h,80h,80h,80h,80h,80h,80h
	;	8
	defb 0ffh,00h,00h,00h,00h,00h,00h,00h
	;	9
	defb 80h,80h,80h,80h,80h,80h,80h,0ffh
