Port equ 1ch
Tempo equ 180

dseg
SoundProc: public SoundProc
    defw 0
Time:
    defw 0
ToneCount:
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


Tone:
;   bc = cycle
    do
        ld a,15h
        out (Port), a
        push bc
            do
                dec bc
                ld a,c
                or b
            while nz | wend
        pop bc
        ld a,05h
        out (Port), a
        push bc
            do
                dec bc
                ld a,c
                or b
            while nz | wend
        pop bc
        ld a,(ToneCount)
        or a
    while nz | wend
ret

Rest:
    do
        ld a,(ToneCount)
        or a
    while nz | wend
ret

SoundHandler70: public SoundHandler70
    push hl | push de
        ld hl,(time)
        ld de,-tempo
        add hl,de
        if nc
            push af
                ld a,(ToneCount)
                or a
                if nz
                    dec a
                    ld (ToneCount),a
                endif
                ld de,600/2
                add hl,de
            pop af
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody: 
; in
;   hl: address
    push af | push de | push bc
        do
            ld a,(hl) | inc hl
            ld b,(hl) | inc hl
            or a
        while nz
            ld (ToneCount),a
            ld a,b | or a
            if nz
                push hl
                    dec b
                    ld l,b | ld h,0
                    add hl,hl
                    ld de,cycles | add hl,de
                    ld c,(hl)
                    inc hl
                    ld b,(hl)
                pop hl
                call Tone
            else
                call Rest
            endif
        wend
    pop bc | pop de | pop af
ret


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire:
    push hl
        ld hl,fire_notes
        call Melody
    pop hl
ret
Sound_Fire70: public Sound_Fire70
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
Sound_Hit70:  public Sound_Hit70
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
Sound_Loose70:  public Sound_Loose70
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
Sound_Up70:  public Sound_Up70
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
Sound_Start70: public Sound_Start70
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
F5S equ 22
G5 equ 23

cycles:
defw 349   ;A3
defw 330   ;A#3
defw 311   ;B3
defw 294   ;C4
defw 277   ;C#4
defw 261   ;D4
defw 247   ;D#4
defw 233   ;E4
defw 220   ;F4
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
defw 103   ;F#5
defw 98   ;G5
