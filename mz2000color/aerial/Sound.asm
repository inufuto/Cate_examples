Port equ 0e2h

dseg
SoundProc_: public SoundProc_
    defw 0

cseg

InitSound_: public InitSound_
    push hl
        ld hl,0
        ld (SoundProc_),hl
    pop hl
ret


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
    in a,(Port) 
    or 04h
    out (Port), a
    push bc
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
    in a,(Port)
    and not 04h
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
;   b = cycle
;   hl = length
    push de
        do
            call Pulse
            or a
            sbc hl,bc
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
        do
            call Dummy
            or a
            sbc hl,bc
        while nc | wend
    pop de
ret 



Sound_Fire_: public Sound_Fire_
    push af | push hl | push de | push bc
        ld bc, 100
        do
            Sound_Fire_.Loop:
            call Pulse
            ld l,c
            ld h,b
            ld de,5
            add hl,de
            ld c,l
            ld b,h
            ld a,b
            or a
            jr z,Sound_Fire_.Loop
            ld a,c
            cp low 300
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


Sound_Hit:
    push af | push hl | push de | push bc
        ld bc, 500
        do
            Sound_Hit_.Loop:
            call Pulse
            ld l,c
            ld h,b
            ld de,-5
            add hl,de
            ld c,l
            ld b,h
            ;ld a,b
            ;or a
            ;jr nz,Sound_Hit_.Loop
            ld a,c
            cp 300
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret 

Sound_Hit_:  public Sound_Hit_
    push hl
        ld hl,Sound_Hit
        ld (SoundProc_),hl
    pop hl
ret


Sound_Loose:
    push af | push bc
        ld bc, 150
        do
            Sound_Miss_.Loop:
            call Pulse
            inc bc
            ld a,b
            or a
            jr z,Sound_Miss_.Loop
            ld a,c
            cp low 300
        while nz | wend
    pop bc | pop af
ret 

Sound_Loose_:  public Sound_Loose_
    push hl
        ld hl,Sound_Loose
        ld (SoundProc_),hl
    pop hl
ret


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


N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2


MakeLangth:
    ld h,a
    ld l,0
    ld d,h
    ld e,l
    add hl,hl ;*2
    add hl,de ;*3
    add hl,hl ;*6
    add hl,de ;*7
    ; add hl,hl ;*14
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
                        ld bc,100
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

up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up:
    ld hl,up_notes
    call Melody
ret

Sound_Up_:  public Sound_Up_
    push hl
        ld hl,Sound_Up
        ld (SoundProc_),hl
    pop hl
ret


start_notes:
	defb 14,G4,1,0, 6,G4,1,0, 6,C5,1,0
	defb 6,E5,1,0, 14,D5,1,0, 6,C5,1,0
	defb 10,D5,1,0, 2,D5,1,0, 6,D5,1,0, 6,E5,1,0
	defb 14,D5,1,0, 15,0
    defb 0
Sound_Start_:
    public Sound_Start_
    push hl
        ld hl,start_notes
        call Melody
    pop hl
ret


over_notes:
	defb 6,F5,1,0, 6,F5,1,0, 6,E5,1,0, 6,E5,1,0
	defb 6,D5,1,0, 6,D5,1,0, 6,C5,1,0, 6,C5,1,0
	defb 6,B4,1,0, 6,G4,1,0, 6,A4,1,0, 6,B4,1,0
	defb 31,C5
    defb 0
Sound_GameOver_:
    public Sound_GameOver_
    push hl
        ld hl,over_notes
        call Melody
    pop hl
ret
