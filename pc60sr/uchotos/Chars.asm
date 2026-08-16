cseg

MonoPattern: public MonoPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,7eh,00h,00h,00h,00h
	defb 3eh,63h,67h,6bh,73h,63h,3eh,00h
	defb 18h,78h,18h,18h,18h,18h,7eh,00h
	defb 3eh,63h,07h,1eh,3ch,70h,7fh,00h
	defb 3eh,63h,03h,1eh,03h,63h,3eh,00h
	defb 06h,0eh,1eh,36h,66h,7fh,06h,00h
	defb 7fh,60h,7eh,03h,03h,63h,3eh,00h
	defb 1eh,30h,60h,7eh,63h,63h,3eh,00h
	defb 7fh,63h,06h,0ch,18h,18h,18h,00h
	defb 3eh,63h,63h,3eh,63h,63h,3eh,00h
	defb 3eh,63h,63h,3fh,03h,63h,3eh,00h
	defb 1ch,36h,63h,63h,7fh,63h,63h,00h
	defb 1eh,33h,60h,60h,60h,33h,1eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,7eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,60h,00h
	defb 1eh,33h,60h,6fh,63h,33h,1fh,00h
	defb 63h,63h,63h,7fh,63h,63h,63h,00h
	defb 7eh,18h,18h,18h,18h,18h,7eh,00h
	defb 63h,66h,6ch,78h,6ch,66h,63h,00h
	defb 7eh,6bh,6bh,6bh,6bh,6bh,6bh,00h
	defb 63h,73h,7bh,7fh,6fh,67h,63h,00h
	defb 3eh,63h,63h,63h,63h,63h,3eh,00h
	defb 7eh,63h,63h,63h,7eh,60h,60h,00h
	defb 7eh,63h,63h,67h,7ch,6eh,67h,00h
	defb 3eh,63h,60h,3eh,03h,63h,3eh,00h
	defb 7eh,18h,18h,18h,18h,18h,18h,00h
	defb 63h,63h,63h,63h,63h,63h,3eh,00h
	defb 63h,63h,63h,36h,36h,1ch,1ch,00h
	defb 66h,66h,66h,3ch,18h,18h,18h,00h
;	logo
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
;	mono8
	defb	60h, 7fh, 7fh, 60h, 60h, 7fh, 7fh, 60h
	defb	06h, 0feh, 0feh, 06h, 06h, 0feh, 0feh, 06h
	defb	0efh, 0efh, 0efh, 00h, 0feh, 0feh, 0feh, 00h
;	mono16
	defb	00h, 00h, 00h, 01h, 01h, 01h, 7fh, 3fh
	defb	00h, 80h, 80h, 0c0h, 0c0h, 0c0h, 0ffh, 0feh
	defb	0fh, 07h, 07h, 07h, 0fh, 0ch, 08h, 00h
	defb	0f8h, 0f0h, 0f0h, 0f0h, 78h, 18h, 08h, 00h

ColorPattern: public ColorPattern
;	sprite
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0f0h, 0ffh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0ffh, 0ffh
	defb	00h, 00h, 00h, 00h, 0f0h, 0ffh, 0aah, 0aah
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0fh, 00h, 0aah, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0a0h, 00h, 0aah, 0a0h, 0aah, 0a0h, 0aah
	defb	00h, 22h, 00h, 00h, 90h, 99h, 90h, 00h
	defb	00h, 00h, 00h, 00h, 99h, 00h, 99h, 00h
	defb	00h, 00h, 00h, 00h, 99h, 00h, 22h, 00h
	defb	0ah, 0ah, 0ah, 0aah, 00h, 00h, 00h, 00h
	defb	09h, 22h, 09h, 00h, 00h, 00h, 00h, 00h
	defb	99h, 00h, 99h, 00h, 00h, 00h, 00h, 00h
	defb	99h, 00h, 22h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0f0h, 0ffh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0ffh, 0ffh
	defb	00h, 00h, 00h, 00h, 0f0h, 0ffh, 00h, 0aah
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0fh, 00h, 0ah, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0a2h, 00h, 0a2h, 0a0h, 0aah, 0a0h, 0aah
	defb	00h, 00h, 00h, 00h, 90h, 99h, 90h, 99h
	defb	00h, 00h, 00h, 90h, 99h, 09h, 99h, 00h
	defb	00h, 92h, 00h, 20h, 09h, 00h, 00h, 00h
	defb	0aah, 0ah, 0ah, 0aah, 00h, 00h, 00h, 00h
	defb	09h, 22h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	99h, 02h, 99h, 02h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0f0h, 0ffh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0ffh, 0ffh
	defb	00h, 00h, 00h, 00h, 0f0h, 0ffh, 00h, 0aah
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0fh, 00h, 0ah, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0aah, 00h, 0aah
	defb	00h, 00h, 00h, 00h, 0a0h, 0aah, 20h, 02h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 90h, 09h
	defb	00h, 00h, 00h, 00h, 90h, 09h, 20h, 02h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	09h, 00h, 09h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0f0h, 0ffh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0ffh, 0ffh
	defb	00h, 00h, 00h, 00h, 0f0h, 0ffh, 00h, 0aah
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0fh, 00h, 0ah, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 20h, 0a0h, 0aah, 0aah, 0ah
	defb	00h, 20h, 00h, 00h, 0aah, 90h, 00h, 99h
	defb	00h, 00h, 00h, 00h, 90h, 90h, 99h, 09h
	defb	00h, 20h, 00h, 00h, 99h, 00h, 02h, 00h
	defb	0ah, 0ah, 0ah, 0aah, 00h, 00h, 00h, 00h
	defb	09h, 22h, 09h, 00h, 00h, 00h, 00h, 00h
	defb	99h, 02h, 99h, 02h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0f0h, 00h, 0aah
	defb	00h, 00h, 0ffh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0ffh, 0fh, 0aah, 0aah, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0a0h, 0a0h, 0aah, 0a0h
	defb	00h, 00h, 00h, 00h, 22h, 90h, 00h, 90h
	defb	00h, 00h, 00h, 00h, 00h, 99h, 00h, 99h
	defb	00h, 00h, 00h, 00h, 00h, 99h, 00h, 22h
	defb	0aah, 0ah, 0aah, 0ah, 0ah, 00h, 0aah, 00h
	defb	99h, 09h, 00h, 09h, 22h, 00h, 00h, 00h
	defb	00h, 99h, 00h, 99h, 00h, 00h, 00h, 00h
	defb	00h, 99h, 00h, 22h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0f0h, 00h, 0a0h
	defb	00h, 00h, 0ffh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0ffh, 0fh, 0aah, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0a0h, 0aah, 0aah, 0a0h
	defb	00h, 00h, 00h, 00h, 22h, 90h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 20h, 99h, 20h, 99h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0aah, 0ah, 0aah, 0ah, 2ah, 00h, 2ah, 00h
	defb	99h, 09h, 99h, 09h, 00h, 00h, 00h, 00h
	defb	90h, 99h, 00h, 99h, 00h, 00h, 09h, 00h
	defb	00h, 90h, 00h, 00h, 29h, 00h, 02h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0f0h, 00h, 0a0h
	defb	00h, 00h, 0ffh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0ffh, 0fh, 0aah, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 90h, 00h, 90h
	defb	00h, 00h, 00h, 00h, 00h, 20h, 00h, 00h
	defb	0aah, 00h, 0aah, 00h, 00h, 00h, 00h, 00h
	defb	0aah, 0ah, 20h, 02h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 90h, 09h, 00h, 00h, 00h, 00h
	defb	90h, 09h, 20h, 02h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0f0h, 00h, 0a0h
	defb	00h, 00h, 0ffh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0ffh, 0fh, 0aah, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0a0h, 0a0h, 0aah, 0a0h
	defb	00h, 00h, 00h, 00h, 22h, 90h, 00h, 90h
	defb	00h, 00h, 00h, 00h, 20h, 99h, 20h, 99h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0aah, 0ah, 0a0h, 0aah, 00h, 00h, 02h, 00h
	defb	09h, 0aah, 99h, 00h, 02h, 00h, 00h, 00h
	defb	09h, 09h, 90h, 99h, 00h, 00h, 00h, 00h
	defb	00h, 99h, 00h, 20h, 02h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0f0h, 0ffh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	00h, 00h, 00h, 22h, 0f0h, 0ffh, 0a0h, 0aah
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 20h, 0ffh, 0a0h, 02h, 00h, 0ah, 00h
	defb	0fh, 0a0h, 0aah, 0aah, 0ah, 00h, 00h, 00h
	defb	00h, 0aah, 00h, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	00h, 0a0h, 00h, 00h, 0a0h, 0aah, 90h, 99h
	defb	00h, 00h, 00h, 00h, 90h, 09h, 20h, 02h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0aah, 0ah, 0aah, 00h, 00h, 00h, 00h, 00h
	defb	0aah, 00h, 99h, 00h, 00h, 00h, 00h, 00h
	defb	99h, 00h, 99h, 00h, 00h, 00h, 00h, 00h
	defb	99h, 00h, 22h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh
	defb	00h, 00h, 00h, 00h, 0f0h, 0ffh, 0f0h, 0ffh
	defb	00h, 22h, 00h, 0aah, 0f0h, 0ffh, 0f0h, 0ffh
	defb	00h, 0aah, 00h, 0a0h, 00h, 0ffh, 0aah, 0aah
	defb	00h, 00h, 0ffh, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 0fh, 0ffh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 0fh, 0ffh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0aah, 20h, 00h, 00h, 02h, 00h
	defb	00h, 00h, 00h, 00h, 0aah, 0aah, 0a0h, 0aah
	defb	00h, 00h, 00h, 00h, 0a0h, 0aah, 90h, 99h
	defb	00h, 00h, 00h, 00h, 90h, 09h, 90h, 09h
	defb	00h, 00h, 00h, 00h, 90h, 09h, 20h, 02h
	defb	0aah, 0aah, 0aah, 0aah, 0ah, 00h, 0ah, 00h
	defb	0aah, 0a0h, 99h, 00h, 00h, 00h, 00h, 00h
	defb	99h, 00h, 22h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0d0h, 0d0h, 0ddh, 0ddh, 0ddh
	defb	00h, 0ddh, 0d0h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	0ddh, 0ddh, 0ddh, 0dh, 0ddh, 0ddh, 0ddh, 0d0h
	defb	0ddh, 0dh, 0ddh, 0dh, 0ddh, 0d0h, 0ddh, 0d0h
	defb	0dh, 00h, 0ddh, 0dh, 00h, 00h, 00h, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 00h, 00h, 0dh, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 00h, 0ddh, 0dh
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0dh, 0ddh, 0dh
	defb	0d0h, 0ddh, 00h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	00h, 00h, 00h, 05h, 00h, 00h, 00h, 05h
	defb	00h, 05h, 00h, 05h, 00h, 05h, 00h, 05h
	defb	00h, 50h, 00h, 00h, 00h, 50h, 00h, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 05h, 00h, 00h, 00h, 00h
	defb	00h, 05h, 00h, 05h, 00h, 00h, 00h, 00h
	defb	00h, 50h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0d0h, 0ddh
	defb	00h, 0d0h, 00h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	0d0h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	0ddh, 0dh, 0ddh, 0dh, 0ddh, 0d0h, 0ddh, 0d0h
	defb	00h, 00h, 0dh, 00h, 00h, 00h, 00h, 00h
	defb	0ddh, 0dh, 0ddh, 0ddh, 00h, 00h, 00h, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0dh, 00h, 0ddh, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0dh, 0ddh, 0dh
	defb	0ddh, 0dh, 0d0h, 0ddh, 0ddh, 0d0h, 0ddh, 0ddh
	defb	00h, 00h, 00h, 50h, 00h, 00h, 00h, 50h
	defb	00h, 50h, 00h, 50h, 00h, 50h, 00h, 50h
	defb	00h, 00h, 00h, 00h, 05h, 00h, 00h, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0dh, 0dh, 00h
	defb	00h, 00h, 00h, 50h, 00h, 00h, 00h, 00h
	defb	00h, 50h, 00h, 50h, 00h, 00h, 00h, 00h
	defb	05h, 00h, 00h, 00h, 05h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0d0h, 0d0h, 0ddh
	defb	00h, 00h, 00h, 0d0h, 0ddh, 0ddh, 0ddh, 0ddh
	defb	00h, 0ddh, 0d0h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	0d0h, 0ddh, 0d0h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	0ddh, 0dh, 0ddh, 0ddh, 00h, 00h, 0dh, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 00h, 0ddh, 0dh
	defb	0ddh, 0ddh, 0dh, 0ddh, 0ddh, 0ddh, 0d0h, 0ddh
	defb	0dh, 0ddh, 0dh, 0ddh, 0d0h, 0ddh, 0d0h, 0ddh
	defb	00h, 0ddh, 00h, 00h, 0ddh, 0ddh, 0ddh, 0ddh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 50h, 00h
	defb	00h, 00h, 00h, 00h, 50h, 00h, 50h, 00h
	defb	00h, 00h, 00h, 00h, 05h, 00h, 00h, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0dh, 0ddh, 00h
	defb	00h, 00h, 50h, 00h, 00h, 00h, 50h, 00h
	defb	50h, 00h, 50h, 00h, 50h, 00h, 50h, 00h
	defb	05h, 00h, 00h, 00h, 05h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0d0h
	defb	00h, 00h, 00h, 00h, 0d0h, 0ddh, 0ddh, 0ddh
	defb	00h, 0d0h, 00h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	0d0h, 0ddh, 0d0h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	00h, 00h, 0ddh, 0dh, 00h, 00h, 00h, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0dh, 00h, 0ddh, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0dh, 0ddh, 0ddh
	defb	0dh, 0ddh, 0dh, 0ddh, 0d0h, 0ddh, 0d0h, 0ddh
	defb	0d0h, 0ddh, 00h, 0d0h, 0ddh, 0ddh, 0ddh, 0ddh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 05h, 00h
	defb	00h, 00h, 00h, 00h, 05h, 00h, 05h, 00h
	defb	00h, 50h, 00h, 00h, 00h, 50h, 00h, 00h
	defb	0dh, 0ddh, 0ddh, 0ddh, 0d0h, 0ddh, 0ddh, 0dh
	defb	00h, 00h, 05h, 00h, 00h, 00h, 05h, 00h
	defb	05h, 00h, 05h, 00h, 05h, 00h, 05h, 00h
	defb	00h, 50h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 05h, 00h
	defb	00h, 50h, 00h, 50h, 00h, 50h, 00h, 50h
	defb	00h, 50h, 00h, 00h, 00h, 50h, 00h, 00h
	defb	0d0h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	00h, 00h, 05h, 00h, 00h, 00h, 05h, 00h
	defb	00h, 50h, 00h, 50h, 00h, 00h, 00h, 00h
	defb	00h, 50h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 00h, 0ddh, 0dh
	defb	0ddh, 0dh, 0ddh, 0ddh, 0dh, 0ddh, 0d0h, 0ddh
	defb	0ddh, 0dh, 0d0h, 0ddh, 0dh, 0ddh, 0ddh, 0ddh
	defb	0d0h, 0ddh, 00h, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	00h, 0d0h, 00h, 00h, 0ddh, 0ddh, 0d0h, 0ddh
	defb	0dh, 0dh, 0ddh, 0d0h, 0ddh, 0dh, 0ddh, 0dh
	defb	0dh, 0dh, 0ddh, 0ddh, 0ddh, 0dh, 0ddh, 00h
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 00h, 0dh, 00h
	defb	0ddh, 0ddh, 0ddh, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0aah, 0aah, 2ah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0aah, 0aah, 00h, 00h, 00h, 00h
	defb	0ah, 0ah, 0a2h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0a0h, 2ah, 22h, 2ah, 2eh
	defb	00h, 0a0h, 00h, 0a0h, 22h, 0eeh, 2ah, 22h
	defb	00h, 00h, 00h, 00h, 0aah, 0aah, 0a0h, 0aah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	22h, 0ah, 0a2h, 0aah, 0ah, 00h, 00h, 00h
	defb	22h, 0ah, 0a2h, 0ah, 00h, 00h, 00h, 00h
	defb	0aah, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 80h, 00h, 68h, 88h, 88h, 66h, 66h
	defb	80h, 66h, 68h, 16h, 66h, 66h, 16h, 66h
	defb	68h, 11h, 68h, 16h, 16h, 66h, 16h, 66h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	88h, 88h, 66h, 66h, 08h, 00h, 86h, 00h
	defb	66h, 66h, 61h, 11h, 66h, 08h, 61h, 86h
	defb	61h, 61h, 61h, 61h, 16h, 86h, 16h, 86h
	defb	68h, 16h, 68h, 16h, 16h, 66h, 16h, 66h
	defb	68h, 11h, 80h, 66h, 61h, 11h, 66h, 66h
	defb	00h, 68h, 00h, 80h, 66h, 66h, 88h, 88h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	61h, 11h, 61h, 61h, 61h, 86h, 66h, 86h
	defb	66h, 61h, 66h, 66h, 66h, 86h, 66h, 08h
	defb	66h, 66h, 88h, 88h, 86h, 00h, 08h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
