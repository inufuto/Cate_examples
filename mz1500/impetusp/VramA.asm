include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern, SpritePattern

SpriteCharCount equ (100h-Char_End)/2
SpriteChar0 equ Char_End
SpriteChar1 equ SpriteChar0+SpriteCharCount


dseg
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
SpriteCharOffset:
    defb 0
NextSpriteChar:
    defb 0

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
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
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
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramWidth*VramHeight
        call Clear

        ld hl,VVram_
        ld bc,VVramWidth*VVramHeight
        call Clear

        xor a | ld (SpriteCharOffset),a
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    inc hl
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push bc
        push hl
            ld a,e
            ld bc,30*256
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
        ld (hl),c
        inc hl
    pop bc | pop af
ret


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld de,SpriteLayer
        ld bc,VVramWidth*VVramHeight
        ldir

        ld a,(SpriteCharOffset)
        add a,SpriteChar0
        ld (NextSpriteChar),a
    pop bc | pop de | pop hl | pop af
ret


; void EndDraw();
cseg
EndDraw_: public EndDraw_
    push hl | push de | push bc
        ld de,SpriteLayer
        ld hl,Vram+VramWidth*0
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            push bc
                ld bc,VramRowSize-VVramWidth
                add hl,bc
            pop bc
            dec c
        while nz | wend

        ld a,(SpriteCharOffset)
        xor SpriteCharCount
        ld (SpriteCharOffset),a
    pop bc | pop de | pop hl
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
PcgPtr:
    ld l,a | ld h,0
    add hl,hl ;*2
    add hl,hl ;*4
    add hl,hl ;*8
    ld a,h | add a,high PatternRam | ld h,a
ret
DrawSprite_: public DrawSprite_
    push af | push hl | push de | push bc
        ld l,e | ld h,0 ;y
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,a | ld d,0 ;x
        add hl,de
        ld de,SpriteLayer | add hl,de
        ex de,hl

        ld h,c | ld l,0; pattern
        srl h | rr l
        ld bc,SpritePattern | add hl,bc
        exx
            ld a,(NextSpriteChar) | ld c,a
        exx
        ld c,2
        do
            ld b,2
            do
                push bc
                    ld a,(de)
                    exx
                        call PcgPtr ; background
                        ex de,hl ; foreground
                        ld a,c | inc c
                    exx
                    ld (de),a
                    exx
                        call PcgPtr
                    exx
                    inc de
                    ld b,CharHeight
                    do
                        ld a,(hl) | inc hl
                        cpl
                        exx
                            ld b,a
                        exx
                        di
                            ld c,01h
                            do
                                ld a,c | out (0e5h),a
                                exx
                                    ld a,(de)
                                    and b
                                exx
                                or (hl) |inc hl
                                exx
                                    ld (hl),a
                                exx
                                inc c
                                ld a,c
                                cp 04h
                            while nz | wend
                            out (0e6h),a
                        ei
                        exx
                            inc de
                            inc hl
                        exx
                    dwnz
                pop bc
            dwnz
            ld a,e | add a,VVramWidth-2 | ld e,a
            ld a,d | adc a,0 | ld d,a
            dec c
        while nz | wend
        exx
            ld a,c
            ld (NextSpriteChar),a
        exx
    pop bc | pop de | pop hl | pop af
ret
