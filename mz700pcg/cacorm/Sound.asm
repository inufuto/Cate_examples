ext WaitTimer_

Tempo equ 180

Count equ 2
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Tone equ Channel_Start+2
Channel_Len equ Channel_Tone+2
UnitSize equ Channel_Len+1


dseg
Channels: public Channels
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
time:
    defw 0


cseg
InitSound: public InitSound
    push af | push hl
        di
            ld hl,0
            ld (time),hl

            ld ix,Channels
            ld b,Count
            ld de,UnitSize
            xor a
            do
                ld (ix+Channel_Ptr),a
                ld (ix+Channel_Ptr+1),a
                ld (ix+Channel_Tone),a
                ld (ix+Channel_Tone+1),a
                add ix,de
            dwnz
        ei
    pop hl | pop af
ret


ToneOn:                                                                         public ToneOn
; in
;   hl : cycle
    push af
        ld a,36h
        ld (0e007h),a
        ld a,l
        ld (0e004h),a
        ld a,h
        ld (0e004h),a
        ld a,1
        ld (0e008h),a
    pop af
ret

ToneOff:
    xor a
    ld (0e008h),a
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                ld b,Count
                do
                    ld l,(ix+Channel_Ptr)
                    ld h,(ix+Channel_Ptr+1)
                    ld a,l
                    or h
                    if nz
                        dec (ix+Channel_Len)                        
                        if z
                            continue:
                            ld a,(hl)
                            or a
                            if z
                                ; end
                                ld (ix+Channel_Ptr),a
                                ld (ix+Channel_Ptr+1),a
                                offch:
                                xor a
                                ld (ix+Channel_Tone),a
                                ld (ix+Channel_Tone+1),a
                                ld a,b
                                cp 2 
                                if z
                                    ; Channel0
                                    ld hl,(Channel1+Channel_Tone)
                                    ld a,l
                                    or h
                                    if nz
                                        call ToneOn
                                        jr next
                                    endif
                                endif
                                call ToneOff
                                jr next
                            endif
                            inc a
                            if z 
                                ; repeat
                                ld l,(ix+Channel_Start)
                                ld h,(ix+Channel_Start+1)
                                jr continue
                            endif
                            dec a
                            ld (ix+Channel_Len),a
                            inc hl
                            ld a,(hl)
                            inc hl
                            ld (ix+Channel_Ptr),l
                            ld (ix+Channel_Ptr+1),h
                            or a
                            jr z,offch
                            dec a
                            add a,a
                            ld e,a
                            ld d,0
                            ld hl,cycles
                            add hl,de
                            ld a,(hl)
                            inc hl
                            ld h,(hl)
                            ld l,a
                            ld (ix+Channel_Tone),l
                            ld (ix+Channel_Tone+1),h
                            ld a,b
                            cp 1
                            if z
                                ; Channel1
                                ld a,(ix+Channel_Tone-UnitSize)
                                or (ix+Channel_Tone-UnitSize+1)
                                if nz
                                    jr next
                                endif
                            endif
                            call ToneOn
                        endif
                    endif
                    next:
                    ld de,UnitSize
                    add ix,de
                dwnz
            pop ix | pop bc | pop hl
            ld de,600/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret


Melody:
    di
        ld (Channel0+Channel_Ptr),hl
        ld a,1
        ld (Channel0+Channel_Len),a
    ei
ret

MelodyWait:
    call Melody
    do
        ld hl,(Channel0+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push hl
        ld hl,loose_notes
        call MelodyWait
    pop hl
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push hl
        ld hl,hit_notes
        call MelodyWait
    pop hl
ret


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push hl
        ld hl,beep_notes
        call MelodyWait
    pop hl
ret


; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push hl
        ld hl,up_notes
        call MelodyWait
    pop hl
ret


; void Sound_Start();
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
        call MelodyWait
    pop hl
ret


; void Sound_Clear();
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
        call MelodyWait
    pop hl
ret


; void Sound_GameOver();
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
        call MelodyWait
    pop hl
ret


BGM_B:
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,D4,1,0
	defb 11,D4,1,0, 5,D4,1,0, 11,E4,1,0
	defb 17,D4,1,0, 36,0
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,F4,1,0
	defb 11,F4,1,0, 5,F4,1,0, 11,A4,1,0
	defb 17,G4,1,0, 36,0
	defb 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 11,E4,1,0
	defb 5,E4,1,0, 11,A4,1,0, 5,D4,1,0
	defb 5,D4,1,0, 5,D4,1,0, 11,D4,1,0
	defb 5,D4,1,0, 11,G4,1,0, 6,0
	defb 5,A4,1,0, 6,0, 5,G4,1,0, 6,0
	defb 5,F4,1,0, 6,0, 5,E4,1,0, 11,D4,1,0
	defb 11,E4,1,0, 23,C4,1,0
    defb 0ffh

StartBGM_: public StartBGM_
    push af | push hl
        di
            ld a,1
            ld hl,BGM_B
            ld (Channel1+Channel_Start),hl
            ld (Channel1+Channel_Ptr),hl
            ld (Channel1+Channel_Len),a
        ei
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push bc
        di
            ld hl,0
            ld (Channel1+Channel_Ptr),hl
            ld (Channel1+Channel_Tone),hl
            call ToneOff
        ei
    pop bc | pop hl | pop af
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
defw 4067 ; A3
defw 3839 ; A#3
defw 3623 ; B3
defw 3420 ; C4
defw 3228 ; C#4
defw 3047 ; D4
defw 2876 ; D#4
defw 2714 ; E4
defw 2562 ; F4
defw 2418 ; F#4
defw 2282 ; G4
defw 2154 ; G#4
defw 2033 ; A4
defw 1919 ; A#4
defw 1811 ; B4
defw 1710 ; C5
defw 1614 ; C#5
defw 1523 ; D5
defw 1438 ; D#5
defw 1357 ; E5
defw 1281 ; F5
defw 1209 ; F#5
defw 1141 ; G5
