Tempo equ 180

Count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
UnitSize equ Channel_Len+1

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
time: defb 0

cseg
AllOff:
    clr $c812
    clr $c814
    clr $c819
rts
InitSound: public InitSound
    clr time

    ldx #Channels
    do
        clr 0,x | inx
        cpx #Channels+UnitSize*Count
    while ne | wend
rts


SoundHandler: public SoundHandler
    ldaa time
    suba #Tempo/2
    if cs
        psha
            ldx #$c812 | stx <pPort
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
                            ldx <pPort
                            clr 0,x
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
                        if ne
                            decb | clra
                            aslb | rola
                            addb #low cycles | adca #high cycles
                            staa <pCycle | stab <pCycle+1
                            ldx <pCycle
                            ldaa 0,x | ldab 1,x
                            ldx <pPort
                            cpx #$c819
                            if ne
                                staa 1,x
                            else
                                bitb #$10
                                if ne
                                    ldab #$0e
                                else
                                    ldab #$06
                                endif
                                pshb
                                    clrb
                                    asla | rolb                                    
                                    asla | rolb
                                    asla | rolb
                                    stab 1,x
                                    staa 2,x
                                pulb
                            endif
                            stab 0,x
                        else
                            ldx <pPort
                            clr 0,x
                        endif
                    endif
                endif
                next:
                ldx <pPort
                inx | inx
                cpx #$c816
                if eq
                    ldx #$c819
                endif
                stx <pPort

                ldx <pChannel
                inx | inx | inx | inx | inx
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
        ldx Channel0+Channel_Ptr
    while ne | wend
rts


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    ldx #loose_notes
    bsr MelodyWait
rts


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    ldx #hit_notes
    bsr Melody
rts


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Stole_: public Sound_Stole_
    ldx #stole_notes
    bsr Melody
rts


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    ldx #fire_notes
    bsr Melody
rts


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    ldx #bonus_notes
    bsr MelodyWait
rts


; void Sound_Start();
start_notes: 
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    ldx #start_notes
    bsr MelodyWait
rts


; void Sound_Clear();
clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldx #clear_notes
    bsr MelodyWait
rts


; void Sound_GameOver();
over_notes:
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldx #over_notes
    bsr MelodyWait
rts


BGM_B:
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,D4,1,0
	defb 11,D4,1,0, 5,D4,1,0, 11,E4,1,0
	defb 17,D4,1,0, 36,0
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,F4,1,0
	defb 11,F4,1,0, 5,F4,1,0, 11,A4,1,0
	defb 17,G4,1,0, 36,0
	defb 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 11,E4,1,0
	defb 5,E4,1,0, 11,A4,1,0, 5,D4,1,0
	defb 5,D4,1,0, 5,D4,1,0, 11,D4,1,0
	defb 5,D4,1,0, 11,G4,1,0, 6,0
	defb 5,A4,1,0, 6,0, 5,G4,1,0, 6,0
	defb 5,F4,1,0, 6,0, 5,E4,1,0, 11,D4,1,0
	defb 11,E4,1,0, 23,C4,1,0
    defb $ff
BGM_C:
	defb 5,C3,1,0, 12,0, 17,E3,1,0
	defb 5,G3,1,0, 6,0, 5,A2,1,0, 12,0
	defb 17,C3,1,0, 5,E3,1,0
	defb 6,0, 5,D3,1,0, 12,0
	defb 17,F3,1,0, 5,A3,1,0
	defb 6,0, 5,G2,1,0, 12,0
	defb 17,B2,1,0, 5,D3,1,0
	defb 6,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0, 5,A2,1,0, 12,0
	defb 17,C3,1,0, 5,E3,1,0
	defb 6,0, 5,F3,1,0, 12,0
	defb 5,F3,1,0, 5,G2,1,0, 12,0
	defb 5,G2,1,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0, 5,C3,1,0, 12,0
	defb 5,C3,1,0, 5,A2,1,0, 12,0
	defb 5,A2,1,0, 5,D3,1,0, 12,0
	defb 5,D3,1,0, 5,G2,1,0, 12,0
	defb 5,G2,1,0, 6,0, 5,F2,1,0, 6,0
	defb 5,F2,1,0, 6,0, 5,G2,1,0, 6,0
	defb 5,G2,1,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0
    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    psha
        sei
            ldaa #1
            ldx #BGM_B
            stx Channel1+Channel_Start
            stx Channel1+Channel_Ptr
            staa Channel1+Channel_Len
            ldx #BGM_C
            stx Channel2+Channel_Start
            stx Channel2+Channel_Ptr
            staa Channel2+Channel_Len
        cli
    pula
rts


; void StopBGM();
StopBGM_: public StopBGM_
    psha
        sei
            clra
            ldx #0
            stx Channel1+Channel_Start
            stx Channel1+Channel_Ptr
            staa Channel1+Channel_Len
            stx Channel2+Channel_Start
            stx Channel2+Channel_Ptr
            staa Channel2+Channel_Len
        cli
    pula
    bsr AllOff
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

Cycles:
defb $7e,$16
defb $77,$16
defb $70,$16
defb $6a,$16
defb $64,$16
defb $5e,$16
defb $59,$16
defb $54,$16
defb $4f,$16
defb $4b,$16
defb $47,$16
defb $43,$16
defb $3e,$16
defb $3b,$16
defb $38,$16
defb $34,$16
defb $31,$16
defb $2e,$16
defb $2c,$16
defb $29,$16
defb $27,$16
defb $25,$16
defb $23,$16
defb $21,$16
defb $fd,$0e
defb $ef,$0e
defb $e3,$0e
defb $d5,$0e
defb $c9,$0e
defb $bd,$0e
defb $b3,$0e
defb $a9,$0e
defb $9f,$0e
defb $96,$0e
defb $8e,$0e
defb $86,$0e
defb $7e,$0e
defb $77,$0e
defb $70,$0e
defb $6a,$0e
