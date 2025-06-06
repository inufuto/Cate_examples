ext WaitTimer_

TimerPort equ 04h
MemBankPort equ 18h
OffValue equ 12h
OnValue equ OffValue or 04h

Tempo equ 220

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
        call ToneOff
    pop hl | pop af
ret


ToneOn: public ToneOn
; in
;   hl : cycle
    push af
        ld a,l | out (TimerPort),a
        ld a,h | out (TimerPort),a
        ld a,OnValue | out (MemBankPort),a
    pop af
ret

ToneOff:
    ld a,OffValue | out (MemBankPort),a
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
    push af
        di
            ld (Channel0+Channel_Ptr),hl
            ld a,1
            ld (Channel0+Channel_Len),a
        ei
    pop af
ret

MelodyWait:
    call Melody
    push af
        do
            ld hl,(Channel0+Channel_Ptr)
            ld a,l
            or h
        while nz | wend
    pop af
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


; void Sound_Get();
Sound_Get_: public Sound_Get_
    push hl
        ld hl,beep_notes
        call Melody
    pop hl
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
        call Melody
    pop hl
ret


; void Sound_Start();
start_notes:
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
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
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
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
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver_:
    public Sound_GameOver_
    push hl
        ld hl,over_notes
        call MelodyWait
    pop hl
ret


BGM_B:
	defb 5,D4,1,0, 5,F4,1,0, 5,G4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0
	defb 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,G4,1,0, 23,F4,1,0, 23,G4,1,0
	defb 35,A4,1,0, 5,D4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 5,G4,1,0, 23,F4,1,0, 23,G4,1,0
	defb 35,F4,1,0
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
F5S equ 24
G5 equ 25

cycles:
defw 10187 ; G3
defw 9616 ; G#3
defw 9076 ; A3
defw 8566 ; A#3
defw 8086 ; B3
defw 7632 ; C4
defw 7203 ; C#4
defw 6799 ; D4
defw 6417 ; D#4
defw 6057 ; E4
defw 5717 ; F4
defw 5396 ; F#4
defw 5093 ; G4
defw 4808 ; G#4
defw 4538 ; A4
defw 4283 ; A#4
defw 4043 ; B4
defw 3816 ; C5
defw 3601 ; C#5
defw 3399 ; D5
defw 3208 ; D#5
defw 3028 ; E5
defw 2858 ; F5
defw 2698 ; F#5
defw 2546 ; G5
