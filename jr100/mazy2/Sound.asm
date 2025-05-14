ext PollTimer_
ext WaitTimer_

ext @Temp@Byte
ext @Temp@Word
ext @Temp@Word2
ext @Temp@Word3

Tempo equ 220

Count equ 2
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Tone equ Channel_Start+2
Channel_Len equ Channel_Tone+2
UnitSize equ Channel_Len+1

zseg
pChannel:
    defw 0
pScore:
    defw 0
pCycle:
    defw 0

dseg
Channels: public Channels
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
time:
    defb 0


cseg
InitSound: public InitSound
    clr $c80b
    clr time

    ldx #Channels
    do
        clr 0,x | inx
        cpx #Channels+UnitSize*Count
    while ne | wend
rts


ToneOn: ; (ab)
    stab $c804
    staa $c805
    ldaa #$c0 | staa $c80b
rts

ToneOff:
    clr $c80b
rts

SoundHandler: public SoundHandler
    ldaa time
    suba #Tempo/2
    if cs
        psha
            ldx #Channels
            do
                stx <pChannel
                ldx Channel_Ptr,x
                if ne
                    stx <pScore
                    ldx <pChannel
                    dec Channel_Len,x
                    if eq
                        continue:
                        ldx <pScore
                        ldaa 0,x
                        if eq
                            ; end
                            ldx <pChannel
                            clr Channel_Ptr,x
                            clr Channel_Ptr+1,x
                            offch:
                            clr Channel_Tone,x
                            clr Channel_Tone+1,x
                            cpx #Channel0
                            if eq
                                ldaa Channel1+Channel_Tone
                                ldab Channel1+Channel_Tone+1
                                bsr ToneOn
                                bra next
                            endif
                            bsr ToneOff
                            bra next
                        endif
                        ldx <pChannel
                        cmpa #$ff
                        if eq
                            ; repeat
                            ldx Channel_Start,x
                            stx <pScore
                            bra continue
                        endif
                        staa Channel_Len,x
                        ldx <pScore
                        inx
                        ldab 0,x
                        inx
                        stx <pScore
                        ldx <pChannel
                        pshb
                            ldaa <pScore | ldab <pScore+1
                            staa Channel_Ptr,x | stab Channel_Ptr+1,x
                        pulb
                        tstb
                        beq offch
                        decb | clra
                        aslb | rola
                        addb #low cycles | adca #high cycles
                        staa <pCycle | stab <pCycle+1
                        ldx <pCycle
                        ldaa 0,x | ldab 1,x
                        ldx <pChannel
                        staa Channel_Tone,x | stab Channel_Tone+1,x
                        cpx #Channel1
                        if eq
                            ldx Channel0+Channel_Tone
                            bne next
                        endif
                        bsr ToneOn
                    endif
                endif
                next:
                ldx <pChannel
                inx | inx | inx | inx | inx | inx | inx
                cpx #Channels+UnitSize*Count
            while ne | wend
        pula
        adda #600/2/2 
    endif
    staa time
rts


Melody: ;(x)
    psha
        stx Channel0+Channel_Ptr
        ldaa #1 | staa Channel0+Channel_Len
    pula
rts

MelodyWait:
    bsr Melody
    do
        jsr PollTimer_
        ldx Channel0+Channel_Ptr
    while ne | wend
rts


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    ldx #beep_notes
    bsr MelodyWait
rts


; void Sound_Get();
Sound_Get_: public Sound_Get_
    ldx #beep_notes
    bsr Melody
rts


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    ldx #hit_notes
    bsr Melody
rts


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    ldx #loose_notes
    bsr MelodyWait
rts


; void Sound_Start();
start_notes: 
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    ldx #start_notes
    bsr MelodyWait
rts


; void Sound_Clear();
clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldx #clear_notes
    bsr MelodyWait
rts


; void Sound_GameOver();
over_notes:
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldx #over_notes
    bsr MelodyWait
rts


BGM_B:
	defb 5,D4,1,0, 5,F4,1,0, 5,G4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0
	defb 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,G4,1,0, 23,F4,1,0, 23,G4,1,0
	defb 35,A4,1,0, 5,D4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 5,G4,1,0, 23,F4,1,0, 23,G4,1,0
	defb 35,F4,1,0
    defb $ff

StartBGM_: public StartBGM_
    psha
        ldx #BGM_B
        stx Channel1+Channel_Start
        stx Channel1+Channel_Ptr
        ldaa #1 | staa Channel1+Channel_Len
    pula
rts


StopBGM_: public StopBGM_
    ldx #0
    stx Channel1+Channel_Ptr
    stx Channel1+Channel_Tone
    bsr ToneOff
rts


A3 equ 1
A3S equ 2
B3 equ 3
C4 equ 4
C4S equ 5
D4 equ 6
D4S equ 7
E4 equ 8
F4 equ 9
F4S equ 10
G4 equ 11
G4S equ 12
A4 equ 13
A4S equ 14
B4 equ 15
C5 equ 16
C5S equ 17
D5 equ 18
D5S equ 19
E5 equ 20
F5 equ 21
F5S equ 22
G5 equ 23

cycles: public cycles
defw 2037 ;A3
defw 1923 ;A#3
defw 1815 ;B3
defw 1713 ;C4
defw 1617 ;C#4
defw 1527 ;D4
defw 1441 ;D#4
defw 1360 ;E4
defw 1284 ;F4
defw 1212 ;F#4
defw 1144 ;G4
defw 1080 ;G#4
defw 1020 ;A4
defw 963 ;A#4
defw 909 ;B4
defw 858 ;C5
defw 810 ;C#5
defw 765 ;D5
defw 722 ;D#5
defw 682 ;E5
defw 644 ;F5
defw 608 ;F#5
defw 574 ;G5
