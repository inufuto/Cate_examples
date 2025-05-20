include 'Zeropage.inc'
include 'Vram.inc'

ext AsciiPattern
ext PatternRamAddress

AsciiColor equ 1

dseg
pCurrentVram:
    defw 0
pCurrentPattern:
    defw 0
TargetChar:
    defb 0
CharShift:
    defb 0


cseg
NextChar:
    lda pCurrentPattern | clc | adc #low CharHeight | sta pCurrentPattern
    lda pCurrentPattern+1 | adc #high CharHeight | sta pCurrentPattern+1

    inc TargetChar
rts

; void PrintC(byte c);
pSourcePattern equ ZW0
sourceIndex equ ZB0
pDestination equ ZW1
destinationIndex equ ZB1
counter equ ZB2
cseg
PrintC_: public PrintC_
    pha
        lda #0 | sta <pSourcePattern+1
        tya | clc|adc #(-' ')
        asl a | rol <pSourcePattern+1 ; *2
        asl a | rol <pSourcePattern+1 ; *4
        clc | adc #low AsciiPattern | sta <pSourcePattern
        lda <pSourcePattern+1 | adc #high AsciiPattern | sta <pSourcePattern+1

        lda pCurrentPattern | sta <pDestination
        lda pCurrentPattern+1 | sta <pDestination+1

        lda #0
        sta <sourceIndex
        sta <destinationIndex

        lda #CharHeight/2 | sta <counter
        lda CharShift
        if eq
            do 
                ldy <sourceIndex
                lda (<pSourcePattern),y | iny
                sty <sourceIndex

                ldy <destinationIndex
                tax
                    and #$f0
                    sta (<pDestination),y | iny
                txa
                asl a | asl a | asl a | asl a
                sta (<pDestination),y | iny
                sty <destinationIndex
                
                dec <counter
            while ne | wend

            ldx #0

            lda pCurrentVram | sta <pDestination
            lda pCurrentVram+1 | sta <pDestination+1
            lda TargetChar | sta (<pDestination,x)

            lda <pDestination+1 | clc | adc #high(ColorMap-Vram) | sta <pDestination+1
            lda #AsciiColor | sta (<pDestination,x)
        else
            do 
                ldy <sourceIndex
                lda (<pSourcePattern),y | iny
                sty <sourceIndex
            
                ldy <destinationIndex
                tax
                    lsr a | lsr a | lsr a | lsr a
                    ora (<pDestination),y
                    sta (<pDestination),y | iny
                txa
                and #$0f
                ora (<pDestination),y
                sta (<pDestination),y | iny
                sty <destinationIndex

                dec <counter
            while ne | wend

            jsr NextChar

            lda pCurrentVram | clc | adc #1 | sta pCurrentVram
            lda pCurrentVram+1 | adc #0 | sta pCurrentVram+1
        endif

        lda CharShift
        eor #1
        sta CharShift
    pla
rts


; void EndPrint();
cseg
EndPrint_: public EndPrint_
    lda CharShift
    if ne
        jsr NextChar
        lda #0
        sta CharShift
    endif
rts


; void Locate(ptr<byte> pVram);
cseg
Locate_: public Locate_
    pha
        sty pCurrentVram
        stx pCurrentVram+1
        lda #0 | sta CharShift
    pla
rts


; void CurrentChar(byte c);
cseg
CurrentChar_: public CurrentChar_
    pha
        lda #0 | sta <pDestination+1
        tya | sta TargetChar
        ldx #pDestination | jsr PatternRamAddress
        lda <pDestination | sta pCurrentPattern
        lda <pDestination+1 | sta pCurrentPattern+1
    pla
rts