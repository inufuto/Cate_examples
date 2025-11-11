include "S1.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVramBack_, VVramFront_

SpritePatternSize equ CharHeight*(1+PlaneCount)*4

dseg
PatternRam: public PatternRam
    defs PatternSize*Char_End
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
pBackup:
	defw 0
VramBank:
    defb 0

zseg
pVram:
    defw 0
yCount:
    defb 0
xCount:
    defb 0

scope
zseg
invertedByte:
mask:
    defb 0
colorBits:
    defb 0
dotCount:
    defb 0
cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
    pshs u,cc | orcc #$50
        ldy #MonoPattern
        ldx #PatternRam
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
        ldb #Char_End-Char_Color
        bsr MakePatternColor
    puls u,cc
rts

MakePatternMono:
    do
        pshs b
            ldb #CharHeight
            do
                pshs a,b
                    ldb #PlaneCount
                    do
                        pshs b
                            clrb
                            bita #$01
                            if ne
                                orb ,y
                            endif
                            bita #$10
                            if ne
                                pshs a
                                    lda ,y
                                    coma
                                    sta <invertedByte
                                puls a
                                orb <invertedByte
                            endif
                            stb ,x+
                            lsra
                        puls b
                        decb
                    while ne | wend
                    leay 1,y
                puls a,b
                decb
            while ne | wend
        puls b
        decb
    while ne | wend
rts

MakePatternColor:
    do
        pshs b
            ldb #CharHeight*PlaneCount
            do
                lda ,y+
                sta ,x+
                decb
            while ne | wend
        puls b
        decb
    while ne | wend
rts
endscope


; void ClearScreen();
cseg
ClearPage:
    ldx #0
    do
        clr ,x+
        cmpx #$1000
    while ne | wend
rts
Clear:
    do
        clr ,x+
        leay -1,y
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pshs a,b,x,y
        lda #$07 | sta ACTIVE_PLANE
        lda #Bank_GVram0
        do
            sta MAP0
            bsr ClearPage
            inca
            cmpa #$b4
        while ne | wend
        lda #$bc | sta MAP0
        bsr ClearPage

        ldx #Backup
        ldy #VVramWidth*VVramHeight*2
        bsr Clear

        ldx #VVramBack_
        ldy #VVramWidth*VVramHeight*2
        bsr Clear

        lda #$e0 | sta DISP_PAGE
        lda #Bank_GVram1 | sta VramBank
        sta MAP0 | inca | sta MAP1
        ldx #Backup1 | stx pBackup
    puls a,b,x,y
rts


cseg
Put: ; (x,y)
    pshs a,b
        ldb #CharHeight
        do
            lda ,y+ | sta B_REG
            lda ,y+ | sta R_REG
            lda ,y+ | sta G_REG
            sta ,x
            leax $400,x
            decb
        while ne | wend
        leax -$400*CharHeight,x
    puls a,b
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs x,y
        lda #PatternSize
        mul
        addd #PatternRam
        tfr d,y

        lda #$0f | sta ACTIVE_PLANE
        clr BMSK_COLOR

        lda #Bank_GVram0 | sta MAP0
        inca | sta MAP1
        bsr Put
        leay -CharHeight*PlaneCount,y
        lda #Bank_GVram1 | sta MAP0
        inca | sta MAP1
        bsr Put
        lda VramBank | sta MAP0 | inca | sta MAP1

        tfr x,d
        addd #1
    puls x,y
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
        tfr a,b
        bsr Put_
    puls y
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        lda VramBank | sta MAP0
        inca | sta MAP1

        lda #$0f | sta ACTIVE_PLANE
        clr BMSK_COLOR

        ldx #Vram
        stx <pVram
        ldx #VVramFront_
        ldy pBackup
        lda #VVramHeight | sta <yCount
        do
            lda #VVramWidth | sta <xCount
            do 
                ldb ,x+
                cmpb ,y
                if ne
                    stb ,y
                    pshs x,y
                        lda #PatternSize
                        mul
                        addd #PatternRam
                        tfr d,y
                        ldx <pVram
                        bsr Put
                    puls x,y
                endif
                leay 1,y
                pshs x
                    ldx <pVram
                    leax 1,x
                    stx <pVram
                puls x
                dec <xCount
            while ne | wend
            pshs x
                ldx <pVram
                leax VramWidth-VVramWidth,x
                stx <pVram
            puls x
            dec <yCount
        while ne | wend
    puls a,b,x,y
rts


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    pshs a,x
        lda VramBank
        anda #$02
        if eq
            lda #$e0 | sta DISP_PAGE
            ldx #Backup1 | stx pBackup
            lda #Bank_GVram1
        else
            lda #$e2 | sta DISP_PAGE
            ldx #Backup0 | stx pBackup
            lda #Bank_GVram0
        endif
        sta VramBank
        sta MAP0 | inca | sta MAP1
    puls a,x
rts


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    pshs a,b,x
        pshs a
            lda #VVramWidth
            mul
            addd #Backup0
            tfr d,x
        puls a
        leax a,x
        ldd #$ff02
        do
            sta Backup1-Backup0,x
            sta ,x+
            sta Backup1-Backup0,x
            sta ,x
            leax VVramWidth-1,x
            decb
        while ne | wend
    puls a,b,x
rts


scope
dseg
DrawSprite1_@Param2: public DrawSprite1_@Param2
DrawSprite2_@Param2: public DrawSprite2_@Param2
DrawSprite_pattern:
    defb 0
zseg
mask:
    defb 0
dotCount:
    defb 0

; void DrawSprite1(byte x, byte y, byte pattern);
cseg
DrawSprite1_: public DrawSprite1_
    pshs a,b,x,y
        bsr VramPtr ; ->y
        bsr SpritePatternPtr ; ->x
        lda #$0f | sta ACTIVE_PLANE
        clr BMSK_COLOR

        bsr Draw1
    puls a,b,x,y
rts


; void DrawSprite2(byte x, byte y, byte pattern);
cseg
DrawSprite2_: public DrawSprite2_
    pshs a,b,x,y
        bsr VramPtr ; ->y
        bsr SpritePatternPtr ; ->x
        lda #$0f | sta ACTIVE_PLANE
        clr BMSK_COLOR

        lda #2 | sta yCount
        do
            lda #2 | sta xCount
            do
                bsr Draw1
                leay 1-$400*CharHeight,y
                dec xCount
            while ne | wend
            leay VramWidth-2,y
            dec yCount
        while ne | wend
    puls a,b,x,y
rts
VramPtr:
    pshs a ;xPos
        lda #VramRowSize | mul
        tfr d,y
    puls a ;xPos
    leay a,y
rts
SpritePatternPtr:
    lda DrawSprite_pattern
    ldb #SpritePatternSize | mul
    tfr d,x
    leax SpritePattern,x
rts
Draw1:
    lda #CharHeight | sta dotCount
    do
        lda ,x+ | coma | sta mask
        lda ,y
        lda B_REG | anda mask | ora ,x+ | sta B_REG
        lda R_REG | anda mask | ora ,x+ | sta R_REG
        lda G_REG | anda mask | ora ,x+ | sta G_REG
        sta ,y
        leay $400,y
        dec dotCount
    while ne | wend
rts
endscope