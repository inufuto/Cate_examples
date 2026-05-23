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
	defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 00h, 00h, 00h

ColorPattern: public ColorPattern
;	color16
	defb	00h, 00h, 7fh, 00h, 00h, 0c0h, 00h, 00h
	defb	80h, 01h, 00h, 80h, 07h, 00h, 80h, 0fh
	defb	00h, 80h, 1fh, 00h, 80h, 3fh, 00h, 80h
	defb	00h, 00h, 0fch, 00h, 00h, 06h, 0e0h, 0e0h
	defb	0e2h, 10h, 10h, 12h, 0c0h, 00h, 02h, 0a0h
	defb	00h, 02h, 0d0h, 00h, 02h, 0f8h, 00h, 02h
	defb	3fh, 00h, 80h, 3fh, 00h, 80h, 3fh, 00h
	defb	80h, 1fh, 00h, 80h, 0fh, 00h, 80h, 07h
	defb	00h, 80h, 00h, 00h, 0c0h, 00h, 00h, 7fh
	defb	0f8h, 00h, 02h, 0f8h, 00h, 02h, 0f8h, 00h
	defb	02h, 0f0h, 00h, 02h, 0e0h, 00h, 02h, 0c0h
	defb	00h, 02h, 00h, 00h, 06h, 00h, 00h, 0fch
	defb	00h, 00h, 00h, 04h, 07h, 07h, 04h, 07h
	defb	07h, 04h, 07h, 07h, 04h, 07h, 07h, 04h
	defb	07h, 07h, 04h, 07h, 07h, 04h, 07h, 07h
	defb	00h, 00h, 00h, 00h, 0f8h, 0f8h, 00h, 0f8h
	defb	0f8h, 00h, 0f8h, 0f8h, 00h, 0f8h, 0f8h, 00h
	defb	0f8h, 0f8h, 00h, 0f8h, 0f8h, 00h, 0f8h, 0f8h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 0eh, 0eh, 0eh, 1fh, 1fh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 04h, 07h, 04h, 04h, 07h
	defb	04h, 04h, 07h, 04h, 04h, 07h, 04h, 04h
	defb	07h, 04h, 04h, 07h, 04h, 04h, 06h, 04h
	defb	00h, 00h, 00h, 00h, 0f8h, 00h, 00h, 0f0h
	defb	00h, 00h, 0e0h, 00h, 00h, 0c0h, 00h, 00h
	defb	80h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 0eh, 0eh, 0eh, 1fh, 1fh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 04h, 04h, 06h, 04h, 04h
	defb	07h, 04h, 04h, 07h, 04h, 04h, 07h, 04h
	defb	04h, 07h, 04h, 04h, 07h, 04h, 04h, 06h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	80h, 00h, 00h, 0e0h, 00h, 00h, 0f8h, 00h
	defb	00h, 0e0h, 00h, 00h, 80h, 00h, 00h, 00h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 0eh, 0eh, 0eh, 1fh, 1fh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 06h, 04h, 06h, 07h, 04h
	defb	07h, 07h, 04h, 07h, 07h, 04h, 07h, 07h
	defb	04h, 07h, 07h, 04h, 07h, 07h, 04h, 07h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 80h, 00h, 80h, 0c0h, 00h, 0c0h, 0e0h
	defb	00h, 0e0h, 0f0h, 00h, 0f0h, 0f8h, 00h, 0f8h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 0eh, 0eh, 0eh, 1fh, 1fh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 07h, 07h, 07h, 0fh, 0fh
	defb	0fh, 0ah, 0ah, 0ah, 0ah, 0ah, 0ah, 0fh
	defb	0fh, 0fh, 07h, 07h, 07h, 00h, 0fh, 00h
	defb	00h, 00h, 00h, 80h, 80h, 80h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 80h, 80h, 80h, 00h, 0c0h, 00h
	defb	00h, 17h, 00h, 00h, 37h, 00h, 07h, 30h
	defb	30h, 04h, 00h, 00h, 0ch, 00h, 00h, 0ch
	defb	00h, 00h, 0ch, 00h, 00h, 00h, 0ch, 0ch
	defb	00h, 0a0h, 00h, 00h, 0b0h, 00h, 80h, 30h
	defb	30h, 80h, 00h, 00h, 0c0h, 00h, 00h, 0c0h
	defb	00h, 00h, 0c0h, 00h, 00h, 00h, 0c0h, 0c0h
