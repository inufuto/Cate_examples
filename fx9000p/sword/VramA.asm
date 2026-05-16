include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext VVram_

dseg
PatternRam: public PatternRam
    defs PatternSize*(100h-Char_End)
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
Backup: ;public Backup
    defs VVramWidth*VVramHeight
NextSpriteChar:
    defb 0


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
    push af | push hl
        ld hl,7000h
        do
            ld (hl),0 | inc hl
            ld a,h
            cp 80h
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ; ld hl,VVramBack_
        ; ld bc,VVramWidth*VVramHeight*2
        ; call Clear
    pop hl | pop af
ret


cseg
PatternPtr:
    push de
        ld l,a
        sub Char_End
        if c
            ld de,CharPattern
        else
            ld l,a
            ld de,PatternRam
        endif
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,de
    pop de
ret

Put:
    push bc
        ld a,e
        ex de,hl
            call PatternPtr
        ex de,hl
        ld b,CharHeight
        do
            ld a,(de) | inc de
            ld (hl),a | dec hl
        dwnz
    pop bc
ret

; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af | push de
        call Put
    pop de | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789:ACEFGHIMNORSTUVXZ"
PrintC_: public PrintC_
    push af | push de
        push hl
            ld a,e
            ld de,30*256
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
        call Put
    pop de | pop af
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
            ld hl,Vram+VramRowSize*1
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
                        ld e,a
                        call Put
                    exx
                else
                    exx
                        ld de,VramStep
                        add hl,de
                    exx
                endif
                inc hl
            dwnz
            exx
                ld de,VramRowSize-VVramWidth*VramStep
                add hl,de
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
        ld e,l | ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld e,a | ld d,0 ;x
        add hl,de
        ld de,SpriteLayer | add hl,de
        ex de,hl

                    _deb: public _deb
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
                        call PatternPtr ; background
                        ex de,hl
                        ld a,(NextSpriteChar)
                        inc a
                        ld (NextSpriteChar),a
                        dec a
                    exx
                    ld (de),a
                    inc de
                    exx
                        call PatternPtr ; foreground
                    exx
                    ld b,CharHeight
                    do
                        ld a,(hl) | inc hl
                        cpl
                        exx
                            ld b,a
                            ld a,(de) | inc de
                            and b
                        exx
                        or (hl) |inc hl
                        exx
                            ld (hl),a | inc hl
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
