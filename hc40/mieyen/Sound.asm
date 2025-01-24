include "hc40.inc"

ext WaitTimer_

Port19Value equ 0f006h

tempo equ 180

dseg
SoundProc_: public SoundProc_
    defw 0

cseg
InitSound: public InitSound
    push hl
        ld hl,0
        ld (SoundProc_),hl
    pop hl
ret


; void CallSound();
cseg
CallSound:
jp (hl)
CallSound_: public CallSound_
    push af | push hl
        ld hl,(SoundProc_)
        ld a,l
        or h
        if nz
            call CallSound
            ld hl,0
            ld (SoundProc_),hl
        endif
    pop hl | pop af
ret


Pulse:
; in:
;   bc = cycle
    ld a,(Port19Value) | or 80h | ld (Port19Value),a
    out (IOCTLR), a
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
    ld a,(Port19Value) | and not 80h | ld (Port19Value),a
    out (IOCTLR), a
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
ret 


Tone:
; in:
;   bc = cycle
;   hl = length
    push de
        ld e,c | ld d,b
        srl d | rr e
        do
            call Pulse
            or a
            sbc hl,de
        while nc | wend
    pop de
ret 


Dummy:
; in:
;   bc = cycle
    ld a,(Port19Value) | out (IOCTLR), a
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
    ld a,(Port19Value) | out (IOCTLR), a
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
ret 

Rest:
; in:
;   b = cycle
;   hl = length
    push de
        ld e,c | ld d,b
        srl d | rr e
        do
            call Dummy
            or a
            sbc hl,de
        while nc | wend
    pop de
ret 


MakeLangth:
    ld h,a
    ld l,0
    ; ld d,h
    ; ld e,l
    add hl,hl ;*2
    add hl,hl ;*4
    ; add hl,hl ;*8
    ; add hl,hl ;*16
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
                        call MakeLangth
                        call Tone
                    pop hl
                else
                    push hl
                        ld a,c
                        ld bc,100*2
                        call MakeLangth
                        call Rest
                    pop hl
                endif
            endif
        wend
    pop bc | pop de | pop af
    ei
ret


; void Sound_Loose();
cseg
loose_notes:
    defb 1,A3, 0
Sound_Loose_:  public Sound_Loose_
    push af | push hl
        ld hl,loose_notes
        call Melody
    pop hl | pop af
ret


; void Sound_Hit();
cseg
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
        ld (SoundProc_),hl
    pop hl
ret


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole: 
    push hl
        ld hl,stole_notes
        call Melody
    pop hl
ret
Sound_Stole_:  public Sound_Stole_
    push hl
        ld hl,Sound_Stole
        ld (SoundProc_),hl
    pop hl
ret


; void Sound_Beep();
cseg
beep_notes:
    defb 1,A4, 1,0, 0
Sound_Beep_:  public Sound_Beep_
    push hl
        ld hl,beep_notes
        call Melody
    pop hl
ret
; void Sound_Fire();
cseg
Sound_Fire_:  public Sound_Fire_
    push hl
        ld hl,Sound_Beep_
        ld (SoundProc_),hl
    pop hl
ret


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push hl
        ld hl,bonus_notes
        call Melody
    pop hl
ret


; void Sound_Start();
cseg
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


; void Sound_Clear();
cseg
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


; void Sound_GameOver();
cseg
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
defw 699   ;A3
defw 660   ;A#3
defw 623   ;B3
defw 588   ;C4
defw 555   ;C#4
defw 523   ;D4
defw 494   ;D#4
defw 466   ;E4
defw 440   ;F4
defw 415   ;F#4
defw 392   ;G4
defw 370   ;G#4
defw 349   ;A4
defw 330   ;A#4
defw 311   ;B4
defw 294   ;C5
defw 277   ;C#5
defw 261   ;D5
defw 247   ;D#5
defw 233   ;E5
defw 220   ;F5
