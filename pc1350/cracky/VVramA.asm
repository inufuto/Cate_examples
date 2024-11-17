include "InternalRam.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_

; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push
    exab|push|exab
        push
            exab
            lp RegisterX | exam | ldm
            rc|sl ;*2
            adm|ldm ;*3
            lib 0
            rc|sl| exab | sl | exab ;*6
            rc|sl| exab | sl | exab ;*12
            rc|sl| exab | sl | exab ;*24
            exam
            exab | lp RegisterX+1 | exam
        pop
        lib 0
        lp RegisterX | adb
    exab|pop|exab
    pop
rtn


; void VVramBackToFront();
cseg
VVramBackToFront_: public VVramBackToFront_
    push
    lp RegisterI|exam|push|exam
    lp RegisterJ|exam|push|exam
    lia low (VVramBack_-1) | lp RegisterX|exam|push
    lia high (VVramBack_-1) | lp RegisterX+1|exam|push
    lia low (VVramFront_-1) | lp RegisterY|exam|push
    lia high (VVramFront_-1) | lp RegisterY+1|exam|push
        lii VVramHeight
        do
            lij VVramWidth
            do
                ixl | iys
                decj
            while nz|wend
            deci
        while nz|wend
    lp RegisterY+1|exam|pop|exam
    lp RegisterY|exam|pop|exam
    lp RegisterX+1|exam|pop|exam
    lp RegisterX|exam|pop|exam
    lp RegisterJ|exam|pop|exam
    lp RegisterI|exam|pop|exam
    pop
rtn
