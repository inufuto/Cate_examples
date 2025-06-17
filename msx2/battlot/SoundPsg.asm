include "BIOS.inc"

ext TempoValue

Psg_Tone.A equ 0
Psg_Tone.B equ 2
Psg_Tone.C equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_Volume.A equ 8
Psg_Volume.B equ 9
Psg_Volume.C equ 10
Psg_EnvTime equ 11
Psg_EnvType equ 13
Psg_Input1 equ 14
Psg_Input2 equ 15

HighNoise equ 0f0h
LowNoise equ 0f1h

MaxVol equ 63
HighNoiseValue equ 11
LowNoiseValue equ 27

Tempo equ 180

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

    dseg
Channels defs unitSize*count
time: defw 0
end_of_dseg: public end_of_dseg
mixerValue: defb 0
shootingTone: defw 0

    cseg

InitSoundPsg: public InitSoundPsg
    ld ix,Channels
    ld b,count
    ld de,unitSize
    xor a
    do
        ld (ix+Channel_Ptr),a
        ld (ix+Channel_Ptr+1),a
        add ix,de
    dwnz
    ld hl,0
    ld (time),hl
    ld (shootingTone),hl

    ld a,0b8h
    ld (mixerValue),a
ret

SoundHandlerPsg: public SoundHandlerPsg
    push hl | push de
        ld hl,(shootingTone)
        ld a,l
        or h
        if nz
            ld e,l
            ld a,Psg_Tone.A
            call WRTPSG
            ld e,h
            ld a,Psg_Tone.A+1
            call WRTPSG
            ld de,10
            add hl,de
            ld a,h
            or a
            jr z,highzero
            ld a,l
            cp 300-256
            if nc
                ld e,0
                ld a,Psg_Volume.A
                call WRTPSG
                ld l,0
            endif
            highzero:
            ld (shootingTone),hl
        endif

        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                exx
                    push bc
                    ld a,(mixerValue)                    
                    ld c,a
                    ld b,1
                exx
                ld ix,Channels
                ld bc,count * 100h ; b = count; c = register
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
                                ld a,c
                                add a,Psg_Volume.A
                                ld e,0
                                call WRTPSG
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
                            cp HighNoise
                            if z
                                ld e,HighNoiseValue
                                WriteNoise:
                                ld a,Psg_Noise
                                call WRTPSG
                                exx
                                    ld a,b
                                    or c
                                exx
                                ld e,a
                                exx
                                    ld a,b
                                    rlca
                                    rlca
                                    rlca
                                    cpl
                                exx
                                and e
                                exx
                                    ld c,a
                                exx
                                ld e,a
                                ld a,Psg_Mixer
                                call WRTPSG
                                ld (ix+Channel_Vol),MaxVol
                                jr EndWriteCycle
                            endif
                            cp LowNoise
                            if z
                                ld e,LowNoiseValue
                                jr WriteNoise
                            endif
                            or a
                            if nz
                                dec a
                                add a,a
                                ld e,a
                                ld d,0
                                ld hl,cycles
                                add hl,de
                                ld a,c
                                add a,a
                                ld e,(hl)
                                call WRTPSG
                                inc hl
                                inc a
                                ld e,(hl)
                                call WRTPSG
                                ld (ix+Channel_Vol),MaxVol
                                exx
                                    ld a,b
                                    rlca
                                    rlca
                                    rlca
                                    or c
                                exx
                                ld e,a
                                exx
                                    ld a,b
                                    cpl
                                exx
                                and e
                                exx
                                    ld c,a
                                exx
                                ld e,a
                                ld a,Psg_Mixer
                                call WRTPSG
                            else
                                rest:
                                ld (ix+Channel_Vol),0
                            endif
                            EndWriteCycle:
                        endif
                        ld a,c
                        add a,Psg_Volume.A
                        ld e,(ix+Channel_Vol)
                        srl e | srl e
                        call WRTPSG
                        ld a,(ix+Channel_Vol)
                        or a
                        if nz
                            dec a
                            ld (ix+Channel_Vol),a
                        endif
                    endif
                    next:
                    inc c
                    ld de,unitSize
                    add ix,de
                    exx
                        sla b
                    exx
                dwnz
            exx
                ld a,c
                ld (mixerValue),a
                pop bc
            exx
            pop ix | pop bc | pop hl
            ld de,(TempoValue)
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody:
    push de
        di
        ld (Channels+Channel_Ptr),hl
        ld a,1
        ld (Channels+Channel_Len),a
        ld hl,0
        ld (shootingTone),hl
        ld e,0
        ld a,Psg_Volume.A
        call WRTPSG
        ei
    pop de
ret

MelodyWait:
    call Melody
    do
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 

C2 equ 1
D2 equ 3
E2 equ 5
F2 equ 6
G2 equ 8
A2 equ 10
B2 equ 12

C3 equ 13
D3 equ 15
E3 equ 17
F3 equ 18
G3 equ 20
G3S equ 21
A3 equ 22
A3S equ 23
B3 equ 24

C4 equ 25
C4S equ 26
D4 equ 27
D4S equ 28
E4 equ 29
F4 equ 30
G4 equ 32
G4S equ 33
A4 equ 34
A4S equ 35
B4 equ 36

C5 equ 37
C5S equ 38
D5 equ 39
D5S equ 40
E5 equ 41
F5 equ 42

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N1 equ N2*2

Sound_Fire_: public Sound_Fire_
    push af| push hl | push de
        ld hl,(Channels++Channel_Ptr)
        ld a,l | or h
        if z
            di
                ld hl,0
                ld (Channels++Channel_Ptr),hl

                ld hl, 150
                ld (shootingTone),hl
                ld a,Psg_Volume.A
                ld e,15
                call WRTPSG
                ld a,(mixerValue)
                and 0f8h
                or 08h
                ld (mixerValue),a
                ld e,a
                ld a,Psg_Mixer
                call WRTPSG
                ld e,15
                ld a,Psg_Volume.A
                call WRTPSG
            ei
        endif
    pop de | pop hl | pop af
ret

beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push af | push hl
        ld hl,beep_notes
        call MelodyWait
    pop hl | pop af
ret


smallExplosion_notes:
    defb N2,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    push af | push hl
        ld hl,smallExplosion_notes
        call Melody
    pop hl | pop af
ret

largeExplosion_notes:
    defb N1,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    push af | push hl
        ld hl,largeExplosion_notes
        call Melody
    pop hl | pop af
ret

start_notes: 
    ; defb N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,D5
    ; defb N8,0, N8,C5, N8,0, N8,C5, N8,0, N8,D5, N2,E5
    defb N4,A4, N4,A4, N8,A4, N4,C5, N8,D5
    defb N2,E5, N4,0, N4,0
    defb 0
Sound_StartPsg:
    public Sound_StartPsg
    push af | push hl
        ld hl,start_notes
        call MelodyWait
    pop hl | pop af
ret

clear_notes: 
    defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
    defb 0
Sound_ClearPsg: public Sound_ClearPsg
    push af | push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl | pop af
ret

over_notes: 
    defb N8,A4, N8,E5, N8,D5, N8,C5, N8,D5, N8,C5, N8,B4, N4P,A4
    defb N8,0, N4,G4, N8,G4, N4,A4
    defb 0
Sound_GameOverPsg: public Sound_GameOverPsg
    push af | push hl
        ld hl,over_notes
        call MelodyWait
    pop hl | pop af
ret


BGM_B:
    defb N4,A4, N4,A4, N8,A4, N4,C5, N8,D5
    defb N2,E5, N4,0, N8,E5, N8,F5
    defb N8P,E5, N8P,D5, N8,C5, N8P,D5, N8P,C5, N8,B4
    defb N8P,C5, N8P,B4, N8,A4, N8P,B4, N8P,A4, N8,G4

    defb N4,A4, N4,A4, N8,A4, N4,C5, N8,D5
    defb N2,E5, N4,0, N8,E5, N8,F5
    defb N8P,E5, N8P,D5, N8,C5, N8P,D5, N8P,C5, N8,B4
    defb N8P,C5, N8P,B4, N8,A4, N8P,B4, N8P,A4, N8,G4

    defb N8,A4, N8,A4, N4,A4, N8,0, N8,G4, N8,0, N8,A4
    defb N8,C5, N8,C5, N4,C5, N8,0, N8,B4, N8,0, N8,C5
    defb N8,D5, N8,D5, N4,D5, N8,0, N8,C5, N8,0, N8,D5
    defb N8P,E5, N8P,D5, N8,C5, N8P,D5, N8P,C5, N8,B4

    defb N8,A4, N8,A4, N4,A4, N8,0, N8,G4, N8,0, N8,A4
    defb N8,C5, N8,C5, N4,C5, N8,0, N8,B4, N8,0, N8,C5
    defb N8,D5, N8,D5, N4,D5, N8,0, N8,C5, N8,0, N8,D5
    defb N8P,E5, N8P,D5, N8,C5, N8P,D5, N8P,C5, N8,B4

    defb 0ffh
BGM_C:
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8, 0, N8,C3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,F2, N8,0, N8,F2, N8,0, N8,G2, N8,0, N8,G2, N8,0

    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8, 0, N8,C3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,F2, N8,0, N8,F2, N8,0, N8,G2, N8,0, N8,G2, N8,0

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,C3, N8,0, N8,C3, N8,0, N8,B2, N8,0, N8,B2, N8,0

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,C3, N8,0, N8,C3, N8,0, N8,B2, N8,0, N8,B2, N8,0

    defb 0ffh

StartBGMPsg: public StartBGMPsg
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

StopBGMPsg: public StopBGMPsg
    push af | push hl | push bc
        di
        ld hl,0
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld bc,2*256 or Psg_Volume.B
        do
            ld a,c
            ld e,0
            call WRTPSG
            inc c
        dwnz
        ei
    pop bc | pop hl | pop af
ret


cycles:
    defw 1710 ; C2
    defw 1614 ; C#2
    defw 1523 ; D2
    defw 1438 ; D#2
    defw 1357 ; E2
    defw 1281 ; F2
    defw 1209 ; F#2
    defw 1141 ; G2
    defw 1077 ; G#2
    defw 1016 ; A2
    defw 959 ; A#2
    defw 905 ; B2
    defw 855 ; C3
    defw 807 ; C#3
    defw 761 ; D3
    defw 719 ; D#3
    defw 678 ; E3
    defw 640 ; F3
    defw 604 ; F#3
    defw 570 ; G3
    defw 538 ; G#3
    defw 508 ; A3
    defw 479 ; A#3
    defw 452 ; B3
    defw 427 ; C4
    defw 403 ; C#4
    defw 380 ; D4
    defw 359 ; D#4
    defw 339 ; E4
    defw 320 ; F
    defw 302 ; F#4
    defw 285 ; G4
    defw 269 ; G#4
    defw 254 ; A4
    defw 239 ; A#4
    defw 226 ; B4
    defw 213 ; C5
    defw 201 ; C#5
    defw 190 ; D5
    defw 179 ; D#5
    defw 169 ; E5
    defw 160 ; F5
