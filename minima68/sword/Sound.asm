ToneFrequencyPort equ $ff40
ToneVolumePort equ $ff46
EffectFrequencyPort equ $ff4c
EffectVolumePort equ $ff4e

Tempo equ 180
MaxVolume equ 63

HighNoise equ $f0
LowNoise equ $f1
LowNoiseValue equ 50
HighNoiseValue equ LowNoiseValue*2/3

ChannelCount equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Volume equ Channel_Len+1
UnitSize equ Channel_Volume+1

zseg
pChannel:
    defw 0
pPort:
    defw 0
pScore:
    defw 0
pCycle:
    defw 0

dseg
Channels: public Channels
Channel0:
    defs unitSize
Channel1:
    defs unitSize
Channel2:
    defs unitSize
EffectLen:
    defb 0
EffectVolume:
    defb 0
Time:
    defb 0

cseg
InitSound: public InitSound
    clr Time
    ldx #Channels
    do
        clr 0,x | inx
        cpx #Channels+UnitSize*ChannelCount
    while ne | wend
    clr EffectVolume
rts

SoundHandler: public SoundHandler
    ldaa time
    suba #Tempo/2
    if cs
        psha
            ldx #ToneFrequencyPort | stx pPort
            ldx #Channels
            do
                stx pChannel
                ldx Channel_Ptr,x
                if ne
                    stx pScore
                    ldx pChannel
                    dec Channel_Len,x
                    if eq
                        continue:
                        ldx pScore
                        ldaa 0,x ; length
                        if eq
                            ; end
                            ldx pChannel
                            clr Channel_Ptr,x
                            clr Channel_Ptr+1,x
                            ldx pPort
                            clr 2*3,x ; volume
                            bra next
                        endif
                        ldx pChannel
                        cmpa #$ff ; repeat
                        if eq
                            ; repeat
                            ldx Channel_Start,x
                            stx pScore
                            bra continue
                        endif
                        staa Channel_Len,x
                        ldx pScore
                        inx
                        ldab 0,x ; tone number
                        inx
                        stx pScore
                        ldx pChannel
                        ldaa pScore | staa Channel_Ptr,x
                        ldaa pScore+1 | staa Channel_Ptr+1,x
                        
                        cmpb #HighNoise
                        if eq
                            ; noise
                            ldx #HighNoiseValue
                            WriteNoise:
                            stx EffectFrequencyPort
                            ldaa #MaxVolume | staa EffectVolume
                            ldx pChannel
                            clr Channel_Volume,x
                            bra EndWriteCycle
                        endif
                        cmpb #LowNoise
                        if eq
                            ldx #LowNoiseValue
                            bra WriteNoise
                        endif
                        
                        tstb
                        if ne
                            ; tone
                            decb | clra
                            aslb | rola ;*2
                            addb #low Cycles | adca #high Cycles
                            staa pCycle | stab pCycle+1
                            ldx pCycle
                            ldaa 0,x | ldab 1,x
                            ldx pPort
                            staa 0,x ; frequency high
                            stab 1,x ; frequency low
                            ldx pChannel
                            ldaa #MaxVolume | staa Channel_Volume,x
                        else
                            ; rest
                            ldx pChannel
                            clr Channel_Volume,x
                        endif
                        EndWriteCycle:
                    endif
                    ldaa Channel_Volume,x
                    ldx pPort
                    staa 2*3,x ; volume
                    if ne
                        suba #2
                        if cs
                            clra
                        endif
                        ldx pChannel
                        staa Channel_Volume,x
                    endif

                    ldaa EffectVolume
                    staa EffectVolumePort
                    if ne
                        suba #4
                        if cs
                            clra
                        endif
                        ; deca
                        staa EffectVolume
                    endif
                endif
                next:
                ldx pPort
                inx | inx
                stx pPort

                ldx pChannel
                inx | inx | inx  | inx | inx  | inx
                cpx #Channels+UnitSize*ChannelCount
            while ne | wend
        pula
        adda #600/2/2 
    endif
    staa time
rts


Melody0:
    stx Channel0+Channel_Ptr
    psha
        ldaa #1
        staa Channel0+Channel_Len
    pula
rts

MelodyWait0:
    bsr Melody0
    psha
        do
            ldaa Channel0+Channel_Ptr
            oraa Channel0+Channel_Ptr+1
        while ne | wend
    pula
rts

Melody1:
    stx Channel1+Channel_Ptr
    psha
        ldaa #1
        staa Channel1+Channel_Len
    pula
rts

MelodyWait1:
    bsr Melody1
    psha
        do
            ldaa Channel1+Channel_Ptr
            oraa Channel1+Channel_Ptr+1
        while ne | wend
    pula
rts

; void Sound_Loose();
loose_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Loose_: public Sound_Loose_
    ldx #loose_notes
jmp Melody0

; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    ldx #hit_notes
jmp Melody0

; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5
    defb 0 
Sound_Up_: public Sound_Up_
    ldx #up_notes
jmp Melody0

; void Sound_Attack();
beep_notes:
    defb 1,A4, 0
Sound_Attack_: public Sound_Attack_
    ldx #beep_notes
jmp Melody0


; void Sound_Start();
start_notes: 
    defb N4,A4, N4,A4, N8,A4, N4,C5, N8,D5
    defb N2,E5, N4,0, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    ldx #start_notes
jmp MelodyWait1

; void Sound_Clear();
clear_notes: 
    defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldx #clear_notes
jmp MelodyWait1

; void Sound_GameOver();
over_notes: 
    defb N8,A4, N8,E5, N8,D5, N8,C5, N8,D5, N8,C5, N8,B4, N4P,A4
    defb N8,0, N4,G4, N8,G4, N4,A4
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldx #over_notes
jmp MelodyWait1


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

    defb $ff
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

    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    psha
        sei
            ldx #BGM_B | stx Channel1+Channel_Ptr | stx Channel1+Channel_Start
            ldx #BGM_C | stx Channel2+Channel_Ptr | stx Channel2+Channel_Start
            ldaa #1 | staa Channel1+Channel_Len | staa Channel2+Channel_Len
        cli
    pula
rts

; void StopBGM();
StopBGM_: public StopBGM_
    sei
        ldx #0
        stx Channel1+Channel_Ptr | stx Channel2 +Channel_Ptr
    cli
    clr ToneVolumePort+2*1 | clr ToneVolumePort+2*2
rts

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
defw 82 ; E2
defw 87 ; F2
defw 92 ; F#2
defw 98 ; G2
defw 104 ; G#2
defw 110 ; A2
defw 117 ; A#2
defw 123 ; B2
defw 131 ; C3
defw 139 ; C#3
defw 147 ; D3
defw 156 ; D#3
defw 165 ; E3
defw 175 ; F3
defw 185 ; F#3
defw 196 ; G3
defw 208 ; G#3
defw 220 ; A3
defw 233 ; A#3
defw 247 ; B3
defw 262 ; C4
defw 277 ; C#4
defw 294 ; D4
defw 311 ; D#4
defw 330 ; E4
defw 349 ; F4
defw 370 ; F#4
defw 392 ; G4
defw 415 ; G#4
defw 440 ; A4
defw 466 ; A#4
defw 494 ; B4
defw 523 ; C5
defw 554 ; C#5
defw 587 ; D5
defw 622 ; D#5
defw 659 ; E5
defw 698 ; F5
defw 740 ; F#5
defw 784 ; G5
