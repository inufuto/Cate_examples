Port equ 18h
Tempo equ 220

dseg
SoundProc:
    defw 0


cseg
InitSound: public InitSound
    ld hl,0
    ld (SoundProc),hl
ret


; void CallSound();
cseg
CallSound:
jp (hl)
CallSound_: public CallSound_
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

Tone:
; in:
;   bc = cycle
;   de*a = length
    do
        push af | push de
            do
                in a,(Port) | or 0c0h | out (Port), a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                in a,(Port) | and not 0c0h | out (Port), a
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
                in a,(Port) | and not 0c0h | out (Port), a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                in a,(Port) | and not 0c0h | out (Port), a
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
    di
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
                    ld bc,588
                    ld de,1453/Tempo
                    call Rest
                endif
            endif
        wend
    pop bc | pop de | pop af
    ei
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
        ld (SoundProc),hl
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
        ld (SoundProc),hl
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
defw 588,1453/Tempo ;C4
defw 555,1539/Tempo ;C#4
defw 523,1631/Tempo ;D4
defw 494,1728/Tempo ;D#4
defw 466,1831/Tempo ;E4
defw 440,1940/Tempo ;F
defw 415,2055/Tempo ;F#4
defw 392,2177/Tempo ;G4
defw 370,2307/Tempo ;G#4
defw 349,2444/Tempo ;A4
defw 330,2589/Tempo ;A#4
defw 311,2743/Tempo ;B4
defw 294,2906/Tempo ;C5
defw 277,3079/Tempo ;C#5
defw 261,3262/Tempo ;D5
defw 247,3456/Tempo ;D#5
defw 233,3662/Tempo ;E5
defw 220,3880/Tempo ;F5
