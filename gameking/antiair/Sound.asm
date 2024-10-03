include "GameKing.inc"
include "ZeroPage.inc"

Tempo equ 200/2
Denom equ 600/2/2

MaxVolume equ $3b
ChannelCount equ 3
MelodyChannel equ 0
BassChannel equ 1
EffectChannel equ 2
PortStep equ 2

Prescaler equ $30
Square12 equ $06
Square1Noise equ $0e
HighNoise equ $f0
LowNoise equ $f1
HighNoiseFreq equ 6
LowNoiseFreq equ 10

dseg
Channels: public Channels
Channel_NotesL:
    defs ChannelCount
Channel_NotesH:
    defs ChannelCount
Channel_Offset:
    defs ChannelCount
Channel_ToneL:
    defs ChannelCount
Channel_ToneH:
    defs ChannelCount
Channel_Len:
    defs ChannelCount
Channel_Vol:
    defs ChannelCount
Channel_Mode:
    defs ChannelCount
Time:
    defb 0

zseg
pNotes:
    defw 0
portOffset:
    defb 0
volValue:
    defb 0
volMask:
    defb 0


cseg
InitSound: public InitSound
    stz Time
    OffAll:
    ldx #0
    do
        stz Channel_NotesL,x
        stz Channel_NotesH,x
        stz Channel_Vol,x
        inx
        cpx #ChannelCount
    while ne | wend
    lda #Prescaler | sta SoundModePort
    stz VolumePort
rts

OutVolume:
    sta <volValue
    lda #$f0 | sta <volMask
    lda <portOffset
    do | while ne
        asl <volValue | lsr <volMask
        asl <volValue | lsr <volMask
        dec a
    wend
    lda VolumePort
    and <volMask
    ora <volValue
    sta VolumePort
rts
SoundHandler: public SoundHandler
    lda Time
    sec | sbc #Tempo
    if cs
        pha
            stz <portOffset
            ldx #0
            do
                lda Channel_NotesL,x
                ora Channel_NotesH,x
                if ne
                    dec Channel_Len,x
                    if eq
                        lda Channel_NotesL,x | sta <pNotes
                        lda Channel_NotesH,x | sta <pNotes+1
                        continue:
                        ldy Channel_Offset,x
                        lda (<pNotes),y
                        if eq
                            ; end
                            stz Channel_NotesL,x
                            stz Channel_NotesH,x
                            offch:
                            stz Channel_Vol,x
                            cpx #EffectChannel
                            if eq
                                lda Channel_Vol+BassChannel
                                if ne
                                    lsr a | lsr a
                                    jsr OutVolume
                                    ldy <portOffset
                                    lda Channel_ToneL+BassChannel | sta >FrequencyPort,y
                                    lda Channel_ToneH+BassChannel | sta >FrequencyPort+1,y
                                    lda Channel_Mode+BassChannel | sta SoundModePort
                                    jmp next
                                endif
                            endif
                            lda #0
                            jsr OutVolume
                            jmp next
                        endif
                        cmp #$ff
                        if eq
                            ; repeat
                            stz Channel_Offset,x
                            jmp continue
                        endif
                        sta Channel_Len,x
                        iny
                        lda (<pNotes),y
                        iny
                        pha
                            tya | sta Channel_Offset,x
                        pla
                        cmp #0
                        beq offch
                        cmp #HighNoise
                        if eq
                            lda #HighNoiseFreq
                            WriteNoise:
                            sta Channel_ToneH,x
                            stz Channel_ToneL,x
                            lda #Prescaler or Square1Noise | sta Channel_Mode,x
                            jmp startVol
                        endif
                        cmp #LowNoise
                        if eq
                            lda #LowNoiseFreq
                            jmp WriteNoise
                        endif
                        dec a
                        asl a
                        tay
                        lda Cycles,y | sta Channel_ToneL,x
                        lda Cycles+1,y | sta Channel_ToneH,x
                        lda #Prescaler or Square12 | sta Channel_Mode,x
                        startVol:
                        lda #MaxVolume | sta Channel_Vol,x
                        cpx #BassChannel
                        if eq
                            lda Channel_Vol+EffectChannel
                            bne EndWriteCycle
                        endif
                        cpx #MelodyChannel
                        if ne
                            lda Channel_Mode,x | sta SoundModePort
                        endif
                        ldy <portOffset
                        lda Channel_ToneL,x | sta >FrequencyPort,y
                        lda Channel_ToneH,x | sta >FrequencyPort+1,y
                        EndWriteCycle:
                    endif
                    lda Channel_Vol,x
                    if ne
                        dec a
                        sta Channel_Vol,x
                        cpx #BassChannel
                        if eq
                            lda Channel_Vol+EffectChannel
                            bne next
                        endif
                        lda Channel_Vol,x
                        lsr a | lsr a
                        jsr OutVolume
                    endif
                endif
                next:
                lda #2 | sta <portOffset
                inx
                cpx #ChannelCount
            while ne | wend
        pla
        clc|adc #Denom
    endif
    sta Time
rts

Melody:
    pha
        sei
            sty Channel_NotesL+EffectChannel
            stx Channel_NotesH+EffectChannel
            lda #1 | sta Channel_Len+EffectChannel
            stz Channel_Offset+EffectChannel
        cli
    pla
rts

MelodyWait:
    jsr Melody
    pha
        do
            lda Channel_NotesL+EffectChannel
            ora Channel_NotesH+EffectChannel
        while ne | wend
    pla
rts


; void Sound_Fire();
fire_notes:
    defb 1,C5, 1,A4S, 1,G4S, 1,F4S, 0
Sound_Fire_: public Sound_Fire_
    ldy #low fire_notes
    ldx #high fire_notes
jmp Melody


; void Sound_SmallBang();
smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    ldy #low smallExplosion_notes
    ldx #high smallExplosion_notes
jmp Melody


; void Sound_LargeBang();
largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    ldy #low largeExplosion_notes
    ldx #high largeExplosion_notes
jmp Melody


; void Sound_Start();
start_notes:
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait


; void Sound_GameOver();
cseg
over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait


BGM_B:
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,B4, N4P,G4, N2,G4, N2P,0
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,G5, N4P,D5, N2,D5, N2P,0
    defb N4P,F5, N4P,E5, N2,F5, N4,F5, N4,E5, N4,F5
    defb N4P,E5, N4P,C5, N2,C5, N2P,0
    
    defb N8,A4, N8,A4, N8,B4, N4,C5, N4,C5, N8,C5
    defb N8,B4, N8,B4, N8,C5, N4,D5, N4,D5, N8,D5
    defb N8,C5, N8,C5, N8,D5, N4,E5, N4,E5, N8,E5
    defb N8,F5, N4,F5, N4P,E5, N4,0

    defb $ff
BGM_C:
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3

    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N4,F3, N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,F3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3

    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4
    
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N8,D4, N8,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0

    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    pha
        sei
            ldx #1
            
            lda #low BGM_B | sta Channel_NotesL+MelodyChannel
            lda #high BGM_B | sta Channel_NotesH+MelodyChannel
            stz Channel_Offset+MelodyChannel
            stx Channel_Len+MelodyChannel
            
            lda #low BGM_C | sta Channel_NotesL+BassChannel
            lda #high BGM_C | sta Channel_NotesH+BassChannel
            stz Channel_Offset+BassChannel
            stx Channel_Len+BassChannel
        cli
    pla
rts


; void StopBGM();
cseg
StopBGM_: public StopBGM_
    sei
        jsr OffAll
    cli
rts


N8 equ 6
N8L equ 8
N8R equ 4
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

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

Cycles:
defw 1062 ; E2
defw 1233 ; F2
defw 1393 ; F#2
defw 1545 ; G2
defw 1688 ; G#2
defw 1823 ; A2
defw 1951 ; A#2
defw 2071 ; B2
defw 2185 ; C3
defw 2292 ; C#3
defw 2393 ; D3
defw 2489 ; D#3
defw 2579 ; E3
defw 2664 ; F3
defw 2745 ; F#3
defw 2820 ; G3
defw 2892 ; G#3
defw 2960 ; A3
defw 3023 ; A#3
defw 3084 ; B3
defw 3140 ; C4
defw 3194 ; C#4
defw 3245 ; D4
defw 3292 ; D#4
defw 3338 ; E4
defw 3380 ; F4
defw 3420 ; F#4
defw 3458 ; G4
defw 3494 ; G#4
defw 3528 ; A4
defw 3560 ; A#4
defw 3590 ; B4
defw 3618 ; C5
defw 3645 ; C#5
defw 3670 ; D5
defw 3694 ; D#5
defw 3717 ; E5
defw 3738 ; F5
defw 3758 ; F#5
defw 3777 ; G5
