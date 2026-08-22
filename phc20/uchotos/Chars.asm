cseg

AsciiPattern: public AsciiPattern
	; ascii 29
	; " 0123456789:ACEFGIMNOPRSTUVXZ"
	defb 00h,00h,00h,00h,00h,00h,54h,44h
	defb 44h,44h,54h,00h,04h,04h,04h,04h
	defb 04h,00h,54h,04h,54h,40h,54h,00h
	defb 54h,04h,54h,04h,54h,00h,44h,44h
	defb 54h,04h,04h,00h,54h,40h,54h,04h
	defb 54h,00h,54h,40h,54h,44h,54h,00h
	defb 54h,04h,10h,10h,10h,00h,54h,44h
	defb 54h,44h,54h,00h,54h,44h,54h,04h
	defb 54h,00h,00h,10h,00h,10h,00h,00h
	defb 10h,44h,44h,54h,44h,00h,10h,44h
	defb 40h,44h,10h,00h,54h,40h,50h,40h
	defb 54h,00h,54h,40h,50h,40h,40h,00h
	defb 14h,40h,44h,44h,10h,00h,54h,10h
	defb 10h,10h,54h,00h,44h,54h,54h,44h
	defb 44h,00h,50h,44h,44h,44h,44h,00h
	defb 10h,44h,44h,44h,10h,00h,50h,44h
	defb 50h,40h,40h,00h,50h,44h,50h,44h
	defb 44h,00h,14h,40h,54h,04h,50h,00h
	defb 54h,10h,10h,10h,10h,00h,44h,44h
	defb 44h,44h,54h,00h,44h,44h,44h,44h
	defb 10h,00h,44h,44h,10h,44h,44h,00h
	defb 54h,04h,10h,40h,54h,00h

CharPattern: public CharPattern
	;logo
	defb 00h,00h,00h,44h,00h,40h,04h,40h
	defb 04h,44h,40h,44h,11h,00h,10h,55h
	defb 00h,50h,15h,40h,14h,55h,40h,54h
	defb 01h,10h,01h,45h,10h,41h,05h,50h
	defb 05h,45h,50h,45h,11h,10h,11h,55h
	defb 10h,51h,15h,50h,15h,55h,50h,55h
	;4dot
	defb 88h,0a0h,8ah,22h,0a0h,2ah,55h,00h
	defb 50h
	;8dot
	defb 01h,50h,01h,00h,40h,00h,51h,40h
	defb 14h,40h,40h,04h
	;sprite
	defb 55h,10h,55h,00h,40h,00h,11h,40h
	defb 14h,40h,40h,04h,55h,10h,55h,00h
	defb 40h,00h,11h,40h,14h,40h,50h,05h
	defb 55h,10h,55h,00h,00h,00h,11h,10h
	defb 11h,00h,00h,00h,00h,10h,00h,55h
	defb 40h,55h,10h,10h,01h,44h,10h,41h
	defb 00h,10h,00h,55h,40h,55h,10h,50h
	defb 05h,44h,10h,41h,00h,00h,00h,55h
	defb 40h,55h,00h,00h,00h,44h,40h,44h
	defb 11h,50h,11h,44h,50h,44h,51h,40h
	defb 14h,54h,10h,41h,0ffh,30h,0ffh,0cfh
	defb 30h,0cfh,3fh,0c0h,0fch,3fh,0c0h,0fch
	defb 3fh,0c0h,3fh,0ffh,0c0h,0ffh,0cfh,30h
	defb 0f3h,0cfh,30h,0f3h,3fh,0f0h,3fh,3fh
	defb 0f0h,3fh,0fch,30h,0c3h,0f3h,0c0h,3ch
	defb 02h,90h,02h,08h,60h,08h,99h,20h
	defb 92h,68h,00h,80h,0cch,0c0h,0cch,0cch
	defb 0c0h,0cch,0cfh,00h,0f0h,0cch,00h,0c0h
