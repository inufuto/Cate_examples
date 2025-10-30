include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

VramTop equ Vram+VramRowSize*0

Port31Save equ 0e6c6h

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
PatternPtr:
    push de
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        ld de,PatternRam | add hl,de
    pop de
ret


ColorTable:
defb 30, 3 ; Ascii
defb 15, 2 ; Logo
defb 1, 3 ; Remain
defb 0
defb Char_End-Char_Color; color
InitVram: public InitVram
    exx
        ld hl,PatternRam
    exx
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld a,(hl) | inc hl
        or a
    while nz
        ld c,a ; count
        ld a,(hl) | inc hl
        exx
            ld d,a ; color
        exx
        push hl
            ld b,a ; count
            do
                ld l,8 ; y count
                do
                    ld a,(de) | inc de
                    exx
                        ld c,a ; source
                    exx
                    ld h,2 ; x count
                    do
                        exx
                            ld e,0 ; destination
                        exx
                        ld b,4 ; dot count
                        do
                            exx
                                sla e
                                sla e
                                sla c
                                if c
                                    ld a,e
                                    or d
                                    ld e,a
                                endif
                            exx
                        dwnz
                        exx
                            ld (hl),e | inc hl
                        exx
                        dec h
                    while nz | wend
                    dec l
                while nz | wend
                dec c
            while nz | wend
        pop hl
    wend
    
    ld hl,ColorPattern
    ld de,PatternRam+PatternSize*Char_Color
    ld bc,PatternSize*(Char_End-Char_Color)
    ldir
ret


; void ClearScreen();
Clear:
    ld (hl),0
    ld e,l | ld d,h
    inc de
    dec bc
    ldir
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        di
            out (5ch),a
            ld hl,Vram
            ld bc,4000h
            call Clear
            out (5fh),a
        ei

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop de | pop hl | pop af
ret


cseg
Put:
    ex de,hl
        call PatternPtr
    ex de,hl
    di
        out (5ch),a
        ld b,CharHeight
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
            ld a,(de) | inc de
            ld (hl),a
            ld a,l | add a,VramWidth-1 | ld l,a
            ld a,h | adc a,0 | ld h,a
        dwnz
        out (5fh),a
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
                    ld b,CharHeight
                    do
                        ld a,(hl) | inc hl
                        cpl
                        exx
                            ld b,a
                        exx
                        ld a,(hl) | inc hl
                        cpl
                        exx
                            ld c,a
                        ; exx
                        ; exx
                            ld a,(de) | inc de
                            and b
                        exx
                        or (hl) |inc hl
                        exx
                            ld (hl),a | inc hl
                        exx
                        exx
                            ld a,(de) | inc de
                            and c
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
