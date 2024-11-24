Tempo equ 180
Rate equ 4000

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


Melody: 
    push af | push bc
        do
            ld a,(hl) | inc hl ; length
            or a
        while nz
            ld b,a
            ld a,(hl) | inc hl ; tone
            or a
            if nz
                push hl
                    dec a
                    add a,a ;*2
                    add a,low Cycles
                    ld l,a
                    ld a,0
                    adc a,high Cycles
                    ld h,a
                    ld a,(hl) | inc hl
                    out (0f2h),a
                    ld a,(hl)
                    out (0f3h),a
                    in a,(0f4h)
                    and 61h | or 0eh
                    out (0f4h),a
                pop hl
            else
                in a,(0f4h)
                and 61h | or 0ch
                out (0f4h),a
            endif
            push hl
                do
                    ld hl,Rate/Tempo*100
                    do
                        dec hl
                        ld a,l | or h
                    while nz | wend
                dwnz
            pop hl
        wend
        in a,(0f4h)
        and 61h | or 0ch
        out (0f4h),a
    pop bc | pop af
ret


; void Sound_Loose();
loose_notes:
    defb 1,C4, 0
Sound_Loose_:  public Sound_Loose_
    push hl
        ld hl,loose_notes
        call Melody
    pop hl
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


; void Sound_Start();
cseg
start_notes: 
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
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

Cycles:
defw 873   ;A3
defw 824   ;A#3
defw 778   ;B3
defw 734   ;C4
defw 693   ;C#4
defw 654   ;D4
defw 617   ;D#4
defw 582   ;E4
defw 550   ;F4
defw 519   ;F#4
defw 490   ;G4
defw 462   ;G#4
defw 436   ;A4
defw 412   ;A#4
defw 389   ;B4
defw 367   ;C5
defw 346   ;C#5
defw 327   ;D5
defw 309   ;D#5
defw 291   ;E5
defw 275   ;F5
