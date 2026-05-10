; 0000-003f Interrupt Vectors
; 0040-007f Waveforms
dseg
    defs 40h

PianoWave:
	defb 0efh,0ach,89h,56h,44h,23h,22h,12h
	defb 10h,22h,22h,43h,54h,86h,0a9h,0ech
BassWave:
	defb 99h,78h,45h,23h,11h,00h,10h,21h
	defb 22h,11h,00h,10h,21h,43h,75h,98h
SquareWave:
	defb 88h,88h,88h,88h,88h,88h,88h,88h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
; SquareWave:
	defb 88h,88h,88h,88h,88h,88h,88h,88h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
; SawWave:
; 	defb 00h,10h,11h,21h,22h,32h,33h,43h
; 	defb 44h,54h,55h,65h,66h,76h,77h,87h
; SineWave:
; 	defb 0ffh,0eeh,0cdh,9ah,68h,35h,12h,01h
; 	defb 00h,11h,32h,65h,97h,0cah,0edh,0feh
; LeadWave:
; 	defb 3ch,25h,12h,10h,20h,22h,33h,33h
; 	defb 34h,33h,23h,22h,10h,10h,22h,35h
; Lead2Wave:
; 	defb 9ch,14h,11h,11h,11h,00h,00h,00h
; 	defb 00h,00h,00h,10h,11h,11h,11h,94h
