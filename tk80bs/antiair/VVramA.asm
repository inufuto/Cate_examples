include "VVram.inc"
include "Vram.inc"

ext VVram_
ext Ground_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push psw | push b
        mov c,a

        mov a,e
        add a ;*2
        add e ;*3
        mov l,a
        mvi h,0
        dad h ;*6
        dad h ;*12
        dad h ;*24
        mvi b,0
        dad b
        lxi b,VVram_
        dad b
    pop b | pop psw
ret


Ground_BlockMask equ $03
Ground_BombMask equ $0c
ext BlockChars_

; void DrawBackground();
DrawBackground_: public DrawBackground_
    push psw | push h | push d | push b
        lxi h,VVram_
        mvi a,Char_Space
        mvi c,VVramHeight-2
        do
            mvi b,VVramWidth
            do
                mov m,a | inx h
                dcr b
            while nz | wend
            dcr c
        while nz | wend

        lxi d,Ground_
        mvi b,VVramWidth
        do
            ldax d | inx d
            push d | push b
                mov c,a
                ani Ground_BombMask
                if nz
                    rrc | rrc
                    dcr a
                    lxi b,BlockChars_+4*2
                    jmp DrawBackground_write
                endif
                mov a,c
                ani Ground_BlockMask
                if nz
                    dcr a
                    lxi b,BlockChars_+0
                    DrawBackground_write:
                    add c | mov c,a
                    mov a,b | aci 0 | mov b,a
                    ldax b
                    mov m,a
                    lxi d,VVramWidth | dad d
                    inx b | inx b
                    ldax b
                    mov m,a
                    lxi d,-VVramWidth | dad d
                else
                    mvi a,Char_Space
                    mov m,a
                    lxi d,VVramWidth | dad d
                    mov m,a
                    lxi d,-VVramWidth | dad d
                endif
                inx h
            pop b | pop d
            dcr b
        while nz | wend
    pop b | pop d | pop h | pop psw
ret
