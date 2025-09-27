include "S1.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern, LinePattern
ext Ground_

TVramTop equ TVram+VramRowSize*0
GVramTop equ GVram+VramRowSize*0

SpritePatternSize equ CharHeight*4*PlaneCount

zseg
CharColor:
shiftedBits:
    defb 0
CharCount:
    defb 0
colorBits:
planeBit:
    defb 0
invertedByte:
    defb 0
yCount:
    defb 0
xCount:
    defb 0
dotCount:
    defb 0
pVram:
    defw 0


dseg
DispPage:
    defb 0
GVramBank:
    defb 0


cseg
ColorTable:
defb 64,7 ;Ascii
defb 16,1 ;Wall
defb 56,7 ;Card
defb 4,7 ;N
defb 4,5 ;E
defb 4,6 ;U
defb 4,3 ;R
defb 4,5 ;A
defb 4,6 ;S
defb 0
InitVram: public InitVram
    pshs u,cc | orcc #$50
        ldy #MonoPattern
        ldx #CRam
        ldu #ColorTable
        do
            ldb 0,u
        while ne
            leau 1,u
            lda 0,u
            leau 1,u
            bsr MakePatternMono
        wend

        ldy #ColorPattern
        ldx #CRam+CharHeight*Char_Color
        ldb #Char_End-Char_Color
        bsr MakePatternColor
    puls u,cc
rts

MakePatternMono:
    std <CharColor
    do
        lda <CharColor | sta <colorBits
        ldb #01
        do
            stb IGENREG
            pshs b
                lda #CharHeight | sta <yCount
                do
                    clrb
                    lda <colorBits
                    bita #$01
                    if ne
                        orb ,y
                    endif
                    bita #$10
                    if ne
                        lda ,y
                        coma
                        sta <invertedByte
                        orb <invertedByte
                    endif
                    stb ,x+
                    leay 1,y
                    dec <yCount
                while ne | wend
                leay -CharHeight,y
                leax -CharHeight,x
                lsr <colorBits
            puls b
            lslb
            bitb #8
        while eq | wend
        leay CharHeight,y
        leax CharHeight,x
        dec <CharCount
    while ne | wend
rts

MakePatternColor:
    stb <CharCount
    do
        ldb #01
        do
            stb IGENREG
            pshs b
                ldb #CharHeight
                do
                    lda ,y+
                    sta ,x+
                    decb
                while ne | wend
                leax -CharHeight,x
            puls b
            lslb
            bitb #8
        while eq | wend
        leax CharHeight,x
        dec <CharCount
    while ne | wend
rts


; void ClearScreen();
cseg
ClearPage:
    clra
    do
        sta,x+
        leay -1,y
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pshs a,b,x,y
        lda #$07 | sta ACTIVE_PLANE
        lda #Bank_GVram0
        do
            sta MAP0
            ldx #GVram
            pshs a
                ldy #$1000
                bsr ClearPage
            puls a
            inca
            cmpa #Bank_GVram0+4
        while ne | wend

        lda #$f7 | sta C_REG_SEL
        ldx #TVram
        ldy #$800
        bsr ClearPage
        ; lda #$f7 | sta C_REG_SEL

        lda #$e0 | sta DISP_PAGE | sta DispPage
        lda #Bank_GVram1 | sta GVramBank
    puls a,b,x,y
rts


; word VramAddress(byte x, byte y);
cseg
VramAddress_: public VramAddress_
    sta <pVram+1
    clr <pVram
    lda #VramRowSize
    mul
    addd <pVram
    addd #TVram
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    stb ,x
    stb $400,x
    tfr x,d
    addd #1
rts


; void EraseSprite(byte x, byte y);
cseg
EraseSprite_: public EraseSprite_
    pshs a,b,y
        pshs a
            lda #2
            lsrb
            adca #0
            sta <yCount
            lda #VramRowSize | mul
            addd #GVramTop
            tfr d,y
        puls a
        ldb #2
        lsra
        adcb #0
        stb <xCount
        leay a,y

        lda GVramBank | sta MAP0
        inca | sta MAP1
        lda #$07 | sta ACTIVE_PLANE
        do
            ldb #CharHeight | stb <dotCount
            do
                pshs y
                    ldb <xCount
                    do
                        clr ,y+
                        decb
                    while ne | wend
                puls y
                leay $400,y
                dec <dotCount
            while ne | wend    
            leay VramRowSize-$400*CharHeight,y
            dec <yCount
        while ne | wend
    puls a,b,y
rts


; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param2: public DrawSprite_@Param2
    defb 0
cseg
DrawSprite_address:
    pshs a
        lda #VramRowSize | mul
        addd #GVramTop
        tfr d,y
    puls a
    leay a,y
    lda GVramBank | sta MAP0
    inca | sta MAP1
rts
DrawSprite_pattern:
    lda DrawSprite_@Param2
    ldb #SpritePatternSize
    mul
    addd #SpritePattern
    tfr d,x
rts
DrawSprite_copyX:
    sta <dotCount
    do
        ldd ,x++
        std ,y++
        leay $400-2,y
        dec <dotCount
    while ne | wend
rts
DrawSprite_copyXShift:
    sta <dotCount
    do
        lda ,x+
        tfr a,b
        lsra | lsra | lsra | lsra
        sta <shiftedBits
        lda ,y
        anda #$f0 | ora <shiftedBits
        sta ,y+
        lslb | lslb | lslb | lslb
        stb <shiftedBits
        lda ,x+
        tfr a,b
        lsra | lsra | lsra | lsra
        ora <shiftedBits
        sta ,y+
        lslb | lslb | lslb | lslb
        stb <shiftedBits
        lda ,y
        anda #$0f | ora <shiftedBits
        sta ,y
        leay $400-2,y
        dec <dotCount
    while ne | wend
rts
DrawSprite_: public DrawSprite_
    pshs a,b,x,y
        lsrb
        if cc
            lsra
            if cc
                bsr DrawSprite_address
                bsr DrawSprite_pattern
                
                lda #$01 | sta <planeBit
                do
                    sta <planeBit | sta ACTIVE_PLANE
                    
                    lda #2 | sta <yCount
                    do
                        lda #CharHeight
                        bsr DrawSprite_copyX
                        leay VramRowSize-$400*CharHeight,y
                        dec <yCount
                    while ne | wend
                    leay -VramRowSize*2,y

                    lda <planeBit
                    lsla
                    bita #8
                while eq | wend
                bra DrawSprite_exit
            else
                bsr DrawSprite_address
                bsr DrawSprite_pattern

                lda #$01 | sta <planeBit
                do
                    sta <planeBit | sta ACTIVE_PLANE

                    lda #2 | sta <yCount
                    do
                        lda #CharHeight
                        bsr DrawSprite_copyXShift
                        leay VramRowSize-$400*CharHeight,y
                        dec <yCount
                    while ne | wend
                    leay -VramRowSize*2,y

                    lda <planeBit
                    lsla
                    bita #8
                while eq | wend
                bra DrawSprite_exit
            endif
        else
            lsra
            if cc
                bsr DrawSprite_address
                leay $400*CharHeight/2,y
                bsr DrawSprite_pattern

                lda #$01 | sta <planeBit
                do
                    sta <planeBit | sta ACTIVE_PLANE
                    
                    lda #CharHeight/2
                    bsr DrawSprite_copyX
                    leay VramRowSize-$400*CharHeight,y
                    lda #CharHeight
                    bsr DrawSprite_copyX
                    leay VramRowSize-$400*CharHeight,y
                    lda #CharHeight/2
                    bsr DrawSprite_copyX
                    leay -VramRowSize*2,y

                    lda <planeBit
                    lsla
                    bita #8
                while eq | wend
                bra DrawSprite_exit
            else
                bsr DrawSprite_address
                leay $400*CharHeight/2,y
                bsr DrawSprite_pattern

                lda #$01 | sta <planeBit
                do
                    sta <planeBit | sta ACTIVE_PLANE

                    lda #CharHeight/2
                    bsr DrawSprite_copyXShift
                    leay VramRowSize-$400*CharHeight,y
                    lda #CharHeight
                    bsr DrawSprite_copyXShift
                    leay VramRowSize-$400*CharHeight,y
                    lda #CharHeight/2
                    bsr DrawSprite_copyXShift
                    leay -VramRowSize*2,y

                    lda <planeBit
                    lsla
                    bita #8
                while eq | wend
            endif
        endif
        DrawSprite_exit:
    puls a,b,x,y
rts


; void SwitchGVram();
cseg
SwitchGVram_: public SwitchGVram_
    pshs a
        lda GVramBank
        anda #$02
        if eq
            lda DispPage | anda #not $02
            sta DISP_PAGE | sta DispPage
            lda #Bank_GVram1 | sta GVramBank
        else
            lda DispPage | ora #$02
            sta DISP_PAGE | sta DispPage
            lda #$b0 | sta GVramBank
        endif
    puls a
rts


; byte ReadVram(word vram);
cseg
ReadVram_: public ReadVram_
    lda ,x
rts
