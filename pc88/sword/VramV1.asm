include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, ColorPatternV1
ext VVram_

dseg
PatternRam: public PatternRam
    defs PatternSize*Char_End
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
Backup:
    defs VVramWidth*VVramHeight


cseg
PatternPtr:
    push de
        ld l,a | ld h,0
        ld e,l | ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,hl ;*48
        ld de,PatternRam | add hl,de
    pop de
ret


cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 6 ; Logo
defb 2, 1 ; Fence
defb 4, 1 ; Wall
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

    ld hl,PatternRam+PatternSize*Char_Color
    ld de,ColorPattern
    ld bc,CharHeight*PlaneCount*(Char_Sprite-Char_Color)
    call MakePatternColor

    ld hl,PatternRam+PatternSize*Char_Sprite
    ld de,ColorPatternV1
    ld bc,CharHeight*PlaneCount*(Char_End-Char_Sprite)
    call MakePatternColor
ret

DoubleADe:
    push bc
        ld de,0
        ld b,8
        do
            sla e | rl d
            sla e | rl d
            rlca
            if c
                set 0,e
                set 1,e
            endif
        dwnz
    pop bc
ret

MakePatternMono: public MakePatternMono
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
                        push de
                            call DoubleADe
                            ld (hl),d | inc hl
                            ld (hl),e | inc hl
                        pop de
                        srl c
                    dwnz
                pop de
            pop bc
            dec c
        while nz | wend
    dwnz    
ret


MakePatternColor: public MakePatternColor
    do
        ld a,(de) | inc de
        push de
            call DoubleADe
            ld (hl),d | inc hl
            ld (hl),e | inc hl
        pop de
        dec bc
        ld a,c | or b
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
        di
            ld a,5ch
            do
                ld c,a
                out (c),a
                ld hl,0c000h
                ld de,0c001h
                ld bc,640/8*200-1
                ld (hl),0
                ldir
                inc a
                cp 5fh
            while nz | wend
            out (5fh),a
        ei

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop de | pop hl | pop af
ret


Put:
    ex de,hl
        call PatternPtr
    ex de,hl
    di
        ld b,CharHeight
        do
            ld c,5ch
            do
                out (c),a
                ld a,(de) | inc de
                ld (hl),a | inc hl
                ld a,(de) | inc de
                ld (hl),a | dec hl
                inc c
                ld a,c
                cp 5fh
            while nz | wend
            out (c),a
            ld a,l | add a,VramWidth | ld l,a
            ld a,h | adc a,0 | ld h,a
        dwnz
    ei
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
    pop bc | pop de | pop hl | pop af
ret


; void EndDraw();
cseg
EndDraw_: public EndDraw_
    push af | push hl | push de | push bc
        ld de,SpriteLayer
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*2
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
                        inc hl | inc hl
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

        ld a,c; pattern
        add a,a ;*2
        add a,a ;*4
        add a,Char_Sprite

        ld c,2
        do
            ld b,2
            do
                ld (de),a | inc de
                inc a
            dwnz
            ex af,af'
                ld a,e | add a,VVramWidth-2 | ld e,a
                ld a,d | adc a,0 | ld d,a
            ex af,af'
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
