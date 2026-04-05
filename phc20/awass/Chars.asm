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
	defb 56h,0a0h,56h,59h,0a0h,59h,0aah,60h
	defb 0a6h,0aah,90h,0a9h,65h,60h,65h,69h
	defb 60h,69h,64h,40h,44h,60h,00h,00h
	defb 55h,50h,55h,54h,00h,54h,54h,40h
	defb 44h,00h,00h,00h,66h,60h,66h,8ah
	defb 80h,8ah,64h,40h,44h,80h,00h,00h
	defb 66h,60h,66h,08h,0a0h,08h,64h,40h
	defb 44h,0a0h,00h,00h
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
	defb 14h,54h,10h,41h,00h,50h,00h,04h
	defb 50h,04h,55h,00h,50h,50h,00h,00h
	defb 10h,10h,10h,14h,40h,14h,10h,00h
	defb 00h,45h,50h,55h,00h,50h,00h,05h
	defb 50h,05h,51h,00h,10h,50h,00h,00h
	defb 0a2h,0a0h,0a2h,0a2h,0a0h,0a2h,0a2h,00h
	defb 20h,0a8h,0a0h,8ah,0ah,20h,0ah,0ah
	defb 20h,0ah,2ah,20h,0a2h,2ah,0a0h,0aah
	defb 0a8h,0a0h,0a8h,0a8h,0a0h,0a8h,0a2h,0a0h
	defb 2ah,0a8h,00h,80h,0ah,80h,0ah,0ah
	defb 80h,0ah,8ah,0a0h,0aah,8ah,80h,0a8h
	defb 0aah,0a0h,0aah,0aah,0a0h,0aah,0a2h,20h
	defb 22h,0a8h,80h,88h,0ah,0a0h,0ah,0ah
	defb 0a0h,0ah,0aah,20h,0a2h,0aah,80h,0a8h
	defb 0a2h,0a0h,0a2h,0a2h,0a0h,0a2h,0a2h,20h
	defb 22h,0a8h,80h,88h,0ah,80h,0ah,0ah
	defb 80h,0ah,8ah,20h,0a2h,8ah,80h,0a8h
	defb 59h,50h,59h,49h,50h,49h,51h,00h
	defb 10h,55h,40h,54h,16h,50h,16h,56h
	defb 50h,56h,55h,10h,51h,54h,00h,40h
	defb 15h,50h,15h,45h,50h,45h,51h,10h
	defb 11h,54h,00h,40h,59h,50h,59h,49h
	defb 50h,49h,51h,00h,10h,54h,40h,44h
	defb 2ah,90h,2ah,86h,0a0h,86h,9ah,20h
	defb 0a2h,0a6h,80h,68h,15h,10h,15h,00h
	defb 10h,00h,11h,50h,15h,11h,40h,14h
	defb 50h,50h,50h,44h,50h,44h,54h,50h
	defb 45h,51h,40h,14h,04h,40h,04h,44h
	defb 50h,44h,45h,00h,50h,55h,40h,54h
	defb 54h,50h,54h,44h,50h,44h,54h,50h
	defb 45h,55h,40h,54h,04h,10h,04h,04h
	defb 10h,04h,11h,40h,14h,11h,40h,14h
