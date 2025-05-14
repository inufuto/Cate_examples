ext InitVram
ext InitSound
ext Main_

cseg
    sei

    jsr $e37e  ;use Graph1
    
    ldaa #$c0
    staa $efe0

    ldaa #1
    staa $e892  ;color mode

    jsr $e38d  ;clear Graph1

    jsr InitVram
    jsr InitSound
    jsr Main_

    clr $efe0
    clr $e892   ;color mode

    cli
rts



Wait_: public Wait_
    psha
        do
            ldx #180
            do
                dex
            while ne | wend
            deca
        while ne | wend
    pula
rts
