Port equ 0fch
Tempo equ 220

dseg
SoundProc_: public SoundProc_
    defw 0

cseg

InitSound: public InitSound
    ld hl,0
    ld (SoundProc_),hl
ret


CallSound:
jp (hl)

CallSound_: public CallSound_
    push af | push hl
        ld hl,(SoundProc_)
        ld a,l | or h
        if nz
            call CallSound
            ld hl,0
            ld (SoundProc_),hl
        endif
    pop hl | pop af
ret


Tone:
; in:
;   bc = cycle
;   de*a = length
    do
        push af | push de
            do
                in a,(Port) 
                or 01h
                out (Port), a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                in a,(Port)
                and not 01h
                out (Port), a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                dec de
                ld a,e | or d
            while nz | wend
        pop de | pop af
        dec a
    while nz | wend
ret 


Rest:
; in:
;   bc = cycle
;   de*a = length
    do
        push af | push de
            do
                in a,(Port) 
                and not 01h
                out (Port), a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                in a,(Port)
                and not 01h
                out (Port), a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                dec de
                ld a,e | or d
            while nz | wend
        pop de | pop af
        dec a
    while nz | wend
ret 


Melody: 
; in
;   hl: address
    push af
    push de
    push bc
        do
            ld c,(hl) | inc hl
            ld b,(hl) | inc hl
            ld a,c
            or a
        while nz
            if nz
                ld a,b
                or a
                ld a,c
                if nz
                    push hl
                        dec b
                        ld l,b | ld h,0
                        add hl,hl | add hl,hl
                        ld de,cycles | add hl,de
                        ld c,(hl) | inc hl
                        ld b,(hl) | inc hl
                        ld e,(hl) | inc hl
                        ld d,(hl)
                    pop hl
                    call Tone
                else
                    ld bc,294
                    ld de,1308/Tempo
                    call Rest
                endif
            endif
        wend
    pop bc
    pop de
    pop af
ret


beep_notes:
    defb 1,A4, 1,0, 0
Sound_Beep_:  public Sound_Beep_
    push hl
        ld hl,beep_notes
        call Melody
    pop hl
ret


Sound_Get_: public Sound_Get_
    push hl
        ld hl,Sound_Beep_
        ld (SoundProc_),hl
    pop hl
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0
Sound_Hit: 
    push af | push hl
        ld hl,hit_notes
        call Melody
    pop hl | pop af
ret
Sound_Hit_:  public Sound_Hit_
    push hl
        ld hl,Sound_Hit
        ld (SoundProc_),hl
    pop hl
ret


loose_notes:
    defb 1,C4, 0
Sound_Loose_: public Sound_Loose_
    push hl
        ld hl,loose_notes
        call Melody
    pop hl
ret


start_notes: 
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_:
    public Sound_Start_
    push hl
        ld hl,start_notes
        call Melody
    pop hl
ret

clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_:
    public Sound_Clear_
    push hl
        ld hl,clear_notes
        call Melody
    pop hl
ret

over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver_:
    public Sound_GameOver_
    push hl
        ld hl,over_notes
        call Melody
    pop hl
ret


C4 equ 1
C4S equ 2
D4 equ 3
E4 equ 5
F4 equ 6
G4 equ 8
A4 equ 10
B4 equ 12
C5 equ 13
D5 equ 15
E5 equ 17
F5 equ 18

cycles:
defw 254,1308/Tempo ;C4
defw 240,1385/Tempo ;C#4
defw 227,1468/Tempo ;D4
defw 214,1555/Tempo ;D#4
defw 202,1648/Tempo ;E4
defw 190,1746/Tempo ;F4
defw 180,1849/Tempo ;F#4
defw 170,1959/Tempo ;G4
defw 160,2076/Tempo ;G#4
defw 151,2200/Tempo ;A4
defw 143,2330/Tempo ;A#4
defw 134,2469/Tempo ;B4
defw 127,2616/Tempo ;C5
defw 120,2771/Tempo ;C#5
defw 113,2936/Tempo ;D5
defw 107,3111/Tempo ;D#5
defw 101,3296/Tempo ;E5
defw 95,3492/Tempo ;F5
