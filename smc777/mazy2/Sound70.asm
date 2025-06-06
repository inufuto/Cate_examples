ext TimerCount

Port equ 1ch
Tempo equ 220

dseg
SoundProc: public SoundProc
    defw 0
Time:
    defw 0
LastTimer:
    defb 0


cseg
InitSound70: public InitSound70
    ld hl,0
    ld (SoundProc),hl
ret


CallSound:
jp (hl)

CallSound70: public CallSound70
    push af | push hl
        ld hl,(SoundProc)
        ld a,l
        or h
        if nz
            call CallSound
            ld hl,0
            ld (SoundProc),hl
        endif
    pop hl | pop af
ret


CountDown:
    push hl | push bc
        ld hl,(Time)
        ld bc,-Tempo
        add hl,bc
        if nc
            dec e
            ld bc,600/2
            add hl,bc
        endif
        ld (Time),hl
    pop bc | pop hl
ret


Tone:
; in:
;   bc = cycle
;   a = length
    push hl | push de | push bc
        ld e,a
        ld a,(LastTimer) | ld d,a
        do
            do
                ld a,15h | out (Port), a
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend

                ld a,05h | out (Port), a
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend

                ld a,(TimerCount)
                cp d
            while z | wend
            ld d,a
            call CountDown
            inc e | dec e
        while nz | wend
        ld a,d | ld (LastTimer),a
    pop bc | pop de | pop hl
ret 

Rest:
; in:
;   b = cycle
;   a = length
    push hl | push de | push bc
        ld e,a
        ld a,(LastTimer) | ld d,a
        do
            do
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend

                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend

                ld a,(TimerCount)
                cp d
            while z | wend
            ld d,a
            call CountDown
            inc e | dec e
        while nz | wend
        ld a,d | ld (LastTimer),a
    pop bc | pop de | pop hl
ret 


Melody: 
; in
;   hl: address
    push af | push de | push bc
        do
            ld c,(hl) | inc hl
            ld b,(hl) | inc hl
            ld a,c
            or a
        while nz
            if nz
                ld a,b
                or a
                if nz
                    push hl
                        ld a,c
                        dec b
                        ld l,b
                        ld h,0
                        add hl,hl
                        ld de,cycles
                        add hl,de
                        ld c,(hl)
                        inc hl
                        ld b,(hl)
                    pop hl
                    push hl
                        call Tone
                    pop hl
                else
                    push hl
                        ld a,c
                        call Rest
                    pop hl
                endif
            endif
        wend
    pop bc | pop de | pop af
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    push hl
        ld hl,hit_notes
        call Melody
    pop hl
ret
Sound_Hit70:  public Sound_Hit70
    push hl
        ld hl,Sound_Hit
        ld (SoundProc),hl
    pop hl
ret


loose_notes:
    defb 1,A3, 0
Sound_Loose70:  public Sound_Loose70
    push hl
        ld hl,loose_notes
        call Melody
    pop hl
ret


beep_notes:
    defb 1,A4, 1,0, 0
Sound_Beep70:  public Sound_Beep70
    push hl
        ld hl,beep_notes
        call Melody
    pop hl
ret


Sound_Get70: public Sound_Get70
    push hl
        ld hl,Sound_Beep70
        ld (SoundProc),hl
    pop hl
ret


start_notes:
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start70: public Sound_Start70
    push hl
        ld hl,start_notes
        call Melody
    pop hl
ret


clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear70: public Sound_Clear70
    push hl
        ld hl,clear_notes
        call Melody
    pop hl
ret


over_notes:
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver70: public Sound_GameOver70
    push hl
        ld hl,over_notes
        call Melody
    pop hl
ret


A3 equ 1
A3S equ 2
B3 equ 3
C4 equ 4
C4S equ 5
D4 equ 6
D4S equ 7
E4 equ 8
F4 equ 9
F4S equ 10
G4 equ 11
G4S equ 12
A4 equ 13
A4S equ 14
B4 equ 15
C5 equ 16
C5S equ 17
D5 equ 18
D5S equ 19
E5 equ 20
F5 equ 21

cycles:
defw 349   ;A3
defw 330   ;A#3
defw 311   ;B3
defw 294   ;C4
defw 277   ;C#4
defw 261   ;D4
defw 247   ;D#4
defw 233   ;E4
defw 220   ;F
defw 207   ;F#4
defw 196   ;G4
defw 185   ;G#4
defw 174   ;A4
defw 165   ;A#4
defw 155   ;B4
defw 147   ;C5
defw 138   ;C#5
defw 130   ;D5
defw 123   ;D#5
defw 116   ;E5
defw 110   ;F5
