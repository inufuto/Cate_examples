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
defb 16,6 ;Logo
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
        ldx #CRam+CharHeight*Char_Remain
        ldb #Char_End-Char_Remain
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


; word VramOffset(byte x, byte y);
cseg
VramOffset_: public VramOffset_
    sta <pVram+1
    clr <pVram
    lda #VramRowSize
    mul
    addd <pVram
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


; word WriteTVram(word vram, byte c);
cseg
WriteTVram_: public WriteTVram_
    stb ,x
    tfr x,d
    addd #1
rts


; word CurrentPage();
cseg
CurrentPage_: public CurrentPage_
    lda DispPage
    bita #1
    if eq
        ldd #TVram
    else
        ldd #TVram+$400
    endif
rts


; word NextPage();
cseg
NextPage_: public NextPage_
    lda DispPage
    bita #1
    if eq
        ldd #TVram+$400
    else
        ldd #TVram
    endif
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


; void ClearNextPage();
WindowWidth equ 32
WindowHeight equ 25
cseg
ClearNextPage_: public ClearNextPage_
    pshs a,b,x,y
        jsr NextPage_ | tfr d,x
        lda #WindowHeight
        do
            ldb #WindowWidth
            do
                clr ,x+
                decb
            while ne | wend
            leax VramRowSize-WindowWidth,x
            deca
        while ne | wend
    puls a,b,x,y
rts



cseg
CellChars0:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
CellChars4:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space4
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight4,Char_Item_TopRight_Space4
	defb Char_Item_BottomLeft_Item_BottomRight4,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space4
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle4,Char_Needle_Space4
	defb Char_Floor_Floor0,Char_Floor_Space4
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor4
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight4,Char_Item_TopRight_Space4
	defb Char_Item_BottomLeft_Item_BottomRight4,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle4,Char_Needle_Space4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_BottomLeft4
	defb Char_Space,Char_Space_Floor4
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_BottomLeft4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight4,Char_Item_TopRight_Space4
	defb Char_Item_BottomLeft_Item_BottomRight4,Char_Space_Item_BottomLeft4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle4,Char_Needle_Item_BottomLeft4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle4
	defb Char_Space,Char_Space_Floor4
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight4,Char_Item_TopRight_Space4
	defb Char_Item_BottomLeft_Item_BottomRight4,Char_Space_Needle4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle4,Char_Needle_Needle4
	defb Char_Floor_Floor0,Char_Floor_Floor0

ext CellMap_,LeftX_,DotOffset_

StageTop equ 4
ColumnCount equ 16*8
FloorCount equ 5
FloorHeight equ 4
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte

; void MapToVram();
zseg
pCharTable:
    defw 0
bitCount:
    defb 0
leftPos:
    defb 0
xPos:
    defb 0
fCount:
    defb 0
cCount:
    defb 0
wCell:
    defw 0

cseg
MapToVram_: public MapToVram_
    pshs a,b,x,y
        lda DotOffset_
        anda #1
        ldb #8*16 | mul
        addd #CellChars0
        std pCharTable

        lda LeftX_
        lsra | lsra | lsra
        ldx #CellMap_
        leax a,x

        bsr NextPage_
        addd #VramRowSize*StageTop
        tfr d,y

        clrb
        lda LeftX_
        anda #1
        if ne
            leay -1,y
            decb
        endif
        stb leftPos

        lda #FloorCount | sta fCount
        do
            lda leftPos | sta xPos
            pshs x,y
                ldd ,x++ | std wCell
                lda LeftX_
                lsra
                anda #3
                sta bitCount
                do | while ne
                    lsr wCell+1 | ror wCell
                    lsr wCell+1 | ror wCell
                    deca
                wend
                lda #WindowWidth/2+1 | sta cCount
                do
                    pshs x
                        lda wCell
                        anda #$0f
                        ldb #8 | mul
                        addd pCharTable
                        tfr d,x

                        lda #FloorHeight | sta yCount
                        do
                            lda #2 | sta xCount
                            do
                                lda ,x+
                                ldb xPos
                                cmpb #WindowWidth
                                if cs
                                    sta ,y
                                endif
                                leay 1,y
                                inc xPos
                                dec xCount
                            while ne | wend
                            dec xPos | dec xPos
                            leay VramRowSize-2,y
                            dec yCount
                        while ne | wend
                        inc xPos | inc xPos
                        leay 2-VramRowSize*FloorHeight,y
                    puls x
                    lsr wCell+1 | ror wCell
                    lsr wCell+1 | ror wCell

                    lda bitCount
                    inca
                    anda #3
                    if eq
                        ldb ,x+
                        stb wCell+1
                        clra
                    endif
                    sta bitCount
                    dec cCount
                while ne | wend
            puls x,y
            leay VramRowSize*FloorHeight,y
            leax MapWidth,x
            dec fCount
        while ne | wend
    puls a,b,x,y
rts
