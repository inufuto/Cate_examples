include "BIOS.inc"

ext TempoValue

WRTOPL equ 4110H
INIOPL equ 4113H

Opll_Rhythm equ 0eh
Opll_ToneL equ 10h
Opll_ToneH equ 20h
Opll_Volume equ 30h

MinVolume equ 0fh
RhythmBit equ 20h

Tempo equ 180

ToneChannelCount equ 6
AllChannelCount equ ToneChannelCount+1
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Inst equ Channel_Len+1
UnitSize equ Channel_Inst+1

Inst_Melody equ 30h
Inst_Bass equ 20h
Inst_Chord equ 21h

dseg
OpllWork: public OpllWork
    defs 160
ChannelsOpll: public ChannelsOpll
    defs UnitSize*AllChannelCount
time:
    defw 0
OpllSlot:
    defb 0

cseg
Signature:
    defb "OPLL"
InstTable:
    defb Inst_Melody, Inst_Melody, Inst_Bass
    defb Inst_Chord, Inst_Chord, Inst_Chord
RhythmTune:
    defb 20h,05h,00h
    defb 0b0h,01h,83h
    defb 01h,01h,25h
cseg
InitSoundOpll: public InitSoundOpll
    ld c,0
    do
        ld de,Signature
        ld hl,401ch
        ld b,4
        do
            ld a,c
            push de | push bc
                call RDSLT
            pop bc | pop de
            ex de,hl
                cp (hl)
            ex de,hl
            jr nz,nextSlot
            inc hl
            inc de
        dwnz
        ld a,c
        ld (OpllSlot),a
        jr found
        nextSlot:
        ld a,c
        inc a
        bit 2,a
        if nz
            or 80h
        endif
        ld c,a
        bit 4,a
    while z | wend
    xor a
    ret
    found:
    ld hl,OpllWork
    ld iy,(OpllSlot-1)
    ld ix,INIOPL
    call CALSLT
    ld hl,4000h
    ld a,(OpllSlot)
    call ENASLT

    ld ix,ChannelsOpll
    ld bc,ToneChannelCount*256+Opll_Volume
    ld hl,InstTable
    do
        xor a
        ld (ix+Channel_Ptr),a
        ld (ix+Channel_Ptr+1),a
        ld (ix+Channel_Len),1

        ld a,(hl) | inc hl
        ld (ix+Channel_Inst),a
        and 0f0h
        or MinVolume
        ld e,a
        ld a,c
        call WRTOPL

        inc c
        ld de,UnitSize
        add ix,de
    dwnz
    xor a
    ld (ix+Channel_Ptr),a
    ld (ix+Channel_Ptr+1),a
    ld (ix+Channel_Len),1

    ld a,Opll_Rhythm
    ld e,RhythmBit
    call WRTOPL

    ld bc,3*256+Opll_ToneL+6
    ld hl,RhythmTune
    do
        ld a,c
        ld e,(hl) | inc hl
        call WRTOPL
        
        ld a,c
        add a,10h
        ld e,(hl) | inc hl
        call WRTOPL

        ld a,c
        ld e,(hl) | inc hl
        call WRTOPL

        inc c
    dwnz
    ld hl,0
    ld (time),hl
    ld a,1
ret

SoundHandlerOpll: public SoundHandlerOpll
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,ChannelsOpll
                ld bc,ToneChannelCount * 256 + Opll_ToneL
                do
                    ld l,(ix+Channel_Ptr)
                    ld h,(ix+Channel_Ptr+1)
                    ld a,l
                    or h
                    if nz
                        dec (ix+Channel_Len)
                        if z
                            continue:
                            ld e,0
                            ld a,c
                            add a,Opll_ToneH-Opll_ToneL
                            call WRTOPL

                            ld a,(hl)
                            or a
                            if z
                                ; end
                                ld (ix+Channel_Ptr),a
                                ld (ix+Channel_Ptr+1),a
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
                                ld e,a
                                ld d,0
                                ld hl,cycles
                                add hl,de

                                ld e,(hl)
                                inc hl
                                ld a,c
                                call WRTOPL

                                ld a,(hl)
                                or 10h
                                ld e,a
                                ld a,c
                                add a,Opll_ToneH-Opll_ToneL
                                call WRTOPL
                            ; else
                            endif
                            EndWriteCycle:
                        endif
                    endif
                    next:
                    inc c
                    ld de,UnitSize
                    add ix,de
                dwnz
                ld l,(ix+Channel_Ptr)
                ld h,(ix+Channel_Ptr+1)
                ld a,l
                or h
                if nz
                    dec (ix+Channel_Len)
                    if z
                        continueR:
                        ld e,RhythmBit
                        ld a,Opll_Rhythm
                        call WRTOPL

                        ld a,(hl)
                        or a
                        if z
                            ; end
                            ld (ix+Channel_Ptr),a
                            ld (ix+Channel_Ptr+1),a
                            jr nextR
                        endif
                        inc a
                        if z 
                            ; repeat
                            ld l,(ix+Channel_Start)
                            ld h,(ix+Channel_Start+1)
                            jr continueR
                        endif
                        dec a
                        ld (ix+Channel_Len),a
                        inc hl
                        
                        ld a,(hl)
                        inc hl
                        ld (ix+Channel_Ptr),l
                        ld (ix+Channel_Ptr+1),h
                        or RhythmBit
                        ld e,a
                        ld a,Opll_Rhythm
                        call WRTOPL
                    endif
                endif
                nextR:
            pop ix | pop bc | pop hl
            ld de,(TempoValue)
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody:
    push af | push de
        di
            ld (ChannelsOpll+Channel_Ptr),hl
            ld a,1
            ld (ChannelsOpll+Channel_Len),a

            ld a,(ChannelsOpll+Channel_Inst)
            ld e,a
            ld a,Opll_Volume
            call WRTOPL
        ei
    pop de | pop af
ret

MelodyWait:
    call Melody
    push af
        do
            ld hl,(ChannelsOpll+Channel_Ptr)
            ld a,l
            or h
        while nz | wend
    pop af
ret 


loose_notes:
    defb 1,A3, 0
Sound_LooseOpll: public Sound_LooseOpll
    push hl
        ld hl,loose_notes
        call MelodyWait
    pop hl
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_HitOpll: public Sound_HitOpll
    push hl
        ld hl,hit_notes
        call Melody
    pop hl
ret


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_StoleOpll: public Sound_StoleOpll
    push hl
        ld hl,stole_notes
        call Melody
    pop hl
ret


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_FireOpll: public Sound_FireOpll
    push hl
        ld hl,fire_notes
        call Melody
    pop hl
ret


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_BonusOpll: public Sound_BonusOpll
    push af | push hl
        ld hl,bonus_notes
        call MelodyWait
    pop hl | pop af
ret


start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_StartOpll: public Sound_StartOpll
    push hl
        ld hl,start_notes
        call MelodyWait
    pop hl
ret


clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_ClearOpll: public Sound_ClearOpll
    push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl
ret


over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOverOpll: public Sound_GameOverOpll
    push hl
        ld hl,over_notes
        call MelodyWait
    pop hl
ret


BGM_B:
    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,D4, N4,D4, N8,D4, N4,E4, N4P,D4
    defb N2P,0

    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,F4, N4,F4, N8,F4, N4,A4, N4P,G4
    defb N2P,0

    defb N8,E4, N8,E4, N8,E4, N4,E4, N8,E4, N4,A4
    defb N8,D4, N8,D4, N8,D4, N4,D4, N8,D4, N4,G4
    defb N8,0, N8,A4, N8,0, N8,G4, N8,0, N8,F4, N8,0, N8,E4
    defb N4,D4, N4,E4, N2,C4

    defb 0ffh
BGM_C:
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 3
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0; 5
    defb N8,G2, N4,0, N4P,B2, N8,D3, N8,0; 6

    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 8
    defb N8,F3, N4,0, N8,F3, N8,G2, N4,0, N8,G2; 9
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 10

    defb N8,C3, N4,0, N8,C3, N8,A2, N4,0, N8,A2; 11
    defb N8,D3, N4,0, N8,D3, N8,G2, N4,0, N8,G2; 12
    defb N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,G2, N8,0, N8,G2
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 14

    defb 0ffh

BGM_D1:
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;3  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;4  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;5  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;6  G

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;7  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;8  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4 , N8,0, N8,G4  ;9  F G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;10 C

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;11 C Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4 , N8,0, N8,G4  ;12 Dm G
    defb N8,0, N8,F4, N8,0, N8,F4, N8,0, N8,G4, N8,0, N8,G4 ;13 F G
    defb N8,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0 ;14 C

    defb 0ffh

BGM_D2:
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;3  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;4  Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;5  Dm
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;6  G

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;7  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;8  Am
    defb N4,C4, N8,0, N8,C4, N8,0, N8,D4 , N8,0, N8,D4  ;9  F G
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;10 C

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;11 C Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;12 Dm G
    defb N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,D4, N8,0, N8,D4 ;13 F G
    defb N8,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0 ;14 C

    defb 0ffh

BGM_D3:
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;3  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;4  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;5  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;6  G

    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;7  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;8  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,B3 , N8,0, N8,B3  ;9  F G
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;10 C

    defb N4,G3, N8,0, N8,G3, N8,0, N8,A3 , N8,0, N8,A3  ;11 C Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,B3 , N8,0, N8,B3  ;12 Dm G
    defb N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,B3, N8,0, N8,B3 ;13 F G
    defb N8,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0 ;14 C

    defb 0ffh

BGM_R:
    defb N8,SD+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,SD

    defb N8,SD+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,SD

    defb N8,SD+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH

    defb N8,BD, N8,SD, N8,BD, N8,SD, N8,BD, N8,SD, N8,BD, N8,SD
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,SD, N8,SD, N8,SD

    defb 0ffh


BGM:
    defw 0,BGM_B,BGM_C,BGM_D1,BGM_D2,BGM_D3
    defw BGM_R

StartBGMOpll: public StartBGMOpll
    push af | push hl | push de | push bc
        di
            ld ix,ChannelsOpll
            ld hl,BGM
            ld bc,ToneChannelCount*256+Opll_Volume
            do
                ld a,(hl) | inc hl
                ld (ix+Channel_Start),a
                ld (ix+Channel_Ptr),a
                ld a,(hl) | inc hl
                ld (ix+Channel_Start+1),a
                ld (ix+Channel_Ptr+1),a
                ld (ix+Channel_Len),1

                ld a,(ix+Channel_Inst)
                ld e,a
                ld a,c
                call WRTOPL

                inc c
                ld de,UnitSize
                add ix,de
            dwnz
            ld a,(hl) | inc hl
            ld (ix+Channel_Start),a
            ld (ix+Channel_Ptr),a
            ld a,(hl) | inc hl
            ld (ix+Channel_Start+1),a
            ld (ix+Channel_Ptr+1),a
            ld (ix+Channel_Len),1
        ei
    pop bc | pop de | pop hl | pop af
ret

StopBGMOpll: public StopBGMOpll
    push af | push hl | push de | push bc
        di
            ld ix,ChannelsOpll
            ld bc,ToneChannelCount*256+Opll_Volume
            do
                xor a
                ld (ix+Channel_Ptr),a
                ld (ix+Channel_Ptr+1),a

                ld a,(ix+Channel_Inst)
                or MinVolume
                ld e,a
                ld a,c
                call WRTOPL

                inc c
                ld de,UnitSize
                add ix,de
            dwnz
            xor a
            ld (ix+Channel_Ptr),a
            ld (ix+Channel_Ptr+1),a
        ei
    pop bc | pop de | pop hl | pop af
ret


N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

HH equ 01h
CY equ 02h
SD equ 08h
BD equ 10h

cycles:
defb 217,4 ; E2
defb 230,4 ; F2
defb 243,4 ; F2S
defb 2,5 ; G2
defb 17,5 ; G2S
defb 34,5 ; A2
defb 51,5 ; A2S
defb 69,5 ; B2
defb 88,5 ; C3
defb 109,5 ; C3S
defb 131,5 ; D3
defb 154,5 ; D3S
defb 178,5 ; E3
defb 204,5 ; F3
defb 231,5 ; F3S
defb 2,7 ; G3
defb 17,7 ; G3S
defb 34,7 ; A3
defb 51,7 ; A3S
defb 69,7 ; B3
defb 88,7 ; C4
defb 109,7 ; C4S
defb 131,7 ; D4
defb 154,7 ; D4S
defb 178,7 ; E4
defb 204,7 ; F4
defb 231,7 ; F4S
defb 2,9 ; G4
defb 17,9 ; G4S
defb 34,9 ; A4
defb 51,9 ; A4S
defb 69,9 ; B4
defb 88,9 ; C5
defb 109,9 ; C5S
defb 131,9 ; D5
defb 154,9 ; D5S
defb 178,9 ; E5
defb 204,9 ; F5
defb 231,9 ; F5S
defb 2,11 ; G5

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
