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
	defb	00h, 00h, 00h, 11h, 00h, 00h, 00h, 11h
	defb	11h, 00h, 00h, 00h, 11h, 00h, 00h, 00h
;	8dot
	defb	11h, 10h, 01h, 10h, 01h, 10h, 11h, 10h
	defb	11h, 10h, 01h, 10h, 01h, 10h, 10h, 01h
	defb	10h, 01h, 01h, 10h, 01h, 10h, 11h, 10h
	defb	10h, 01h, 01h, 10h, 11h, 01h, 10h, 01h
	defb	00h, 00h, 22h, 62h, 00h, 22h, 62h, 26h
	defb	22h, 22h, 22h, 22h, 00h, 20h, 22h, 22h
	defb	26h, 22h, 02h, 00h, 26h, 66h, 26h, 26h
	defb	22h, 66h, 22h, 22h, 66h, 22h, 22h, 00h
	defb	06h, 66h, 60h, 65h, 66h, 00h, 00h, 07h
	defb	66h, 07h, 77h, 77h, 60h, 76h, 76h, 06h
	defb	60h, 65h, 66h, 06h, 57h, 55h, 50h, 66h
	defb	70h, 00h, 50h, 66h, 06h, 06h, 66h, 60h
;	sprite
	defb	00h, 00h, 00h, 00h, 55h, 00h, 50h, 00h
	defb	55h, 05h, 55h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 05h, 20h, 25h, 00h, 50h
	defb	50h, 00h, 05h, 00h, 00h, 00h, 50h, 50h
	defb	00h, 00h, 00h, 00h, 55h, 00h, 50h, 00h
	defb	55h, 05h, 55h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 07h, 00h, 00h, 02h, 02h, 00h, 05h
	defb	20h, 20h, 00h, 50h, 00h, 00h, 00h, 00h
	defb	05h, 00h, 05h, 00h, 55h, 00h, 05h, 00h
	defb	50h, 50h, 50h, 00h, 00h, 00h, 00h, 00h
	defb	50h, 00h, 00h, 05h, 52h, 52h, 00h, 50h
	defb	20h, 20h, 55h, 05h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 07h, 00h, 00h
	defb	77h, 77h, 00h, 00h, 77h, 77h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 55h, 50h, 55h, 00h
	defb	55h, 00h, 05h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 05h, 05h, 05h, 00h, 50h, 00h
	defb	00h, 55h, 00h, 05h, 00h, 70h, 00h, 50h
	defb	00h, 00h, 00h, 00h, 55h, 50h, 55h, 00h
	defb	55h, 00h, 05h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 50h, 05h, 00h, 05h
	defb	00h, 70h, 00h, 50h, 20h, 20h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 05h, 05h, 05h, 00h
	defb	55h, 00h, 50h, 00h, 50h, 00h, 50h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 55h, 50h
	defb	05h, 00h, 00h, 05h, 55h, 00h, 00h, 50h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	77h, 77h, 00h, 00h, 77h, 77h, 00h, 00h
	defb	77h, 70h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 55h, 55h, 55h, 00h
	defb	55h, 55h, 55h, 00h, 00h, 00h, 00h, 00h
	defb	25h, 20h, 00h, 00h, 05h, 05h, 50h, 50h
	defb	50h, 50h, 05h, 00h, 50h, 50h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 55h, 55h, 55h, 00h
	defb	55h, 55h, 55h, 00h, 00h, 00h, 00h, 00h
	defb	05h, 02h, 00h, 00h, 05h, 05h, 50h, 00h
	defb	50h, 50h, 05h, 05h, 50h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 55h, 55h, 55h, 00h
	defb	55h, 55h, 55h, 00h, 00h, 00h, 00h, 00h
	defb	05h, 02h, 00h, 00h, 05h, 05h, 50h, 50h
	defb	50h, 50h, 05h, 05h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 70h, 77h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	77h, 77h, 77h, 77h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 55h, 00h, 50h, 00h
	defb	55h, 05h, 55h, 00h, 00h, 00h, 00h, 00h
	defb	05h, 05h, 07h, 00h, 05h, 05h, 50h, 50h
	defb	52h, 52h, 05h, 00h, 20h, 20h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 55h, 50h, 55h, 00h
	defb	55h, 00h, 05h, 00h, 00h, 00h, 00h, 00h
	defb	05h, 07h, 00h, 00h, 05h, 05h, 50h, 00h
	defb	50h, 50h, 05h, 05h, 52h, 02h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 55h, 00h
	defb	00h, 00h, 55h, 05h, 00h, 00h, 00h, 00h
	defb	00h, 05h, 05h, 00h, 50h, 00h, 00h, 50h
	defb	50h, 00h, 00h, 05h, 50h, 52h, 02h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 77h, 77h, 77h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 07h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 07h, 77h, 70h
	defb	77h, 07h, 77h, 70h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 07h, 00h, 07h, 00h, 70h
	defb	00h, 00h, 07h, 00h, 00h, 00h, 70h, 70h
	defb	00h, 00h, 00h, 00h, 77h, 07h, 77h, 70h
	defb	77h, 07h, 77h, 70h, 00h, 00h, 00h, 00h
	defb	00h, 07h, 00h, 00h, 00h, 00h, 00h, 07h
	defb	00h, 00h, 70h, 70h, 00h, 70h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 70h, 77h, 07h
	defb	77h, 70h, 77h, 07h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 07h, 07h, 00h, 00h, 70h, 00h
	defb	00h, 70h, 00h, 07h, 00h, 00h, 00h, 70h
	defb	00h, 00h, 00h, 00h, 77h, 70h, 77h, 07h
	defb	77h, 70h, 77h, 07h, 00h, 00h, 00h, 00h
	defb	00h, 07h, 00h, 00h, 00h, 00h, 07h, 07h
	defb	00h, 00h, 00h, 70h, 00h, 70h, 00h, 00h
	defb	00h, 00h, 00h, 07h, 77h, 77h, 77h, 00h
	defb	77h, 77h, 77h, 00h, 00h, 00h, 00h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 70h, 70h
	defb	00h, 00h, 07h, 00h, 70h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 07h, 77h, 77h, 77h, 00h
	defb	77h, 77h, 77h, 00h, 00h, 00h, 00h, 70h
	defb	07h, 00h, 00h, 00h, 00h, 00h, 70h, 00h
	defb	00h, 00h, 07h, 07h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 77h, 07h, 77h, 70h
	defb	77h, 07h, 77h, 70h, 00h, 00h, 00h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 70h, 70h
	defb	00h, 00h, 07h, 00h, 70h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 07h, 77h, 70h, 77h, 07h
	defb	77h, 70h, 77h, 07h, 00h, 00h, 00h, 00h
	defb	07h, 00h, 00h, 00h, 00h, 00h, 70h, 00h
	defb	00h, 00h, 07h, 07h, 00h, 00h, 00h, 00h
	defb	07h, 77h, 77h, 07h, 07h, 77h, 07h, 77h
	defb	07h, 70h, 77h, 07h, 70h, 77h, 70h, 77h
	defb	77h, 07h, 77h, 07h, 77h, 70h, 77h, 07h
	defb	70h, 77h, 77h, 70h, 77h, 70h, 07h, 70h
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
	defb	04h, 41h, 41h, 41h, 44h, 41h, 41h, 41h
	defb	44h, 44h, 22h, 24h, 40h, 44h, 24h, 24h
	defb	41h, 44h, 04h, 00h, 11h, 44h, 44h, 00h
	defb	22h, 24h, 44h, 00h, 24h, 44h, 40h, 00h
