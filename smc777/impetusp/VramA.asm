include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern, SpritePattern

CharVram equ 0000h
AttrVram equ 0800h

dseg
MonoPatternRam: public MonoPatternRam
    defs PatternSize*Char_Color
MixedPatternRam: public MixedPatternRam
    defs PatternSize*4*32
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
Backup:
    defs VVramWidth*VVramHeight
NextSpriteChar:
    defb 0


cseg
ColorTable:
defb 31, 7 ; Ascii
defb 15, 3 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
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
ret

MakePatternMono:
    push de
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld de,MonoPatternRam
        add hl,de
    pop de
    push hl | exx | pop hl | exx
    ld a,c
    exx
        ld e,a
        and 0fh
        ld d,a
        ld a,e
        srl a | srl a | srl a | srl a
        ld e,a
    exx
    do
        ld c,CharHeight
        do
            ld a,(de)
            ld l,a
            inc de
            ld h,8
            xor a
            do
                sla l
                if c
                    exx
                        or d
                    exx
                else
                    exx
                        or e
                    exx
                endif
                bit 0,h
                if nz
                    exx
                        ld (hl),a
                        inc hl
                        xor a
                    exx
                else
                    rlca | rlca | rlca | rlca
                endif
                dec h
            while nz | wend
            dec c
        while nz | wend
    dwnz
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearVram:
    do
        ld b,l | ld c,h
        xor a | out (c),a
        inc hl
        dec de
        ld a,e | or d
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld de,8000h
        call ClearVram

        ld hl,CharVram
        ld de,0800h
        call ClearVram

        ld hl,AttrVram
        ld de,0800h
        do
            ld b,l | ld c,h
            ld a,1 | out (c),a
            inc hl
            dec de
            ld a,e | or d
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ; ld hl,VVramBack_
        ; ld bc,VVramWidth*VVramHeight*2
        ; call Clear
    pop bc | pop de | pop hl | pop af
ret


cseg
PatternPtr:
    push de
        cp Char_Color
        if c
            ld de,MonoPatternRam
            jr PatternPtr_add
        endif
        cp Char_End
        if c
            sub Char_Color
            ld de,ColorPattern
            jr PatternPtr_add
        endif
        sub Char_End
        ld de,MixedPatternRam
        PatternPtr_add:
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        add hl,de
    pop de
ret

Put:
    ex de,hl
        call PatternPtr
    ex de,hl
    ld c,CharHeight
    do
        ld b,VramStep
        do
            push bc
                ld b,l | ld c,h
                ld a,(de) | inc de
                out (c),a
            pop bc
            inc hl
        dwnz
        ld a,l | add a,low(1000h-VramStep) | ld l,a
        ld a,h | adc a,high(1000h-VramStep) | ld h,a
        dec c
    while nz | wend
    ld a,l | sub low(8000h-VramStep) | ld l,a
    ld a,h | sbc a,high(8000h-VramStep) | ld h,a
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


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld de,SpriteLayer
        ld bc,VVramWidth*VVramHeight
        ldir

        ld a,Char_End
        ld (NextSpriteChar),a
    pop bc | pop de | pop hl | pop af
ret


; void EndDraw();
cseg
EndDraw_: public EndDraw_
    push af | push hl | push de | push bc
        ld de,SpriteLayer
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*0
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                cp Char_End
                jr nc,EndDraw_write
                cp (hl)
                if nz
                    EndDraw_write:
                    ld (hl),a
                    exx
                        push de
                            call Put
                        pop de
                    exx
                else
                    exx
                        inc hl | inc hl | inc hl | inc hl
                    exx
                endif
                inc hl
            dwnz
            exx
                ld a,l | add a,low(VramRowSize-VramStep*VVramWidth) | ld l,a
                ld a,h | adc a,high(VramRowSize-VramStep*VVramWidth) | ld h,a
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
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

        ld c,2
        do
            ld b,2
            do
                push bc
                    ld a,(de)
                    exx
                        call PatternPtr ; background
                        ex de,hl
                        ld a,(NextSpriteChar)
                        inc a
                        ld (NextSpriteChar),a
                    exx
                    ld (de),a
                    inc de
                    exx
                        call PatternPtr ; foreground
                    exx
                    ld b,CharHeight*VramStep
                    do
                        ld a,(hl) | inc hl
                        exx
                            ld c,a
                            and 0f0h
                            if z
                                ld a,(de)
                                and 0f0h
                            endif
                            ld b,a
                            ld a,c
                            and 0fh
                            if z
                                ld a,(de)
                                and 0fh
                            endif
                            or b
                            ld (hl),a | inc hl
                            inc de
                        exx
                    dwnz
                pop bc
            dwnz
            ld a,e | add a,VVramWidth-2 | ld e,a
            ld a,d | adc a,0 | ld d,a
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
