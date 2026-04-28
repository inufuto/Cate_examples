include "Vram.inc"
include "Share.inc"
include "Chars.inc"

SpritePatternPage equ $10
SpriteHeight equ 16

dseg
CharPattern:
    defs CharPatternSize*Char_End

zseg
CurrentPage:
    defb 0
xCount:
    defb 0
yCount:
    defb 0
readPlane:
    defb 0
writePlane:
    defb 0
maskWord:
    defw 0
patternWord:
    defw 0

cseg
SubMain: public SubMain
    ; lds #$a000
    orcc #$50
    lda #high CurrentPage | tfr a,dp
    lda #$07 | sta $AFE2

    clr SubShareRam+Share_Command
loop:
    ldb $AFE0 | orb #$01 | stb $AFE0 ; ready
    do
        lda SubShareRam+Share_Command
    while eq | wend
    ldb $AFE0 | andb #not $01 | stb $AFE0 ; busy
    deca
    lsla
    ldx #Table
    ldx a,x
    jmp ,x
    next:
    clr SubShareRam+Share_Command
bra loop
Table:
    defw ClearVram
    defw DrawChar1, DrawChar2, DrawSprite
    defw SwitchPage
    defw DefChar, DefSprite

Clear:
    ldx #0
    do
        clr ,x+
        cmpx #$4000
    while ne | wend
rts
ClearVram:
    lda #$1f | sta $AFE1
    clr $AFE3
    bsr Clear
    lda #$07 | sta $AFE2
    lda #$08 | sta $AFE3 | sta CurrentPage
    bsr Clear
bra next

DrawChar:
    lda #CharHeight | sta yCount
    do
        ldb #$01
        do
            pshs b
                orb #$38 | andb #$3f | stb $AFE1
                ldd ,x++
                std ,y
            puls b
            lslb | andb #$07
        while ne | wend
        leay VramWidth,y
        dec yCount
    while ne | wend
rts

DrawChar1:
    lda SubShareRam+Share_Char
    ldb #CharPatternSize | mul
    addd #CharPattern
    tfr d,x
    ldy SubShareRam+Share_Address
    bsr DrawChar
bra next

DrawChar2:
    lda SubShareRam+Share_Char
    ldb #CharPatternSize | mul
    addd #CharPattern
    tfr d,x
    ldy SubShareRam+Share_Address
    clr $AFE3
    pshs x,y
        bsr DrawChar
    puls x,y
    lda #$08 | sta $AFE3
    bsr DrawChar
    lda CurrentPage | sta $AFE3
bra next

DrawSprite: public DrawSprite
    lda SubShareRam+Share_Char
    clrb
    tfr d,x
    ldy SubShareRam+Share_Address
    lda #SpriteHeight | sta yCount
    do
        lda #2 | sta <xCount
        do
            lda #$38 | sta $AFE1
            lda #SpritePatternPage | sta $AFE3
            ldd ,x++
            if ne
                coma | comb
                std maskWord
                clr readPlane
                lda #$01 | sta writePlane
                do
                    lda #SpritePatternPage | sta $AFE3
                    ldd ,x++ | std patternWord
                    
                    lda readPlane | ora writePlane | ora #$38 | sta $AFE1
                    lda CurrentPage | sta $AFE3
                    ldd ,y
                    anda maskWord | ora patternWord
                    andb maskWord+1 | orb patternWord+1
                    std ,y

                    lda #$38 | sta $AFE1
                    lda readPlane | adda #$40 | sta readPlane
                    lda writePlane | lsla | anda #$07 | sta writePlane
                while ne | wend
            else
                leax 2*PlaneCount,x
            endif
            leay 2,y
            dec xCount
        while ne | wend
        leay VramWidth-2*2,y
        dec yCount
    while ne | wend
    lda CurrentPage | sta $AFE3
bra next

SwitchPage:
    do
        lda $AFE6
    while mi | wend
    lda CurrentPage
    pshs a
        eora #$08
        sta $AFE3 | sta CurrentPage
    puls a
    ora #$07
    sta $AFE2
    nop | nop | nop | nop
bra next

DefChar:
    lda SubShareRam+Share_Char
    ldb #CharPatternSize | mul
    addd #CharPattern
    tfr d,y
    ldx #SubShareRam+Share_Pattern

    ldb #CharPatternSize
    do
        lda ,x+ | sta ,y+
        decb
    while ne | wend
bra next

DefSprite:
    lda SubShareRam+Share_Char
    ldb #SpritePatternSize/4 | mul
    tfr d,y
    lda #$1f | sta $AFE1
    lda #SpritePatternPage | sta $AFE3
    ldx #SubShareRam+Share_Pattern

    ldb #SpritePatternSize/4
    do
        lda ,x+
        sta ,y+
        decb
    while ne | wend
    
    lda CurrentPage | sta $AFE3
bra next
