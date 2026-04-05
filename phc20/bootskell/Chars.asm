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
	;8dot
	defb 55h,60h,55h,96h,50h,96h,65h,90h
	defb 59h,59h,50h,95h,29h,90h,29h,86h
	defb 60h,86h,99h,20h,92h,66h,80h,68h
	defb 00h,90h,00h,86h,60h,86h,99h,20h
	defb 92h,60h,80h,08h,00h,20h,00h,00h
	defb 60h,00h,29h,20h,92h,60h,80h,08h
	defb 00h,00h,00h,00h,00h,00h,09h,20h
	defb 92h,08h,0a0h,8ah,00h,00h,00h,00h
	defb 00h,00h,00h,20h,02h,00h,60h,06h
	defb 00h,20h,00h,00h,00h,00h,20h,00h
	defb 00h,08h,00h,80h,00h,20h,00h,00h
	defb 80h,00h,22h,00h,20h,88h,00h,80h
	defb 00h,0a0h,00h,00h,60h,00h,0a9h,00h
	defb 90h,6ah,00h,0a0h,0ah,90h,0ah,0ah
	defb 60h,0ah,9ah,00h,0a0h,6ah,00h,0a0h
	defb 10h,20h,10h,44h,80h,44h,22h,40h
	defb 24h,84h,10h,41h,10h,60h,10h,44h
	defb 90h,44h,62h,10h,21h,98h,40h,84h
	defb 11h,20h,11h,40h,80h,40h,21h,40h
	defb 14h,88h,10h,81h,11h,60h,11h,40h
	defb 90h,40h,62h,10h,21h,98h,40h,84h
	defb 11h,60h,11h,44h,90h,44h,62h,10h
	defb 21h,99h,00h,90h,11h,60h,11h,44h
	defb 90h,44h,66h,00h,60h,98h,40h,84h
	defb 10h,60h,10h,40h,90h,40h,62h,00h
	defb 20h,99h,40h,94h,10h,60h,10h,40h
	defb 90h,40h,66h,10h,61h,98h,00h,80h
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
	defb 15h,10h,15h,00h,10h,00h,11h,50h
	defb 15h,11h,40h,14h,50h,50h,50h,44h
	defb 50h,44h,54h,50h,45h,51h,40h,14h
	defb 04h,40h,04h,44h,50h,44h,45h,00h
	defb 50h,55h,40h,54h,54h,50h,54h,44h
	defb 50h,44h,54h,50h,45h,55h,40h,54h
	defb 04h,10h,04h,04h,10h,04h,11h,40h
	defb 14h,11h,40h,14h
