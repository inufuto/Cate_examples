include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern, SpritePattern

dseg
Backup: ;public Backup
    defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
MonoColorPattern: public MonoColorPattern
    defs PatternSize*Char_Color
SpriteCharPattern: public SpriteCharPattern
    defs PatternSize*($100-Char_End)
NextSpriteChar:
    defb 0


cseg
PalleteValues:
defb	54h, 55h, 4ch, 4dh, 52h, 53h, 4ah, 4bh
defb	54h, 5eh, 5ch, 56h, 46h, 57h, 4eh, 40h
ColorTable:
defb 30,7 ; Ascii
defb 15,5 ; Logo
defb 1,7 ; Remain
defb 0
defb Char_End-Char_Color; color chars
DotTable:
    defb 00h, 40h, 04h, 44h, 10h, 50h, 14h, 54h
    defb 01h, 41h, 05h, 45h, 11h, 51h, 15h, 55h
ToDot: ; (a):d
    push af | push hl | push bc
        and 0fh
        ld l,a | ld h,0
        ld bc,DotTable | add hl,bc
        ld d,(hl)
    pop bc | pop hl | pop af
ret
InitVram: public InitVram
    ld hl,PalleteValues
    ld bc,7f00h
    ld e,16
    do
        out (c),c
        ld a,(hl) | inc hl
        out (c),a
        inc c
        dec e
    while nz | wend
    out (c),c
    ld a,54h | out (c),a

    exx
        ld hl,MonoColorPattern
    exx
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld a,(hl) | inc hl ; count
        or a
    while nz
        ld c,a ; count
        ld a,(hl) | inc hl ; color
        exx
            call ToDot
            ld e,d
            rrca | rrca | rrca | rrca
            call ToDot
        exx
        push hl
            do
                ld b,4 ; source byte count
                do
                    ld a,(de) | inc de ; source
                    exx
                        ld c,a
                    exx
                    ld l,4 ; destination byte count
                    do
                        exx
                            xor a
                            ld b,2 ; destination pixel count
                            do
                                rlca
                                sla c
                                if c
                                    or e
                                else
                                    or d
                                endif
                            dwnz
                            ld (hl),a | inc hl
                        exx
                        dec l
                    while nz | wend
                dwnz
                                    _deb: public _deb
                dec c
            while nz | wend
        pop hl
    wend
    ld c,(hl)
    do
        ld b,16
        do
            ld a,(de)
            inc de
            exx
                ld (hl),a
                inc hl
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
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,0c000h
        ld de,0c001h
        ld bc,4000h-1
        ld (hl),0
        ldir

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ; ld hl,VVram_
        ; ld bc,VVramWidth*VVramHeight*2
        ; call Clear
    pop bc | pop de | pop hl | pop af
ret


cseg
PatternPtr: ; a->hl
    push af | push de
        ld l,a
        sub Char_Color
        if c
            ld de,MonoColorPattern
            jr PatternPtrExit
        endif
        ld l,a
        sub Char_End-Char_Color
        if c
            ld de,ColorPattern
            jr PatternPtrExit
        endif
        ld l,a
        ld de,SpriteCharPattern
        PatternPtrExit:
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,de
    pop de | pop af
ret

Put:
    ex de,hl
        call PatternPtr
    ex de,hl
    ld b,CharHeight
    do
        ld a,(de) | inc de
        ld (hl),a | inc l
        ld a,(de) | inc de
        ld (hl),a | dec l
        ld a,h | add a,8 | ld h,a
    dwnz
    ld a,h | sub 8*CharHeight | ld h,a
    inc hl | inc hl
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop af
ret

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push de | push bc
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
                push bc 
                    ld a,(de) | inc de
                    cp Char_End
                    jr nc,EndDraw_force
                    cp (hl)
                    if nz
                        EndDraw_force:
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
                    ld b,CharHeight*2
                    do
                        ex af,af'
                            xor a
                        ex af,af'
                        ld c,(hl) | inc hl
                        ld a,c
                        and 55h
                        if z
                            ex af,af'
                                or 55h
                            ex af,af'
                        endif
                        ld a,c
                        and 0aah
                        if z
                            ex af,af'
                                or 0aah
                            ex af,af'
                        endif
                        exx
                            ex af,af'
                                ld c,a
                            ex af,af'
                            ld a,(de) | inc de
                            and c
                        exx
                        or c
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
