include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext AsciiPattern, ColorPattern

VramTop equ Vram+VramRowSize

ReadPlain equ 0f1h
WritePlain equ 0f2h

dseg
Backup:
    defs VVramWidth*VVramHeight


cseg
InitColors: public InitColors
    push af
        ld a,44h
        out (0f5h),a
        out (0f8h),a
        ld a,11h
        out (0f6h),a
        out (0f9h),a
        ld a,22h
        out (0f7h),a
        out (0fah),a
    pop af
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld a,07h
        out (WritePlain),a

        ld hl,Vram
        ld de,Vram+1
        ld bc,VramRowSize*VramHeight-1
        ld (hl),0
        ldir

        ld hl,Backup
        ld de,Backup+1
        ld bc,VVramWidth*VVramHeight-1
        ld (hl),0
        ldir

        ld hl,VVram_
        ld de,VVram_+1
        ld bc,VVramWidth*VVramHeight-1
        ld (hl),0
        ldir
    pop bc | pop de | pop hl | pop af
ret


PatternAddress:
    push de
        ld l,a
        ld h,0
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld de,ColorPattern
        add hl,de
    pop de
ret


; void Put(word vram, byte c);
Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            call PatternAddress
        ex de,hl
        ld bc,0301h
        do
            ld a,c | out (WritePlain),a
            push bc
                ld b,CharHeight
                do
                    ld a,(de) | inc de
                    ld (hl),a
                    push bc
                        ld bc,VramWidth
                        add hl,bc
                    pop bc
                dwnz
                ld bc, -VramWidth*CharHeight
                add hl,bc
            pop bc
            sla c
        dwnz
    pop bc | pop de | pop hl | pop af
ret


cseg
PutShift0:
    ex de,hl
        call PatternAddress
    ex de,hl
    ld bc,0101h
    do
        ld a,c | out (WritePlain),a
        ld a,b | out (ReadPlain),a
        push bc
            ld b,CharHeight
            do
                ld a,(de) | inc de
                ld c,a
                ld a,(hl)
                and 0c0h
                or c
                ld (hl),a
                ld a,l | add a,VramWidth | ld l,a
                ld a,h | adc a,0 | ld h,a
            dwnz
            ld bc,-VramWidth*CharHeight
            add hl,bc
        pop bc
        sla c
        inc b
        bit 2,b
    while z | wend
ret

PutShift2:
    ex de,hl
        call PatternAddress
    ex de,hl
    ld bc,0101h
    do
        ld a,c | out (WritePlain),a
        ld a,b | out (ReadPlain),a
        push bc
            ld b,CharHeight
            do
                ld a,(de) | inc de
                rlca | rlca
                ld c,a
                ld a,(hl)
                and 03h
                or c
                ld (hl),a
                ld a,l | add a,VramWidth | ld l,a
                ld a,h | adc a,0 | ld h,a
            dwnz
            ld bc,-VramWidth*CharHeight
            add hl,bc
        pop bc
        sla c
        inc b
        bit 2,b
    while z | wend
ret

PutShift4:
    ex de,hl
        call PatternAddress
    ex de,hl
    ld bc,0101h
    do
        ld a,c | out (WritePlain),a
        ld a,b | out (ReadPlain),a
        push bc
            ld b,CharHeight
            do
                ld a,(de) | inc de
                push de
                    ld d,0 | or a
                    rla | rl d
                    rla | rl d
                    rla | rl d
                    rla | rl d
                    ld e,a
                    ld a,(hl)
                    and 0fh
                    or e
                    ld (hl),a
                    inc hl
                    ld a,(hl)
                    and 0fch
                    or d
                    ld (hl),a
                    ld de,VramWidth-1
                    add hl,de
                pop de
            dwnz
            ld bc,-VramWidth*CharHeight
            add hl,bc
        pop bc
        sla c
        inc b
        bit 2,b
    while z | wend
ret

PutShift6:
    ex de,hl
        call PatternAddress
    ex de,hl
    ld bc,0101h
    do
        ld a,c | out (WritePlain),a
        ld a,b | out (ReadPlain),a
        push bc
            ld b,CharHeight
            do
                ld a,(de) | inc de
                push de
                    ld d,0 | or a
                    rla | rl d
                    rla | rl d
                    rla | rl d
                    rla | rl d
                    rla | rl d
                    rla | rl d
                    ld e,a
                    ld a,(hl)
                    and 3fh
                    or e
                    ld (hl),a
                    inc hl
                    ld a,(hl)
                    and 0f0h
                    or d
                    ld (hl),a
                    ld de,VramWidth-1
                    add hl,de
                pop de
            dwnz
            ld bc,-VramWidth*CharHeight
            add hl,bc
        pop bc
        sla c
        inc b
        bit 2,b
    while z | wend
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
        
        ld c, VVramHeight
        do
            ld b,VVramWidth/4
            do
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call PutShift0
                    exx
                endif
                inc hl
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call PutShift6
                    exx
                endif
                inc hl
                exx | inc hl | exx
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call PutShift4
                    exx
                endif
                inc hl
                exx | inc hl | exx
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call PutShift2
                    exx
                endif
                inc hl
                exx | inc hl | exx
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VramWidth
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void PutShift(word vram, byte xMod, byte c);
cseg
PutShift_: public PutShift_
    push af | push hl | push de | push bc
        ld a,c
        dec e | dec e
        if z
            call PutShift2
            jr PutShift_end
        endif
        dec e | dec e
        if z
            call PutShift4
            jr PutShift_end
        endif
        dec e | dec e
        if z
            call PutShift6
            jr PutShift_end
        endif
        call PutShift0
        PutShift_end:
    pop bc | pop de | pop hl | pop af
ret


dseg
CurrentVram:
    defw 0
CharShift:
    defb 0
; void Locate(word vram, bool shift);
cseg
Locate_: public Locate_
    push af
        ld (CurrentVram),hl
        ld a,e
        ld (CharShift),a
    pop af
ret


; void PrintC(byte c);
cseg
PrintC_: public PrintC_
    push af | push hl | push de | push bc
        sub ' '
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        ld de,AsciiPattern
        add hl,de
        ex de,hl

        ld a,07h | out (WritePlain),a
        ld a,1 | out (ReadPlain),a

        ld hl,(CurrentVram)
        ld a,(CharShift)
        or a
        if z
            ld b,4
            do
                push bc
                    ld a,(de) | inc de
                    ld c,a
                    push de
                        ld de,VramWidth

                        and 0fh
                        ld b,a
                        ld a,(hl)
                        and 0f0h
                        or b
                        ld (hl),a
                        add hl,de

                        ld a,c
                        rrca | rrca | rrca | rrca
                        and 0fh
                        ld b,a
                        ld a,(hl)
                        and 0f0h
                        or b
                        ld (hl),a
                        add hl,de
                    pop de
                pop bc
            dwnz
        else
            ld b,4
            do
                push bc
                    ld a,(de) | inc de
                    ld c,a
                    push de
                        ld de,VramWidth

                        rlca | rlca | rlca | rlca
                        and 0f0h
                        ld b,a
                        ld a,(hl)
                        and 0fh
                        or b
                        ld (hl),a
                        add hl,de

                        ld a,c
                        and 0f0h
                        ld b,a
                        ld a,(hl)
                        and 0fh
                        or b
                        ld (hl),a
                        add hl,de
                    pop de
                pop bc
            dwnz
        endif
        ld a,(CharShift)
        xor 1
        ld (CharShift),a
        if z
            ld hl,(CurrentVram)
            inc hl
            ld (CurrentVram),hl
        endif
    pop bc | pop de | pop hl | pop af
ret
