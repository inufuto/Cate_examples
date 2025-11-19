Port equ 0feh

Tempo equ 180

dseg
SoundProc:
    defw 0

cseg
InitSoundBeep: public InitSoundBeep
    push hl
        ld hl,0
        ld (SoundProc),hl
    pop hl
ret


CallSound:
jp (hl)

CallSoundBeep: public CallSoundBeep
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
                ld a,10h | out (Port), a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                ld a,00h | out (Port), a
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
                ld a,00h | out (Port), a
                push bc
                    do
                        dec bc
                        ld a,c | or b
                    while nz | wend
                pop bc
                ld a,00h | out (Port), a
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
                    ld bc,(cycles)
                    ld de,(cycles+2)
                    call Rest
                endif
            endif
        wend
    pop bc | pop de | pop af
ret


fire_notes:
    defb 1,A4, 1,A4, 0
Sound_Fire:
    push hl
        ld hl,fire_notes
        call Melody
    pop hl
ret
Sound_FireBeep:  public Sound_FireBeep
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
Sound_HitBeep:  public Sound_HitBeep
    push hl
        ld hl,Sound_Hit
        ld (SoundProc),hl
    pop hl
ret


loose_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Loose:
    push hl
        ld hl,loose_notes
        call Melody
    pop hl
ret
Sound_LooseBeep:  public Sound_LooseBeep
    push hl
        ld hl,Sound_Loose
        ld (SoundProc),hl
    pop hl
ret


up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up:
    push hl
        ld hl,up_notes
        call Melody
    pop hl
ret
Sound_UpBeep: public Sound_UpBeep
    push hl
        ld hl,Sound_Up
        ld (SoundProc),hl
    pop hl
ret


start_notes:
	defb 5,A4,1,0, 11,B4,1,0, 11,C5,1,0
	defb 11,C5,1,0, 5,A4,1,0, 11,D5,1,0
	defb 11,D5,1,0, 5,C5,1,0, 17,D5,1,0
	defb 35,E5,1,0
	defb 12,0
    defb 0
Sound_StartBeep: public Sound_StartBeep
    push hl
        ld hl,start_notes
        call Melody
    pop hl
ret

over_notes:
	defb 11,A4,1,0, 5,E4,1,0, 5,A4,1,0
	defb 5,G4,1,0, 5,F4,1,0, 5,E4,1,0, 5,D4,1,0
	defb 35,E4,1,0
	defb 12,0
    defb 0
Sound_GameOverBeep: public Sound_GameOverBeep
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
; F5S equ 22
; G5 equ 23

cycles:
defw 303,1100/Tempo ;A3
defw 286,1165/Tempo ;A#3
defw 269,1234/Tempo ;B3
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
; defw 90,3699/Tempo ;F#5
; defw 85,3919/Tempo ;G5
