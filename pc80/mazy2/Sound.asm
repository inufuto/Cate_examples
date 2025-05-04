Port.Beep equ 40h

dseg
SoundProc:
    defw 0

cseg
InitSound_: public InitSound_
    push hl
        ld hl,0
        ld (SoundProc),hl
    pop hl
ret


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


long:
; in:
;   bc = length
; use af
    push bc
        ld a,20h
        out (Port.Beep), a
        do
            dec bc
            ld a,c
            or b
        while nz| wend
        xor a
        out (Port.Beep), a
    pop bc
ret 

Sound_Beep_: public Sound_Beep_
    push af
    push bc
        ld bc,750
        call long
    pop bc
    pop af
ret 


Pulse:
; in:
;   b = cycle
    ld a,20h
    out (Port.Beep), a
    push bc
        do
        dwnz
    pop bc
    xor a
    out (Port.Beep), a
    push bc
        do
        dwnz
    pop bc
ret 

DummyPulse:
; in:
;   b = cycle
    ld a,20h
    in a,(Port.Beep)
    push bc
        do
        dwnz
    pop bc
    xor a
    in a,(Port.Beep)
    push bc
        do
        dwnz
    pop bc
ret 


Tone:
; in:
;   b = cycle
;   hl = length
    push de
        ld e,b
        ld d,0
        do
            call Pulse
            or a
            sbc hl,de
        while nc | wend
    pop de
ret 

DummyTone:
; in:
;   b = cycle
;   hl = length
    push de
        ld e,b
        ld d,0
        do
            call DummyPulse
            or a
            sbc hl,de
        while nc | wend
    pop de
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
            ld a,b
            or a
            if nz
                dec a
                exx
                    ld e,a
                    ld d,0
                    ld hl,cycles
                    add hl,de
                    ld a,(hl)
                exx
                ld b,a
                push hl
                    ld h,c
                    ld l,0
                    add hl,hl
                    add hl,hl
                    add hl,hl
                    call Tone
                pop hl
            else
                ld a,(cycles)
                ld b,a
                push hl
                    ld h,c
                    ld l,0
                    add hl,hl
                    add hl,hl
                    add hl,hl
                    call DummyTone
                pop hl
            endif
        wend
    pop bc
    pop de
    pop af
ret


Sound_Get_: public Sound_Get_
    push hl
        ld hl,Sound_Beep_
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


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    push hl
        ld hl,hit_notes
        call Melody
    pop hl
ret
Sound_Hit_: public Sound_Hit_
    push hl
        ld hl,Sound_Hit
        ld (SoundProc),hl
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
D4S equ 4
E4 equ 5
F4 equ 6
FS equ 7
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

cycles:
defb 214 ;C4
defb 202 ;C#4
defb 190 ;D4
defb 179 ;D#4
defb 169 ;E4
defb 160 ;F
defb 151 ;F#4
defb 142 ;G4
defb 134 ;G#4
defb 127 ;A4
defb 120 ;A#4
defb 113 ;B4
defb 107 ;C5
defb 101 ;C#5
defb 95 ;D5
defb 89 ;D#5
defb 84 ;E5
defb 80 ;F5
