include "Vram.inc"
include "Share.inc"

OffscreenPage equ $08

zseg
yCount:
    defb 0


cseg
SubMain: public SubMain
    lda #high yCount | tfr a,dp
    lda #$07 | sta $AFE2

    clr SubShareRam+Share_Command
loop:
    ldb $AFE0 | orb #$01 | stb $AFE0 ; ready
    lda SubShareRam+Share_Command
    beq loop
    ldb $AFE0 | andb #not $01 | stb $AFE0 ; busy
    
    deca
    beq ClearVram
    deca
    beq Put
    deca
    beq DefChar
    deca
    beq SetWall
    next:
    clr SubShareRam+Share_Command
bra loop

ClearVram:
    lda #$1f | sta $AFE1
    clr $AFE3

    ldx #0
    do
        clr ,x+
        cmpx #$4000
    while ne | wend
bra next

DefChar:
    lda #$1f | sta $AFE1
    lda #OffscreenPage | sta $AFE3

    lda SubShareRam+Share_Char
    ldb#PatternSize | mul
    tfr d,y
    ldx #SubShareRam+Share_Pattern

    ldb #PatternSize
    do
        lda ,x+ | sta ,y+
        decb
    while ne | wend
bra next


Put:
    lda SubShareRam+Share_Char
    ldb#PatternSize | mul
    tfr d,x
    ldy SubShareRam+Share_Address

    ldb #$01
    do
        pshs b
            orb #$38 | andb #$3f | stb $AFE1
            lda #CharHeight | sta <yCount
            do
                ldb #OffscreenPage | stb $AFE3
                ldd ,x++
                clr $AFE3
                std ,y
                leay VramWidth,y
                dec <yCount
            while ne | wend
            leay -VramRowSize,y
        puls b
        lslb | andb #$07
    while ne | wend
bra next


SetWall: public SetWall
    ldy SubShareRam+Share_Address
    lda SubShareRam+Share_Char
    ldb #$3d | stb $AFE1    
    ldb #CharHeight | stb <yCount
    tfr a,b
    do
        std ,y
        leay 80,y
        dec <yCount
    while ne | wend
bra next
