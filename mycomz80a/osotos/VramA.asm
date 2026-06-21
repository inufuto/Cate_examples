include "Port.inc"
include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVram_
ext PollVsync_

dseg
Backup:
    defs VVramWidth * VVramHeight

; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld bc,VramWidth*VramHeight
        do
            ld a,l | out (VramAddressLow),a
            ld a,h | out (VramAddressHigh),a
            xor a | out (VramData),a
            inc hl
            dec bc
            ld a,c | or b
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ex de,hl
            ld h,0
            add hl,hl
            ld bc,CharPattern | add hl,bc
        ex de,hl
        ld b,2
        do
            ld a,l | out (VramAddressLow),a
            ld a,h | out (VramAddressHigh),a
            ld a,(de) | inc de
            out (VramData),a
            inc hl
        dwnz
    pop bc | pop de | pop af
ret


; word PrintC(word vram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIKLMNOPRSTUVWY"
PrintC_: public PrintC_
    push af | push de | push bc
        ld a,e
        ex de,hl
            ld bc,33 shl 8
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
            ld l,c | ld h,0
            add hl,hl ; *2
            add hl,hl ; *4
            ld bc,AsciiPattern | add hl,bc
        ex de,hl
        ld c,2
        do
            ld b,2
            do
                ld a,l | out (VramAddressLow),a
                ld a,h | out (VramAddressHigh),a
                ld a,(de) | inc de
                out (VramData),a
                inc hl
            dwnz
            ld a,l | add a,VramRowSize-2 | ld l,a
            ld a,h | adc a,0 | ld h,a
            dec c
        while nz | wend
        ld de,2-VramRowSize*2 | add hl,de
    pop bc | pop de | pop af
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*0
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                push bc 
                    ld a,(de)
                    inc de
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            push de
                                ld e,a
                                call Put_
                            pop de
                        exx
                    else
                        exx
                            inc hl
                            inc hl
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth*2
                    add hl,bc
                pop bc
            exx
            call PollVsync_
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
