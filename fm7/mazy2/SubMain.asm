include "Vram.inc"
include "Share.inc"
include "Chars.inc"

SharedRam  equ $D380

plCount equ $00
yCount equ $01


dseg
SubChars: public SubChars
    defs PatternSize*(Char_End-Char_Subsys)

cseg
SubMain: public SubMain
    lds #$d000
    clr SharedRam+Share_Command
loop:
    lda $d40a ; ready
    lda SharedRam+Share_Command
    beq loop
    sta $d40a
    deca
    beq ClearVram
    deca
    beq Put
    deca
    beq DefChar
    deca
    beq SetWall
    next:
    clr SharedRam+Share_Command
bra loop


ClearVram: public ClearVram
    pshs cc | orcc #$50
        tst $d409
        ldx #0
        do
            clr ,x+
            cmpx #$c000
        while ne | wend
        sta $d409
    puls cc
bra next

Put: public Put
    pshs cc | orcc #$50
        tst $d409
        ldy SharedRam+Share_Address
        lda SharedRam+Share_Char
        if eq
            ldb #3 | stb <plCount
            do
                ldb #CharHeight
                do
                    clr ,y+
                    clr ,y
                    leay 80-1,y
                    decb
                while ne | wend
                leay $4000-80*8,y
                dec <plCount
            while ne | wend
            bra Put_exit
        endif
        cmpa #Char_Subsys
        if cs
            ldx #SharedRam+Share_Pattern
        else
            suba #Char_Subsys
            ldb #PatternSize
            mul
            addd #SubChars
            tfr d,x
        endif
        ldb #3 | stb <plCount
        do
            ldb #CharHeight | stb <yCount
            do
                ldd ,x++
                std ,y++
                leay 80-2,y
                dec <yCount
            while ne | wend
            leay $4000-80*8,y
            dec <plCount
        while ne | wend
        Put_exit:
        sta $d409
    puls cc
bra next

DefChar: public DefChar
    pshs cc | orcc #$50
        tst $d409
        ldx #SharedRam+Share_Pattern
        lda SharedRam+Share_Char
        suba #Char_Subsys
        ldb #PatternSize
        mul
        addd #SubChars
        tfr d,y
        ldb #PatternSize
        do
            lda ,x+
            sta ,y+
            decb
        while ne | wend
        sta $d409
    puls cc
bra next


SetWall: public SetWall
    pshs cc | orcc #$50
        ldy SharedRam+Share_Address
        leay $8000,y
        lda SharedRam+Share_Char
        ldb #CharHeight | stb <yCount
        tfr a,b
        do
            std ,y
            leay 80,y
            dec <yCount
        while ne | wend
    puls cc
bra next
