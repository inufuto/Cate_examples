cseg

AsciiPattern: public AsciiPattern
	; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,77h,00h,00h,00h,70h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 77h,70h,70h,70h,70h,70h,70h,70h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 00h,00h,00h,00h,70h,70h,70h,70h
	defb 00h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,00h,77h,70h,70h,70h,70h,00h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,00h,77h,00h,70h,70h,70h,70h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 70h,70h,77h,00h,70h,70h,70h,70h
	defb 00h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,70h,77h,00h,70h,00h,70h,70h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,70h,77h,70h,70h,00h,70h,70h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,00h,07h,07h,70h,70h,00h,00h
	defb 07h,00h,00h,00h,00h,00h,00h,00h
	defb 77h,70h,77h,70h,70h,70h,70h,70h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,70h,77h,00h,70h,70h,70h,70h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 07h,70h,70h,77h,00h,70h,70h,70h
	defb 70h,00h,00h,00h,70h,00h,00h,00h
	defb 07h,70h,70h,70h,00h,70h,00h,70h
	defb 07h,00h,00h,00h,00h,00h,00h,00h
	defb 77h,70h,77h,70h,70h,00h,00h,00h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,70h,77h,70h,70h,00h,00h,00h
	defb 70h,00h,00h,00h,00h,00h,00h,00h
	defb 07h,70h,70h,70h,70h,00h,70h,70h
	defb 07h,00h,00h,00h,00h,00h,00h,00h
	defb 70h,70h,77h,70h,70h,70h,70h,70h
	defb 70h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,07h,07h,07h,70h,00h,00h,00h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 70h,70h,77h,70h,70h,70h,00h,70h
	defb 70h,00h,00h,00h,70h,00h,00h,00h
	defb 70h,77h,77h,70h,70h,70h,70h,70h
	defb 70h,00h,00h,00h,70h,00h,00h,00h
	defb 77h,70h,70h,70h,00h,70h,70h,70h
	defb 70h,00h,00h,00h,70h,00h,00h,00h
	defb 07h,70h,70h,70h,00h,70h,70h,70h
	defb 07h,00h,00h,00h,00h,00h,00h,00h
	defb 77h,70h,77h,70h,70h,70h,70h,00h
	defb 70h,00h,00h,00h,00h,00h,00h,00h
	defb 77h,70h,77h,70h,00h,70h,00h,70h
	defb 70h,00h,00h,00h,70h,00h,00h,00h
	defb 07h,70h,77h,00h,70h,00h,70h,70h
	defb 77h,00h,00h,00h,00h,00h,00h,00h
	defb 77h,07h,07h,07h,70h,00h,00h,00h
	defb 07h,00h,00h,00h,00h,00h,00h,00h
	defb 70h,70h,70h,70h,70h,70h,70h,70h
	defb 77h,00h,00h,00h,70h,00h,00h,00h
	defb 70h,70h,70h,70h,70h,70h,70h,70h
	defb 07h,00h,00h,00h,00h,00h,00h,00h
	defb 70h,70h,07h,07h,70h,70h,00h,00h
	defb 07h,00h,00h,00h,00h,00h,00h,00h

CharPattern: public CharPattern
;	logo
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	66h, 66h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 66h, 66h, 00h, 00h, 00h, 00h
	defb	66h, 66h, 66h, 66h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 66h, 66h, 00h, 00h
	defb	66h, 66h, 00h, 00h, 66h, 66h, 00h, 00h
	defb	00h, 00h, 66h, 66h, 66h, 66h, 00h, 00h
	defb	66h, 66h, 66h, 66h, 66h, 66h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 66h, 66h
	defb	66h, 66h, 00h, 00h, 00h, 00h, 66h, 66h
	defb	00h, 00h, 66h, 66h, 00h, 00h, 66h, 66h
	defb	66h, 66h, 66h, 66h, 00h, 00h, 66h, 66h
	defb	00h, 00h, 00h, 00h, 66h, 66h, 66h, 66h
	defb	66h, 66h, 00h, 00h, 66h, 66h, 66h, 66h
	defb	00h, 00h, 66h, 66h, 66h, 66h, 66h, 66h
	defb	66h, 66h, 66h, 66h, 66h, 66h, 66h, 66h
;	4dot
	defb	06h, 06h, 06h, 06h, 00h, 66h, 00h, 66h
	defb	00h, 66h, 00h, 66h, 60h, 60h, 60h, 60h
	defb	11h, 11h, 00h, 00h, 11h, 11h, 00h, 00h
;	8dot
	defb	44h, 40h, 40h, 40h, 44h, 00h, 00h, 01h
	defb	44h, 07h, 70h, 10h, 44h, 74h, 04h, 04h
	defb	40h, 40h, 40h, 44h, 11h, 11h, 01h, 44h
	defb	11h, 11h, 10h, 44h, 04h, 04h, 04h, 44h
	defb	00h, 00h, 00h, 00h, 76h, 76h, 76h, 76h
	defb	66h, 66h, 66h, 66h, 60h, 60h, 60h, 60h
	defb	00h, 00h, 00h, 07h, 70h, 70h, 70h, 77h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 72h, 72h, 72h, 72h
	defb	22h, 22h, 20h, 00h, 20h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 07h, 70h, 70h, 70h, 77h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 74h, 74h, 74h, 74h
	defb	00h, 44h, 44h, 44h, 00h, 00h, 40h, 00h
	defb	00h, 00h, 00h, 07h, 74h, 70h, 70h, 77h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 75h, 75h, 75h, 75h
	defb	00h, 50h, 55h, 55h, 00h, 00h, 00h, 50h
	defb	00h, 00h, 00h, 07h, 70h, 70h, 70h, 77h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;	sprite
	defb	00h, 00h, 00h, 00h, 77h, 07h, 77h, 22h
	defb	77h, 07h, 77h, 22h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 00h, 00h, 02h, 01h, 10h, 10h
	defb	20h, 10h, 01h, 01h, 20h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 07h, 77h, 02h
	defb	77h, 07h, 77h, 22h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 00h, 01h, 02h, 01h, 10h, 00h
	defb	20h, 10h, 01h, 00h, 20h, 00h, 10h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 07h, 77h, 00h
	defb	77h, 07h, 77h, 20h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 02h, 00h, 01h, 01h
	defb	20h, 00h, 01h, 01h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 07h, 77h, 02h
	defb	77h, 07h, 77h, 20h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 00h, 00h, 20h, 01h, 10h, 10h
	defb	20h, 10h, 01h, 00h, 20h, 00h, 10h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 70h, 77h, 22h
	defb	77h, 70h, 77h, 22h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 00h, 00h, 02h, 01h, 10h, 10h
	defb	20h, 10h, 01h, 01h, 20h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 70h, 77h, 22h
	defb	77h, 70h, 77h, 20h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 01h, 00h, 02h, 01h, 10h, 00h
	defb	20h, 10h, 01h, 00h, 20h, 00h, 00h, 10h
	defb	00h, 00h, 00h, 00h, 77h, 70h, 77h, 02h
	defb	77h, 70h, 77h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 02h, 00h, 10h, 10h
	defb	20h, 00h, 10h, 10h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 70h, 77h, 02h
	defb	77h, 70h, 77h, 20h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 01h, 00h, 02h, 01h, 10h, 00h
	defb	02h, 10h, 01h, 01h, 20h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 02h, 77h, 77h, 77h, 02h
	defb	77h, 77h, 77h, 22h, 00h, 00h, 20h, 00h
	defb	00h, 00h, 00h, 00h, 22h, 01h, 10h, 00h
	defb	20h, 10h, 01h, 01h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 02h, 00h, 77h, 77h, 77h, 22h
	defb	77h, 77h, 77h, 20h, 00h, 00h, 00h, 20h
	defb	00h, 00h, 00h, 00h, 02h, 01h, 10h, 10h
	defb	22h, 10h, 01h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 77h, 70h, 00h, 00h, 72h, 72h
	defb	00h, 20h, 00h, 21h, 00h, 00h, 11h, 00h
	defb	77h, 70h, 00h, 00h, 72h, 72h, 00h, 00h
	defb	21h, 00h, 20h, 00h, 00h, 11h, 00h, 00h
	defb	00h, 00h, 00h, 02h, 10h, 10h, 01h, 02h
	defb	01h, 01h, 10h, 20h, 00h, 00h, 00h, 20h
	defb	00h, 00h, 00h, 00h, 22h, 77h, 70h, 77h
	defb	22h, 77h, 70h, 77h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 11h, 00h, 00h, 02h, 00h, 12h
	defb	00h, 00h, 27h, 27h, 00h, 00h, 07h, 77h
	defb	00h, 11h, 00h, 00h, 12h, 00h, 02h, 00h
	defb	27h, 27h, 00h, 00h, 07h, 77h, 00h, 00h
	defb	00h, 03h, 00h, 33h, 30h, 33h, 30h, 33h
	defb	30h, 33h, 33h, 33h, 00h, 00h, 00h, 30h
	defb	03h, 00h, 00h, 00h, 33h, 33h, 03h, 00h
	defb	33h, 33h, 30h, 33h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 03h, 00h, 00h, 30h, 33h, 30h
	defb	00h, 30h, 33h, 33h, 00h, 00h, 00h, 00h
	defb	03h, 33h, 00h, 00h, 33h, 33h, 33h, 03h
	defb	33h, 33h, 33h, 33h, 00h, 30h, 00h, 00h
	defb	00h, 00h, 00h, 03h, 03h, 33h, 33h, 33h
	defb	03h, 33h, 03h, 33h, 00h, 30h, 00h, 33h
	defb	00h, 00h, 00h, 00h, 33h, 33h, 03h, 33h
	defb	33h, 33h, 30h, 00h, 30h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 03h, 33h, 33h
	defb	00h, 03h, 33h, 03h, 00h, 00h, 30h, 00h
	defb	00h, 03h, 00h, 00h, 33h, 33h, 33h, 33h
	defb	33h, 33h, 33h, 30h, 30h, 33h, 00h, 00h
	defb	00h, 00h, 00h, 03h, 03h, 33h, 33h, 33h
	defb	03h, 33h, 33h, 33h, 00h, 30h, 30h, 33h
	defb	00h, 00h, 00h, 00h, 33h, 33h, 03h, 00h
	defb	33h, 33h, 33h, 30h, 30h, 30h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 03h, 33h, 33h
	defb	00h, 03h, 33h, 33h, 00h, 00h, 30h, 30h
	defb	00h, 03h, 00h, 00h, 33h, 33h, 33h, 03h
	defb	33h, 33h, 33h, 33h, 30h, 33h, 30h, 00h
	defb	00h, 03h, 03h, 33h, 30h, 33h, 03h, 33h
	defb	30h, 33h, 03h, 33h, 00h, 00h, 00h, 30h
	defb	03h, 03h, 00h, 00h, 33h, 33h, 33h, 03h
	defb	33h, 33h, 30h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 03h, 03h, 00h, 30h, 33h, 03h
	defb	00h, 30h, 33h, 03h, 00h, 00h, 00h, 00h
	defb	03h, 33h, 03h, 00h, 33h, 33h, 33h, 33h
	defb	33h, 33h, 33h, 30h, 00h, 30h, 00h, 00h
	defb	07h, 71h, 77h, 71h, 77h, 11h, 17h, 11h
	defb	77h, 11h, 11h, 11h, 00h, 70h, 70h, 70h
	defb	71h, 07h, 00h, 00h, 11h, 11h, 77h, 00h
	defb	11h, 17h, 11h, 77h, 70h, 00h, 70h, 00h
	defb	00h, 07h, 07h, 07h, 77h, 11h, 11h, 11h
	defb	77h, 11h, 71h, 11h, 70h, 17h, 77h, 17h
	defb	07h, 00h, 07h, 00h, 11h, 71h, 11h, 77h
	defb	11h, 11h, 77h, 00h, 17h, 70h, 00h, 00h
	defb	00h, 07h, 07h, 07h, 77h, 11h, 11h, 11h
	defb	77h, 11h, 11h, 11h, 70h, 17h, 17h, 17h
	defb	07h, 00h, 00h, 00h, 11h, 71h, 07h, 00h
	defb	11h, 11h, 17h, 70h, 17h, 70h, 00h, 00h
	defb	00h, 07h, 07h, 07h, 77h, 11h, 17h, 11h
	defb	77h, 11h, 17h, 11h, 70h, 17h, 17h, 17h
	defb	07h, 00h, 00h, 00h, 11h, 71h, 07h, 00h
	defb	11h, 11h, 17h, 70h, 17h, 70h, 00h, 00h
	defb	00h, 07h, 77h, 07h, 00h, 00h, 07h, 07h
	defb	00h, 70h, 07h, 07h, 00h, 00h, 00h, 00h
	defb	07h, 77h, 00h, 00h, 00h, 70h, 00h, 00h
	defb	70h, 07h, 07h, 00h, 70h, 07h, 07h, 70h
	defb	00h, 07h, 70h, 00h, 00h, 00h, 77h, 77h
	defb	00h, 70h, 07h, 07h, 00h, 00h, 00h, 00h
	defb	07h, 77h, 00h, 00h, 00h, 70h, 00h, 00h
	defb	70h, 07h, 07h, 00h, 70h, 07h, 07h, 70h
	defb	00h, 00h, 70h, 70h, 00h, 70h, 77h, 77h
	defb	00h, 70h, 07h, 07h, 00h, 00h, 00h, 00h
	defb	77h, 00h, 00h, 00h, 70h, 70h, 00h, 00h
	defb	70h, 07h, 07h, 00h, 70h, 07h, 07h, 70h
	defb	00h, 07h, 70h, 07h, 00h, 00h, 77h, 07h
	defb	00h, 70h, 07h, 07h, 00h, 00h, 00h, 00h
	defb	70h, 07h, 00h, 00h, 70h, 00h, 00h, 00h
	defb	70h, 07h, 07h, 00h, 70h, 07h, 07h, 70h
	defb	00h, 02h, 22h, 02h, 02h, 22h, 60h, 06h
	defb	00h, 20h, 02h, 60h, 00h, 20h, 22h, 20h
	defb	02h, 22h, 02h, 00h, 60h, 22h, 02h, 02h
	defb	60h, 02h, 20h, 00h, 22h, 20h, 20h, 00h
