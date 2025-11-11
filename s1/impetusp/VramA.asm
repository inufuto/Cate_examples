include "S1.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern

SpritePatternSize equ CharHeight*PlaneCount*4

dseg
DispPage: public DispPage
    defb 0
GVramBank:
    defb 0
zseg
yCount:
    defb 0


scope
zseg
CharColor:
    defb 0
CharCount:
    defb 0
colorBits:
    defb 0
invertedByte:
    defb 0
xCount:
    defb 0
pUpperPattern:
    defw 0
pLowerPattern:
    defw 0
cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
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
        ldb #Char_Fort1-Char_Color
        bsr MakePatternColor

        bsr MakeFort
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
        ldb #CharHeight
        bsr CopyColor
        dec <CharCount
    while ne | wend
rts
CopyColor:
    stb yCount
    do
        ldb #01
        do
            stb IGENREG
                lda ,y+
                sta ,x
            lslb
            bitb #8
        while eq | wend
        leax 1,x
        dec yCount
    while ne | wend
rts

MakeFort:
    ldx #CRam+CharHeight*Char_Fort1
    ldy #ColorPattern+PatternSize*(Char_Fort0-Char_Color) | sty pLowerPattern
    
    lda #6 | sta CharCount
    do
        ldy #ColorPattern+PatternSize*(Char_Terrain+25-Char_Color)
        ldb #CharHeight/2 | bsr CopyColor
        ldy pLowerPattern
        ldb #CharHeight/2 | bsr CopyColor
        leay PatternSize/2,y
        sty pLowerPattern
        dec CharCount
    while ne | wend

    ldy #ColorPattern+PatternSize*(Char_Fort0-Char_Color)+PatternSize/2 | sty pUpperPattern
    lda #6*5 | sta CharCount
    do
        ldy pUpperPattern
        ldb #CharHeight/2 | bsr CopyColor
        leay PatternSize/2,y
        sty pUpperPattern
        ldy pLowerPattern
        ldb #CharHeight/2 | bsr CopyColor
        leay PatternSize/2,y
        sty pLowerPattern
        dec CharCount
    while ne | wend

    lda #6 | sta CharCount
    do
        ldy pUpperPattern
        ldb #CharHeight/2 | bsr CopyColor
        leay PatternSize/2,y
        sty pUpperPattern
        ldy #ColorPattern+PatternSize*(Char_Terrain+25-Char_Color)
        ldb #CharHeight/2 | bsr CopyColor
        dec CharCount
    while ne | wend
rts
endscope


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
        ldx #TVram0
        ldy #$800
        bsr ClearPage

        lda #$e0 | sta DISP_PAGE | sta DispPage
        lda #Bank_GVram1 | sta GVramBank
        sta MAP0 | inca | sta MAP1
    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    stb ,x
    stb TVram1-TVram0,x
    tfr x,d
    addd #1
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    pshs y
        ldy #CharTable
        clra
        do
            cmpb ,y+
            beq PrintC_break
            inca
            cmpa #30
        while cs | wend
        clra
        PrintC_break:
        sta ,x
        sta TVram1-TVram0,x
        tfr x,d
        addd #1
    puls y
rts



cseg
GVramPtr:
    pshs a ;xPos
        pshs b ;yPos
            andb #$fe
            lda #VramRowSize/2 | mul
            tfr d,y
        puls b ;yPos
        andb #$01
        lslb | lslb | lslb | lslb
        tfr b,a | clrb
        leay d,y
    puls b ;xPos
    lsrb
    leay b,y
    ; leay GVram,y
rts

; void EraseSprite(byte x, byte y);
cseg
EraseSprite_: public EraseSprite_
    pshs a,b,y
        pshs a
            bsr GVramPtr ; ->y
        puls a

        anda #1 ; xPos
        if ne
            ldd #$fd03
        else
            ldd #$fe02
        endif
        stb EraseSprite_xCount+1
        sta EraseSprite_feed+3

        lda #$07 | sta ACTIVE_PLANE

        lda #16/2
        do
            EraseSprite_xCount:
            ldb #3
            do
                clr $400,y
                clr ,y+
                decb
            while ne | wend
            EraseSprite_feed:
            leay $400*2-3,y
            cmpy #GVram+$2000
            if cc
                leay VramWidth-$400*8,y
            endif
            deca
        while ne | wend
    puls a,b,y
rts

scope
zseg
patternBytes:
    defs 6
plCount:
    defb 0
dseg
DrawSprite1_@Param2: public DrawSprite1_@Param2
DrawSprite2_@Param2: public DrawSprite2_@Param2
DrawSprite_pattern:
    defb 0

; void DrawSprite1(byte x, byte y, byte pattern);
cseg
DrawSprite1_: public DrawSprite1_
    pshs a,b,x,y
        pshs a
            bsr GVramPtr ; ->y
            bsr SpritePatternPtr ; ->x

            lda #$0f | sta ACTIVE_PLANE
            clr BMSK_COLOR
        puls a

        anda #1 ; xPos
        if eq
            lda #8 | sta yCount
            do
                lda ,x++
                sta B_REG
                lda ,x++
                sta R_REG
                lda ,x++
                sta G_REG
                sta ,y
                leay $400,y
                cmpy #GVram+$2000
                if cc
                    leay VramWidth-$400*8,y
                endif
                dec yCount
            while ne | wend
        else
            lda #8 | sta yCount
            do
                lda ,y
                lda B_REG | anda #$f0 | sta B_REG
                lda R_REG | anda #$f0 | sta R_REG
                lda G_REG | anda #$f0 | sta G_REG

                ldd ,x++
                stb patternBytes+0
                ldb #4
                do
                    lsra | ror patternBytes+0
                    decb
                while ne | wend
                ora B_REG | sta B_REG
                ldd ,x++
                stb patternBytes+1
                ldb #4
                do
                    lsra | ror patternBytes+1
                    decb
                while ne | wend
                ora R_REG | sta R_REG
                ldd ,x++
                stb patternBytes+2
                ldb #4
                do
                    lsra | ror patternBytes+2
                    decb
                while ne | wend
                ora G_REG | sta G_REG
                sta ,y+
                lda ,y
                lda B_REG | anda #$0f | ora patternBytes+0 | sta B_REG
                lda R_REG | anda #$0f | ora patternBytes+1 | sta R_REG
                lda G_REG | anda #$0f | ora patternBytes+2 | sta G_REG
                sta ,y
                leay $400-1,y
                cmpy #GVram+$2000
                if cc
                    leay VramWidth-$400*8,y
                endif
                dec yCount
            while ne | wend
        endif
    puls a,b,x,y
rts

; void DrawSprite2(byte x, byte y, byte pattern);
cseg
DrawSprite2_: public DrawSprite2_
    pshs a,b,x,y
        pshs a
            bsr GVramPtr ; ->y
            bsr SpritePatternPtr ; ->x

            lda #$0f | sta ACTIVE_PLANE
            clr BMSK_COLOR
        puls a

        anda #1 ; xPos
        if eq
            lda #16 | sta yCount
            do
                ldd ,x++
                stb patternBytes
                sta B_REG
                ldd ,x++
                stb patternBytes+1
                sta R_REG
                ldd ,x++
                stb patternBytes+2
                sta G_REG
                sta ,y+
                lda patternBytes
                sta B_REG
                lda patternBytes+1
                sta R_REG
                lda patternBytes+2
                sta G_REG
                sta ,y
                leay $400-1,y
                cmpy #GVram+$2000
                if cc
                    leay VramWidth-$400*8,y
                endif
                dec yCount
            while ne | wend
        else
            lda #16 | sta yCount
            do
                lda ,y
                lda B_REG | anda #$f0 | sta B_REG
                lda R_REG | anda #$f0 | sta R_REG
                lda G_REG | anda #$f0 | sta G_REG

                ldd ,x++
                stb patternBytes+0 | clr patternBytes+1
                ldb #4
                do
                    lsra | ror patternBytes+0 | ror patternBytes+1
                    decb
                while ne | wend
                ora B_REG | sta B_REG
                ldd ,x++
                stb patternBytes+2 | clr patternBytes+3
                ldb #4
                do
                    lsra | ror patternBytes+2 | ror patternBytes+3
                    decb
                while ne | wend
                ora R_REG | sta R_REG
                ldd ,x++
                stb patternBytes+4 | clr patternBytes+5
                ldb #4
                do
                    lsra | ror patternBytes+4 | ror patternBytes+5
                    decb
                while ne | wend
                ora G_REG | sta G_REG
                sta ,y+
                lda patternBytes+0
                sta B_REG
                lda patternBytes+2
                sta R_REG
                lda patternBytes+4
                sta G_REG
                sta ,y+
                lda ,y
                lda B_REG | anda #$0f | ora patternBytes+1 | sta B_REG
                lda R_REG | anda #$0f | ora patternBytes+3 | sta R_REG
                lda G_REG | anda #$0f | ora patternBytes+5 | sta G_REG
                sta ,y
                leay $400-2,y
                cmpy #GVram+$2000
                if cc
                    leay VramWidth-$400*8,y
                endif
                dec yCount
            while ne | wend
        endif
    puls a,b,x,y
rts
SpritePatternPtr:
    lda DrawSprite_pattern
    ldb #SpritePatternSize | mul
    tfr d,x
    leax SpritePattern,x
rts
endscope


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
        sta MAP0 | inca | sta MAP1
    puls a
rts


; void SwitchTVram();
cseg
SwitchTVram_: public SwitchTVram_
    pshs a
        lda DispPage
        eora #$01
        sta DISP_PAGE | sta DispPage
    puls a
rts
