ext TimerCount

PortAddress equ 6800h
PortByte equ 08h
Tempo equ 220

dseg
SoundProc: public SoundProc
    defw 0
Time:
    defw 0
LastTimer:
    defb 0

cseg
InitSound: public InitSound
    ld hl,0
    ld (SoundProc),hl
    ld (Time),hl
    ld a,(TimerCount)
    ld (LastTimer),a
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


CountDown:
    push hl | push bc
        ld hl,(Time)
        ld bc,-Tempo
        add hl,bc
        if nc
            dec e
            ld bc,600/2
            add hl,bc
        endif
        ld (Time),hl
    pop bc | pop hl
ret

Tone:
; in:
;   bc = cycle
;   a = length
    push hl | push de | push bc
        ld e,a
        ld a,(LastTimer) | ld d,a
        do
            do
                ld a,PortByte or 01h | ld (PortAddress),a
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend

                ld a,PortByte or 20h | ld (PortAddress),a
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend

                ld a,(TimerCount)
                cp d
            while z | wend
            ld d,a
            call CountDown
            inc e | dec e
        while nz | wend
        ld a,d | ld (LastTimer),a
    pop bc | pop de | pop hl
ret 

Rest:
; in:
;   b = cycle
;   a = length
    push hl | push de | push bc
        ld e,a
        ld a,(LastTimer) | ld d,a
        do
            do
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend

                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend

                ld a,(TimerCount)
                cp d
            while z | wend
            ld d,a
            call CountDown
            inc e | dec e
        while nz | wend
        ld a,d | ld (LastTimer),a
    pop bc | pop de | pop hl
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
                        call Tone
                    pop hl
                else
                    push hl
                        ld a,c
                        call Rest
                    pop hl
                endif
            endif
        wend
    pop bc | pop de | pop af
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
    push hl
        ld hl,hit_notes
        call Melody
    pop hl
ret
Sound_Hit_:  public Sound_Hit_
    push hl
        ld hl,Sound_Hit | ld (SoundProc),hl
    pop hl
ret


loose_notes:
    defb 2,C4, 2,0, 0
Sound_Loose_: public Sound_Loose_
    push af | push hl
        ld hl,loose_notes
        call Melody
    pop hl | pop af
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
defw 263   ;C4
defw 248   ;C#4
defw 234   ;D4
defw 221   ;D#4
defw 208   ;E4
defw 197   ;F4
defw 186   ;F#4
defw 175   ;G4
defw 165   ;G#4
defw 156   ;A4
defw 147   ;A#4
defw 139   ;B4
defw 131   ;C5
defw 124   ;C#5
defw 117   ;D5
defw 110   ;D#5
defw 104   ;E5
defw 98   ;F5
