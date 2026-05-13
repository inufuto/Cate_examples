ext InitSound
ext Main_

Interval equ 10240*2

dseg
NmiSave:
    defw 0
IrqSave:
    defw 0
StatusSave:
    defb 0
TimerCount:
    defb 0

cseg
    jsr InitSound

    ldx $2251+1 | stx NmiSave
    ldx #return | stx $2251+1

    sei
        ldx $2245+1 | stx IrqSave
        ldx #Handler | stx $2245+1
        ldaa <$08 | staa StatusSave
        ldaa #$08 | staa <$08
        ldx #0 | stx <$09
        ldx #Interval | stx <$0b
    cli
    jsr Main_
    sei
        ldx IrqSave | stx $2245+1
        ldaa StatusSave | staa <$08
    cli
    ldx NmiSave | stx $2252+1
return:
rts


Handler: public Handler
    psha | pshb
        ldaa <$08
        ldd #0 | std <$09
        ldd #Interval | std <$0b
        ldaa #$08 | staa <$08
        inc TimerCount
    pulb | pula
rti


dseg
WaitTimer_param:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    staa WaitTimer_param
        do
            ldaa TimerCount
            cmpa WaitTimer_param
        while cs
        wend
    ldaa WaitTimer_param
    clr TimerCount
rts
