include "GameCom.inc"
include "Vram.inc"

ext InitKeys, ScanKeys_, ScanStop_
ext InitSound, SoundHandler
ext Main_
ext ExitPoint

dseg
; oldIE0:
;     defb 0
; oldIE1:
;     defb 0
TimerCount: public TimerCount
    defb 0

cseg
Startup: public Startup
    push r0
        di
        ; LCD
        bset r LCC,7
        ; Interrupt
        ; mov r0,IE0_ | mov @oldIE0,r0
        ; mov r0,IE1_ | mov @oldIE1,r0
        ; mov IE0,00h
        ; mov IE1,40h
        mov r TM1C,85h
        mov r TM1D,5

        call InitSound
        ei
        call InitKeys
        call Main_

        ; mov r0,@oldIE0 | mov IE0_,r0
        ; mov r0,@oldIE1 | mov IE1_,r1

        mov r SGC,80h
    pop r0
jmp T,ExitPoint


Handler: public Handler
    push r0
        mov r0,@TimerCount
        inc r0
        mov @TimerCount,r0
        call SoundHandler
    pop r0
iret


WaitTimer_: public WaitTimer_
    push r0
        do
            mov r0,@TimerCount
            cmp r0,r1
        while c | wend
        di
            clr r0
            mov @TimerCount,r0
        ei
    pop r0
ret