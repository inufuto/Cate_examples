Port equ 40h

dseg
SoundProc:
    defw 0
cseg

InitSound: public InitSound
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


SoundHandler: public SoundHandler
StartBGM_: public StartBGM_
StopBGM_: public StopBGM_
ret


Beep:
; in:
;   bc = length
; use af
    push bc
        ld a,20h
        out (Port), a
        do
            dec bc
            ld a,c
            or b
        while nz| wend
        xor a
        out (Port), a
    pop bc
ret 
Sound_Beep_: public Sound_Beep_
    push af | push bc
        ld bc,750
        call Beep
    pop bc | pop af
ret 


Pulse:
;   bc = cycle
    ld a,20h
Pulse_out:
    out (Port), a
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
    xor a
    out (Port), a
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
ret 

Dummy:
    xor a
jr Pulse_out


Tone:
;   bc = cycle
;   hl = length
    push de
        do
            call Pulse
            or a
            sbc hl,bc
        while nc | wend
    pop de
ret 

Rest:
;   bc = cycle
;   hl = length
    push de
        do
            call Dummy
            or a
            sbc hl,bc
        while nc | wend
    pop de
ret 


MakeLength:
    ld h,a
    ld l,0
    ld d,h
    ld e,l
    add hl,hl ;*2
    add hl,de ;*3
    add hl,hl ;*6
ret

Melody: 
;   hl: address
    push af
    push de
    push bc
    di
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
                        call MakeLength
                        call Tone
                    pop hl
                else
                    push hl
                        ld a,c
                        ld bc,100
                        call MakeLength
                        call Rest
                    pop hl
                endif
            endif
        wend
    ei
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
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call Melody
    pop hl
ret

clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push hl
        ld hl,clear_notes
        call Melody
    pop hl
ret

over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
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
