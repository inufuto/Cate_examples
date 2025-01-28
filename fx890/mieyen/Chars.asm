cseg

AsciiPattern: public AsciiPattern
;	ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,0eah,0aah,0e0h,00h
	defb 22h,22h,20h,00h,0e2h,0e8h,0e0h,00h
	defb 0e2h,0e2h,0e0h,00h,0aah,0e2h,20h,00h
	defb 0e8h,0e2h,0e0h,00h,0e8h,0eah,0e0h,00h
	defb 0e2h,44h,40h,00h,0eah,0eah,0e0h,00h
	defb 0eah,0e2h,0e0h,00h,4ah,0aeh,0a0h,00h
	defb 4ah,8ah,40h,00h,0e8h,0c8h,0e0h,00h
	defb 0e8h,0c8h,80h,00h,68h,0aah,40h,00h
	defb 0aah,0eah,0a0h,00h,0e4h,44h,0e0h,00h
	defb 0aah,0cah,0a0h,00h,0aeh,0eah,0a0h,00h
	defb 0cah,0aah,0a0h,00h,4ah,0aah,40h,00h
	defb 0eah,0e8h,80h,00h,0cah,0cah,0a0h,00h
	defb 68h,0e2h,0c0h,00h,0e4h,44h,40h,00h
	defb 0aah,0aah,0e0h,00h,0aah,0aah,40h,00h
	defb 0aah,44h,40h,00h

CharPattern: public CharPattern
;	bg
	defb 00h,00h,00h,00h,00h,00h,00h,01h
	defb 01h,01h,01h,01h,01h,01h,01h,01h
	defb 00h,00h,00h,00h,00h,00h,00h,0ffh
	defb 01h,01h,01h,01h,01h,01h,01h,0ffh
	defb 00h,00h,00h,18h,18h,00h,00h,01h
	defb 01h,01h,01h,19h,19h,01h,01h,01h
	defb 00h,00h,00h,18h,18h,00h,00h,0ffh
	defb 01h,01h,01h,19h,19h,01h,01h,0ffh
	defb 00h,3ch,7eh,00h,3ch,00h,7eh,01h
	defb 01h,3dh,7fh,01h,3dh,01h,7fh,01h
	defb 00h,3ch,7eh,00h,3ch,00h,7eh,0ffh
	defb 01h,3dh,7fh,01h,3dh,01h,7fh,0ffh
	defb 00h,3ch,7eh,00h,3ch,00h,7eh,00h
;	sprite
	defb 00h,1ch,78h,16h,38h,18h,24h,00h
	defb 00h,38h,1eh,68h,1ch,18h,24h,00h
	defb 00h,38h,7eh,3ch,3ch,18h,24h,00h
	defb 00h,1ch,7eh,14h,3ch,18h,24h,00h
	defb 00h,30h,7ch,2ch,7ch,38h,1ch,00h
	defb 00h,0ch,3eh,34h,3eh,1ch,38h,00h
	defb 00h,38h,7ch,7ch,7ch,38h,10h,00h
	defb 00h,1ch,3eh,2ah,3eh,1ch,08h,00h
	defb 00h,00h,00h,1ch,24h,28h,10h,00h
	defb 00h,08h,14h,22h,2ah,22h,1ch,00h
