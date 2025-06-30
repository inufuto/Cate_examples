include "S1.inc"

ext InitVram
ext InitSound, SoundHandler
ext JoystickAvailable_, InitKeys, KeyHandler
ext Main_

zseg
Direct: public Direct

dseg
TimerCount: public TimerCount
    defb 0 
Division:
    defb 0 

cseg
Init_: public  Init_
    lda #$e0 | sta DISP_PAGE
    clr SCRN_MODE
    clr MODE_SEL
    lda #$80 | sta TIME_MASK
    
    ldx #Palette
    ldy #PALET0
    ldb #8
    do
        lda ,x+ | sta ,y+
        decb
    while ne | wend

    lda #high Direct
    tfr a,dp

    clr TimerCount
    clr Division
    clr JoystickAvailable_
    jsr InitKeys
    jsr InitSound

    orcc #$50
        ldd VFIRQ+1
        std FHandler_end+1
        ldd #FHandler
        std VFIRQ+1

        ldd #Handler
        std VIRQ+1
    andcc #not $50
    lda #$40 | sta KB_W

    jsr InitVram
jmp Main_
Palette:
    defb 0,1+8,2+8,3+8,4+8,5+8,6+8,7+8

Handler: public Handler
    jsr KeyHandler
rti

FHandler: public FHandler
    pshs a
        lda $FFCA
        anda #$40
        if ne
            lda Division
            if eq
                inc TimerCount
                jsr SoundHandler
                lda #8
            else
                deca  
            endif
            sta Division
        endif
    puls a
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
