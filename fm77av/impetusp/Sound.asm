ext WaitTimer_

Port_FM_Command equ $FD15
Port_FM_Data equ $FD16

Psg_ToneA equ 0
Psg_ToneB equ 2
Psg_ToneC equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_VolumeA equ 8
Psg_VolumeB equ 9
Psg_VolumeC equ 10
Psg_EnvTime equ 11
Psg_EnvType equ 13
Psg_Input1 equ 14
Psg_Input2 equ 15

Opn_OnOff equ 28h
Opn_Part equ 30h

MaxVol equ 63
HighNoise equ $f0
LowNoise equ $f1

HighNoiseValue equ 11
LowNoiseValue equ 27

Tempo equ 180

PsgCount equ 3
OpnCount equ 3
AllCount equ PsgCount+OpnCount
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels defs unitSize*AllCount
time: defw 0
mixerValue: defb 0
shootingTone: defw 0


cseg
WriteSound: public WriteSound ;(a,b)
    pshs a,cc | orcc #$50
        sta Port_FM_Data
        lda #3
        sta Port_FM_Command
        clr Port_FM_Command

        stb Port_FM_Data
        lda #2
        sta Port_FM_Command
        clr Port_FM_Command
    puls a,cc
rts


ReadSound: public ReadSound ; (a):a
    pshs cc | orcc #$50
        sta Port_FM_Data
        lda #3
        sta Port_FM_Command
        clr Port_FM_Command

        lda #9
        sta Port_FM_Command
        lda Port_FM_Data
        clr Port_FM_Command
    puls cc
rts


ReadStatus: ; ():a
    pshs cc | orcc #$50
        lda #4
        sta Port_FM_Command
        lda Port_FM_Data
        clr Port_FM_Command
    puls cc
rts


WaitPort:
    pshs a
        do
            bsr ReadStatus
            bita #$80
        while ne | wend
    puls a
rts


BassTone:
    defb 96,96,102,97
    defb 33,40,20,0
    defb 31,31,148,31
    defb 15,5,16,13
    defb 7,6,6,7
    defb 40,23,71,87
    defb 58
; PianoTone:
;     defb 15,82,50,2
;     defb 65,27,0,0
;     defb 94,94,94,158
;     defb 15,8,7,8
;     defb 5,5,5,5
;     defb 214,214,216,216
;     defb 60
; GuiterTone:
;     defb 67,119,79,113
;     defb 10,23,22,8
;     defb 31,31,18,31
;     defb 4,4,1,12
;     defb 1,1,1,0
;     defb 16,16,24,24
;     defb 40
OrganTone:
    defb 114,116,20,18
    defb 50,0,0,0
    defb 31,29,29,29
    defb 20,0,0,0
    defb 0,0,0,0
    defb 72,10,10,10
    defb 54
SnareTone:
    defb 15,0,0,0
    defb 14,19,17,0
    defb 31,31,31,31
    defb 0,24,15,19
    defb 0,0,17,16
    defb 8,184,44,44
    defb 60

SetTone: ; (a,x)
    ldb #24
    do
        pshs b
            bsr WaitPort
            ldb ,x+
            bsr WriteSound
            adda #4
        puls b
        decb
    while ne | wend
    adda #$20
    ldb ,x+
    bsr WriteSound
rts


cseg
InitSound: public InitSound
    pshs cc | orcc #$50
        ldx #Channels
        ldb #AllCount
        clra
        do
            sta Channel_Ptr,x
            sta Channel_Ptr+1,x
            leax unitSize,x
            decb
        while ne | wend
        ldx #0
        stx time
        stx shootingTone
    puls cc

    ldd #(Psg_Mixer shl 8) or $b8
    stb mixerValue
    bsr WriteSound

    ldx #BassTone
    lda #Opn_Part
    bsr SetTone

    ldx #OrganTone
    lda #Opn_Part+1
    bsr SetTone

    ldx #SnareTone
    lda #Opn_Part+2
    bsr SetTone

    ldd #OpnCount shl 8
    do
        pshs a
            bsr WaitPort
            lda #Opn_OnOff
            bsr WriteSound
            incb
        puls a
        deca
    while ne | wend
rts


; ToneOn:
; ; in
; ;   d : cycle
;     pshs a,b
;         pshs a
;             lda #Psg_ToneA
;             bsr WriteSound
;         puls a
;         tfr a,b
;         lda #Psg_ToneA+1
;         bsr WriteSound

;         ldd #(Psg_VolumeA shl 8) or 15
;         bsr WriteSound
;     puls a,b
; rts


; ToneOff:
;     pshs a,b
;         pshs b
;             lda #Psg_ToneA
;             bsr WriteSound
;         puls b
;         tfr a,b
;         lda #Psg_ToneA+1
;         bsr WriteSound

;         ldd #Psg_VolumeA shl 8
;         bsr WriteSound
;     puls a,b
; rts


zseg
SoundHandler_channel:
    defb 0
SoundHandler_channelBit:
    defb 0
cseg
SoundHandler: public SoundHandler
    pshs a,b,x,y
        ldd shootingTone
        if ne
            lda #Psg_ToneA
            ldb shootingTone+1
            bsr WriteSound
            inca
            ldb shootingTone
            bsr WriteSound

            ldd shootingTone
            addd #10
            cmpd #200
            if cc
                lda #Psg_VolumeA
                clrb
                bsr WriteSound
            endif
            std shootingTone
        endif

        ldd time
        subd #Tempo
        if cs
            pshs a,b
                ldx #Channels
                clr <SoundHandler_channel
                lda #$01 | sta SoundHandler_channelBit
                do
                    ldy Channel_Ptr,x
                    if ne
                        dec Channel_Len,x
                        if eq
                            continue:
                            lda ,y+
                            if eq
                                ; end
                                ldy #0
                                sty Channel_Ptr,x

                                lda <SoundHandler_channel
                                adda #Psg_VolumeA
                                clrb
                                bsr WriteSound
                                bra next
                            endif
                            cmpa #$ff
                            if eq 
                                ; repeat
                                ldy Channel_Start,x
                                bra continue
                            endif
                            sta Channel_Len,x
                            lda ,y+
                            sty Channel_Ptr,x
                            cmpa #HighNoise
                            if eq
                                ldb #HighNoiseValue
                                WriteNoise:
                                lda #Psg_Noise
                                bsr WriteSound
                                
                                ldb SoundHandler_channelBit
                                lslb | lslb | lslb | comb
                                andb mixerValue
                                orb SoundHandler_channelBit
                                stb mixerValue
                                lda #Psg_Mixer
                                bsr WriteSound

                                ldb #MaxVol
                                bra EndWriteCycle
                            endif
                            cmpa #LowNoise
                            if eq
                                ldb #LowNoiseValue
                                bra WriteNoise
                            endif
                            tsta
                            if ne
                                deca
                                lsla
                                ldy #cycles
                                leay a,y
                                
                                lda <SoundHandler_channel
                                lsla
                                adda #Psg_ToneA
                                ldb 1,y
                                bsr WriteSound
                                inca
                                ldb ,y
                                bsr WriteSound

                                ldb SoundHandler_channelBit
                                comb
                                andb mixerValue
                                stb mixerValue
                                ldb SoundHandler_channelBit
                                lslb | lslb | lslb
                                orb mixerValue
                                stb mixerValue
                                lda #Psg_Mixer
                                bsr WriteSound

                                ldb #MaxVol
                            else
                                rest:
                                clrb
                            endif
                            EndWriteCycle:
                            stb Channel_Vol,x
                        endif
                        lda <SoundHandler_channel
                        adda #Psg_VolumeA
                        ldb Channel_Vol,x
                        pshs b
                            lsrb | lsrb
                            bsr WriteSound
                        puls b
                        tstb
                        if ne
                            decb
                            stb Channel_Vol,x
                        endif
                    endif
                    next:
                    leax unitSize,x
                    lsl SoundHandler_channelBit
                    ldb <SoundHandler_channel
                    incb
                    stb <SoundHandler_channel
                    cmpb #PsgCount
                while ne | wend
                
                clr <SoundHandler_channel
                do
                    ldy Channel_Ptr,x
                    if ne
                        dec Channel_Len,x
                        if eq
                            lda Channel_Vol,x
                            if ne
                                bsr WaitPort
                                lda #Opn_OnOff
                                ldb <SoundHandler_channel
                                bsr WriteSound
                                clr Channel_Vol,x
                            endif
                            continue2:
                            lda ,y
                            if eq
                                ; end
                                clr Channel_Ptr,x
                                clr Channel_Ptr+1,x
                                bra next2
                            endif
                            inca
                            if eq
                                ; repeat
                                ldy Channel_Start,x
                                bra continue2
                            endif
                            deca
                            sta Channel_Len,x
                            leay 1,y
                            lda ,y+
                            sty Channel_Ptr,x
                            tsta
                            if ne
                                deca
                                lsla
                                ldy #OpnScales
                                leay a,y
                                bsr WaitPort
                                
                                lda <SoundHandler_channel
                                adda #$a4
                                ldb ,y+
                                bsr WriteSound

                                lda <SoundHandler_channel
                                adda #$a0
                                ldb ,y
                                bsr WriteSound

                                bsr WaitPort
                                lda #Opn_OnOff
                                ldb <SoundHandler_channel
                                orb #$f0
                                bsr WriteSound

                                lda #$ff | sta Channel_Vol,x
                            endif
                        endif
                    endif
                    next2:
                    leax unitSize,x
                    ldb <SoundHandler_channel
                    incb
                    stb <SoundHandler_channel
                    cmpb #OpnCount
                while ne | wend
            puls a,b
            addd #600/2
        endif
        std time
    puls a,b,x,y
rts


Melody0:
    pshs cc,a,b | orcc #$50
        stx Channels+Channel_Ptr
        lda #1
        sta Channels+Channel_Len
        ldd #0
        std shootingTone
    puls cc,a,b
rts

MelodyWait0:
    bsr Melody0
    do
        ldx Channels+Channel_Ptr
    while ne | wend
rts


Melody4:
    pshs cc,a,b | orcc #$50
        stx Channels+unitSize*4+Channel_Ptr
        lda #1
        sta Channels+unitSize*4+Channel_Len
    puls cc,a,b
rts

MelodyWait4:
    bsr Melody4
    do
        ldx Channels+unitSize*4+Channel_Ptr
    while ne | wend
rts


; void Sound_Fire();
Sound_Fire_: public Sound_Fire_
    pshs a,b
        ldd Channels++Channel_Ptr
        if eq
            orcc #$50
                ldd #0
                std Channels++Channel_Ptr

                ldd #100
                std shootingTone
                
                lda #Psg_VolumeA
                ldb #15
                bsr WriteSound

                ldb mixerValue
                andb #$f8
                orb #$38
                stb mixerValue

                lda #Psg_Mixer
                bsr WriteSound
            andcc #not $50
        endif
    puls a,b
rts


; void Sound_SmallBang();
smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    pshs a,x
        ldx #smallExplosion_notes
        bsr Melody0
    puls a,x
rts


; void Sound_LargeBang();
largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    pshs a,x
        ldx #largeExplosion_notes
        bsr Melody0
    puls a,x
rts

; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    pshs a,x
        ldx #up_notes
        bsr MelodyWait0
    puls a,x
rts


; void Sound_Start();
start_notes: 
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    pshs a,x
        ldx #start_notes
        bsr MelodyWait4
    puls a,x
rts


; ; void Sound_Clear();
; clear_notes: 
;     defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
;     defb 0
; Sound_Clear_: public Sound_Clear_
;     pshs a,x
;         ldx #clear_notes
;         bsr MelodyWait4
;     puls a,x
; rts


; void Sound_GameOver();
over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs a,x
        ldx #over_notes
        bsr MelodyWait4
    puls a,x
rts


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
BGM_D:
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4
    
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N8,0, N8,A4, N8,A4, N8,A4
    
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4

    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N8,0, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    ; defb N4,0, N8,A4, N8,A4, N4,0, N4,A4,  N4,0, N8,A4, N8,A4, N4,0, N4,A4
    ; defb N4,0, N8,A4, N8,A4, N4,0, N4,A4,  N8,0, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4

    defb $ff


StartBGM_: public StartBGM_
    pshs a,x,cc | orcc #$50
        lda #1
        ldx #BGM_B
        stx Channels+unitSize*4+Channel_Start
        stx Channels+unitSize*4+Channel_Ptr
        sta Channels+unitSize*4+Channel_Len
        ldx #BGM_C
        stx Channels+unitSize*3+Channel_Start
        stx Channels+unitSize*3+Channel_Ptr
        sta Channels+unitSize*3+Channel_Len
        ldx #BGM_D
        stx Channels+unitSize*5+Channel_Start
        stx Channels+unitSize*5+Channel_Ptr
        sta Channels+unitSize*5+Channel_Len
    puls a,x,cc
rts

StopBGM_: public StopBGM_
    pshs a,b,x,cc | orcc #$50
        ldx #0
        stx Channels+unitSize*4+Channel_Ptr
        stx Channels+unitSize*3+Channel_Ptr
        stx Channels+unitSize*5+Channel_Ptr
        lda #1
        sta Channels+unitSize*4+Channel_Len
        sta Channels+unitSize*3+Channel_Len
        sta Channels+unitSize*5+Channel_Len

        ldd #(Psg_VolumeB shl 8) or 2
        do
            pshs b,a
                clrb
                bsr WriteSound
            puls b,a
            inca
            decb
        while ne | wend
        ldd #(Psg_Mixer shl 8) or $b8
        bsr WriteSound

        lda #Opn_OnOff
        clr
        do
            bsr WaitPort
            bsr WriteSound
            incb
            cmpb #OpnCount
        while ne | wend
    puls a,b,x,cc
rts


N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

E3 equ 1
F3 equ 2
F3S equ 3
G3 equ 4
G3S equ 5
A3 equ 6
A3S equ 7
B3 equ 8
C4 equ 9
C4S equ 10
D4 equ 11
D4S equ 12
E4 equ 13
F4 equ 14
F4S equ 15
G4 equ 16
G4S equ 17
A4 equ 18
A4S equ 19
B4 equ 20
C5 equ 21
C5S equ 22
D5 equ 23
D5S equ 24
E5 equ 25
F5 equ 26
F5S equ 27
G5 equ 28

cycles:
defw 465 ; E3
defw 439 ; F3
defw 415 ; F#3
defw 391 ; G3
defw 369 ; G#3
defw 349 ; A3
defw 329 ; A#3
defw 311 ; B3
defw 293 ; C4
defw 277 ; C#4
defw 261 ; D4
defw 246 ; D#4
defw 232 ; E4
defw 219 ; F4
defw 207 ; F#4
defw 195 ; G4
defw 184 ; G#4
defw 174 ; A4
defw 164 ; A#4
defw 155 ; B4
defw 146 ; C5
defw 138 ; C#5
defw 130 ; D5
defw 123 ; D#5
defw 116 ; E5
defw 109 ; F5
defw 103 ; F#5
defw 97 ; G5

OpnScales:
defb 20,242 ; E3
defb 21,61 ; F3
defb 21,141 ; F#3
defb 21,225 ; G3
defb 22,59 ; G#3
defb 22,154 ; A3
defb 22,254 ; A#3
defb 23,105 ; B3
defb 27,237 ; C4
defb 28,40 ; C#4
defb 28,104 ; D4
defb 28,171 ; D#4
defb 28,242 ; E4
defb 29,61 ; F4
defb 29,141 ; F#4
defb 29,225 ; G4
defb 30,59 ; G#4
defb 30,154 ; A4
defb 30,254 ; A#4
defb 31,105 ; B4
defb 35,237 ; C5
defb 36,40 ; C#5
defb 36,104 ; D5
defb 36,171 ; D#5
defb 36,242 ; E5
defb 37,61 ; F5
defb 37,141 ; F#5
defb 37,225 ; G5
