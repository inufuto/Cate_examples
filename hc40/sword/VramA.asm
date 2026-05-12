include "hc40.inc"
include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

dseg
Backup:
    defs VVramWidth*VVramHeight


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld a,high Vram
        ld (0f295h),a
        out (VADR),a

        xor a
        ld (0f2a0h),a
        ld hl,0efb6h
        or (hl)
        out (YOFF),a

        ld hl,Vram
        ld bc,VramWidth*CharHeight*VramHeight
        call Clear

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop hl | pop af
ret


cseg
WriteLBytes:
    push hl
        do
            ld a,(de) | inc de
            push de
                ld b,2
                do
                    ld d,a
                        and 0f0h
                        ld e,a
                        ld a,(hl)
                        and 0fh
                        or e
                        ld (hl),a
                    ld a,d
                    rlca | rlca | rlca | rlca
                    ld de,VramWidth
                    add hl,de
                dwnz
            pop de
            dec c
        while nz | wend
    pop hl
ret
WriteRBytes:
    push hl
        do
            ld a,(de) | inc de
            push de
                ld b,2
                do
                    rrca | rrca | rrca | rrca
                    ld d,a
                        and 0fh
                        ld e,a
                        ld a,(hl)
                        and 0f0h
                        or e
                        ld (hl),a
                    ld a,d
                    ld de,VramWidth
                    add hl,de
                dwnz
            pop de
            dec c
        while nz | wend
    pop hl
    inc hl
ret

CharPatternADe:
    ex de,hl
        ld h,0
        add hl,hl ;*2
        push bc
            ld bc,CharPattern
            add hl,bc
        pop bc
    ex de,hl
ret
PutL:
    call CharPatternADe
    ld c,CharHeight/2
    call WriteLBytes
ret
PutR:
    call CharPatternADe
    ld c,CharHeight/2
    call WriteRBytes
ret


; ptr<byte> Put(ptr<byte> pVram, byte c, bool right);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,c
        or a
        if z
            call PutL
        else
            call PutR
        endif
    pop bc | pop de | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c, bool right);
cseg
CharTable:
    defb " 0123456789ABCEFGHIKLMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push de | push bc
        push hl
            ld a,e
            ld de,31*256
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc e
                dec d
            while nz | wend
            ld e,0
            PrintC_break:
        pop hl
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            push bc
                ld bc,AsciiPattern
                add hl,bc
            pop bc
        ex de,hl

        ld a,c
        or a
        if z
            ld c,AsciiHeight/2
            call WriteLBytes
        else
            ld c,AsciiHeight/2
            call WriteRBytes
        endif
    pop bc | pop de | pop af
ret


; void VVramToVram();
cseg
VVramToVram_L:
    ld a,(de) | inc de
    cp (hl)
    if nz
        ld (hl),a
        exx
            ld e,a
            call PutL
        exx
    endif
    inc hl
ret
VVramToVram_R:
    ld a,(de) | inc de
    cp (hl)
    if nz
        ld (hl),a
        exx
            ld e,a
            call PutR
        exx
    else
        exx
            inc hl
        exx
    endif
    inc hl
ret
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram+VramWidth*8
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth/2
            do
                call VVramToVram_L
                call VVramToVram_R
            dwnz
            exx
                ld de,VramRowSize-VVramWidth/2
                add hl,de
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
