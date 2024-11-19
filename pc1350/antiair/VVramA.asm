include "InternalRam.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext Ground_
ext BlockChars_


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
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
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
    lp RegisterY+1|pop|exam
    lp RegisterY|pop|exam
    lp RegisterX+1|pop|exam
    lp RegisterX|pop|exam
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    pop
rtn


Ground_BlockMask equ $03
Ground_BombMask equ $0c

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    push
    exab|push
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
    lia low (VVramBack_-1) | lp RegisterY|exam|push
    lia high (VVramBack_-1) | lp RegisterY+1|exam|push
    lia low (Ground_-1) | lp RegisterX|exam|push
    lia high (Ground_-1) | lp RegisterX+1|exam|push
        lia 00h
        lii 6
        do
            lij VVramWidth
            do
                iys
                decj
            while nz|wend
            deci
        while nz|wend
        lia low VVramWidth*(VVramHeight-2-6)
        lib 0
        lp RegisterY|adb

        lij VVramWidth
        do
            ixl
            lp RegisterX|exam|push|exam
            lp RegisterX+1|exam|push|exam
                tsia Ground_BombMask
                if nz
                    sr|sr|ania 3
                    deca
                    exab
                        lp RegisterX+1|lia high(BlockChars_+8-1)|exam
                        lp RegisterX|lia low(BlockChars_+8-1)|exam
                    exab
                    lib 0
                    adb
                    jr DrawBackground_write
                endif
                ania Ground_BlockMask
                if nz
                    deca
                    exab
                        lp RegisterX+1|lia high(BlockChars_-1)|exam
                        lp RegisterX|lia low(BlockChars_-1)|exam
                    exab
                    lib 0
                    adb
                    DrawBackground_write:
                    ixl|iys
                    lia low(VVramWidth-1)
                    lib high(VVramWidth-1)
                    lp RegisterY|adb
                    ix
                    ixl|iys
                    lia low(-VVramWidth)
                    lib high(-VVramWidth)
                    lp RegisterY|adb
                else
                    lp RegisterY
                    lia 0
                    iys
                    lia low(VVramWidth-1)
                    lib high(VVramWidth-1)
                    lp RegisterY|adb
                    lia 0
                    iys
                    lia low(-VVramWidth)
                    lib high(-VVramWidth)
                    lp RegisterY|adb
                endif
            lp RegisterX+1|pop|exam
            lp RegisterX|pop|exam

            decj
        while nz|wend        
    lp RegisterX+1|pop|exam
    lp RegisterX|pop|exam
    lp RegisterY+1|pop|exam
    lp RegisterY|pop|exam
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    pop|exab
    pop
rtn
