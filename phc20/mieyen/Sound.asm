Tempo equ 180

HighValue equ 0f5h
LowValue equ 06h

dseg
SoundProc:
    defw 0

cseg
InitSound: public InitSound
    ld hl,0 | ld (SoundProc),hl
    ld a,LowValue | ld (6000h),a
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
                ld a,HighValue | ld (6000h),a
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend
                ld a,LowValue | ld (6000h),a
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend
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
                ld a,LowValue | ld (6000h),a
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend
                ld a,LowValue | ld (6000h),a
                ld l,c | ld h,b
                do
                    dec hl
                    ld a,l | or h
                while nz | wend
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
        ld a,(7fffh)
        cp 5ah
        jr z,Melody_skip
        do
            ld c,(hl) | inc hl
            ld b,(hl) | inc hl
            ld a,c | or a
        while nz
            push hl
                ld a,b
                or a
                if nz
                    ld a,c
                    dec b
                    ld l,b | ld h,0
                    add hl,hl
                    add hl,hl
                    ld de,cycles | add hl,de
                    ld c,(hl) | inc hl
                    ld b,(hl) | inc hl
                    ld e,(hl) | inc hl
                    ld d,(hl)
                    call Tone
                else
                    ld a,c
                    ld bc,(cycles)
                    ld de,(cycles+2)
                    call Rest
                endif
            pop hl
        wend
        Melody_skip:
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
Sound_Hit_:  public Sound_Hit_
    push hl
        ld hl,hit_notes
        call Melody
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
        ld hl,Sound_Stole | ld (SoundProc),hl
    pop hl
ret


beep_notes:
    defb 1,A4, 1,0, 0
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
F5S equ 19
G5 equ 20

cycles:
defw 263,1308/Tempo ;C4
defw 248,1385/Tempo ;C#4
defw 234,1468/Tempo ;D4
defw 221,1555/Tempo ;D#4
defw 208,1648/Tempo ;E4
defw 197,1746/Tempo ;F4
defw 186,1849/Tempo ;F#4
defw 175,1959/Tempo ;G4
defw 165,2076/Tempo ;G#4
defw 156,2200/Tempo ;A4
defw 147,2330/Tempo ;A#4
defw 139,2469/Tempo ;B4
defw 131,2616/Tempo ;C5
defw 124,2771/Tempo ;C#5
defw 117,2936/Tempo ;D5
defw 110,3111/Tempo ;D#5
defw 104,3296/Tempo ;E5
defw 98,3492/Tempo ;F5
defw 93,3699/Tempo ;F#5
defw 87,3919/Tempo ;G5
