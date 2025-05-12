include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext XOffset_

; void ClearScreen();
cseg
ClearScreen_:
    public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramWidth*VramHeight
        do
            ld (hl),Char_Space | inc hl
            dec bc
            ld a,c | or b
        while nz | wend

        ld hl,VVram_
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),0 | inc hl
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop hl | pop af
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld a,(XOffset_)
        ld e,a
        ld d,0
        add hl,de
        ld de,Vram+VramRowSize*2+(VramWidth-WindowWidth)/2
        ld c,VVramHeight
        do
            ld b,WindowWidth
            do
                ld a,(hl) | inc hl
                ld (de),a | inc de
            dwnz
            inc hl | inc hl | inc hl | inc hl
            inc de | inc de | inc de | inc de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    push af | push bc
        cp ' '
        if nz
            push hl
                ld bc,29*256+2
                ld hl,CharTable
                ld a,e
                do
                    cp (hl)
                    jr z,PrintC_break
                    inc hl
                    inc c
                dwnz
                PrintC_break:
                ld a,c
            pop hl
        else
            ld a,Char_Space
        endif
        ld (hl),a
        inc hl
    pop bc | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    inc hl
ret
