include "BIOS.inc"

ext TempoValue
ext SoundHandlerPsg

WRTOPL equ 4110H
INIOPL equ 4113H

Opll_Rhythm equ 0eh
Opll_ToneL equ 10h
Opll_ToneH equ 20h
Opll_Volume equ 30h

MinVolume equ 0fh
RhythmBit equ 20h

Tempo equ 170

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
jp SoundHandlerPsg

Melody:
    push af
        di
            ld (ChannelsOpll+Channel_Ptr),hl
            ld a,1
            ld (ChannelsOpll+Channel_Len),a

            ld a,(ChannelsOpll+Channel_Inst)
            ld e,a
            ld a,Opll_Volume
            call WRTOPL
        ei
    pop af
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


start_notes: 
    defb N4,C5, N4,C5, N4,G4, N4,G4, N8L,E5, N8R,D5, N8L,E5, N8R+N4,D5
    defb N4,D5, N2P,C5, N4,0
    defb 0
Sound_StartOpll: public Sound_StartOpll
    push hl
        ld hl,start_notes
        call MelodyWait
    pop hl
ret


clear_notes: 
    defb N4,C4, N4,E4, N4+N8L,G4, N4,A4 
    defb N8R,A4, N8L,G4, N8R,F4, N8L,G4, N8R,G4, N8L,A4, N8R,B4
    defb N2P,C5, N4,0
    defb 0
Sound_ClearOpll: public Sound_ClearOpll
    push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl
ret


over_notes: 
    defb N8L,C5, N8R,C5, N8L,B4, N8R,B4, N8L,A4, N8R,A4, N8L,G4, N8R,E4
    defb N8L,G4, N8R,G4, N8L,A4, N8R,B4, N2,C5
    defb 0
Sound_GameOverOpll: public Sound_GameOverOpll
    push hl
        ld hl,over_notes
        call MelodyWait
    pop hl
ret


BGM_B:
    defb N4,C5, N4,C5, N4,G4, N4,G4, N8L,E5, N8R,D5, N8L,E5, N2,D5, N8R,0 ; 3-5
    defb N4,E5, N4,G5, N8L,D5, N8R,C5, N8L,D5, N1,E5, N8R,0 ; 5-6
    defb N4,F5, N4,F5, N4,E5, N4,E5, N8L,D5, N8R,D5, N8L,D5, N2,E5, N8R,0 ; 7-8
    defb N4,F5, N4,F5, N4,E5, N4,E5, N8L,G5, N8R,G5, N8L,G5, N2,D5, N8R,0 ; 9-10
    
    defb N4,C5, N4,C5, N4,G4, N4,G4, N8L,E5, N8R,D5, N8L,E5, N2,D5, N8R,0 ; 11-12
    defb N4,E5, N4,G5, N8L,D5, N8R,C5, N8L,D5, N1,E5, N8R,0 ; 13-14
    defb N4,F5, N4,F5, N4,E5, N4,E5, N8L,G5, N8R,G5, N8L,G5, N8R+N4,E5, N4,D5 ; 15-16
    defb N4,C5, N4,G4, N8L,C5, N4,D5, N1,C5, N8R,0 ; 17-18
    
    defb 0ffh

BGM_C:
    defb N8L,C3, N8R,0, N8L,C3, N8R,0, N4,C3, N8L,0, N8R,C3 ; 19
    defb N8L,0, N8R,C3, N8L,0, N8R,C3, N8L,C3, N8R,D3, N8L,C3, N8R,D3S ; 20
    defb N8L,E3, N8R,B2, N8L,E3, N8R,0, N4,E3, N8L,0, N4,A2 ; 21-
    defb N8R,A2, N8L,0, N8R,A2, N8L,A2, N8R,0, N8L,A2, N8R,0 ; 22
    defb N8L,F3, N8R,C3, N8L,F3, N8R,0, N4,F3, N8L,0, N4,D3 ; 23-
    defb N8R,D3, N8L,0, N8R,D3, N8L,D3, N8R,0, N8L,D3, N8R,0 ; 24
    defb N8L,F2, N8R,0, N8L,F2, N8R,0, N4,F2, N8L,0, N4,G3 ; 25-
    defb N8R,G3, N8L,0, N8R,D3, N8L,G3, N8R,D3, N8L,G3, N8R,0 ; 26
    defb N8L,C3, N8R,0, N8L,C3, N8R,0, N4,C3, N8L,0, N8R,C3 ; 27
    defb N8L,0, N8R,C3, N8L,0, N8R,C3, N8L,C3, N8R,D3, N8L,C3, N8R,D3S ; 28
    defb N8L,E3, N8R,B2, N8L,E3, N8R,0, N4,E3, N8L,0, N4,A2 ; 29-
    defb N8R,A2, N8L,0, N8R,E2, N8L,A2, N8R,E2, N8L,A2, N8R,0 ; 30
    defb N8L,F2, N8R,0, N8L,F2, N8R,0, N4,F2, N8L,0, N4,E2 ; 31-
    defb N8R,E2, N8L,0, N8R,E2, N8L,E2, N8R,0, N8L,E2, N8R,0 ; 32
    defb N8L,C3, N8R,0, N8L,C3, N8R,0, N4,G2, N8L,0, N4,C3 ;33-
    defb N8R,C3, N8L,0, N8R,C3, N8L,C3, N8R,0, N8L,C3, N8R,0 ; 34
    defb 0ffh

BGM_D1:
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 3  C
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 4  C
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 5  Em
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 6  Am
    
    defb N4,0, N8L,F4, N8R,0, N4,0, N8L,F4, N8R,0 ; 7  F
    defb N4,0, N8L,F4, N8R,0, N4,0, N8L,F4, N8R,0 ; 8  Dm
    defb N4,0, N8L,F4, N8R,0, N4,0, N8L,F4, N8R,0 ; 9  F
    defb N4,0, N8L,G4, N8R,0, N4,0, N8L,G4, N8R,0 ; 10  G

    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 11  C
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 12  C
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 13  Em
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 14  Am

    defb N4,0, N8L,F4, N8R,0, N4,0, N8L,F4, N8R,0 ; 15  F
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 16  Em
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,G4, N8R,0 ; 17  C G
    defb N4,0, N8L,E4, N8R,0, N4,0, N8L,E4, N8R,0 ; 18  C

    defb 0ffh

BGM_D2:
    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 3  C
    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 4  C
    defb N4,0, N8L,B3, N8R,0, N4,0, N8L,B3, N8R,0 ; 5  Em
    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 6  Am

    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 7  F
    defb N4,0, N8L,D4, N8R,0, N4,0, N8L,D4, N8R,0 ; 8  Dm
    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 9  F
    defb N4,0, N8L,D4, N8R,0, N4,0, N8L,D4, N8R,0 ; 10  G

    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 11  C
    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 12  C
    defb N4,0, N8L,B3, N8R,0, N4,0, N8L,B3, N8R,0 ; 13  Em
    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 14  Am

    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 15  F
    defb N4,0, N8L,B3, N8R,0, N4,0, N8L,B3, N8R,0 ; 16  Em
    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,D4, N8R,0 ; 17  C G
    defb N4,0, N8L,C4, N8R,0, N4,0, N8L,C4, N8R,0 ; 18  C

    defb 0ffh

BGM_D3:
    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,G3, N8R,0 ; 3  C
    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,G3, N8R,0 ; 4  C
    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,G3, N8R,0 ; 5  Em
    defb N4,0, N8L,A3, N8R,0, N4,0, N8L,A3, N8R,0 ; 6  Am

    defb N4,0, N8L,A3, N8R,0, N4,0, N8L,A3, N8R,0 ; 7  F
    defb N4,0, N8L,A3, N8R,0, N4,0, N8L,A3, N8R,0 ; 8  Dm
    defb N4,0, N8L,A3, N8R,0, N4,0, N8L,A3, N8R,0 ; 9  F
    defb N4,0, N8L,B3, N8R,0, N4,0, N8L,B3, N8R,0 ; 10  G

    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,G3, N8R,0 ; 11  C
    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,G3, N8R,0 ; 12  C
    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,G3, N8R,0 ; 13  Em
    defb N4,0, N8L,A3, N8R,0, N4,0, N8L,A3, N8R,0 ; 14  Am

    defb N4,0, N8L,A3, N8R,0, N4,0, N8L,A3, N8R,0 ; 15  F
    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,G3, N8R,0 ; 16  Em
    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,B3, N8R,0 ; 17  C
    defb N4,0, N8L,G3, N8R,0, N4,0, N8L,G3, N8R,0 ; 18  C

    defb 0ffh

BGM_R:
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,SD

    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8R,SD, N8R,SD, N8R,SD

    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,SD

    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH
    defb N8L,HH+BD, N8R,HH, N8L,HH+SD, N8R,HH, N8R,SD, N8R,SD, N8R,SD, N8R,SD, N8R,SD, N8R,SD

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
N8L equ 8
N8R equ 4
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
