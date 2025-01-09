Port_Psg_Command equ $FD0D
Port_Psg_Data equ $FD0E

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
Psg_Input2 equ 14

    dseg

MaxVol equ 63

Tempo equ 180

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

Wait defb 0
Channels defs unitSize*count
time: defw 0

cseg
WriteRegister:
    pshs cc | orcc #$50
        stb Port_Psg_Data
        pshs b
            ldb #3
            stb Port_Psg_Command
            clr Port_Psg_Command

            sta Port_Psg_Data
            ldb #2
            stb Port_Psg_Command
            clr Port_Psg_Command
        puls b
    puls cc
rts


cseg
InitSound: public InitSound
    jsr $EBE5
    pshs b,x
        pshs cc | orcc #$50
            ldx #Channels
            ldb #count
            clra
            do
                sta Channel_Ptr,x
                sta Channel_Ptr+1,x
                leax unitSize,x
                decb
            while ne | wend
            ldx #0
            stx time
        puls cc

        lda #$f8
        ldb #Psg_Mixer
        bsr WriteRegister
    puls b,x
rts


dseg
SoundHandler_channel:
    defb 0

cseg
SoundHandler: public SoundHandler
    pshs a,b,x,y
        lda Wait
        if ne
            deca
            sta Wait
        endif

        ldd time
        subd #Tempo
        if cs
            pshs a,b
                ldx #Channels
                clr SoundHandler_channel
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

                                ldb SoundHandler_channel
                                addb #Psg_VolumeA
                                clra
                                bsr WriteRegister
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
                            tsta
                            if ne
                                deca
                                lsla
                                ldy #cycles
                                leay a,y
                                
                                ldb SoundHandler_channel
                                lslb
                                addb #Psg_ToneA
                                lda 1,y
                                bsr WriteRegister
                                incb
                                lda ,y
                                bsr WriteRegister
                                lda #MaxVol
                            else
                                rest:
                                clra
                            endif
                            EndWriteCycle:
                            sta Channel_Vol,x
                        endif
                        ldb SoundHandler_channel
                        addb #Psg_VolumeA
                        lda Channel_Vol,x
                        pshs a
                            lsra | lsra
                            bsr WriteRegister
                        puls a
                        tsta
                        if ne
                            deca
                            sta Channel_Vol,x
                        endif
                    endif
                    next:
                    leax unitSize,x
                    ldb SoundHandler_channel
                    incb
                    stb SoundHandler_channel
                    cmpb #count
                while ne | wend
            puls a,b
            addd #500/2
        endif
        std time
    puls a,b,x,y
rts


Melody:
    pshs cc,a,b | orcc #$50
        stx Channels+Channel_Ptr
        lda #1
        sta Channels+Channel_Len
    puls cc,a,b
rts

MelodyWait:
    bsr Melody
    do
        ldx Channels+Channel_Ptr
    while ne | wend
rts


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    pshs a,x
        ldx #loose_notes
        bsr MelodyWait
    puls a,x
rts


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    pshs a,x
        ldx #hit_notes
        bsr Melody
    puls a,x
rts


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole_: public Sound_Stole_
    pshs a,x
        ldx #stole_notes
        bsr Melody
    puls a,x
rts


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    pshs a,x
        ldx #fire_notes
        bsr Melody
    puls a,x
rts


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    pshs a,x
        ldx #bonus_notes
        bsr MelodyWait
    puls a,x
rts


start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    pshs a,x
        ldx #start_notes
        bsr MelodyWait
    puls a,x
rts

clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pshs a,x
        ldx #clear_notes
        bsr MelodyWait
    puls a,x
rts


over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs a,x
        ldx #over_notes
        bsr MelodyWait
    puls a,x
rts


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
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0; 3
    defb N8,A3, N4,0, N4P,C4, N8,E4, N8,0; 4
    defb N8,D4, N4,0, N4P,F4, N8,A3, N8,0; 5
    defb N8,G3, N4,0, N4P,B3, N8,D4, N8,0; 6

    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0; 7
    defb N8,A3, N4,0, N4P,C4, N8,E4, N8,0; 8
    defb N8,F4, N4,0, N8,F4, N8,G3, N4,0, N8,G3; 9
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0; 10

    defb N8,C4, N4,0, N8,C4, N8,A3, N4,0, N8,A3; 11
    defb N8,D4, N4,0, N8,D4, N8,G3, N4,0, N8,G3; 12
    defb N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,G3, N8,0, N8,G3
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0; 14

    defb $ff

StartBGM_: public StartBGM_
    pshs a,x
        orcc #$50
        lda #1
        ldx #BGM_B
        stx Channels+unitSize*1+Channel_Start
        stx Channels+unitSize*1+Channel_Ptr
        sta Channels+unitSize*1+Channel_Len
        ldx #BGM_C
        stx Channels+unitSize*2+Channel_Start
        stx Channels+unitSize*2+Channel_Ptr
        sta Channels+unitSize*2+Channel_Len
        andcc #not $50
    puls a,x
rts

StopBGM_: public StopBGM_
    pshs a,b,x
        orcc #$50
        ldx #0
        stx Channels+unitSize*1+Channel_Ptr
        stx Channels+unitSize*2+Channel_Ptr
        ldd #2*256 or Psg_VolumeB
        do
            pshs b,a
                clra
                bsr WriteRegister
            puls b,a
            incb
            deca
        while ne | wend
        lda #$f8
        ldb #Psg_Mixer
        bsr WriteRegister

        andcc #not $50
    puls a,b,x
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

cycles:
defw 931 ; E2
defw 879 ; F2
defw 830 ; F#2
defw 783 ; G2
defw 739 ; G#2
defw 698 ; A2
defw 658 ; A#2
defw 622 ; B2
defw 587 ; C3
defw 554 ; C#3
defw 523 ; D3
defw 493 ; D#3
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
