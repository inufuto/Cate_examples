include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CharPattern, SpritePattern

dseg
Backup:
    defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
SpriteCharPattern: public SpriteCharPattern
    defs PatternSize*($100-Char_End)
NextSpriteChar:
    defb 0


cseg
LptSource: public LptSource
    defb 256-200
    defb 52h
    defb 11,51
    defw Vram,0
    defb	00h, 26h, 49h, 6dh, 82h, 10h, 0c3h, 0c7h

    defb -50,12h,63,0,0,0,0,0,0,0,0,0,0,0,0,0
    defb -3,16,63,0,0,0,0,0,0,0,0,0,0,0,0,0
    defb -4,16,6,63,0,0,0,0,0,0,0,0,0,0,0,0
    defb -1,90h,63,32,0,0,0,0,0,0,0,0,0,0,0,0
    defb 252,12h,6,63,0,0,0,0,0,0,0,0,0,0,0,0
    defb -50,13h,63,0,0,0,0,0,0,0,0,0,0,0,0,0
InitVram: public InitVram
    ld hl,Lpt/16
    ld a,l | out (82h),a
    ld a,h | or 0c0h | out (83h),a

    ld hl,LptSource
    ld de,Lpt
    ld bc,080h
    ldir
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
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld de,Vram+1
        ld bc,VramRowSize*VramHeight-1
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
        ld (hl),a | inc hl
        ld a,(de) | inc de
        ld (hl),a
        ld a,l | add a,VramWidth-1 | ld l,a
        ld a,h | adc a,0 | ld h,a
    dwnz
    ld a,l | add a,low(VramStep-VramRowSize) | ld l,a
    ld a,h | adc a,high(VramStep-VramRowSize) | ld h,a
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
