MaxVolume equ $3f
VolumeStep equ 2

Tempo equ 180

zseg 
Cycle:
    defw 0
PortValue:
    defb 0
SoundProc:
    defw 0
Time:
    defw 0    
ToneCount:
    defb 0
Volume:
    defb 0

cseg
InitSound: public InitSound
    pshs x
        lda $E7CB | ora #$08 | sta $E7CB
        ldx #0 | stx SoundProc
        stx Time
        clr ToneCount
    puls x
rts


CallSound_: public CallSound_
    pshs x
        ldx SoundProc
        if ne
            jsr ,x
        endif
        ldx #0
        stx SoundProc
    puls x
rts


SoundHandler: public SoundHandler
    pshs a,b
        ldd Time
        subd #Tempo
        if cs
            pshs a,b
                lda ToneCount
                if ne
                    deca
                    sta ToneCount
                                _deb: public _deb
                    lda Volume
                    if ne
                        suba #VolumeStep
                        if cs
                            clra
                        endif
                        sta Volume
                    endif
                endif
            puls a,b
            addd #600/2
        endif
        std Time
    puls a,b
rts


Melody:
    pshs a,b,y
        do
            ldb ,x+ ; length
        while ne
            lda ,x+
            if ne
                deca
                asla
                ldy #cycles
                leay a,y
                ldy ,y
                lda #MaxVolume
            else
                ldy #256
                clra
            endif
            pshs cc | orcc #$50
                sta Volume
                stb ToneCount
                sty Cycle
            puls cc

            lda $E7CD | anda #$c0 | sta PortValue
            do
                lda Volume | ora PortValue ; 4+4
                sta $E7CD ; 5
                ldd Cycle ; 5
                do
                    subd #1 ; 4*
                while ne | wend ; 3*
                lda PortValue ; 4
                sta $E7CD ; 5
                ldd Cycle ; 5
                do
                    subd #1 ; 4*
                while ne | wend ; 3*
                tst ToneCount ; 7
            while ne | wend ; 3
        wend
    puls a,b,y
rts


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    pshs x
        ldx #loose_notes
        bsr Melody
    puls x
rts

hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_:  public Sound_Hit_
    pshs x
        ldx #hit_notes
        bsr Melody
    puls x
rts

beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    pshs x
        ldx #beep_notes
        bsr Melody
    puls x
rts


up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up:
    pshs x
        ldx #up_notes
        bsr Melody
    puls x
rts
Sound_Up_: public Sound_Up_
    pshs x
        ldx #Sound_Up
        stx SoundProc
    puls x
rts


start_notes:
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    pshs a,b,x,y
        ldx #start_notes
        bsr Melody
    puls a,b,x,y
rts


clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pshs a,b,x,y
        ldx #clear_notes
        bsr Melody
    puls a,b,x,y
rts


over_notes:
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs a,b,x,y
        ldx #over_notes
        bsr Melody
    puls a,b,x,y
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

N8 equ 6
N8L equ 8
N8R equ 4
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2

cycles:
defw 321 ;A3
defw 303 ;A#3
defw 286 ;B3
defw 270 ;C4
defw 254 ;C#4
defw 240 ;D4
defw 226 ;D#4
defw 213 ;E4
defw 201 ;F4
defw 190 ;F#4
defw 179 ;G4
defw 168 ;G#4
defw 159 ;A4
defw 150 ;A#4
defw 141 ;B4
defw 133 ;C5
defw 125 ;C#5
defw 118 ;D5
defw 111 ;D#5
defw 105 ;E5
defw 99 ;F5
defw 93 ;F#5
defw 88 ;G5
