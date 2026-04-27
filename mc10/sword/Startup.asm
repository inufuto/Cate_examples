ext InitSound
ext Main_

Interval equ 14833*4/5

cseg
    ldaa #$24
    staa $bfff

    jsr InitSound

    ; clr TimerCount
    ; clr PrevSync
    clr <$08
jmp Main_


ResetTimer: public ResetTimer
    ldx #0 | stx <$09
    ldx #Interval
    stx <$0b
rts


WaitTimer_: public WaitTimer_
    psha
        do
            psha
                do
                    ldaa <$08
                    anda #$40
                while eq | wend
                bsr ResetTimer
                ; do
                ;     ldaa <$08
                ;     anda #$40
                ; while ne | wend
            pula
            deca
        while ne | wend
    pula
rts
