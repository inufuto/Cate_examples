include "InternalRam.inc"

ext InitSound
ext Main_

cseg
    ldp|push
        call InitSound
        call Main_
    pop|stp
rtn


; void Wait(byte t);
Wait_: public Wait_
    push
        do
            Wait 15
            deca
        while nz|wend
    pop
rtn