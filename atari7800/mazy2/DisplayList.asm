include "Atari7800.inc"
include "ZeroPage.inc"
include "Vram.inc"

RowHead equ $40 or CharHeight-1

pDisplayList equ ZW0
pVram equ ZW1
count equ ZB0

dseg
CurrentDPP: public CurrentDPP
    defw 0

cseg
DisplayListList0: public DisplayListList0
    defb CharHeight*2-1,high EmptyElement,low EmptyElement
    defb $80 or CharHeight-1,high EmptyElement,low EmptyElement
    defb RowHead,high(DisplayLists0+DisplayListSize*0),low(DisplayLists0+DisplayListSize*0)
    defb RowHead,high(DisplayLists0+DisplayListSize*1),low(DisplayLists0+DisplayListSize*1)
    defb RowHead,high(DisplayLists0+DisplayListSize*2),low(DisplayLists0+DisplayListSize*2)
    defb RowHead,high(DisplayLists0+DisplayListSize*3),low(DisplayLists0+DisplayListSize*3)
    defb RowHead,high(DisplayLists0+DisplayListSize*4),low(DisplayLists0+DisplayListSize*4)
    defb RowHead,high(DisplayLists0+DisplayListSize*5),low(DisplayLists0+DisplayListSize*5)
    defb RowHead,high(DisplayLists0+DisplayListSize*6),low(DisplayLists0+DisplayListSize*6)
    defb RowHead,high(DisplayLists0+DisplayListSize*7),low(DisplayLists0+DisplayListSize*7)
    defb RowHead,high(DisplayLists0+DisplayListSize*8),low(DisplayLists0+DisplayListSize*8)
    defb RowHead,high(DisplayLists0+DisplayListSize*9),low(DisplayLists0+DisplayListSize*9)
    defb RowHead,high(DisplayLists0+DisplayListSize*10),low(DisplayLists0+DisplayListSize*10)
    defb RowHead,high(DisplayLists0+DisplayListSize*11),low(DisplayLists0+DisplayListSize*11)
    defb RowHead,high(DisplayLists0+DisplayListSize*12),low(DisplayLists0+DisplayListSize*12)
    defb RowHead,high(DisplayLists0+DisplayListSize*13),low(DisplayLists0+DisplayListSize*13)
    defb RowHead,high(DisplayLists0+DisplayListSize*14),low(DisplayLists0+DisplayListSize*14)
    defb RowHead,high(DisplayLists0+DisplayListSize*15),low(DisplayLists0+DisplayListSize*15)
    defb RowHead,high(DisplayLists0+DisplayListSize*16),low(DisplayLists0+DisplayListSize*16)
    defb RowHead,high(DisplayLists0+DisplayListSize*17),low(DisplayLists0+DisplayListSize*17)
    defb RowHead,high(DisplayLists0+DisplayListSize*18),low(DisplayLists0+DisplayListSize*18)
    defb RowHead,high(DisplayLists0+DisplayListSize*19),low(DisplayLists0+DisplayListSize*19)
    defb RowHead,high(DisplayLists0+DisplayListSize*20),low(DisplayLists0+DisplayListSize*20)
    defb RowHead,high(DisplayLists0+DisplayListSize*21),low(DisplayLists0+DisplayListSize*21)
    defb RowHead,high(DisplayLists0+DisplayListSize*22),low(DisplayLists0+DisplayListSize*22)
    defb RowHead,high(DisplayLists0+DisplayListSize*23),low(DisplayLists0+DisplayListSize*23)
    defb CharHeight*2-1,high EmptyElement,low EmptyElement
    defb CharHeight*2-1,high EmptyElement,low EmptyElement
    defb 0
DisplayListList1: public DisplayListList1
    defb CharHeight*2-1,high EmptyElement,low EmptyElement
    defb $80 or CharHeight-1,high EmptyElement,low EmptyElement
    defb RowHead,high(DisplayLists1+DisplayListSize*0),low(DisplayLists1+DisplayListSize*0)
    defb RowHead,high(DisplayLists1+DisplayListSize*1),low(DisplayLists1+DisplayListSize*1)
    defb RowHead,high(DisplayLists1+DisplayListSize*2),low(DisplayLists1+DisplayListSize*2)
    defb RowHead,high(DisplayLists1+DisplayListSize*3),low(DisplayLists1+DisplayListSize*3)
    defb RowHead,high(DisplayLists1+DisplayListSize*4),low(DisplayLists1+DisplayListSize*4)
    defb RowHead,high(DisplayLists1+DisplayListSize*5),low(DisplayLists1+DisplayListSize*5)
    defb RowHead,high(DisplayLists1+DisplayListSize*6),low(DisplayLists1+DisplayListSize*6)
    defb RowHead,high(DisplayLists1+DisplayListSize*7),low(DisplayLists1+DisplayListSize*7)
    defb RowHead,high(DisplayLists1+DisplayListSize*8),low(DisplayLists1+DisplayListSize*8)
    defb RowHead,high(DisplayLists1+DisplayListSize*9),low(DisplayLists1+DisplayListSize*9)
    defb RowHead,high(DisplayLists1+DisplayListSize*10),low(DisplayLists1+DisplayListSize*10)
    defb RowHead,high(DisplayLists1+DisplayListSize*11),low(DisplayLists1+DisplayListSize*11)
    defb RowHead,high(DisplayLists1+DisplayListSize*12),low(DisplayLists1+DisplayListSize*12)
    defb RowHead,high(DisplayLists1+DisplayListSize*13),low(DisplayLists1+DisplayListSize*13)
    defb RowHead,high(DisplayLists1+DisplayListSize*14),low(DisplayLists1+DisplayListSize*14)
    defb RowHead,high(DisplayLists1+DisplayListSize*15),low(DisplayLists1+DisplayListSize*15)
    defb RowHead,high(DisplayLists1+DisplayListSize*16),low(DisplayLists1+DisplayListSize*16)
    defb RowHead,high(DisplayLists1+DisplayListSize*17),low(DisplayLists1+DisplayListSize*17)
    defb RowHead,high(DisplayLists1+DisplayListSize*18),low(DisplayLists1+DisplayListSize*18)
    defb RowHead,high(DisplayLists1+DisplayListSize*19),low(DisplayLists1+DisplayListSize*19)
    defb RowHead,high(DisplayLists1+DisplayListSize*20),low(DisplayLists1+DisplayListSize*20)
    defb RowHead,high(DisplayLists1+DisplayListSize*21),low(DisplayLists1+DisplayListSize*21)
    defb RowHead,high(DisplayLists1+DisplayListSize*22),low(DisplayLists1+DisplayListSize*22)
    defb RowHead,high(DisplayLists1+DisplayListSize*23),low(DisplayLists1+DisplayListSize*23)
    defb CharHeight*2-1,high EmptyElement,low EmptyElement
    defb CharHeight*2-1,high EmptyElement,low EmptyElement
    defb 0
EmptyElement:
    defb $00,$00

; WaitV:
;     do
;         bit MSTAT
;     while mi | wend
; rts
InitDisplayLists: public InitDisplayLists
    lda #$60 | sta <CTRL
    lda #$00 | sta <OFFSET

    lda #low DisplayLists0 | sta <pDisplayList
    lda #high DisplayLists0 | sta <pDisplayList+1
    jsr InitDisplayList

    lda #low DisplayLists1 | sta <pDisplayList
    lda #high DisplayLists1 | sta <pDisplayList+1
    jsr InitDisplayList

    ; jsr WaitV
    lda #low DisplayListList0 | sta CurrentDPP | sta <DPPL
    lda #high DisplayListList0 | sta CurrentDPP+1 | sta <DPPH
    lda #$50 | sta <CTRL
rts

InitDisplayList:
    lda #low Vram | sta <pVram
    lda #high Vram | sta <pVram+1

    lda #VramHeight | sta <count
    do
        ldy #0
        lda <pVram | sta (<pDisplayList),y | iny
        lda #$e0 | sta (<pDisplayList),y | iny
        lda <pVram+1 | sta (<pDisplayList),y | iny
        lda #0 | sta (<pDisplayList),y | iny
        lda #16 | sta (<pDisplayList),y | iny

        lda #0
        ldx #4*HorizontalSpriteCount+2
        do
            sta (<pDisplayList),y | iny
            dex
        while ne | wend

        lda <pDisplayList | clc|adc #DisplayListSize | sta <pDisplayList
        lda <pDisplayList+1 | adc #0 | sta <pDisplayList+1

        lda <pVram | clc|adc #VramWidth | sta <pVram
        lda <pVram+1 | adc #0 | sta <pVram+1

        dec <count
    while ne | wend
rts
