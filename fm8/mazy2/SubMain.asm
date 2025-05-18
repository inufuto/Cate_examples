include "Share.inc"
include "Vram.inc"
include "Chars.inc"

SharedRam  equ $D380

plCount equ $00
yCount equ $01

dseg
SubChars: public SubChars
    defs PatternSize*(Char_End-Char_Subsys)

cseg
SubMain: public SubMain
    lds #$d100
    clr SharedRam+Share_Command
loop:
    sta $d40a ; busy
    lda $d004
    if ne
        sta SharedRam
        lda #$0f | sta SharedRam+Share_Status
        lda $d404 ; ATTENTION
        clr $d004
    endif
    lda $d40a ; ready
    lda SharedRam+Share_Command
    beq loop
    sta $d40a ; busy
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
    orcc #$40
        tst $d409
        ldx #0 | tfr x,d
        do
            std ,x++
            cmpx #$c000
        while ne | wend
        sta $d409
    andcc #not $40
bra next


Put: public Put
    orcc #$40
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
    andcc #not $40
bra next

DefChar: public DefChar
    orcc #$40
        ; tst $d409
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
        ; sta $d409
    andcc #not $40
bra next


SetWall: public SetWall
    orcc #$40
        tst $d409
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
        sta $d409
    andcc #not $40
bra next
