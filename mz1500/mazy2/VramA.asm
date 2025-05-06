include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern

cseg
Fill:
    ld bc,VramWidth*VramHeight
    do
        ld (hl),e
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
defb 16,7 ; Point
defb 0
InitVram: public InitVram
    ld hl,TextVram
    ld e,0
    call Fill

    ld hl,Attributes
    ld e,70h
    call Fill

    ld hl, HighVram
    ld e,08h
    call Fill

    ld a,3
    out (0f0h),a

    xor a
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld b,(hl)
        inc b | dec b
    while nz
        inc hl
        ld c,(hl)
        inc hl
        push af | push hl | push bc
            call MakePatternMono
        pop bc | pop hl | pop af
        add a,b
    wend

    ld hl,PatternRam+CharHeight*Char_Color
    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakePatternColor
ret

MakePatternMono:
    push de
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        ld de,PatternRam
        add hl,de
    pop de
    do
        push bc
            ld a,1
            do
                push hl
                    out (0e5h),a
                    bit 0,c
                    if nz
                        push de | push bc
                            ex de,hl
                                ld bc,CharHeight
                                ldir
                            ex de,hl
                        pop bc | pop de
                    else
                        push bc
                            ld b,CharHeight
                            do
                                ld (hl),0
                                inc hl
                            dwnz
                        pop bc
                    endif
                pop hl
                srl c
                inc a
                cp 4
            while nz | wend
            ld bc, CharHeight
            add hl,bc
            ex de,hl
                add hl,bc
            ex de,hl
        pop bc
    dwnz
    out (0e6h),a
ret

MakePatternColor:
    do
        push bc
            ld a,1
            do
                push hl
                    out (0e5h),a
                    ex de,hl
                        ld bc,8
                        ldir
                    ex de,hl
                pop hl
                inc a
                cp 4
            while nz | wend
            ld bc, CharHeight
            add hl,bc
        pop bc
        dec c
    while nz | wend
    out (0e6h),a
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
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramWidth*VramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    inc hl
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Vram+VramWidth*1
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            push bc
                ld bc,VramWidth-VVramWidth
                add hl,bc
            pop bc
            dec c
        while nz | wend
    pop bc | pop de | pop hl
ret
