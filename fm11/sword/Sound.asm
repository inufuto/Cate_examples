Tempo equ 180

Count equ 2
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Tone equ Channel_Start+2
Channel_Len equ Channel_Tone+2
UnitSize equ Channel_Len+1


dseg
Channels: public Channels
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
time:
    defw 0


cseg
InitSound: public InitSound
    orcc #$40
        ldd #0
        std time

        ldx #Channels
        ldb #UnitSize*Count
        do
            clr ,x+
            decb
        while ne | wend
    andcc #not $40
rts


zseg
curChannel:
    defb 0
cseg
SoundHandler: public SoundHandler
    ldd time
    subd #Tempo
    if cs
        pshs a,b
            ldx #Channels
            clr <curChannel
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
                            offch:
                            ldd #0
                            std Channel_Tone,x
                            tst <curChannel
                            if eq
                                ; Channel0
                                ldd Channel1+Channel_Tone
                                if ne
                                    std $FD3A
                                    lda #$80 | sta $FD03
                                    bra next
                                endif
                            endif
                            clra | sta $FD03
                            bra next
                        endif
                        cmpa #$ff
                        if eq
                            ; repeat
                            ldy Channel_Start,x
                            bra continue
                        endif
                        sta Channel_Len,x
                        ldb ,y+
                        sty Channel_Ptr,x
                        tstb
                        beq offch
                        decb
                        lslb
                        clra
                        addd #cycles
                        tfr d,y
                        ldd ,y
                        std Channel_Tone,x
                        tst <curChannel
                        if ne
                            ; Channel1
                            ldy Channel0+Channel_Tone
                            bne next
                        endif
                        std $FD3A
                        lda #$80 | sta $FD03
                    endif
                endif
                next:
                leax UnitSize,x
                lda <curChannel
                inca
                sta <curChannel
                cmpa #Count
            while ne | wend
        puls a,b
        addd #600/2
    endif
    std time
rts


Melody:
    pshs cc,a | orcc #$40
        stx Channel0+Channel_Ptr
        lda #1
        sta Channel0+Channel_Len
    puls cc,a
rts

MelodyWait:
    pshs x
        bsr Melody
        do
            ldx Channel0+Channel_Ptr
        while ne | wend
    puls x
rts


; void Sound_Loose();
loose_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Loose_: public Sound_Loose_
    pshs x
        ldx #loose_notes
        bsr Melody
    puls x
rts


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    pshs x
        ldx #hit_notes
        bsr Melody
    puls x
rts


; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5
    defb 0 
Sound_Up_: public Sound_Up_
    pshs x
        ldx #up_notes
        bsr Melody
    puls x
rts


; void Sound_Attack();
beep_notes:
    defb 1,A4, 0
Sound_Attack_: public Sound_Attack_
    pshs x
        ldx #beep_notes
        bsr Melody
    puls x
rts


; void Sound_Start();
start_notes:
	defb 11,A4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 11,C5,1,0, 5,D5,1,0
	defb 23,E5,1,0
	defb 12,0, 12,0
    defb 0
Sound_Start_: public Sound_Start_
    pshs x
        ldx #start_notes
        bsr MelodyWait
    puls x
rts


; void Sound_Clear();
clear_notes:
	defb 5,A4,1,0, 6,0, 5,A4,1,0, 5,G4,1,0
	defb 5,A4,1,0, 11,C5,1,0, 5,D5,1,0
	defb 6,0, 5,C5,1,0, 6,0, 17,A4,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pshs x
        ldx #clear_notes
        bsr MelodyWait
    puls x
rts


; void Sound_GameOver();
over_notes:
	defb 5,A4,1,0, 5,E5,1,0, 5,D5,1,0, 5,C5,1,0
	defb 5,D5,1,0, 5,C5,1,0, 5,B4,1,0, 17,A4,1,0
	defb 6,0, 11,G4,1,0, 5,G4,1,0
	defb 11,A4,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs x
        ldx #over_notes
        bsr MelodyWait
    puls x
rts


BGM_B:
	defb 11,A4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 11,C5,1,0, 5,D5,1,0
	defb 23,E5,1,0
	defb 12,0, 5,E5,1,0, 5,F5,1,0
	defb 8,E5,1,0, 8,D5,1,0, 5,C5,1,0
	defb 8,D5,1,0, 8,C5,1,0, 5,B4,1,0
	defb 8,C5,1,0, 8,B4,1,0, 5,A4,1,0
	defb 8,B4,1,0, 8,A4,1,0, 5,G4,1,0
	defb 11,A4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 11,C5,1,0, 5,D5,1,0
	defb 23,E5,1,0
	defb 12,0, 5,E5,1,0, 5,F5,1,0
	defb 8,E5,1,0, 8,D5,1,0, 5,C5,1,0
	defb 8,D5,1,0, 8,C5,1,0, 5,B4,1,0
	defb 8,C5,1,0, 8,B4,1,0, 5,A4,1,0
	defb 8,B4,1,0, 8,A4,1,0, 5,G4,1,0
	defb 5,A4,1,0, 5,A4,1,0, 11,A4,1,0
	defb 6,0, 5,G4,1,0, 6,0, 5,A4,1,0
	defb 5,C5,1,0, 5,C5,1,0, 11,C5,1,0
	defb 6,0, 5,B4,1,0, 6,0, 5,C5,1,0
	defb 5,D5,1,0, 5,D5,1,0, 11,D5,1,0
	defb 6,0, 5,C5,1,0, 6,0, 5,D5,1,0
	defb 8,E5,1,0, 8,D5,1,0, 5,C5,1,0
	defb 8,D5,1,0, 8,C5,1,0, 5,B4,1,0
	defb 5,A4,1,0, 5,A4,1,0, 11,A4,1,0
	defb 6,0, 5,G4,1,0, 6,0, 5,A4,1,0
	defb 5,C5,1,0, 5,C5,1,0, 11,C5,1,0
	defb 6,0, 5,B4,1,0, 6,0, 5,C5,1,0
	defb 5,D5,1,0, 5,D5,1,0, 11,D5,1,0
	defb 6,0, 5,C5,1,0, 6,0, 5,D5,1,0
	defb 8,E5,1,0, 8,D5,1,0, 5,C5,1,0
	defb 8,D5,1,0, 8,C5,1,0, 5,B4,1,0
    defb $ff

StartBGM_: public StartBGM_
    pshs a,x,cc | orcc #$40
        ldx #BGM_B
        stx Channel1+Channel_Start
        stx Channel1+Channel_Ptr
        lda #1
        sta Channel1+Channel_Len
    puls a,x,cc
rts


StopBGM_: public StopBGM_
    pshs x,cc | orcc #$40
        ldx #0
        stx Channel1+Channel_Ptr
        stx Channel1+Channel_Tone
        clra | sta $FD03
    puls x,cc
rts



G3 equ 1
G3S equ 2
A3 equ 3
A3S equ 4
B3 equ 5
C4 equ 6
C4S equ 7
D4 equ 8
D4S equ 9
E4 equ 10
F4 equ 11
F4S equ 12
G4 equ 13
G4S equ 14
A4 equ 15
A4S equ 16
B4 equ 17
C5 equ 18
C5S equ 19
D5 equ 20
D5S equ 21
E5 equ 22
F5 equ 23
F5S equ 24
G5 equ 25

cycles:
defw 10285 ; G3
defw 9708 ; G#3
defw 9163 ; A3
defw 8649 ; A#3
defw 8163 ; B3
defw 7705 ; C4
defw 7273 ; C#4
defw 6864 ; D4
defw 6479 ; D#4
defw 6115 ; E4
defw 5772 ; F4
defw 5448 ; F#4
defw 5142 ; G4
defw 4854 ; G#4
defw 4581 ; A4
defw 4324 ; A#4
defw 4081 ; B4
defw 3852 ; C5
defw 3636 ; C#5
defw 3432 ; D5
defw 3239 ; D#5
defw 3057 ; E5
defw 2886 ; F5
defw 2724 ; F#5
defw 2571 ; G5
