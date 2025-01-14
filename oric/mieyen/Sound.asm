VIA_IORB equ $300 ; Port B in and out
VIA_PCA equ $30c ; Peripheral control register
VIA_IORA2 equ $30f ; Read/write to port A without handshake

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

MaxVol equ 63

Tempo equ 180/2
denom equ 600/2/2

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*count
time: 
    defb 0

zseg
pMelody:
    defw 0
toneRegister:
    defb 0
volumeRegister:
    defb 0


; WritePsg a,x
cseg
WritePsg: public WritePsg
    php | sei
        sta VIA_IORA2
        txa
        cpy #7
        if eq
            ora #$40
        endif
        pha
            lda VIA_PCA
            ora #$ee
            sta VIA_PCA
            and #$11
            ora #$cc
            sta VIA_PCA
            tax
        pla
        sta VIA_IORA2
        txa
        ora #$ec
        sta VIA_PCA
        and #$11
        ora #$cc
        sta VIA_PCA
    plp
rts


cseg
InitSound: public InitSound
    ldx #0
    do
        lda #0
        sta Channels+Channel_Ptr,x
        sta Channels+Channel_Ptr+1,x
        txa | clc|adc #unitSize | tax    
        cpx #unitSize*count
    while ne | wend
    lda #0 | sta time

    lda #Psg_Mixer | ldx #$f8
    jsr WritePsg
rts


SoundHandler: public SoundHandler
    pha | txa | pha | tya | pha
        lda time
        sec | sbc #Tempo
        if cs
            pha
                ldx #0
                lda #Psg_ToneA | sta <toneRegister
                lda #Psg_VolumeA | sta <volumeRegister
                do
                    lda Channels+Channel_Ptr,x
                    ora Channels+Channel_Ptr+1,x
                    if ne
                        dec Channels+Channel_Len,x
                        if eq
                            continue:
                            lda Channels+Channel_Ptr,x | sta <pMelody
                            lda Channels+Channel_Ptr+1,x | sta <pMelody+1

                            ldy #0
                            lda (<pMelody),y
                            if eq
                                ; end
                                sta Channels+Channel_Ptr,x
                                sta Channels+Channel_Ptr+1,x

                                txa | pha
                                    lda <volumeRegister
                                    ldx #0
                                    jsr WritePsg
                                pla | tax
                                jmp next
                            endif
                            cmp #$ff
                            if eq
                                ; repeat
                                lda Channels+Channel_Start,x | sta Channels+Channel_Ptr,x
                                lda Channels+Channel_Start+1,x | sta Channels+Channel_Ptr+1,x
                                jmp continue
                            endif
                            sta Channels+Channel_Len,x
                            iny
                            lda (pMelody),y
                            pha
                                lda Channels+Channel_Ptr,x | clc|adc #2 | sta Channels+Channel_Ptr,x
                                lda Channels+Channel_Ptr+1,x | adc #0 | sta Channels+Channel_Ptr+1,x
                            pla
                            cmp #0
                            if ne
                                sec|sbc #1
                                asl a
                                tay
                                txa | pha
                                    lda <toneRegister
                                    ldx cycles,y
                                    jsr WritePsg
                                pla | tax
                                iny
                                txa | pha
                                    lda <toneRegister
                                    clc|adc #1
                                    ldx cycles,y
                                    jsr WritePsg
                                pla | tax
                                lda #MaxVol
                            else
                                lda #0
                            endif
                            EndWriteCycle:
                            sta Channels+Channel_Vol,x
                        endif
                        txa | pha
                            lda Channels+Channel_Vol,x
                            lsr a | lsr a
                            tax
                            lda <volumeRegister
                            jsr WritePsg
                        pla | tax
                        lda Channels+Channel_Vol,x
                        if ne
                            dec Channels+Channel_Vol,x
                        endif                            
                    endif
                    next:
                    lda <toneRegister 
                    clc|adc #Psg_ToneB-Psg_ToneA
                    sta <toneRegister

                    lda <volumeRegister
                    clc|adc #Psg_VolumeB-Psg_VolumeA
                    sta <volumeRegister

                    txa 
                    clc|adc #unitSize
                    tax

                    cpx #unitSize*count
                while ne | wend
            pla
            clc|adc #denom
        endif
        sta time
    pla | tay | pla | tax | pla
rts


Melody:
    php | sei
        sty Channels+unitSize*0+Channel_Ptr
        stx Channels+unitSize*0+Channel_Ptr+1
        tax
            lda #1
            sta Channels+unitSize*0+Channel_Len
        txa
    plp
rts

MelodyWait:
    jsr Melody
    tax
        do
            lda Channels+unitSize*0+Channel_Ptr
            ora Channels+unitSize*0+Channel_Ptr+1
        while ne | wend
    txa
rts


; void Sound_Loose();
loose_notes:
    defb 1,C4, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    ldy #low hit_notes
    ldx #high hit_notes
jmp Melody


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Stole_: public Sound_Stole_
    ldy #low stole_notes
    ldx #high stole_notes
jmp Melody


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    ldy #low fire_notes
    ldx #high fire_notes
jmp Melody


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    ldy #low bonus_notes
    ldx #high bonus_notes
jmp MelodyWait


; void Sound_Start();
start_notes:
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait


; void Sound_Clear();
clear_notes:
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp MelodyWait


; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait


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

    defb $ff
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

    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    pha
        php | sei
            ldx #1
            lda #low BGM_B
            sta Channels+unitSize*1+Channel_Ptr
            sta Channels+unitSize*1+Channel_Start
            lda #high BGM_B
            sta Channels+unitSize*1+Channel_Ptr+1
            sta Channels+unitSize*1+Channel_Start+1
            stx Channels+unitSize*1+Channel_Len
            lda #low BGM_C
            sta Channels+unitSize*2+Channel_Ptr
            sta Channels+unitSize*2+Channel_Start
            lda #high BGM_C
            sta Channels+unitSize*2+Channel_Ptr+1
            sta Channels+unitSize*2+Channel_Start+1
            stx Channels+unitSize*2+Channel_Len
        plp
    pla
rts

; void StopBGM();
StopBGM_: public StopBGM_
    pha
        php | sei
            lda #0
            sta Channels+unitSize*1+Channel_Ptr
            sta Channels+unitSize*1+Channel_Ptr+1
            sta Channels+unitSize*2+Channel_Ptr
            sta Channels+unitSize*2+Channel_Ptr+1

            lda #Psg_VolumeA
            ldx #0
            do
                pha
                    jsr WritePsg
                pla
                clc|adc #1
                cmp #Psg_VolumeC+1
            while ne | wend
        plp
    pla
rts


N8 equ 6
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

cycles:
defw 758 ; E2
defw 715 ; F2
defw 675 ; F#2
defw 637 ; G2
defw 601 ; G#2
defw 568 ; A2
defw 536 ; A#2
defw 506 ; B2
defw 477 ; C3
defw 450 ; C#3
defw 425 ; D3
defw 401 ; D#3
defw 379 ; E3
defw 357 ; F3
defw 337 ; F#3
defw 318 ; G3
defw 300 ; G#3
defw 284 ; A3
defw 268 ; A#3
defw 253 ; B3
defw 238 ; C4
defw 225 ; C#4
defw 212 ; D4
defw 200 ; D#4
defw 189 ; E4
defw 178 ; F4
defw 168 ; F#4
defw 159 ; G4
defw 150 ; G#4
defw 142 ; A4
defw 134 ; A#4
defw 126 ; B4
defw 119 ; C5
defw 112 ; C#5
defw 106 ; D5
defw 100 ; D#5
defw 94 ; E5
defw 89 ; F5
defw 84 ; F#5
defw 79 ; G5
