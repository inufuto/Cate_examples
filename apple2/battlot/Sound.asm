include 'Apple2.inc'
include 'ZeroPage.inc'

tempo equ 180*2

dseg
SoundProc_: public SoundProc_
    defw 0

cseg

InitSound_: public InitSound_
    lda #0
    sta SoundProc_
    sta SoundProc_+1
rts

CallSound:
    jmp (SoundProc_)

CallSound_: public CallSound_
    lda SoundProc_
    ora SoundProc_+1
    if ne
        jsr CallSound
        lda #0
        sta SoundProc_
        sta SoundProc_+1
    endif
rts



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


Rest:
;   Zp.Counter0: length
;   Zp.Byte: cycle
    do
        lda SoundProc_
        lda Zp.Byte
        sta Zp.Counter1
        do
            nop | nop | nop | nop | nop | nop
            dec Zp.Counter1
        while ne | wend
        lda SoundProc_
        lda Zp.Byte
        sta Zp.Counter1
        do
            nop | nop | nop | nop | nop | nop
            dec Zp.Counter1
        while ne | wend
        dec Zp.Counter0
    while ne | wend
rts


Sound_Fire_: public Sound_Fire_
    lda #60 | sta Zp.Byte
    lda #15 | sta Zp.Counter0
    jsr Tone
rts


Sound_Hit:
    ldx #150
    do
        stx Zp.Byte
        lda #1 | sta Zp.Counter0
        jsr Tone
        dex
        cpx #70
    while ne | wend
rts

Sound_Hit_: public Sound_Hit_
    lda #low Sound_Hit | sta SoundProc_
    lda #high Sound_Hit | sta SoundProc_+1
rts


Sound_Loose:
    ldx #70
    do
        stx Zp.Byte
        lda #1 | sta Zp.Counter0
        jsr Tone
        inx
        cpx #150
    while ne | wend
rts

Sound_Loose_: public Sound_Loose_
    lda #low Sound_Loose | sta SoundProc_
    lda #high Sound_Loose | sta SoundProc_+1
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
        
        cmp #0
        if ne
            sec | sbc #1
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
        else
            asl a
            tax
            lda cycles,x
            sta Zp.Byte
            inx 
            do
                lda cycles,x | sta Zp.Counter0
                jsr Rest
                dec Zp.Byte2
            while ne | wend
        endif
    wend
rts


C4 equ 1
C4S equ 2
D4 equ 3
D4S equ 4
E4 equ 5
F4 equ 6
F4S equ 7
G4 equ 8
G4S equ 9
A4 equ 10
A4S equ 11
B4 equ 12
C5 equ 13
C5S equ 14
D5 equ 15
D5S equ 16
E5 equ 17
F5 equ 18


start_notes: 
    defb 11,A4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 11,C5,1,0, 5,D5,1,0
	defb 23,E5,1,0
	defb 12,0, 12,0
    defb 0
Sound_Start_: public Sound_Start_
    lda #low start_notes | sta Zp.TmpX0.low
    lda #high start_notes | sta Zp.TmpX0.high
jmp Melody


clear_notes: 
    defb 5,A4,1,0, 6,0, 5,A4,1,0, 5,G4,1,0
	defb 5,A4,1,0, 11,C5,1,0, 5,D5,1,0
	defb 6,0, 5,C5,1,0, 6,0, 17,A4,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    lda #low clear_notes | sta Zp.TmpX0.low
    lda #high clear_notes | sta Zp.TmpX0.high
jmp Melody


over_notes: 
	defb 5,A4,1,0, 5,E5,1,0, 5,D5,1,0, 5,C5,1,0
	defb 5,D5,1,0, 5,C5,1,0, 5,B4,1,0, 17,A4,1,0
	defb 6,0, 11,G4,1,0, 5,G4,1,0
	defb 11,A4,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    lda #low over_notes | sta Zp.TmpX0.low
    lda #high over_notes | sta Zp.TmpX0.high
jmp Melody


cycles:
defb 102,(10230000/tempo-10)/(3896+16) ; C4
defb 96,(10230000/tempo-10)/(3668+16) ; C4S
defb 91,(10230000/tempo-10)/(3478+16) ; D4
defb 86,(10230000/tempo-10)/(3288+16) ; D4S
defb 81,(10230000/tempo-10)/(3098+16) ; E4
defb 76,(10230000/tempo-10)/(2908+16) ; F4
defb 72,(10230000/tempo-10)/(2756+16) ; F4S
defb 68,(10230000/tempo-10)/(2604+16) ; G4
defb 64,(10230000/tempo-10)/(2452+16) ; G4S
defb 60,(10230000/tempo-10)/(2300+16) ; A4
defb 57,(10230000/tempo-10)/(2186+16) ; A4S
defb 53,(10230000/tempo-10)/(2034+16) ; B4
defb 50,(10230000/tempo-10)/(1920+16) ; C5
defb 48,(10230000/tempo-10)/(1844+16) ; C5S
defb 45,(10230000/tempo-10)/(1730+16) ; D5
defb 42,(10230000/tempo-10)/(1616+16) ; D5S
defb 40,(10230000/tempo-10)/(1540+16) ; E5
defb 38,(10230000/tempo-10)/(1464+16) ; F5
