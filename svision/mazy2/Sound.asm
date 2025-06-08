include "Port.inc"
include "ZeroPage.inc"

PortStep equ 4

Tempo equ 220/2
Denom equ 600/2/2
PolyCount equ 2
ChannelCount equ PolyCount*2
MaxVolume equ $3f

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
Time:
    defb 0

zseg
pNotes:
    defw 0
pPort:
    defw 0
portOffset:
    defb 0

cseg
DutyValues:
    defb $70,$70,$60,$40
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
    ldx #0
    do
        sta CH1_Vol_Duty,x
        inx | inx | inx | inx
        cpx #PortStep*PolyCount
    while ne | wend
    stz CH4_Freq_Vol
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
                            ldy <portOffset
                            stz Channel_Vol,x
                            cpx #PolyCount
                            if cc ; <
                                lda Channel_Vol+PolyCount,x
                                if ne
                                    lsr a | lsr a
                                    ora DutyValues+PolyCount,x | sta CH1_Vol_Duty,y
                                    lda Channel_ToneL+PolyCount,x | sta CH1_Flow,y
                                    lda Channel_ToneH+PolyCount,x | sta CH1_Fhi,y
                                    jmp next
                                endif
                            endif
                            lda #0 | sta CH1_Vol_Duty,y
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
                        dec a
                        asl a
                        tay
                        lda Cycles,y | sta Channel_ToneL,x
                        lda Cycles+1,y | sta Channel_ToneH,x
                        lda #MaxVolume | sta Channel_Vol,x
                        cpx #PolyCount
                        if cs ; >
                            lda Channel_Vol-PolyCount,x
                            bne EndWriteCycle
                        endif
                        ldy <portOffset
                        lda Channel_ToneL,x | sta CH1_Flow,y
                        lda Channel_ToneH,x | sta CH1_Fhi,y
                        EndWriteCycle:
                    endif
                    lda Channel_Vol,x
                    if ne
                        dec a
                        sta Channel_Vol,x
                        cpx #PolyCount
                        if cs ; >
                            lda Channel_Vol-PolyCount,x
                            bne next
                        endif
                        ldy <portOffset
                        lda Channel_Vol,x
                        lsr a | lsr a
                        ora DutyValues,x | sta CH1_Vol_Duty,y
                    endif
                endif
                next:
                lda <portOffset | clc|adc #PortStep | and #$07 | sta <portOffset
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
            sty Channel_NotesL+0
            stx Channel_NotesH+0
            lda #1 | sta Channel_Len+0
            stz Channel_Offset+0
        cli
    pla
rts

MelodyWait:
    jsr Melody
    pha
        do
            lda Channel_NotesL+0
            ora Channel_NotesH+0
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
    defb N4P,C3, N4P,C3, N4,C3
    defb N2,F3, N2,G3, N2+N8,A2, N4P,0
    defb N4P,A2, N4P,A2, N4,A2
    defb N4P,G3, N4P,G3, N4,G3
    defb N2,F3, N2,C3, N2+N8,F3
    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    pha
        sei
            ldx #1
            
            lda #low BGM_B | sta Channel_NotesL+2
            lda #high BGM_B | sta Channel_NotesH+2
            stz Channel_Offset+2
            stx Channel_Len+2
            
            lda #low BGM_C | sta Channel_NotesL+3
            lda #high BGM_C | sta Channel_NotesH+3
            stz Channel_Offset+3
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
defw 1516 ;E2
defw 1431 ;F2
defw 1350 ;F#2
defw 1275 ;G2
defw 1203 ;G#2
defw 1135 ;A2
defw 1072 ;A#2
defw 1011 ;B2
defw 955 ;C3
defw 901 ;C#3
defw 850 ;D3
defw 803 ;D#3
defw 757 ;E3
defw 715 ;F3
defw 675 ;F#3
defw 637 ;G3
defw 601 ;G#3
defw 567 ;A3
defw 535 ;A#3
defw 505 ;B3
defw 477 ;C4
defw 450 ;C#4
defw 425 ;D4
defw 401 ;D#4
defw 378 ;E4
defw 357 ;F4
defw 337 ;F#4
defw 318 ;G4
defw 300 ;G#4
defw 283 ;A4
defw 267 ;A#4
defw 252 ;B4
defw 238 ;C5
defw 224 ;C#5
defw 212 ;D5
defw 200 ;D#5
defw 189 ;E5
defw 178 ;F5
defw 168 ;F#5
defw 158 ;G5
