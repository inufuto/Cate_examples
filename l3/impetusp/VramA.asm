include "L3.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CharPattern, SpritePattern

RowStep equ $0400

dseg
CharColors: public CharColors
    defs $100
SpriteColors:
    defs Pattern_End
Backup: ;public Backup
    defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
SpriteCharPattern: public SpriteCharPattern
    defs PatternSize*($100-Char_End)
NextSpriteChar:
    defb 0

zseg
yCount:
    defb 0
xCount:
    defb 0

cseg
CharColorTable:
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 10, 4 ; Terrain4
defb 1, 5 ; Terrain5
defb 1, 6 ; Terrain6
defb 1, 7 ; Terrain7
defb 36, 5 ; Fort
defb 0
SpriteColorTable:
defb 1, 7 ; FighterBullet
defb 1, 2 ; EnemyBullet
defb 3, 5 ; Barrier
defb 5, 2 ; Bang
defb 1, 5 ; Item
defb 1, 7 ; Fighter
defb 1, 2 ; SkyEnemyA
defb 8, 3 ; SkyEnemyB
defb 1, 6 ; SkyEnemyC
defb 2, 7 ; GroundEnemy
defb 0
InitVram: public InitVram
    ldx #CharColorTable
    ldy #CharColors
    bsr ExtractColors

    ldx #SpriteColorTable
    ldy #SpriteColors
    bsr ExtractColors
rts
ExtractColors:
    do
        ldb ,x+
    while ne
        lda ,x+
        do
            ora #$90
            sta ,y+
            decb
        while ne | wend
    wend
rts

; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs a,x
        lda #$97 | sta C_REG_SEL
        
        ldx #Vram
        do
            clr ,x+
            cmpx #Vram+$2000
        while ne | wend
        
        ldx #Backup
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        ; ldx #VVram_
        ; do
        ;     clr ,x+
        ;     cmpx #VVram_+VVramWidth*VVramHeight
        ; while ne | wend
    puls a,x
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put:; (x,b)
    ldy #CharColors
    clra | lda d,y
    sta C_REG_SEL

    bsr PatternPtr ; b->y
    ldb #CharHeight
    do
        lda ,y+
        sta ,x
        leax RowStep,x
        decb
    while ne | wend
    leax 1-RowStep*CharHeight,x
rts
Put_: public Put_
    pshs x,y
        bsr Put
        tfr	x,d
    puls x,y
rts
PatternPtr: ;(b->y)
    cmpb #Char_End
    if cs
        ldy #CharPattern
    else
        subb #Char_End
        ldy #SpriteCharPattern
    endif
    lda #PatternSize | mul
    leay d,y
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    pshs x,y
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
        tfr a,b
        bsr Put
        tfr	x,d
    puls x,y
rts


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    pshs a,b,x,y
        ldx #VVram_
        ldy #SpriteLayer
        do
            ldd ,x++
            std ,y++
            cmpx #VVram_+VVramWidth*VVramHeight
        while ne | wend
        lda #Char_End | sta NextSpriteChar
    puls a,b,x,y
rts



; void EndDraw();
zseg
pVram:
    defw 0
cseg
EndDraw_: public EndDraw_
    pshs a,b,x,y
        ldx #Vram+VramRowSize*0
        stx pVram
        ldx #SpriteLayer
        ldy #Backup
        
        lda #VVramHeight | sta yCount
        do
            lda #VVramWidth | sta xCount
            do 
                ldb ,x+
                cmpb #Char_End
                bcc EndDraw_force
                cmpb ,y
                if ne
                    EndDraw_force:
                    stb ,y+
                    pshs x,y
                        ldx pVram
                        bsr Put
                        stx pVram
                    puls x,y
                else
                    pshs x
                        ldx pVram
                        leax 1,x
                        stx pVram
                    puls x
                    leay 1,y
                endif
                dec xCount
            while ne | wend
            pshs x
                ldx pVram
                leax VramWidth-VVramWidth,x
                stx pVram
            puls x
            dec yCount
        while ne | wend
    puls a,b,x,y
rts


; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
zseg
pSpriteLayer:
    defw 0
pSpritePattern:
    defw 0
pBackground:
    defw 0
pForeground:
    defw 0
color:
    defb 0
background:
    defb 0
foreground:
    defb 0
oldByte:
    defb 0
vCount:
    defb 0
cseg
DrawSprite_: public DrawSprite_
    pshs a,b,x,y
        pshs a ;xPos
            lda #VVramWidth | mul
            addd #SpriteLayer
            tfr d,x
        puls a ;xPos
        leax a,x
        stx pSpriteLayer

        lda DrawSprite_pattern
        ldx #SpriteColors
        ldb a,x
        stb color
        ldb #SpritePatternSize | mul
        addd #SpritePattern
        std pSpritePattern

        lda #2 | sta yCount
        do
            lda #2 | sta xCount
            do
                ldx pSpriteLayer
                ldb ,x
                stb background
                bsr PatternPtr ; background b->y
                sty pBackground

                ldb NextSpriteChar
                inc NextSpriteChar
                stb ,x+
                stx pSpriteLayer
                
                stb foreground
                bsr PatternPtr ; foreground b->y
                sty pForeground

                ldx pSpritePattern
                clr vCount
                ldb #CharHeight
                do
                    lda ,x+
                    coma
             
                    ldy pBackground
                    anda ,y+
                    sta oldByte
                    sty pBackground

                    lda ,x+
                    if ne
                        inc vCount
                    endif
                    ora oldByte
                    ldy pForeground
                    sta ,y+
                    sty pForeground
                    
                    decb
                while ne | wend
                stx pSpritePattern

                ldx #CharColors
                tst vCount
                if eq
                    ldb background
                    clra | lda d,x
                    sta color
                endif
                ldb foreground
                clra | leax d,x
                lda color | sta ,x

                dec xCount
            while ne | wend
            ldx pSpriteLayer
            leax VVramWidth-2,x
            stx pSpriteLayer

            dec yCount
        while ne | wend
    puls a,b,x,y
rts
