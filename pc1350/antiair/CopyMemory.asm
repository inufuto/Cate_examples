include "InternalRam.inc"

; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
cseg
CopyMemory_: public CopyMemory_
    push
    lp RegisterI|ldm|push
    lp RegisterX+1|ldm|push
    lp RegisterX|ldm|push
    lp RegisterY+1|ldm|push
    lp RegisterY|ldm|push
    lp Word0+1|ldm|push
    lp Word0|ldm|push
        lp RegisterX | liq RegisterY | lii 2-1 | exw
        dx | dy
        do
            ixl | iys
            lia 1 | lib 0
            lp Word0 | sbb
        while nz|wend
    lp Word0|pop|exam
    lp Word0+1|pop|exam
    lp RegisterY|pop|exam
    lp RegisterY+1|pop|exam
    lp RegisterX|pop|exam
    lp RegisterX+1|pop|exam
    lp RegisterI|pop|exam
    pop
rtn


; void FillMemory(ptr<byte> pDestination, word length, byte b);
cseg
FillMemory_: public FillMemory_
    push
    lp RegisterX+1|ldm|push
    lp RegisterX|ldm|push
    lp RegisterY+1|ldm|push
    lp RegisterY|ldm|push
        liq RegisterX | lp RegisterY | lij 2-1 | exb
        dy
        do
            lp RegisterI|ldm
            iys
            lia 1 | lib 0
            lp RegisterX | sbb
        while nz|wend
    lp RegisterY|pop|exam
    lp RegisterY+1|pop|exam
    lp RegisterX|pop|exam
    lp RegisterX+1|pop|exam
    pop
rtn
