include "InternalRam.inc"

; byte Abs(byte a, byte b);
cseg
Abs_: public Abs_
    exab|push|exab
        lp RegisterB | sbm | exab
        if nz
            tsia 80h
            if nz
                lib 0
                sbm
                exab
            endif
        endif
    exab|pop|exab
rtn
