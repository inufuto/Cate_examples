include "SharedRam.inc"
include "Share.inc"

ext @Temp@word
ext HaltSubsys, ResumeSubsys, SendSubsys, SendSubProgram
ext InitVram, SendPattern
ext InitKey, KeyHandler
ext InitSound
ext Main_

dseg
TimerCount: defb 0 public TimerCount
division:defb 0


cseg
    lda #high @Temp@word
    tfr a,dp

    jsr StartTimer
    jsr SendSubProgram
    jsr InitSound
    jsr InitKey
    jsr InitVram
    jsr SendPattern

    clr division
    orcc #$50
        ldd #SubSysHandler
        std $01e0+1
        lda Handler_End
        std $01da
    andcc #not $40
jmp Main_


StartTimer_Command:
    defb 0,0
    defb $3d ; SETTIM
    defb $19,$02
    defb 0,0,0,0
    defb 0,0,0,0
    defb 0,0,0,1
    defb 0,0,0,1
StartTimer: public StartTimer
    ldx #StartTimer_Command
    ldb #21
    jsr SendSubsys
rts


SubSysHandler: public SubSysHandler
    pshs a,b
        lda $FD04
        bita #$01
        if eq
            jsr HaltSubsys
            ldd SharedRam
            clr SharedRam+Share_Status
            jsr ResumeSubsys
            bitb #$20
            if ne
                jsr TimerHandler
            endif
            bitb #$0f
            if ne
                jsr KeyHandler
            endif
        endif
    puls a,b
Handler_End:
rti


TimerHandler: public TimerHandler
    pshs a
        lda division
        do
        while pl
            inc TimerCount
            ; jsr SoundHandler
            suba #5
        wend
        adda #6
        sta division
    puls a
rts


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
