include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CharPattern, SpritePattern
ext Status_

dseg
CharColors: public CharColors
    defs $100
SpriteColors:
    defs Pattern_End
Backup: ;public Backup
    defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
SpriteCharPattern: public SpriteCharPattern
    defs PatternSize*($100-Char_End)
NextSpriteChar:
    defb 0


cseg
CharColorTable:
defb 30,47h ; Ascii
defb 15,45h ; Logo
defb 1,47h ; Remain
defb 10,44h ; Terrain4
defb 1,45h ; Terrain5
defb 1,46h ; Terrain6
defb 1,47h ; Terrain7
defb 36,45h ; Fort
defb 0
SpriteColorTable:
defb 1,47h ; FighterBullet
defb 1,42h ; EnemyBullet
defb 3,45h ; Barrier
defb 5,42h ; Bang
defb 1,44h ; Item
defb 1,47h ; Fighter
defb 1,42h ; SkyEnemyA
defb 8,43h ; SkyEnemyB
defb 1,46h ; SkyEnemyC
defb 2,47h ; GroundEnemy
defb 0
InitVram: public InitVram
    ld hl,CharColorTable
    ld de,CharColors
    call ExtractColors

    ld hl,SpriteColorTable
    ld de,SpriteColors
    call ExtractColors
ret
ExtractColors:
    do
        ld a,(hl)
        or a
    while nz
        ld b,a
        inc hl
        ld a,(hl) | inc hl
        or 40h
        do
            ld (de),a | inc de
        dwnz
    wend
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),c
        inc hl
        dec de
        ld a,e | or d
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push hl | push de | push bc 
        ld hl,Vram0
        ld de,ColorMap-Vram0
        ld c,0
        call Clear

        ld hl,ColorMap
        ld de,5B00h-ColorMap
        ld c,47h
        call Clear

        ld hl,Backup
        ld de,VVramWidth*VVramHeight
        ld c,0
        call Clear

        ld hl,VVram_
        ld de,VVramWidth*VVramHeight
        ld c,10
        call Clear
    pop bc | pop de | pop hl
ret


cseg
PatternPtr: ; a->hl
    push af | push de
        ld l,a
        sub Char_End
        if c
            ld de,CharPattern
        else
            ld l,a
            ld de,SpriteCharPattern
        endif
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,de
    pop de | pop af
ret

cseg
Put: ; (hl,a)
    ex de,hl
        call PatternPtr
    ex de,hl
    push hl
        sla h | sla h | sla h
        set 6,h
        ex af,af'
            ld b,CharHeight
            do
                ld a,(de)
                inc de
                ld (hl),a
                inc h
            dwnz
        ex af,af'
        ld l,a | ld h,0
        ld de,CharColors | add hl,de
        ld a,(hl)
    pop hl
    push hl
        ld bc,ColorMap
        add hl,bc
        ld (hl),a
    pop hl
    inc hl
ret    


; word Put(word vram, byte c);
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop af
ret


; byte FromAscii(byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
FromAscii:
    push hl
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
        ld a,c
    pop hl
ret
FromAscii_: public FromAscii_
    push bc
        call FromAscii
    pop bc
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    push af | push de | push bc
        call FromAscii
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
            ld hl,Vram
        exx
        ld c,VVramHeight
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
                                call Put
                            pop de
                        exx
                    else
                        exx
                            inc hl
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawSprite(byte x, byte y, byte pattern);
dseg
color:
    defb 0
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

        ld b,0
        ld hl,SpriteColors
        add hl,bc
        ld a,(hl) | ld (color),a
        ld h,c | ld l,0; pattern
        srl h | rr l
        srl h | rr l
        ld bc,SpritePattern | add hl,bc

        ld c,2
        do
            ld b,2
            do
                push bc
                    ld a,(de)
                    exx
                        ld c,a
                        call PatternPtr ; background
                        ex de,hl
                        ld a,(NextSpriteChar)
                        inc a
                        ld (NextSpriteChar),a
                        dec a
                    exx
                    ld c,a
                    ld (de),a
                    inc de
                    push de
                        exx
                            call PatternPtr ; foreground
                        exx
                        ld e,0
                        ld b,CharHeight
                        do
                            ld a,(hl) | inc hl
                            cpl
                            exx
                                ld b,a
                                ld a,(de) | inc de
                                and b
                                ld b,a
                            exx
                            ld a,(hl) |inc hl
                            or a
                            if nz
                                inc e
                            endif
                            exx
                                or b
                                ld (hl),a | inc hl
                            exx
                        dwnz
                        ld a,e
                        or a
                        if z
                            exx
                                ld b,0
                                ld hl,CharColors
                                add hl,bc
                                ld a,(hl)
                            exx
                        else
                            ld a,(color)
                        endif
                        push hl
                            ld b,0
                            ld hl,CharColors
                            add hl,bc
                            ld (hl),a
                        pop hl
                    pop de
                pop bc
            dwnz
            ld a,e | add a,VVramWidth-2 | ld e,a
            ld a,d | adc a,0 | ld d,a
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void StatusToSpriteLayer();
cseg
StatusToSpriteLayer_: public StatusToSpriteLayer_
    push af | push hl | push de | push bc
        ld hl,Status_
        ld de,SpriteLayer
        ld b,VramWidth*2
        do
            ld a,(hl) | inc hl
            or a
            if nz
                ld (de),a
            endif
            inc de
        dwnz
    pop bc | pop de | pop hl | pop af
ret
