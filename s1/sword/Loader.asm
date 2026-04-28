include "S1.inc"
include "BinSize.inc"

cseg
    lda #$0f
    ldb #$40 or ((BinSize+$fff)/$1000)
    swi2 | defb $40,$01

    swi2 | defb $41,$56
    ; ldb #1
    ; swi2 | defb $41,$57
    do
        bsr ReadByte
        cmpa #$c9
    while ne | wend
    do
        bsr ReadByte
        cmpa #$c9
    while eq | wend

    pshs a
        bsr ReadByte
        tfr a,b
    puls a
    tfr d,x

    pshs x
        bsr ReadByte
        pshs a
            bsr ReadByte
            tfr a,b
        puls a
        tfr d,y

        do
            bsr ReadByte
            sta ,x+
            leay -1,y
        while ne | wend

        swi2 | defb $41,$0d
    puls x
    jmp ,x
loop:
    bra loop


ReadByte:
    pshs b
        swi2 | defb $41,$0a
        ldb MAP4
        pshs b
            ldb #$bc | stb MAP4
            sta $4000+40-1
        puls b
        stb MAP4
    puls b
rts
