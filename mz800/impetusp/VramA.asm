include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

dseg
PatternRam: ;public PatternRam
    defs PatternSize*100h
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
Backup: ;public Backup
    defs VVramWidth*VVramHeight
NextSpriteChar:
    defb 0


cseg
ColorTable:
defb 30, 3 ; Ascii
defb 15, 2 ; Logo
defb 1, 3 ; Remain
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
        push af | push hl | push bc
            call MakePatternMono
        pop bc | pop hl | pop af
        add a,b
    wend

    ld hl,ColorPattern
    ld de,PatternRam+PatternSize*Char_Color
    ld bc,PatternSize*(Char_End-Char_Color)
    ldir
ret

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

MakePatternMono:
    call PatternPtr
    ld a,c ; color
    exx
        ld c,a
    exx
    do
        ld c,CharHeight
        do
            push bc
                ld a,(de) | inc de
                push de
                    ld e,a
                    exx
                        ld a,c ; color
                    exx
                    ld c,a ; color
                    ld b,PlaneCount
                    do
                        ld d,0 ; byteValue
                        bit 0,c
                        if nz
                            ld a,d | or e | ld d,a
                        endif
                        bit 4,c
                        if nz
                            ld a,e
                            cpl
                            or d
                            ld d,a
                        endif
                        ld a,d
                        ld (hl),d | inc hl
                        srl c
                    dwnz
                pop de
            pop bc
            dec c
        while nz | wend
    dwnz    
ret


; void ClearScreen();
cseg
Clear:
    ld (hl),0
    ld e,l | ld d,h
    inc de
    dec bc
    ldir
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        di
            out (0e4h),a
            ld a,83h | out (0cch),a
            
            ld hl,Vram
            ld bc,2000h
            call Clear
            out (0e0h),a
        ei

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ; ld hl,VVram_
        ; ld bc,VVramWidth*VVramHeight*2
        ; call Clear
    pop bc | pop de | pop hl | pop af
ret


Put:
    ex de,hl
        call PatternPtr
    ex de,hl
    ld b,CharHeight
    di | out (0e4h),a
        do
            ld c,01h
            do
                ld a,c
                out (0cch),a

                ld a,(de) | inc de
                ld (hl),a

                ld a,c
                add a,a
                ld c,a
                cp 04h
            while c | wend
            ld a,l | add a,VramWidth | ld l,a
            ld a,h | adc a,0 | ld h,a
        dwnz
        xor a | out (0cch),a
    out (0e0h),a | ei
    ld a,l | sub low(VramRowSize-1) | ld l,a
    ld a,h | sbc a,high(VramRowSize-1) | ld h,a
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
        ld c, VVramHeight
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
                        call Put
                    exx
                else
                    exx
                        inc hl
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

        ld b,0
        ld l,c | ld h,b
        add hl,hl ;*2
        add hl,bc ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,hl ;*48
        add hl,hl ;*96
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
                                    _deb: public _deb
                    ld b,CharHeight
                    do
                        ld a,(hl) | inc hl
                        cpl
                        exx
                            ld c,a
                        exx
                        ld c,PlaneCount
                        do
                            exx
                                ld a,(de) | inc de
                                and c
                            exx
                            or (hl) | inc hl
                            exx
                                ld (hl),a | inc hl
                            exx
                            dec c
                        while nz | wend
                    dwnz
                pop bc
            dwnz
            ld a,e | add a,VVramWidth-2 | ld e,a
            ld a,d | adc a,0 | ld d,a
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
