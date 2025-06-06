Tempo equ 220

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


Tone:
; in:
;   bc = cycle
;   de*a = length
    do
        push psw | push d
            do
                mvi a,OnValue | out PortC
                push b
                    do
                        dcx b
                        mov a,c | ora b
                    while nz | wend
                pop b
                mvi a,OffValue | out PortC
                push b
                    do
                        dcx b
                        mov a,c | ora b
                    while nz | wend
                pop b
                dcx d
                mov a,e | ora d
            while nz | wend
        pop d | pop psw
        dcr a
    while nz | wend
ret 


Rest:
; in:
;   bc = cycle
;   de*a = length
    do
        push psw | push d
            do
                mvi a,OffValue | out PortC
                push b
                    do
                        dcx b
                        mov a,c | ora b
                    while nz | wend
                pop b
                mvi a,OffValue | out PortC
                push b
                    do
                        dcx b
                        mov a,c | ora b
                    while nz | wend
                pop b
                dcx d
                mov a,e | ora d
            while nz | wend
        pop d | pop psw
        dcr a
    while nz | wend
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
                mov a,c
                if nz
                    push h
                        dcr b
                        mov l,b | mvi h,0
                        dad h | dad h
                        lxi d,cycles | dad d
                        mov c,m | inx h
                        mov b,m | inx h
                        mov e,m | inx h
                        mov d,m
                    pop h
                    call Tone
                else
                    lxi b,120
                    lxi d,1380/Tempo
                    call Rest
                endif
            endif
        wend
    pop b | pop d | pop psw
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


; void Sound_Get();
Sound_Get_: public Sound_Get_
    push h
        lxi h,Sound_Beep_
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


start_notes: 
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    push h
        lxi h,start_notes
        call Melody
    pop h
ret


clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push h
        lxi h,clear_notes
        call Melody
    pop h
ret

over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
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
defw 120,1308/Tempo ;C4
defw 113,1385/Tempo ;C#4
defw 107,1468/Tempo ;D4
defw 101,1555/Tempo ;D#4
defw 95,1648/Tempo ;E4
defw 90,1746/Tempo ;F4
defw 85,1849/Tempo ;F#4
defw 80,1959/Tempo ;G4
defw 75,2076/Tempo ;G#4
defw 71,2200/Tempo ;A4
defw 67,2330/Tempo ;A#4
defw 63,2469/Tempo ;B4
defw 60,2616/Tempo ;C5
defw 56,2771/Tempo ;C#5
defw 53,2936/Tempo ;D5
defw 50,3111/Tempo ;D#5
defw 47,3296/Tempo ;E5
defw 45,3492/Tempo ;F5
