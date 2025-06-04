include "Lynx.inc"
include "ZeroPage.inc"

Port_Vol equ $FD20
Port_Feedback equ $FD21
Port_ShiftL equ $FD23
Port_Freq equ $FD24
Port_Control equ $FD25
Port_Count equ $FD26
Port_Other equ $FD27
PortStep equ 8

Tempo equ 220/2
Denom equ 600/2/2
Count equ 4
MaxVolume equ -127
SDFreq equ 150

dseg
Channels: public Channels
Channel_CurrentL:
    defs Count
Channel_CurrentH:
    defs Count
Channel_StartL:
    defs Count
Channel_StartH:
    defs Count
Channel_Len:
    defs Count
Channel_Vol:
    defs Count
Time:
    defb 0

zseg
pPort:
    defw 0
pMelody:
    defw 0
channelOffset:
    defb 0
portOffset:
    defb 0

cseg
InitSound: public InitSound
    stz Time
    stz MSTEREO
OffAll:
    ldx #0
    do
        stz Channel_CurrentL,x
        stz Channel_CurrentH,x
        inx
        cpx #Count
    while ne | wend
    ldx #0
    do
        stz Port_Vol,x
        stz Port_ShiftL,x
        txa | clc|adc #PortStep | tax
        cpx #PortStep*Count
    while ne | wend
rts
        
SoundHandler: public SoundHandler
    lda Time
    sec | sbc #Tempo
    if cs
        pha
            ldx #0 
            stx <portOffset
            stx <channelOffset
            do
                lda Channel_CurrentL,x
                ora Channel_CurrentH,x
                if ne
                    dec Channel_Len,x
                    if eq
                        continue:
                        lda Channel_CurrentL,x | sta <pMelody
                        lda Channel_CurrentH,x | sta <pMelody+1
                        ldy #0
                        lda (<pMelody),y
                        if eq
                            ; end
                            sta Channel_CurrentL,x
                            sta Channel_CurrentH,x
                            ldy <portOffset
                            sta Port_Vol,y
                            jmp next
                        endif
                        cmp #$ff
                        if eq
                            ; repeat
                            lda Channel_StartL,x | sta Channel_CurrentL,x
                            lda Channel_StartH,x | sta Channel_CurrentH,x
                            jmp continue
                        endif
                        sta Channel_Len,x
                        iny
                        lda (<pMelody),y
                        pha
                            lda Channel_CurrentL,x | clc|adc #2 | sta Channel_CurrentL,x
                            lda Channel_CurrentH,x | adc #0 | sta Channel_CurrentH,x
                        pla
                        cmp #SD
                        if eq
                            ldy <portOffset
                            lda #SDFreq | sta Port_Freq,y
                            lda #$18 or 0 | sta Port_Control,y
                            lda #$90 | sta Port_Feedback,y
                            lda #MaxVolume/4
                            jmp startVol
                        endif
                        cmp #0
                        if ne
                            sec|sbc #1
                            asl a
                            tax
                            ldy <portOffset
                            lda Cycles,x | sta Port_Freq,y
                            lda Cycles+1,x
                            ora #$18
                            sta Port_Control,y
                            lda #$10 | sta Port_Feedback,y
                            ldx <channelOffset
                            lda #MaxVolume
                        else
                            lda #0
                        endif
                        startVol:
                        sta Channel_Vol,x
                        EndWriteCycle:
                    endif
                    ldy <portOffset
                    lda Channel_Vol,x
                    sta Port_Vol,y
                    if ne
                        clc|adc #4
                        if cs
                            lda #0
                        endif
                        sta Channel_Vol,x
                    endif
                endif
                next:
                lda <portOffset | clc|adc #PortStep | sta <portOffset
                inx
                stx <channelOffset
                cpx #Count
            while ne | wend
        pla
        clc|adc #Denom
    endif
    sta Time
rts

Melody:
    pha
        sei
            sty Channel_CurrentL+0
            stx Channel_CurrentH+0
            lda #1
            sta Channel_Len+0
        cli
    pla
rts

MelodyWait:
    jsr Melody
    pha
        do
            lda Channel_CurrentL+0
            ora Channel_CurrentH+0
        while ne | wend
    pla
rts


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    ldy #low beep_notes
    ldx #high beep_notes
jmp MelodyWait


; void Sound_Get();
Sound_Get_: public Sound_Get_
    ldy #low beep_notes
    ldx #high beep_notes
jmp Melody


; void Sound_Hit();
cseg
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    ldy #low hit_notes
    ldx #high hit_notes
jmp Melody


; void Sound_Loose();
cseg
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait


; void Sound_Start();
start_notes:
    defb N8,C4, N8,G4, N8,E4, N8,G4, N2,C5
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait


; void Sound_Clear();
cseg
clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp MelodyWait


; void Sound_GameOver();
cseg
over_notes: 
    defb N8,C5, N8,G4, N8,E4, N8,C5,  N8,B4, N8,G4, N8,E4, N8,B4,  N4,A4, N4,B4,  N2,C5
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait


BGM_B:
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,A4
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,F4
    defb $ff

BGM_C:
    defb N4P,0
    defb N4P,F3, N4P,F3, N4,F3
    defb N4P,C4, N4P,C4, N4,C4
    defb N2,F3, N2,G3, N2+N8,A3, N4P,0
    defb N4P,A3, N4P,A3, N4,A3
    defb N4P,G3, N4P,G3, N4,G3
    defb N2,F3, N2,C4, N2+N8,F3
    defb $ff

BGM_R:
    defb N8,SD, N8,SD, N8,SD
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD
    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    pha
        sei
            ldx #1
            lda #low BGM_B
            sta Channel_CurrentL+1
            sta Channel_StartL+1
            lda #high BGM_B
            sta Channel_CurrentH+1
            sta Channel_StartH+1
            stx Channel_Len+1
            lda #low BGM_C
            sta Channel_CurrentL+2
            sta Channel_StartL+2
            lda #high BGM_C
            sta Channel_CurrentH+2
            sta Channel_StartH+2
            stx Channel_Len+2
            lda #low BGM_R
            sta Channel_CurrentL+3
            sta Channel_StartL+3
            lda #high BGM_R
            sta Channel_CurrentH+3
            sta Channel_StartH+3
            stx Channel_Len+3
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

SD equ $e0
HH equ $00
BD equ $00

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
defb 190,3 ;E2
defb 179,3 ;F2
defb 169,3 ;F#2
defb 159,3 ;G2
defb 150,3 ;G#2
defb 142,3 ;A2
defb 134,3 ;A#2
defb 253,2 ;B2
defb 239,2 ;C3
defb 225,2 ;C#3
defb 213,2 ;D3
defb 201,2 ;D#3
defb 190,2 ;E3
defb 179,2 ;F3
defb 169,2 ;F#3
defb 159,2 ;G3
defb 150,2 ;G#3
defb 142,2 ;A3
defb 134,2 ;A#3
defb 253,1 ;B3
defb 239,1 ;C4
defb 225,1 ;C#4
defb 213,1 ;D4
defb 201,1 ;D#4
defb 190,1 ;E4
defb 179,1 ;F4
defb 169,1 ;F#4
defb 159,1 ;G4
defb 150,1 ;G#4
defb 142,1 ;A4
defb 134,1 ;A#4
defb 253,0 ;B4
defb 239,0 ;C5
defb 225,0 ;C#5
defb 213,0 ;D5
defb 201,0 ;D#5
defb 190,0 ;E5
defb 179,0 ;F5
defb 169,0 ;F#5
defb 159,0 ;G5
