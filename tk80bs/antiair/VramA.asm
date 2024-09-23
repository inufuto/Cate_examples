include "Vram.inc"
include "VVram.inc"

ext VVram_

Char_Space equ $20
VramTop equ Vram+VramRowSize*2+(VramWidth-VVramWidth)/2

; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push psw | push h | push b
        lxi h,Vram
        lxi b,VramWidth*VramHeight
        do
            mvi m,Char_Space | inx h
            dcx b
            mov a,c
            ora b
        while nz | wend
    pop b | pop h | pop psw
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    mov m,e
    inx h
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push psw | push h | push d | push b
        lxi h,VramTop
        lxi d,VVram_
        mvi c,VVramHeight
        do
            mvi b,VVramWidth
            do
                ldax d | inx d
                mov m,a | inx h
                dcr b
            while nz | wend
            push d
                lxi d,VramRowSize-VVramWidth
                dad d
            pop d
            dcr c
        while nz | wend
    pop b | pop d | pop h | pop psw
ret
