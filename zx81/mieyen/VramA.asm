include "Vram.inc"

ext PollVSync_

VramTop equ Vram_ + VramRowSize*2

dseg
pCurrentPage_: public pCurrentPage_
    defw 0
CurrentPage:
    defb 0

    defb 0
Vram_: public Vram_
Vram0: public Vram0
    defs VramRowSize*VramHeight
Vram1: public Vram1
    defs VramRowSize*VramHeight
    defb 0

cseg
InitVram: public InitVram
    lxi h,Vram1-1 | shld $400c
    xra a | sta CurrentPage
    lxi h,Vram0 | shld pCurrentPage_
ret

; void SwitchPage();
cseg
SwitchPage_: public SwitchPage_
    push psw | push h
        lda CurrentPage
        ora a
        if z
            lxi h,Vram0-1 | shld $400c
            inr a | sta CurrentPage
            lxi h,Vram1 | shld pCurrentPage_
        else
            lxi h,Vram1-1 | shld $400c
            xra a | sta CurrentPage
            lxi h,Vram0 | shld pCurrentPage_
        endif
    pop h | pop psw
ret

; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push psw | push h | push b
        lxi h,Vram_-1
        mvi c,VramHeight*2
        xra a
        do
            mvi m,$76 | inx h
            mvi b,VramWidth
            do
                mov m,a | inx h
                dcr b
            while nz | wend
            dcr c
        while nz | wend
        mvi m,$76
    pop b | pop h | pop psw
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push h | push d
        mov m,a
        lxi d,VramRowSize*VramHeight
        dad d
        mov m,a
    pop d | pop h
    inx h
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    push psw
        mov a,e
        cpi ' '
        if z
            xra a
        else
            cpi '-'
            if z
                mvi a,$16
            else
                cpi 'A'
                if nc
                    adi $26-'A'
                else
                    adi $1c-'0'
                endif
            endif
        endif
        call Put_
    pop psw
ret


; ptr<byte> VramPtr(byte x, byte y);
cseg
VramPtr_: public VramPtr_
    push psw | push d
        mvi d,0

        mov l,e
        mov h,d
        dad h ;*2
        dad h ;*4
        dad h ;*8
        dad h ;*16
        dad h ;*32
        dad d ;*33
        
        mov e,a
        mvi d,0
        dad d
        xchg
            lhld pCurrentPage_
        xchg
        dad d
    pop d | pop psw
ret
