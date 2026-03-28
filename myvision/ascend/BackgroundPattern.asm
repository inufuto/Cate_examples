cseg
BackgroundPattern_: public BackgroundPattern_
	; 0: Floor_Space
	defb 55h,0aah,55h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
	; 1: LeftLadder_Floor
	defb 7fh,7fh,60h,60h,7fh,7fh,60h,0aah,55h,0aah,55h,00h,00h,00h,00h
	; 2: LeftLadder_LeftLadder
	defb 7fh,7fh,60h,60h,7fh,7fh,60h,60h,7fh,7fh,60h,60h,7fh,7fh,60h
	; 3: LeftLadder_Wall
	defb 7fh,7fh,60h,60h,7fh,7fh,60h,0aah,55h,0aah,55h,0aah,55h,0aah,55h
	; 4: RightLadder_Floor
	defb 0feh,0feh,06h,06h,0feh,0feh,06h,0aah,55h,0aah,55h,00h,00h,00h,00h
	; 5: RightLadder_RightLadder
	defb 0feh,0feh,06h,06h,0feh,0feh,06h,06h,0feh,0feh,06h,06h,0feh,0feh,06h
	; 6: Space_Floor
	defb 00h,00h,00h,00h,00h,00h,00h,0aah,55h,0aah,55h,00h,00h,00h,00h
	; 7: Space_LeftLadder
	defb 00h,00h,00h,00h,00h,00h,00h,60h,7fh,7fh,60h,60h,7fh,7fh,60h
	; 8: Space_RightLadder
	defb 00h,00h,00h,00h,00h,00h,00h,06h,0feh,0feh,06h,06h,0feh,0feh,06h
	; 9: Space_Wall
	defb 00h,00h,00h,00h,00h,00h,00h,0aah,55h,0aah,55h,0aah,55h,0aah,55h
	; 10: Wall_Floor
	defb 55h,0aah,55h,0aah,55h,0aah,55h,0aah,55h,0aah,55h,00h,00h,00h,00h
	; 11: Wall_Space
	defb 55h,0aah,55h,0aah,55h,0aah,55h,00h,00h,00h,00h,00h,00h,00h,00h
	; 12: Wall_Wall
	defb 55h,0aah,55h,0aah,55h,0aah,55h,0aah,55h,0aah,55h,0aah,55h,0aah,55h
	; 13: Gap
	defb 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
	; 14: Gap
	defb 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
	; 15: Gap
	defb 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
	; 16: LeftLowerBlock_Space
	defb 0dfh,0dfh,0dfh,0dfh,0c0h,0ffh,7fh,00h,00h,00h,00h,00h,00h,00h,00h
	; 17: LeftUpperBlock_LeftLowerBlock
	defb 0ffh,0c0h,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0c0h,0ffh,7fh
	; 18: RightLowerBlock_Space
	defb 0fbh,0fbh,0fbh,0fbh,03h,0ffh,0feh,00h,00h,00h,00h,00h,00h,00h,00h
	; 19: RightUpperBlock_RightLowerBlock
	defb 0ffh,03h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,03h,0ffh,0feh
	; 20: Space_LeftUpperBlock
	defb 00h,00h,00h,00h,00h,00h,00h,7fh,0ffh,0c0h,0dfh,0dfh,0dfh,0dfh,0dfh
	; 21: Space_RightUpperBlock
	defb 00h,00h,00h,00h,00h,00h,00h,0feh,0ffh,03h,0fbh,0fbh,0fbh,0fbh,0fbh
	; 22: Gap
	defb 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
	; 23: Gap
	defb 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
