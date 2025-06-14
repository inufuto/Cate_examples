cseg

AsciiPattern: public AsciiPattern
	; ascii 29
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
;	3dot
	defb 00h,00h,0eh,60h,0eh,0c0h,46h,60h
	defb 66h,40h,4eh,40h,0eh,00h,44h,40h
;	point
	defb 22h,20h,22h,00h,0e2h,0e0h,8eh,00h
	defb 0aah,0e0h,22h,00h,0eah,0e0h,0aeh,00h
	defb 64h,40h,46h,00h,0aah,0a0h,0aah,00h
	defb 0c4h,40h,4ch,00h
;	6dot
	defb 22h,00h,88h,0c0h,02h,20h,80h,40h
	defb 22h,00h,88h,0c0h,42h,20h,80h,60h
	defb 22h,00h,88h,80h,20h,00h,08h,80h
	defb 22h,00h,88h,0a0h,40h,20h,84h,20h
	defb 22h,60h,88h,00h,20h,40h,08h,80h
	defb 22h,60h,88h,00h,20h,0c0h,48h,80h
	defb 22h,20h,88h,00h,02h,20h,80h,00h
	defb 22h,0a0h,88h,00h,24h,80h,40h,80h
	defb 00h,0c0h,00h,60h,0e2h,00h,82h,00h
	defb 00h,0c0h,08h,60h,0e2h,00h,82h,20h
	defb 00h,0c0h,00h,80h,0e0h,00h,60h,00h
	defb 00h,0c0h,08h,20h,0e0h,20h,84h,20h
	defb 02h,0e0h,02h,80h,0c0h,00h,60h,00h
	defb 02h,0e0h,22h,80h,0c0h,00h,68h,00h
	defb 00h,0e0h,00h,60h,0c0h,00h,80h,00h
	defb 20h,0e0h,24h,80h,0c0h,00h,28h,00h
	defb 40h,20h,88h,00h,62h,20h,08h,80h
	defb 00h,0c0h,00h,60h,28h,00h,0e8h,00h
	defb 0ch,0a0h,0ch,40h,0e6h,0a0h,0c8h,40h
	defb 6eh,0a0h,8ch,40h,0e6h,0a0h,0c8h,40h
	defb 22h,0a0h,88h,0a0h,0e6h,20h,0ech,80h
	defb 26h,0e0h,8ch,0e0h,0a2h,20h,0a8h,80h
	defb 0eeh,0e0h,0cch,0c0h,0eeh,0e0h,4ch,0c0h
