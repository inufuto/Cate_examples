include 'apple2.inc'
include 'zeropage.inc'

tempo equ 220

    cseg

Tone:
;   Zp.Counter0: length
;   Zp.Byte: cycle
    do
        lda SPKR
        lda Zp.Byte
        sta Zp.Counter1
        do
            nop | nop | nop | nop | nop | nop
            dec Zp.Counter1
        while ne | wend
        lda SPKR
        lda Zp.Byte
        sta Zp.Counter1
        do
            nop | nop | nop | nop | nop | nop
            dec Zp.Counter1
        while ne | wend
        dec Zp.Counter0
    while ne | wend
rts


Snd.Get: public Snd.Get
    lda #60 | sta Zp.Byte
    lda #15 | sta Zp.Counter0
    jsr Tone
rts


Snd.Hit: public Snd.Hit
    ldx #150
    do
        stx Zp.Byte
        lda #1 | sta Zp.Counter0
        jsr Tone
        dex
        cpx #70
    while ne | wend
rts


Snd.Die: public Snd.Die
    lda #244 | sta Zp.Byte
    lda #10 | sta Zp.Counter0
    jsr Tone
rts


Melody:
    ldy #0
    do
        lda (Zp.TmpX0),y
    while ne
        sta Zp.Byte2

        iny
        lda (Zp.TmpX0),y
        iny
        
        asl a
        tax
        lda cycles,x
        sta Zp.Byte
        inx 
        do
            lda cycles,x | sta Zp.Counter0
            jsr Tone
            dec Zp.Byte2
        while ne | wend
    wend
rts


C4 equ 0
D4 equ 2
E4 equ 4
F4 equ 6
G4 equ 7
A4 equ 9
B4 equ 11
C5 equ 12

start.notes: defb 3,C4, 3,G4, 3,E4, 3,G4, 12,C5, 0
Snd.Start: public Snd.Start
    lda #low start.notes | sta Zp.TmpX0.low
    lda #high start.notes | sta Zp.TmpX0.high
jmp Melody

clear.notes: defb 3,C4, 3,E4, 3,G4, 3,D4, 3,F4, 3,A4, 3,E4, 3,G4, 3,B4, 9,C5,0
Snd.Clear: public Snd.Clear
    lda #low clear.notes | sta Zp.TmpX0.low
    lda #high clear.notes | sta Zp.TmpX0.high
jmp Melody

over.notes: defb 3,C5, 3,G4, 3,E4, 3,C5,  3,B4, 3,G4, 3,E4, 3,B4,  6,A4, 6,B4,  12,C5, 0
Snd.Over: public Snd.Over
    lda #low over.notes | sta Zp.TmpX0.low
    lda #high over.notes | sta Zp.TmpX0.high
jmp Melody


cycles:
    defb 102,(10230000/tempo-10)/(3896+16) ; C4
    defb 96,(10230000/tempo-10)/(3668+16) ; C#4
    defb 91,(10230000/tempo-10)/(3478+16) ; D4
    defb 86,(10230000/tempo-10)/(3288+16) ; D#4
    defb 81,(10230000/tempo-10)/(3098+16) ; E4
    defb 76,(10230000/tempo-10)/(2908+16) ; F
    defb 72,(10230000/tempo-10)/(2756+16) ; F#4
    defb 68,(10230000/tempo-10)/(2604+16) ; G4
    defb 64,(10230000/tempo-10)/(2452+16) ; G#4
    defb 60,(10230000/tempo-10)/(2300+16) ; A4
    defb 57,(10230000/tempo-10)/(2186+16) ; A#4
    defb 53,(10230000/tempo-10)/(2034+16) ; B4
    defb 50,(10230000/tempo-10)/(1920+16) ; C5
