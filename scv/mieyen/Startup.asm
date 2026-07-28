ext InitVram
ext InitSound, SoundHandler
ext Main_

dseg
DsegTop: public DsegTop

zseg
TimerCount:
    defb 0

cseg
    defb 'H'
    calt 90h
    di
        lxi sp,DsegTop

        lxi h,VideoValues
        lxi d,3400h
        mvi c,4-1
        block
    ei
    call InitVram
    call InitSound

    di
        lxi h,Handler
        shld $fffa+1
    ei

    mvi a,60
    call WaitTimer_
jmp Main_

VideoValues:
    defb 51h
    defb 21h
    defb 00h
    defb 21h

Handler: public Handler
    if offi mk,$20
        inrw TimerCount
        call SoundHandler
    endif
;     ei
; reti
jmp $0951


WaitTimer_: public WaitTimer_
    push v | push d
        mov e,a
        do
            ldaw TimerCount
            sub a,e
            sknc
        repeat
        di
            xra a,a
            staw TimerCount
        ei
    pop d | pop v
ret
