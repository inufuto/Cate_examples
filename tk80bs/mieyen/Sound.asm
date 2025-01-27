PortC equ $fa
OnValue equ $72
OffValue equ $70

dseg
SoundProc:
    defw 0

cseg
InitSound: public InitSound
    lxi h,0
    shld SoundProc
ret


; void CallSound();
CallSound:
pchl
CallSound_: public CallSound_
    push psw | push h
        lhld SoundProc
        mov a,l
        ora h
        if nz
            call CallSound
            lxi h,0
            shld SoundProc 
        endif
    pop h | pop psw
ret


Pulse:
; in:
;   bc = cycle
;   e = out
    mov a,e | out PortC
    push b
        do
            dcx b
            mov a,c
            ora b
        while nz | wend
    pop b
    mvi a,OffValue | out PortC
    push b
        do
            dcx b
            mov a,c
            ora b
        while nz | wend
    pop b
ret 

Tone:
; in:
;   b = cycle
;   hl = length
;   e = out
    push d
        do
            call Pulse
            mov a,l | sub c | mov l,a
            mov a,h | sbb b | mov h,a
        while nc | wend
    pop d
ret 


MakeLength:
    mov h,a
    mvi l,0
    mov d,h
    mov e,l
    dad h ;*2
    dad h ;*4
    ; dad d ;*5
ret


Melody:
; in
;   hl: address
    push psw | push d | push b
        do
            mov c,m | inx h
            mov b,m | inx h
            mov a,c
            ora a
        while nz
            if nz
                mov a,b
                ora a
                if nz
                    push h
                        mov a,c
                        dcr b
                        mov l,b
                        mvi h,0
                        dad h
                        lxi d,cycles
                        dad d
                        mov c,m
                        inx h
                        mov b,m
                    pop h
                    push h
                        call MakeLength
                        mvi e,OnValue
                        call Tone
                    pop h
                else
                    push h
                        mov a,c
                        lxi b,100
                        call MakeLength
                        mvi e,OffValue
                        call Tone
                    pop h
                endif
            endif
        wend
    pop b | pop d | pop psw
ret


; void Sound_Loose();
cseg
loose_notes:
    defb 1,C4, 1,0, 0
Sound_Loose:
    push h
        lxi h,loose_notes
        call Melody
    pop h
ret 
Sound_Loose_: public Sound_Loose_
    push h
        lxi h,Sound_Loose
        shld SoundProc
    pop h
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit: 
    push h
        lxi h,hit_notes
        call Melody
    pop h
ret
Sound_Hit_:  public Sound_Hit_
    push h
        lxi h,Sound_Hit
        shld SoundProc
    pop h
ret


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole: 
    push h
        lxi h,stole_notes
        call Melody
    pop h
ret
Sound_Stole_:  public Sound_Stole_
    push h
        lxi h,Sound_Stole
        shld SoundProc
    pop h
ret


; void Sound_Beep();
beep_notes:
    defb 1,A4, 1,0, 0
Sound_Beep_:  public Sound_Beep_
    push h
        lxi h,beep_notes
        call Melody
    pop h
ret
; void Sound_Fire();
Sound_Fire_: public Sound_Fire_
    push h
        lxi h,Sound_Beep_
        shld SoundProc
    pop h
ret


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_:  public Sound_Bonus_
    push h
        lxi h,bonus_notes
        call Melody
    pop h
ret


start_notes: 
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push h
        lxi h,start_notes
        call Melody
    pop h
ret


clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push h
        lxi h,clear_notes
        call Melody
    pop h
ret

over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push h
        lxi h,over_notes
        call Melody
    pop h
ret


C4 equ 1
C4S equ 2
D4 equ 3
D4S equ 4
E4 equ 5
F4 equ 6
F4S equ 7
G4 equ 8
G4S equ 9
A4 equ 10
A4S equ 11
B4 equ 12
C5 equ 13
C5S equ 14
D5 equ 15
D5S equ 16
E5 equ 17
F5 equ 18
F5S equ 19
G5 equ 20

cycles:
defw 120   ;C4
defw 113   ;C#4
defw 107   ;D4
defw 101   ;D#4
defw 95   ;E4
defw 90   ;F4
defw 85   ;F#4
defw 80   ;G4
defw 75   ;G#4
defw 71   ;A4
defw 67   ;A#4
defw 63   ;B4
defw 60   ;C5
defw 56   ;C#5
defw 53   ;D5
defw 50   ;D#5
defw 47   ;E5
defw 45   ;F5
defw 42   ;F#5
defw 40   ;G5
