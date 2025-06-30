include "S1.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

CharPatternSize equ CharHeight*PlaneCount
SpritePatternSize equ CharHeight*4*PlaneCount

VramTop equ Vram+VramRowSize*0

zseg
invertedByte:
mask:
    defb 0
colorBits:
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
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
VramBank:
    defb 0
pBackup: public pBackup
	defw 0
CharPatternRam:
    defs CharPatternSize*Char_End

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
        ldx #CharPatternRam
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
            ldb #CharHeight
            do
                lda ,y | sta ,x+
                lda CharHeight,y | sta ,x+
                lda CharHeight*2,y | sta ,x+
                leay 1,y
                decb
            while ne | wend
            leay CharHeight*2,y
        puls b
        decb
    while ne | wend
rts


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

        ldx #VVram_
        ldy #VVramWidth*VVramHeight*2
        bsr Clear

        lda #$e0 | sta DISP_PAGE
        lda #Bank_GVram1 | sta VramBank
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
        lda #CharPatternSize
        mul
        addd #CharPatternRam
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

        tfr x,d
        addd #1
    puls x,y
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        lda VramBank | sta MAP0
        inca | sta MAP1

        lda #$0f | sta ACTIVE_PLANE
        clr BMSK_COLOR

        ldx #VramTop
        stx <pVram
        ldx #VVram_
        ldy pBackup
        lda #VVramHeight | sta <yCount
        do
            lda #VVramWidth | sta <xCount
            do 
                ldb ,x+
                cmpb ,y
                if ne
                    stb ,y
                    tstb
                    if eq
                        clr B_REG
                        clr R_REG
                        clr G_REG
                        bsr Fill
                        bra VVramToVram_next
                    endif
                    cmpb #Char_Wall
                    if eq
                        lda #$ff
                        sta B_REG
                        clr R_REG
                        sta G_REG
                        bsr Fill
                        bra VVramToVram_next
                    endif
                    pshs x,y
                        lda #CharPatternSize
                        mul
                        addd #CharPatternRam
                        tfr d,y
                        ldx <pVram
                        bsr Put
                    puls x,y
                endif
                VVramToVram_next:
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
Fill:
    pshs a,x
        ldx <pVram
        lda #CharHeight
        do
            sta ,x
            leax $400,x
            deca
        while ne | wend
    puls a,x
rts

; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    pshs a,x
        lda VramBank
        anda #$02
        if eq
            lda #$e0 | sta DISP_PAGE
            lda #Bank_GVram1 | sta VramBank
            ldx #Backup1 | stx pBackup
        else
            lda #$e2 | sta DISP_PAGE
            lda #Bank_GVram0 | sta VramBank
            ldx #Backup0 | stx pBackup
        endif
    puls a,x
rts
