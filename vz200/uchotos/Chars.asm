cseg

AsciiPattern: public AsciiPattern
	; ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,00h,54h,44h
	defb 44h,44h,54h,00h,04h,04h,04h,04h
	defb 04h,00h,54h,04h,54h,40h,54h,00h
	defb 54h,04h,54h,04h,54h,00h,44h,44h
	defb 54h,04h,04h,00h,54h,40h,54h,04h
	defb 54h,00h,54h,40h,54h,44h,54h,00h
	defb 54h,04h,10h,10h,10h,00h,54h,44h
	defb 54h,44h,54h,00h,54h,44h,54h,04h
	defb 54h,00h,10h,44h,44h,54h,44h,00h
	defb 10h,44h,40h,44h,10h,00h,54h,40h
	defb 50h,40h,54h,00h,54h,40h,50h,40h
	defb 40h,00h,14h,40h,44h,44h,10h,00h
	defb 44h,44h,54h,44h,44h,00h,54h,10h
	defb 10h,10h,54h,00h,44h,44h,50h,44h
	defb 44h,00h,44h,54h,54h,44h,44h,00h
	defb 50h,44h,44h,44h,44h,00h,10h,44h
	defb 44h,44h,10h,00h,50h,44h,50h,40h
	defb 40h,00h,50h,44h,50h,44h,44h,00h
	defb 14h,40h,54h,04h,50h,00h,54h,10h
	defb 10h,10h,10h,00h,44h,44h,44h,44h
	defb 54h,00h,44h,44h,44h,44h,10h,00h
	defb 44h,44h,10h,10h,10h,00h

CharPattern: public CharPattern
	;logo
	defb 00h,00h,00h,00h,00h,0a0h,0a0h,00h
	defb 0a0h,00h,00h,00h,0a0h,00h,0a0h,0a0h
	defb 0a0h,0a0h,0a0h,0a0h,0ah,0ah,00h,0ah
	defb 00h,0aah,0aah,00h,0aah,00h,0ah,0ah
	defb 0a0h,0ah,0a0h,0aah,0aah,0a0h,0aah,0a0h
	defb 00h,00h,0ah,00h,0ah,0a0h,0a0h,0ah
	defb 0a0h,0ah,00h,00h,0aah,00h,0aah,0a0h
	defb 0a0h,0aah,0a0h,0aah,0ah,0ah,0ah,0ah
	defb 0ah,0aah,0aah,0ah,0aah,0ah,0ah,0ah
	defb 0aah,0ah,0aah,0aah,0aah,0aah,0aah,0aah
	;4dot
	defb 10h,10h,15h,10h,15h,04h,04h,54h
	defb 04h,54h,0ffh,0ffh,00h,0ffh,00h
	;8dot
	defb 01h,01h,15h,01h,01h,00h,00h,50h
	defb 00h,00h,15h,05h,10h,05h,10h,50h
	defb 40h,10h,40h,10h
	;sprite
	defb 05h,09h,0fh,05h,09h,50h,90h,0f0h
	defb 50h,90h,0fh,33h,08h,33h,08h,0f0h
	defb 0cch,20h,0cch,20h,05h,09h,03h,05h
	defb 09h,50h,90h,0f0h,50h,90h,03h,33h
	defb 08h,33h,08h,0f0h,0cch,28h,0cch,28h
	defb 05h,09h,00h,05h,09h,50h,90h,0c0h
	defb 50h,90h,00h,03h,02h,03h,02h,0c0h
	defb 0c0h,20h,0c0h,20h,05h,09h,03h,05h
	defb 09h,50h,90h,0c0h,50h,90h,03h,3ch
	defb 08h,3ch,08h,0c0h,0cch,28h,0cch,28h
	defb 05h,06h,0fh,05h,06h,50h,60h,0f0h
	defb 50h,60h,0fh,33h,08h,33h,08h,0f0h
	defb 0cch,20h,0cch,20h,05h,06h,0fh,05h
	defb 06h,50h,60h,0c0h,50h,60h,0fh,33h
	defb 28h,33h,28h,0c0h,0cch,20h,0cch,20h
	defb 05h,06h,03h,05h,06h,50h,60h,00h
	defb 50h,60h,03h,03h,08h,03h,08h,00h
	defb 0c0h,80h,0c0h,80h,05h,06h,03h,05h
	defb 06h,50h,60h,0c0h,50h,60h,03h,33h
	defb 28h,33h,28h,0c0h,3ch,20h,3ch,20h
	defb 05h,05h,3fh,05h,05h,50h,5ch,0f0h
	defb 50h,5ch,3fh,0fh,08h,0fh,08h,0f0h
	defb 0c0h,20h,0c0h,20h,05h,35h,0fh,05h
	defb 35h,50h,50h,0fch,50h,50h,0fh,03h
	defb 08h,03h,08h,0fch,0f0h,20h,0f0h,20h
	defb 0ah,2ah,88h,0ah,2ah,80h,0a0h,0aah
	defb 80h,0a0h,88h,2ah,22h,2ah,22h,0aah
	defb 0a8h,20h,0a8h,20h,00h,0ah,2ah,00h
	defb 0ah,00h,80h,0a0h,00h,80h,2ah,88h
	defb 2ah,88h,2ah,0a0h,0aah,0a8h,0aah,0a8h
	defb 02h,0ah,0aah,02h,0ah,0a0h,0a8h,22h
	defb 0a0h,0a8h,0aah,2ah,08h,2ah,08h,22h
	defb 0a8h,88h,0a8h,88h,00h,02h,0ah,00h
	defb 02h,00h,0a0h,0a8h,00h,0a0h,0ah,0aah
	defb 2ah,0aah,2ah,0a8h,22h,0a8h,22h,0a8h
	defb 22h,2ah,0a2h,22h,2ah,20h,0a8h,8ah
	defb 20h,0a8h,0a2h,2ah,0ah,2ah,0ah,8ah
	defb 0a8h,0a0h,0a8h,0a0h,00h,03h,0dh,00h
	defb 03h,00h,00h,0f0h,00h,00h,0dh,35h
	defb 0fh,35h,0fh,0f0h,0c0h,00h,0c0h,00h
	defb 15h,66h,66h,15h,66h,54h,0fdh,0ddh
	defb 54h,0fdh,66h,6ah,15h,6ah,15h,0ddh
	defb 0fdh,0d4h,0fdh,0d4h
