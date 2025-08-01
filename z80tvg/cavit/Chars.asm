cseg

CharPattern: public CharPattern
	; ascii
	defb 00h,00h,00h,00h,22h,22h,20h,02h
	defb 55h,00h,00h,00h,22h,27h,27h,02h
	defb 72h,73h,76h,02h,51h,24h,51h,04h
	defb 52h,12h,55h,02h,22h,02h,00h,00h
	defb 12h,11h,11h,02h,42h,44h,44h,02h
	defb 50h,25h,55h,00h,20h,72h,22h,00h
	defb 00h,00h,22h,01h,00h,70h,00h,00h
	defb 00h,00h,20h,02h,40h,24h,11h,00h
	defb 52h,55h,55h,02h,22h,22h,22h,02h
	defb 52h,44h,12h,07h,52h,24h,54h,02h
	defb 54h,75h,44h,04h,17h,31h,44h,03h
	defb 52h,31h,55h,02h,57h,44h,22h,02h
	defb 52h,25h,55h,02h,52h,65h,54h,02h
	defb 20h,02h,22h,00h,20h,02h,22h,01h
	defb 40h,12h,42h,00h,00h,07h,07h,00h
	defb 10h,42h,12h,00h,52h,24h,02h,02h
	defb 52h,55h,11h,06h,52h,55h,57h,05h
	defb 53h,35h,55h,03h,52h,11h,51h,02h
	defb 53h,55h,55h,03h,17h,31h,11h,07h
	defb 17h,31h,11h,01h,16h,51h,55h,02h
	defb 55h,75h,55h,05h,27h,22h,22h,07h
	defb 46h,44h,54h,02h,75h,13h,73h,05h
	defb 11h,11h,11h,07h,75h,77h,55h,05h
	defb 53h,55h,55h,05h,52h,55h,55h,02h
	defb 53h,55h,13h,01h,52h,55h,35h,06h
	defb 53h,55h,53h,05h,52h,21h,54h,02h
	defb 27h,22h,22h,02h,55h,55h,55h,07h
	defb 55h,55h,25h,02h,55h,75h,77h,05h
	defb 55h,22h,52h,05h,55h,25h,22h,02h
	defb 47h,24h,11h,07h,26h,22h,22h,06h
	defb 10h,21h,44h,00h,23h,22h,22h,03h
	defb 52h,00h,00h,00h,00h,00h,00h,07h
	; logo
	defb 00h,00h,00h,00h,33h,33h,00h,00h
	defb 00h,00h,33h,33h,33h,33h,33h,33h
	defb 0cch,0cch,00h,00h,0ffh,0ffh,00h,00h
	defb 0cch,0cch,33h,33h,0ffh,0ffh,33h,33h
	defb 00h,00h,0cch,0cch,33h,33h,0cch,0cch
	defb 00h,00h,0ffh,0ffh,33h,33h,0ffh,0ffh
	defb 0cch,0cch,0cch,0cch,0ffh,0ffh,0cch,0cch
	defb 0cch,0cch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	; 8dot
	defb 0ffh,0fdh,0ffh,0fbh,0ffh,0ffh,0fbh,0feh
	defb 00h,00h,00h,00h,11h,00h,11h,00h
	defb 00h,88h,00h,88h,0afh,00h,00h,00h
	defb 00h,00h,00h,0f5h,0bfh,00h,11h,00h
	defb 0afh,88h,00h,88h,11h,00h,11h,0f5h
	defb 00h,88h,00h,0fdh,0ddh,0bbh,77h,0eeh
	; 16dot
	defb 00h,0cch,0cch,0cch,00h,11h,00h,11h
	defb 88h,88h,66h,22h,00h,00h,11h,33h
	defb 00h,0cch,0cch,0cch,00h,11h,00h,11h
	defb 0cch,0aah,44h,0cch,00h,22h,00h,00h
	defb 00h,88h,00h,88h,00h,33h,33h,33h
	defb 00h,00h,88h,0cch,11h,11h,66h,44h
	defb 00h,88h,00h,88h,00h,33h,33h,33h
	defb 00h,44h,00h,00h,33h,55h,22h,33h
	defb 00h,00h,0eeh,0eeh,00h,0cch,44h,33h
	defb 0aah,00h,00h,00h,0cch,88h,00h,00h
	defb 00h,00h,0eeh,0eeh,00h,22h,0ddh,0bbh
	defb 0aah,00h,00h,00h,00h,22h,00h,00h
	defb 00h,00h,00h,0aah,00h,00h,88h,0cch
	defb 0eeh,0eeh,00h,00h,33h,44h,0cch,00h
	defb 00h,00h,00h,0aah,00h,00h,22h,00h
	defb 0eeh,0eeh,00h,00h,0bbh,0ddh,22h,00h
	defb 00h,0cch,0cch,0cch,0eeh,55h,44h,55h
	defb 88h,88h,66h,22h,33h,00h,11h,33h
	defb 00h,88h,88h,88h,00h,33h,11h,33h
	defb 00h,00h,88h,88h,99h,0eeh,88h,11h
	defb 77h,0aah,22h,0aah,00h,33h,33h,33h
	defb 0cch,00h,88h,0cch,11h,11h,66h,44h
	defb 00h,0cch,88h,0cch,00h,11h,11h,11h
	defb 99h,77h,11h,88h,00h,00h,11h,11h
	defb 00h,00h,0eeh,0eeh,00h,0cch,44h,33h
	defb 0aah,11h,0ffh,11h,0ddh,99h,00h,00h
	defb 00h,00h,00h,0eeh,00h,00h,00h,0cch
	defb 0eeh,0aah,00h,00h,99h,22h,22h,77h
	defb 11h,0ffh,11h,0aah,00h,00h,99h,0ddh
	defb 0eeh,0eeh,00h,00h,33h,44h,0cch,00h
	defb 00h,00h,0aah,0eeh,77h,22h,22h,99h
	defb 0eeh,00h,00h,00h,0cch,00h,00h,00h
	defb 88h,0cch,0cch,0eeh,22h,77h,22h,0ffh
	defb 0cch,0cch,88h,0cch,77h,33h,13h,01h
	defb 80h,0c8h,0cch,0cch,20h,72h,27h,72h
	defb 0ech,0ceh,8ch,0cch,0f7h,3fh,33h,11h
	defb 44h,0eeh,44h,0ffh,11h,33h,33h,77h
	defb 0eeh,0cch,8ch,08h,33h,33h,11h,33h
	defb 40h,0e4h,4eh,0e4h,10h,31h,33h,33h
	defb 0feh,0cfh,0cch,88h,73h,37h,13h,33h
	defb 44h,0eeh,0aah,0ffh,11h,33h,22h,77h
	defb 0eeh,0eeh,0cch,88h,33h,33h,11h,00h
	defb 40h,0e4h,0aeh,0eah,10h,31h,23h,32h
	defb 0feh,0efh,0eeh,0cch,73h,37h,33h,11h
	defb 88h,0cch,0cch,0eeh,22h,77h,77h,0ffh
	defb 0cch,0cch,88h,00h,77h,77h,33h,11h
	defb 80h,0c8h,0cch,0cch,20h,72h,77h,77h
	defb 0ech,0ceh,0cch,88h,0f7h,7fh,77h,33h
	defb 77h,33h,33h,11h,0ddh,88h,0ddh,00h
	defb 33h,33h,77h,33h,88h,0cch,0ech,0feh
	defb 7fh,37h,33h,33h,0dfh,8dh,0d8h,8dh
	defb 13h,31h,73h,33h,08h,0c0h,0cch,0eeh
	defb 0bbh,11h,0bbh,00h,0eeh,0cch,0cch,88h
	defb 11h,33h,73h,0f7h,0cch,0cch,0eeh,0cch
	defb 0bfh,1bh,0b1h,1bh,0efh,0ceh,0cch,0cch
	defb 01h,30h,33h,77h,8ch,0c8h,0ech,0cch
	defb 0bbh,11h,55h,00h,0eeh,0cch,0ddh,88h
	defb 11h,11h,33h,77h,0cch,0cch,0eeh,0ffh
	defb 0bfh,1bh,51h,15h,0efh,0ceh,0dch,0cdh
	defb 01h,10h,11h,73h,8ch,0c8h,0cch,0feh
	defb 77h,33h,33h,11h,0ddh,88h,88h,00h
	defb 33h,33h,77h,0ffh,88h,88h,0cch,0eeh
	defb 7fh,37h,33h,33h,0dfh,8dh,88h,88h
	defb 13h,31h,33h,0f7h,08h,80h,88h,0ech
	defb 40h,0aeh,0aah,4eh,40h,0aeh,0aah,5fh
	defb 0c8h,6ch,0eah,22h,73h,0d7h,0fah,99h
	defb 0c8h,0a4h,0aeh,5eh,10h,33h,76h,0d7h
	defb 0bfh,0ffh,5fh,0cah,0ebh,0bfh,0b5h,25h
	defb 00h,0a0h,0bah,2bh,00h,21h,22h,12h
	defb 22h,22h,07h,00h,0a4h,0aah,4ah,00h
	defb 00h,0a0h,0dfh,4ch,00h,21h,22h,12h
	defb 26h,12h,07h,00h,0a4h,0aah,4ah,00h
	defb 00h,0c0h,0cch,5dh,00h,21h,22h,12h
	defb 75h,47h,04h,00h,0a4h,0aah,4ah,00h
	defb 00h,0a0h,0ddh,2dh,00h,21h,22h,12h
	defb 52h,55h,02h,00h,0a4h,0aah,4ah,00h
	defb 22h,66h,88h,88h,33h,11h,00h,00h
	defb 0cch,0cch,0cch,00h,11h,00h,11h,00h
	defb 00h,00h,11h,33h,00h,00h,00h,55h
	defb 0cch,22h,33h,00h,77h,77h,00h,00h
	defb 80h,0ech,9dh,0aah,33h,77h,0ffh,0ffh
	defb 55h,33h,66h,44h,37h,0c9h,7eh,13h
