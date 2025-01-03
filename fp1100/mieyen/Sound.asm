include "SubMain_.inc"

ext SendSub

dseg
SoundProc:
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
    ld a,l
    or h
    if nz
        call CallSound
        ld hl,0
        ld (SoundProc),hl
    endif
    pop hl | pop af
ret


Pulse:
;   bc = cycle
    ld a,low Sub.BeepOn
Pulse_out:
    call SendSub
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
    ld a,low Sub.BeepOff
    call SendSub
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
ret 

Dummy:
    ld a,low Sub.BeepOff
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
    ; ld d,h
    ; ld e,l
    add hl,hl ;*2
    add hl,hl ;*4
    add hl,hl ;*8
    ; add hl,de ;*5
ret

Melody: 
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
    pop bc | pop de | pop af
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
Sound_Hit_:  public Sound_Hit_
    push hl
        ld hl,Sound_Hit
        ld (SoundProc),hl
    pop hl
ret


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole:
    push hl
        ld hl,stole_notes
        call Melody
    pop hl
ret
Sound_Stole_: public Sound_Stole_
    push hl
        ld hl,Sound_Stole
        ld (SoundProc),hl
    pop hl
ret


beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push hl
        ld hl,beep_notes
        call Melody
    pop hl
ret


Sound_Fire_: public Sound_Fire_
    push hl
        ld hl,Sound_Beep_
        ld (SoundProc),hl
    pop hl
ret


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push hl
        ld hl,bonus_notes
        call Melody
    pop hl
ret


start_notes: 
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_:
    public Sound_Start_
    push hl
        ld hl,start_notes
        call Melody
    pop hl
ret


clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_:
    public Sound_Clear_
    push hl
        ld hl,clear_notes
        call Melody
    pop hl
ret


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
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

cycles:
defw 611 ;C4
defw 577 ;C#4
defw 544 ;D4
defw 514 ;D#4
defw 485 ;E4
defw 458 ;F4
defw 432 ;F#4
defw 408 ;G4
defw 385 ;G#4
defw 363 ;A4
defw 343 ;A#4
defw 323 ;B4
defw 305 ;C5
defw 288 ;C#5
defw 272 ;D5
defw 257 ;D#5
defw 242 ;E5
defw 229 ;F5