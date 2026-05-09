ext InitSound
ext Main_

cseg

Init_: public Init_
    sei
    jsr InitSound
    jsr Main_
    cli
rts


Wait_: public Wait_
    psha
        do
            ldx #700
            do
                dex
            while ne | wend
            deca
        while ne | wend
    pula
rts
