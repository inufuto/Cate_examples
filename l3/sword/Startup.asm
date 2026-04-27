include "L3.inc"

ext InitVram
ext InitSound
ext KeyHandler
ext Main_

dseg
TimerCount:  public TimerCount
    defb 0
DpBackup:
    defb 0
OldHandler:
    defw 0

zseg
Direct:

cseg
    lda #$40 | sta KB

    tfr dp,a
    sta DpBackup
    lda #high Direct
    tfr a,dp

    clr TimerCount

    orcc #$60
        ldd $10c+1
        std OldHandler
        ldd #Handler
        std $10c+1

        ldd $0110
        std FHandler_end+1
        ldd #FHandler
        std $0110
    andcc #not $60

    jsr InitVram
    jsr InitSound
    jsr Main_

    orcc #$60
        ldd FHandler_end+1
        std $0110

        ldd OldHandler
        std $10c+1
    andcc #not $60
    
    lda DpBackup
    tfr a,dp

    lda #$c0
    sta KB

    ;lda $0249
    ;sta MODE_SEL
rts


Handler: public Handler
    jsr KeyHandler
rti

FHandler:
    inc TimerCount
FHandler_end:
jmp $e131


dseg
WaitTimer_param:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    sta WaitTimer_param
        do
            lda TimerCount
            cmpa WaitTimer_param
        while cs | wend
    lda WaitTimer_param
    orcc #$50
        clr TimerCount
    andcc #not $50
rts
