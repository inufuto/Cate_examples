Tempo equ 150

MaxVol equ 63
VolStep equ 2
ChannelCount equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*ChannelCount
time:
    defw 0

cseg
InitSound: public InitSound
    ld ix,Channels
    ld b,ChannelCount
    ld de,unitSize
    xor a
    do
        ld (ix+Channel_Ptr),a
        ld (ix+Channel_Ptr+1),a
        add ix,de
    dwnz
    ld hl,0
    ld (time),hl
ret


SetVolumeCmd:
    defb 23,0,85h,0,2,0
SetVolumeCmdLength equ 6
SetVolume: ;(c,a)
    ld (SetVolumeCmd+5),a
    push af
        ld a,c
        ld (SetVolumeCmd+3),a
        push hl | push de | push bc
            ld hl,SetVolumeCmd
            ld bc,SetVolumeCmdLength
            defb 49h | rst 18h
        pop bc | pop de | pop hl
    pop af
ret
SetFrequencyCmd: ;(c,de)
    defb 23,0,85h,0,3 | defw 0
SetFrequencyCmdLength equ 7
SetFrequency:
    ld (SetFrequencyCmd+5),de
    push af
        ld a,c
        ld (SetFrequencyCmd+3),a
        push hl | push de | push bc
            ld hl,SetFrequencyCmd
            ld bc,SetFrequencyCmdLength
            defb 49h | rst 18h
        pop bc | pop de | pop hl
    pop af
ret

SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                ld bc,ChannelCount * 100h ; b = count; c = channel
                do
                    ld l,(ix+Channel_Ptr)
                    ld h,(ix+Channel_Ptr+1)
                    ld a,l | or h
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
                                xor a | call SetVolume
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
                            if nz
                                dec a
                                add a,a
                                ld e,a | ld d,0
                                ld hl,Cycles | add hl,de
                                ld e,(hl) | inc hl
                                ld d,(hl)
                                call SetFrequency
                                ld (ix+Channel_Vol),MaxVol
                            else
                                rest:
                                ld (ix+Channel_Vol),0
                            endif
                            EndWriteCycle:
                        endif
                        ld a,(ix+Channel_Vol)
                        or a
                        if nz
                            sub VolStep
                            if c
                                xor a
                            endif
                            ld (ix+Channel_Vol),a
                            call SetVolume
                        endif
                    endif
                    next:
                    inc c ; channel
                    ld de,unitSize | add ix,de
                dwnz
            pop ix | pop bc | pop hl
            ld de,600/2 | add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret


Melody:
    push af | push de
        di
            ld (Channels+Channel_Ptr),hl
            ld a,1
            ld (Channels+Channel_Len),a
            ld c,0
            xor a | call SetVolume
        ei
    pop de | pop af
ret

MelodyWait:
    call Melody
    push af
        do
            ext PollTimer_
            call PollTimer_
            ld hl,(Channels+Channel_Ptr)
            ld a,l | or h
        while nz | wend
    pop af
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


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push hl
        ld hl,beep_notes
        call MelodyWait
    pop hl
ret


; void Sound_Start();
start_notes: 
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N1,C5
    defb 0
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call MelodyWait
    pop hl
ret


; void Sound_Clear();
clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5
    defb 0
Sound_Clear_: public Sound_Clear_
    push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl
ret


; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,C5, N8,G4, N8,G4, N8,A4, N8,A4, N8,B4, N8,B4
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push hl
        ld hl,over_notes
        call MelodyWait
    pop hl
ret


BGM_B:
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,D5, N4,F5
    defb N8,F5, N8,E5, N8,C5, N4,C5, N4,D5
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N4,F5, N4,F5, N4,E5, N4,E5
    defb N4,D5, N8,D5, N4,E5, N8,E5, N8,D5, N8,C5
    defb N4,C5, N4,C5, N8,D5, N4,D5, N4P,C5, N2P,0
    defb 0ffh
BGM_C:
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 3
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0 ; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0 ; 5
    defb N8,G2, N4,0, N4P,B2, N8,D3, N8,0 ; 6
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0 ; 8
    defb N8,F2, N4,0, N4P,A2, N8,C3, N8,0 ; 9
    defb N8,D3, N4,0, N4P,E3, N8,A3, N8,0 ; 10
    defb N8,F2, N4,0, N8,F2, N8,G2, N8,0, N8,B2, N8,D3 ; 11
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 12
    defb 0ffh

StartBGM_: public StartBGM_
    push af | push hl
        di
            ld a,1
            ld hl,BGM_B
            ld (Channels+unitSize*1+Channel_Start),hl
            ld (Channels+unitSize*1+Channel_Ptr),hl
            ld (Channels+unitSize*1+Channel_Len),a
            ld hl,BGM_C
            ld (Channels+unitSize*2+Channel_Start),hl
            ld (Channels+unitSize*2+Channel_Ptr),hl
            ld (Channels+unitSize*2+Channel_Len),a
        ei
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push bc
        di
            ld hl,0
            ld (Channels+unitSize*1+Channel_Ptr),hl
            ld (Channels+unitSize*2+Channel_Ptr),hl
            ld bc,2*256 or 1
            do
                xor a | call SetVolume
                inc c
            dwnz
        ei
    pop bc | pop hl | pop af
ret


E2 equ 1
F2 equ 2
F2S equ 3
G2 equ 4
G2S equ 5
A2 equ 6
A2S equ 7
B2 equ 8
C3 equ 9
C3S equ 10
D3 equ 11
D3S equ 12
E3 equ 13
F3 equ 14
F3S equ 15
G3 equ 16
G3S equ 17
A3 equ 18
A3S equ 19
B3 equ 20
C4 equ 21
C4S equ 22
D4 equ 23
D4S equ 24
E4 equ 25
F4 equ 26
F4S equ 27
G4 equ 28
G4S equ 29
A4 equ 30
A4S equ 31
B4 equ 32
C5 equ 33
C5S equ 34
D5 equ 35
D5S equ 36
E5 equ 37
F5 equ 38
F5S equ 39
G5 equ 40

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2

Cycles:
defw 82 ;E2
defw 87 ;F2
defw 92 ;F#2
defw 98 ;G2
defw 104 ;G#2
defw 110 ;A2
defw 117 ;A#2
defw 123 ;B2
defw 131 ;C3
defw 139 ;C#3
defw 147 ;D3
defw 156 ;D#3
defw 165 ;E3
defw 175 ;F3
defw 185 ;F#3
defw 196 ;G3
defw 208 ;G#3
defw 220 ;A3
defw 233 ;A#3
defw 247 ;B3
defw 262 ;C4
defw 277 ;C#4
defw 294 ;D4
defw 311 ;D#4
defw 330 ;E4
defw 349 ;F4
defw 370 ;F#4
defw 392 ;G4
defw 415 ;G#4
defw 440 ;A4
defw 466 ;A#4
defw 494 ;B4
defw 523 ;C5
defw 554 ;C#5
defw 587 ;D5
defw 622 ;D#5
defw 659 ;E5
defw 698 ;F5
defw 740 ;F#5
defw 784 ;G5
