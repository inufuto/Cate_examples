Port equ 0ffh
Tempo equ 180

dseg
SoundProc: public SoundProc
    defw 0

cseg
InitSound: public InitSound
    ld hl,0
    ld (SoundProc),hl
ret


CallSound:
jp (hl)

CallSound_: public CallSound_
    push af | push hl
        ld hl,(SoundProc)
        ld a,l | or h
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
                ld a,5
                out (Port),a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                ld a,4
                out (Port),a
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
                ld a,4
                out (Port),a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                ld a,4
                out (Port),a
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
                    ld bc,(cycles)
                    ld de,(cycles+2)
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
Sound_Fire:
    push hl
        ld hl,beep_notes
        call Melody
    pop hl
ret
Sound_Fire_:  public Sound_Fire_
    push hl
        ld hl,Sound_Fire
        ld (SoundProc),hl
    pop hl
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
Sound_Hit_:  public Sound_Hit_
    push hl
        ld hl,Sound_Hit
        ld (SoundProc),hl
    pop hl
ret


loose_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Loose:
    ld hl,loose_notes
    call Melody
ret
Sound_Loose_:  public Sound_Loose_
    push hl
        ld hl,Sound_Loose
        ld (SoundProc),hl
    pop hl
ret


up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up:
    ld hl,up_notes
    call Melody
ret
Sound_Up_:  public Sound_Up_
    push hl
        ld hl,Sound_Up
        ld (SoundProc),hl
    pop hl
ret


start_notes: 
	defb 5,E4,1,0, 11,F4S,1,0, 11,G4,1,0
	defb 11,G4,1,0, 5,E4,1,0, 11,A4,1,0
	defb 11,A4,1,0, 5,G4,1,0, 17,A4,1,0
	defb 35,B4,1,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call Melody
    pop hl
ret


over_notes: 
	defb 11,E4,1,0, 5,B3,1,0, 5,E4,1,0
	defb 5,D4,1,0, 5,C4,1,0, 5,B3,1,0, 5,A3,1,0
	defb 35,B3,1,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
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
F5S equ 22
G5 equ 23

cycles:
defw 299,660/Tempo ;A3
defw 282,699/Tempo ;A#3
defw 266,740/Tempo ;B3
defw 251,784/Tempo ;C4
defw 237,831/Tempo ;C#4
defw 224,880/Tempo ;D4
defw 211,933/Tempo ;D#4
defw 200,988/Tempo ;E4
defw 188,1047/Tempo ;F4
defw 178,1109/Tempo ;F#4
defw 168,1175/Tempo ;G4
defw 158,1245/Tempo ;G#4
defw 149,1320/Tempo ;A4
defw 141,1398/Tempo ;A#4
defw 133,1481/Tempo ;B4
defw 125,1569/Tempo ;C5
defw 118,1663/Tempo ;C#5
defw 112,1761/Tempo ;D5
defw 105,1866/Tempo ;D#5
defw 100,1977/Tempo ;E5
defw 94,2095/Tempo ;F5
defw 89,2219/Tempo ;F#5
defw 84,2351/Tempo ;G5
