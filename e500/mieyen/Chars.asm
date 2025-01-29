cseg

AsciiPattern: public AsciiPattern
;	ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,1fh,11h,1fh,00h
	defb 00h,00h,1fh,00h,1dh,15h,17h,00h
	defb 15h,15h,1fh,00h,07h,04h,1fh,00h
	defb 17h,15h,1dh,00h,1fh,15h,1dh,00h
	defb 01h,1dh,03h,00h,1fh,15h,1fh,00h
	defb 17h,15h,1fh,00h,1eh,09h,1eh,00h
	defb 0eh,11h,0ah,00h,1fh,15h,11h,00h
	defb 1fh,05h,01h,00h,0eh,11h,0dh,00h
	defb 1fh,04h,1fh,00h,11h,1fh,11h,00h
	defb 1fh,04h,1bh,00h,1fh,06h,1fh,00h
	defb 1fh,01h,1eh,00h,0eh,11h,0eh,00h
	defb 1fh,05h,07h,00h,1fh,05h,1ah,00h
	defb 16h,15h,0dh,00h,01h,1fh,01h,00h
	defb 1fh,10h,1fh,00h,0fh,10h,0fh,00h
	defb 03h,1ch,03h,00h

CharPattern: public CharPattern
;	bg
	defb 00h,00h,00h,00h,00h,00h,00h,80h
	defb 00h,00h,00h,00h,00h,00h,00h,0ffh
	defb 80h,80h,80h,80h,80h,80h,80h,80h
	defb 80h,80h,80h,80h,80h,80h,80h,0ffh
	defb 00h,00h,00h,18h,18h,00h,00h,80h
	defb 00h,00h,00h,18h,18h,00h,00h,0ffh
	defb 80h,80h,80h,98h,98h,80h,80h,80h
	defb 80h,80h,80h,98h,98h,80h,80h,0ffh
	defb 00h,44h,56h,56h,56h,56h,44h,80h
	defb 00h,44h,56h,56h,56h,56h,44h,0ffh
	defb 80h,0c4h,0d6h,0d6h,0d6h,0d6h,0c4h,80h
	defb 80h,0c4h,0d6h,0d6h,0d6h,0d6h,0c4h,0ffh
	defb 00h,44h,56h,56h,56h,56h,44h,00h
;	sprite
	defb 00h,04h,54h,3eh,36h,4ah,08h,00h
	defb 00h,08h,4ah,36h,3eh,54h,04h,00h
	defb 00h,04h,5eh,3eh,3eh,5ch,04h,00h
	defb 00h,04h,54h,3eh,36h,5eh,04h,00h
	defb 00h,14h,3eh,76h,7ch,5ch,00h,00h
	defb 00h,00h,5ch,7ch,76h,3eh,14h,00h
	defb 00h,1ch,3eh,7eh,3eh,1ch,00h,00h
	defb 00h,00h,1ch,36h,7eh,36h,1ch,00h
	defb 00h,00h,30h,48h,28h,18h,00h,00h
	defb 00h,00h,38h,44h,52h,44h,38h,00h
