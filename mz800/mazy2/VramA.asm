include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext VVramBack_,VVramFront_

dseg
Backup:
    defs VVramWidth*VVramHeight
PatternRam: public PatternRam
    defs CharPatternSize*Char_End


cseg
ColorTable:
defb 64,3 ; Ascii
defb 16,2 ; Logo
defb 4,3 ; Knife
defb 72,3 ; Man
defb 16,3 ; Point
defb 8,3 ; Stair
defb 4,3 ; Goal
defb 0
PaletteValues:
	defb	00h, 0ah, 0ch, 0fh
InitVram: public InitVram
    ld hl,PaletteValues
    ld c,0
    do
        ld a,(hl) | inc hl
        or c
        out (0f0h),a
        ld a,c
        add a,10h
        ld c,a
        cp 40h
    while nz | wend

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
        call MakePatternMono
        add a,b
    wend

    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakePatternColor
ret

PatternAddress:
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

MakePatternMono:
    push af | push hl | push bc
        call PatternAddress
        do
            push bc
                ld b,PlaneCount
                do
                    push bc | push de
                        ld b,CharHeight
                        do
                            push bc
                                ld b,0
                                ld a,(de) | inc de
                                bit 0,c
                                if nz
                                    or b
                                    ld b,a
                                endif
                                bit 4,c
                                if nz
                                    cpl
                                    or b
                                    ld b,a
                                endif
                                ld (hl),b | inc hl
                            pop bc
                        dwnz
                    pop de | pop bc
                    srl c
                dwnz
            pop bc
            ld a,e | add a,CharHeight | ld e,a
            ld a,d | adc a,0 | ld d,a
        dwnz
    pop bc | pop hl | pop af
ret

MakePatternColor:
    call PatternAddress
    do
        ld b,CharPatternSize
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
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
    push af | push hl | push bc
        di
            out (0e4h),a
            ld a,83h | out (0cch),a
            
            ld hl,Vram
            do
                ld (hl),0
                inc hl
                ld a,h
                cp high Vram+20h
            while nz | wend
            out (0e0h),a
        ei

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop hl | pop af
ret


Put:
    ex de,hl
        call PatternAddress
    ex de,hl
    di
        out (0e4h),a
        ld c,01h
        do
            ld a,c
            out (0cch),a
            ld b,CharHeight
            do
                ld a,(de) | inc de
                ld (hl),a
                ld a,l | add a,VramWidth | ld l,a
                ld a,h | adc a,0 | ld h,a
            dwnz
            ld a,l | sub low VramRowSize | ld l,a
            ld a,h | sbc a,high VramRowSize | ld h,a
            sla c
            bit 2,c
        while z | wend
        out (0e0h),a
    ei
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop af
    inc hl
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*1
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de)
                inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call Put
                    exx
                endif
                exx
                    inc hl
                exx
                inc hl
            dwnz
            exx
                ld bc,VramRowSize-VVramWidth
                add hl,bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
