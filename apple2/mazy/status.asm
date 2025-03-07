include 'zeropage.inc'
include 'apple2.inc'
include "mazy.inc"
include "char.inc"

status.x equ window.width + 1

ext PrintS, PrintC, Print2x2, Print1x1, PrintSpace2x2, Locate, ClearVram
ext Score, HiScore, Stage, Stage.Time

    dseg
drawn defw 0
drawn.low equ drawn
drawn.high equ drawn+1

    cseg

PrintNumber:
    lda #low 10000 | sta drawn.low
    lda #high 10000 | sta drawn.high
    jsr PrintDigit

    lda #low 1000 | sta drawn.low
    lda #high 1000 | sta drawn.high
    jsr PrintDigit

    PrintNumber3:
    lda #low 100 | sta drawn.low
    lda #high 100 | sta drawn.high
    jsr PrintDigit

    lda #low 10 | sta drawn.low
    lda #high 10 | sta drawn.high
    jsr PrintDigit

    lda Zp.TmpX0.low
    clc | adc #'0' | sta Zp.Byte
jmp PrintC

PrintDigit:
    lda #'0'
    sta Zp.Byte
    do
        inc Zp.Byte
        lda Zp.TmpX0.low | sec | sbc drawn.low | sta Zp.TmpX0.low
        lda Zp.TmpX0.high | sbc drawn.high | sta Zp.TmpX0.high
    while cs | wend
    dec Zp.Byte
    lda Zp.TmpX0.low | clc | adc drawn.low | sta Zp.TmpX0.low
    lda Zp.TmpX0.high | adc drawn.high | sta Zp.TmpX0.high
    jsr PrintC
rts


PrintByte:
    lda #100 | sta drawn.low
    jsr PrintDigitB
PrintByte2:
    lda #10 | sta drawn.low
    jsr PrintDigitB
    lda Zp.TmpX0.low
    clc | adc #'0' | sta Zp.Byte
jmp PrintC

PrintDigitB:
    lda #'0'
    sta Zp.Byte
    do 
        inc Zp.Byte
        lda Zp.TmpX0.low | sec | sbc drawn.low | sta Zp.TmpX0.low
    while cs | wend
    
    dec Zp.Byte
    lda Zp.TmpX0.low | clc | adc drawn.low | sta Zp.TmpX0.low
    jsr PrintC
rts


PrintScore: public PrintScore
    lda Score | sta Zp.TmpX0.low
    lda Score+1 | sta Zp.TmpX0.high

    lda #status.x | sta Zp.X
    lda #1 | sta Zp.Y
    jsr Locate

    jsr PrintNumber
    lda #'0' | sta Zp.Byte
    jsr PrintC

    lda HiScore | sta Zp.TmpX0.low
    lda HiScore+1 | sta Zp.TmpX0.high
    lda #status.x | sta Zp.X
    lda #5 | sta Zp.Y
    jsr Locate

    jsr PrintNumber
    lda #'0' | sta Zp.Byte
    jsr PrintC
rts

ext Stage.Time
PrintTime: public PrintTime
    lda Stage.Time | sta Zp.TmpX0.low
    lda Stage.Time+1 | sta Zp.TmpX0.high

    lda #status.x+3 | sta Zp.X
    lda #11 | sta Zp.Y
    jsr Locate

jmp PrintNumber3



extrn Kn.Invent
Print.Kn.Invent:  public Print.Kn.Invent
    lda #status.x | sta Zp.X
    lda #window.height - 4 | sta Zp.Y

    lda Kn.Invent
    sta Zp.Byte2
    do | while ne
        lda #Char.Kn.Left | sta Zp.Byte
        jsr Print1x1
        inc Zp.X
        dec Zp.Byte2
    wend
    lda #4
    sec | sbc Kn.Invent
    sta Zp.Byte2
    do 
        lda #Char.Space | sta Zp.Byte
        jsr Print1x1
        inc Zp.X
        dec Zp.Byte2
    while ne | wend
rts


extrn Man.Count
Print.Men:
    lda #status.x | sta Zp.X
    lda Man.Count
    if ne
        do
            sec | sbc #1
        while ne
            pha
                lda Zp.X | pha
                    lda #Char.Man.Remain | sta Zp.Byte
                    lda #window.height - 2 | sta Zp.Y
                    jsr Print2x2
                pla | clc | adc #2 | sta Zp.X
            pla
        wend
    endif
  
    lda #4
    sec | sbc Man.Count
    do
        pha
            lda Zp.X | pha
                lda #window.height - 2 | sta Zp.Y
                jsr PrintSpace2x2
            pla | clc | adc #2 | sta Zp.X
        pla
        sec | sbc #1
    while ne | wend
rts


Str.Score: defb 'SCORE',0
Str.High: defb 'HIGH',0
Str.Stage: defb 'STAGE',0
Str.Time: defb 'TIME',0

PrintStatus: public PrintStatus
    lda #status.x | sta Zp.X
    lda #0 | sta Zp.Y
    lda #low Str.Score | sta Zp.TmpX0.low
    lda #high Str.Score | sta Zp.TmpX0.high
    jsr PrintS

    lda #status.x | sta Zp.X
    lda #3 | sta Zp.Y
    lda #low Str.High | sta Zp.TmpX0.low
    lda #high Str.High | sta Zp.TmpX0.high
    jsr PrintS

    lda #status.x | sta Zp.X
    lda #4 | sta Zp.Y
    lda #low Str.Score | sta Zp.TmpX0.low
    lda #high Str.Score | sta Zp.TmpX0.high
    jsr PrintS

    lda #status.x | sta Zp.X
    lda #7 | sta Zp.Y
    lda #low Str.Stage | sta Zp.TmpX0.low
    lda #high Str.Stage | sta Zp.TmpX0.high
    jsr PrintS

    lda #status.x+4 | sta Zp.X
    lda #8 | sta Zp.Y
    jsr Locate
    lda stage
    clc | adc #1
    sta Zp.TmpX0.low
    jsr PrintByte2

    lda #status.x | sta Zp.X
    lda #10 | sta Zp.Y
    lda #low Str.Time | sta Zp.TmpX0.low
    lda #high Str.Time | sta Zp.TmpX0.high
    jsr PrintS

    jsr PrintScore
    jsr PrintTime
    jsr Print.Kn.Invent
    jsr Print.Men
rts


WhiteBox:
    lda #window.height/2 - 1
    do
        pha
            sta Zp.y
            lda #(window.width - 11)/2 | sta Zp.X
            jsr Locate
            lda #11
            do
                pha
                    lda #' ' | sta Zp.Byte
                    jsr PrintC
                pla
                sec | sbc #1
            while ne | wend
        pla
        clc | adc #1
        cmp #window.height/2 + 2
    while ne | wend
rts

Str.Over:   defb 'GAME OVER',0
Print.Over: public Print.Over
    jsr WhiteBox
    lda #(window.width - 9)/2 | sta Zp.X
    lda #(window.height / 2) | sta Zp.Y
    jsr Locate
    lda #low Str.Over | sta Zp.TmpX0.low
    lda #high Str.Over | sta Zp.TmpX0.high
jmp PrintS


Str.Timeup:   defb 'TIME UP',0
PrintTimeup: public PrintTimeup
    jsr WhiteBox
    lda #(window.width - 7)/2 | sta Zp.X
    lda #(window.height / 2) | sta Zp.Y
    jsr Locate
    lda #low Str.Timeup | sta Zp.TmpX0.low
    lda #high Str.Timeup | sta Zp.TmpX0.high
jmp PrintS

Str.Chars: defb '--- CHARACTERS ---',0
Str.Man: defb 'MAN',0
Str.Chaser: defb 'CHASER',0
Str.Disturber: defb 'DISTURBER',0
Str.Exit: defb 'EXIT',0
Str.Push: defb 'PUSH TRIGGER BUTTON',0

TitleScreen: public TitleScreen
    jsr ClearVram
    jsr PrintStatus

    lda #Char.Title | sta Zp.Byte3
    lda #8
    do
        pha
            sta Zp.X
            lda #1 | sta Zp.Y
            lda Zp.Byte3 | sta Zp.Byte
            jsr Print2x2
            lda Zp.Byte3 | clc | adc #4 | sta Zp.Byte3
        pla
        clc | adc #2
        cmp #8+2*4
    while ne | wend

    lda #6 | sta Zp.X
    lda #7 | sta Zp.Y
    lda #Char.Man.Remain | sta Zp.Byte
    jsr Print2x2

    lda #6 | sta Zp.X
    lda #10 | sta Zp.Y
    lda #Char.Chaser | sta Zp.Byte
    jsr Print2x2

    lda #6 | sta Zp.X
    lda #13 | sta Zp.Y
    lda #Char.Disturber | sta Zp.Byte
    jsr Print2x2

    lda #6 | sta Zp.X
    lda #16 | sta Zp.Y
    lda #Char.Goal | sta Zp.Byte
    jsr Print2x2

    lda #4 | sta Zp.X
    lda #4 | sta Zp.Y
    lda #low Str.Chars | sta Zp.TmpX0.low
    lda #high Str.Chars | sta Zp.TmpX0.high
    jsr PrintS
 
    lda #10 | sta Zp.X
    lda #8 | sta Zp.Y
    lda #low Str.Man | sta Zp.TmpX0.low
    lda #high Str.Man | sta Zp.TmpX0.high
    jsr PrintS

    lda #10 | sta Zp.X
    lda #11 | sta Zp.Y
    lda #low Str.Chaser | sta Zp.TmpX0.low
    lda #high Str.Chaser | sta Zp.TmpX0.high
    jsr PrintS

    lda #10 | sta Zp.X
    lda #14 | sta Zp.Y
    lda #low Str.Disturber | sta Zp.TmpX0.low
    lda #high Str.Disturber | sta Zp.TmpX0.high
    jsr PrintS

    lda #10 | sta Zp.X
    lda #17 | sta Zp.Y
    lda #low Str.Exit | sta Zp.TmpX0.low
    lda #high Str.Exit | sta Zp.TmpX0.high
    jsr PrintS

    lda #3 | sta Zp.X
    lda #21 | sta Zp.Y
    lda #low Str.Push | sta Zp.TmpX0.low
    lda #high Str.Push | sta Zp.TmpX0.high
    jsr PrintS
rts
