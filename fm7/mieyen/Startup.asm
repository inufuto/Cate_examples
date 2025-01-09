include "bios.inc"
ext @Temp@word
ext InitVram, SendSubSys, SendSubProgram, StartSubMain, SendPattern
ext JoystickAvailable_
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: defb 0 public TimerCount
division:defb 0

cseg
    clr $FD02

    lda #high @Temp@word
    tfr a,dp

    clr JoystickAvailable_
    jsr InitVram
    jsr SendSubProgram
    jsr StartSubMain
    jsr InitSound
    jsr SendPattern

    clr division
    orcc #$50
        ldd #Handler
        std $05DF+1
    andcc #not $50

    lda #$04
    sta $FD02
jmp Main_


Handler: public Handler
    pshs a
        lda division
        if pl
            suba #50
            sta division

            inc TimerCount
            jsr SoundHandler
        else
            adda #6
            sta division
        endif
    puls a
; Handler_end:
; jmp $ed72
rts

; returnI:
; rti

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


InitConsole_Command:
    defb 0,0
    defb SUB.INIT
    defb 0
    defb 40,25
    defb 0,25
    defb 0,1,0

InitConsole: public InitConsole
    pshs x,b
        ldx #InitConsole_Command
        ldb #11
        jsr SendSubSys
    puls x,b
rts
