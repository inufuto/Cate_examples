include "Share.inc"
include "Sub.inc"

ext CmdLoop

Tempo equ 220

Count equ 2
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Tone equ Channel_Start+2
Channel_Len equ Channel_Tone+2
UnitSize equ Channel_Len+1


dseg
SoundChannels: public SoundChannels
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
time:
    defw 0


cseg
InitSound: public InitSound
    ; OUT2 (counter 2, mode 0) drives GATE1: low stops the tone
    ld a,0b0h | out (PitPort+3),a

    ld a,08h | out (PpiPort+3),a ; PC4 low: fixed, avoids envelope
    
    ld hl,0
    ld (time),hl

    ld ix,SoundChannels
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
ret


ToneOn:
; in
;   hl : cycle
    push af
        ld a,76h | out (PitPort+3),a
        ld a,l | out (PitPort+1),a
        ld a,h | out (PitPort+1),a
        ; mode set drives OUT2 low, then count 1 raises it: GATE1 high
        ld a,0b0h | out (PitPort+3),a
        ld a,1 | out (PitPort+2),a
        xor a | out (PitPort+2),a
    pop af
ret

ToneOff:
    ld a,0b0h | out (PitPort+3),a ; OUT2 low: GATE1 low, output held high
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,SoundChannels
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

            ld de,(SoundChannels+Channel_Ptr)
            ld a,e | or d
            ld (SubShareRam+Share_Playing),a
        endif
        ld (time),hl
    pop de | pop hl
ret


Melody:
    ld (Channel0+Channel_Ptr),hl
    ld a,1
    ld (Channel0+Channel_Len),a
    ld (SubShareRam+Share_Playing),a
ret

beep_notes:
    defb 1,A4, 0
Sound_Beep:
    ld hl,beep_notes
    call Melody
jp CmdLoop

hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    ld hl,hit_notes
    call Melody
jp CmdLoop

loose_notes:
    defb 1,A3, 0
Sound_Loose:
    ld hl,loose_notes
    call Melody
jp CmdLoop

start_notes: 
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start:
    ld hl,start_notes
    call Melody
jp CmdLoop

clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear:
    ld hl,clear_notes
    call Melody
jp CmdLoop

over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver:
    ld hl,over_notes
    call Melody
jp CmdLoop


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

StartBGM:
    ld a,1
    ld hl,BGM_B
    ld (Channel1+Channel_Start),hl
    ld (Channel1+Channel_Ptr),hl
    ld (Channel1+Channel_Len),a
jp CmdLoop

StopBGM:
    ld hl,0
    ld (Channel1+Channel_Ptr),hl
    ld (Channel1+Channel_Tone),hl
    call ToneOff
jp CmdLoop

JumpTable:
    defw Sound_Beep
    defw Sound_Hit
    defw Sound_Loose
    defw Sound_Start
    defw Sound_Clear
    defw Sound_GameOver
    defw StartBGM
    defw StopBGM

PlaySound: public PlaySound
    ld a,(SubShareRam+Share_SoundId)
    add a,a
    ld l,a | ld h,0
    ld de,JumpTable | add hl,de
    ld a,(hl) | inc hl
    ld h,(hl) | ld l,a
jp (hl)


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
defw 11139 ; A3
defw 10514 ; A#3
defw 9924 ; B3
defw 9367 ; C4
defw 8841 ; C#4
defw 8345 ; D4
defw 7877 ; D#4
defw 7434 ; E4
defw 7017 ; F4
defw 6623 ; F#4
defw 6252 ; G4
defw 5901 ; G#4
defw 5569 ; A4
defw 5257 ; A#4
defw 4962 ; B4
defw 4683 ; C5
defw 4420 ; C#5
defw 4172 ; D5
defw 3938 ; D#5
defw 3717 ; E5
defw 3508 ; F5
defw 3311 ; F#5
defw 3126 ; G5
