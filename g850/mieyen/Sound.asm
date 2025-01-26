Port equ 18h
tempo equ 180

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


Pulse:
; in:
;   bc = cycle
    in a,(Port) 
    or 0c0h
    out (Port), a
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
    in a,(Port)
    and not 0c0h
    out (Port), a
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
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
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
    add hl,hl ;*2
    add hl,hl ;*4
    ld d,h
    ld e,l
    add hl,hl ;*8
    add hl,de ;*12
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
    pop bc
    pop de
    pop af
ret


; void Sound_Loose();
cseg
loose_notes:
    defb 1,C4, 0
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
        ld (SoundProc),hl
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
        ld (SoundProc),hl
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
	defb 17,A4,1,0, 15,C5,16,C5,5,0
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
	defb 11,B4,1,0, 15,C5,14,C5,1,0
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
	defb 16,C5,15,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_:
    public Sound_GameOver_
    push hl
        ld hl,over_notes
        call Melody
    pop hl
ret



cycles:
defw 588   ;C4
defw 555   ;C#4
defw 523   ;D4
defw 494   ;D#4
defw 466   ;E4
defw 440   ;F
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
