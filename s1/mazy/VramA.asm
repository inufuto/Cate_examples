include "S1.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext Ground_

TVramTop equ TVram+VramRowSize*0
GVramTop equ GVram+VramRowSize*0

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
; GVramBank:
;     defb 0


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 1, 5 ; Wall
defb 4, 7 ; Goal
defb 4, 6 ; Bang
defb 4, 7 ; M
defb 4, 3 ; A
defb 4, 6 ; Z
defb 4, 2 ; Y
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
        ; lda #Bank_GVram1 | sta GVramBank
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


ext Map_
ext BaseX_, BaseY_

WindowWidth equ 32
WindowHeight equ 25
MapStep equ 8

; void MapToVram();
zseg
MapByte defb 0
cseg
MapToVram_: public MapToVram_
    pshs a,b,x,y
        lda BaseY_
        ldb #MapStep
        mul
        addd #Map_
        tfr d,x

        lda BaseX_
        asra
        asra
        asra
        leax a,x

        ldb #1
        lda BaseX_
        anda #7
        do | while ne
            aslb
            deca
        wend
        stb MapByte

        bsr NextPage_ | tfr d,y
        lda #WindowHeight
        do
            pshs a,x
                lda #WindowWidth
                do
                    pshs a
                        lda ,x
                        anda MapByte
                        if ne
                            lda #Char_Wall
                        else
                            lda #Char_Space
                        endif
                        sta ,y+
                        asl MapByte
                        if eq
                            leax 1,x
                            inc MapByte
                        endif
                    puls a
                    deca
                while ne | wend
            puls a,x
            leax MapStep,x
            leay VramRowSize-WindowWidth,y
            deca
        while ne | wend
    puls a,b,x,y
rts