include "mz2000.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
PatternPtr:
    push de
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        ld de,PatternRam
        add hl,de
    pop de
ret


cseg
InitVram: public InitVram
    ld hl,CharPattern
    exx
        ld hl,PatternRam
    exx
    ld c,Char_End
    do
        ld b,CharHeight
        do
            ld a,(hl) | inc hl
            exx
                ld de,0
                ld b,8
                do
                    srl d | rr e
                    srl d | rr e
                    rrca
                    if c
                        set 7,d | set 6,d
                    endif
                dwnz
                ld (hl),e | inc hl
                ld (hl),d | inc hl
            exx
        dwnz
        dec c
    while nz | wend
ret


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
        ld de,Vram+1
        ld bc,640/8*200-1
        ld (hl),0
        ldir

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret


cseg
Put:
    ex de,hl
        call PatternPtr
    ex de,hl
    ld b,CharHeight
    do
        ld a,(de) | inc de
        ld (hl),a | inc hl
        ld a,(de) | inc de
        ld (hl),a
        ld a,l | add a,VramWidth-1 | ld l,a
        ld a,h | adc a,0 | ld h,a
    dwnz
    ld a,l | sub low(VramRowSize-VramStep) | ld l,a
    ld a,h | sbc a,high(VramRowSize-VramStep) | ld h,a
ret

; word Put(word vram, byte c);
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push de | push bc
        push hl
            ld a,e
            ld bc,31*256
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
        pop hl
        ld a,c
        call Put
    pop bc | pop de | pop af
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*1
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
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
