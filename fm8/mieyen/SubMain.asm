include "Share.inc"
include "Vram.inc"
include "Chars.inc"

SharedRam  equ $D380

plCount equ $00
yCount equ $01

dseg
SubChars: public SubChars
    defs PatternSize*(Char_End-Char_Monster)

cseg
SubMain: public SubMain
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
    
    cmpa #SubCommand_Put
    if eq
        bsr Put
        bra next
    endif
    cmpa #SubCommand_Clear
    if eq
        bsr ClearVram
        bra next
    endif
    cmpa #SubCommand_DefChar
    if eq
        bsr DefChar
    endif

    next:
    clr SharedRam+Share_Command
bra loop


ClearVram: public ClearVram
    pshs cc | orcc #$40
        tst $d409
        ldx #0 | tfr x,d
        do
            std ,x++
            cmpx #$c000
        while ne | wend
        sta $d409
    puls cc
rts


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
        cmpa #Char_Monster
        if cs
            ldx #SharedRam+Share_Pattern
        else
            suba #Char_Monster
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
rts

DefChar: public DefChar
    pshs cc | orcc #$50
        tst $d409
        ldx #SharedRam+Share_Pattern
        lda SharedRam+Share_Char
        suba #Char_Monster
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
rts
