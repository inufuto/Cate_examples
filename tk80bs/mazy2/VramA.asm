include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_

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
; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
Put_: public Put_
    mov m,e
    inx h
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push psw | push h | push d | push b
        lxi h,VramTop
        lxi d,VVramFront_+VVramWidth+1
        mvi c,WindowHeight
        do
            mvi b,WindowWidth
            do
                ldax d | inx d
                mov m,a | inx h
                dcr b
            while nz | wend
            inx d | inx d
            push d
                lxi d,VramRowSize-WindowWidth
                dad d
            pop d
            dcr c
        while nz | wend
    pop b | pop d | pop h | pop psw
ret
