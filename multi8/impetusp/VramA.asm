include "Vram.inc"
include "VVram.inc"
include "Chars.inc"
include "FixedCode.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

SpritePatternSize equ CharHeight*2*4*4
PatternRam equ 1000h
SpritePatternW equ 4000h

dseg
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
Backup:
    defs VVramWidth*VVramHeight
NextSpriteChar:
    defb 0

cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
    di | ld a,20h | out (2ah),a
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
        ld b,Char_End-Char_Color
        call MakePatternColor
        
        ld hl,SpritePatternW
        ld de,SpritePattern
        ld bc,CharHeight*4*4*Pattern_End
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
    xor a | out (2ah),a | ei
ret

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
        ld c,CharHeight
        do
            push bc
                ld b,PlaneCount
                do
                    ld a,(de)
                    push de
                        call DoubleADe
                        ld (hl),d | inc hl
                        ld (hl),e | inc hl
                    pop de
                    ld a,e | add a,CharHeight | ld e,a
                    ld a,d | adc a,0 | ld d,a
                dwnz
                ld a,e | sub CharHeight*PlaneCount-1 | ld e,a
                ld a,d | sbc a,0 | ld d,a
            pop bc
            dec c
        while nz | wend
        ld a,e | add a,CharHeight*(PlaneCount-1) | ld e,a
        ld a,d | adc a,0 | ld d,a
    dwnz
ret


; void ClearScreen();
cseg
Clear:
    ld e,l | ld d,h
    inc de
    dec bc
    ld (hl),0
    ldir
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        call ClearVram

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
    call WriteVram
    inc hl | inc hl
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
        ld bc,SpritePatternW | add hl,bc
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
                        di | ld a,20h | out (2ah),a
                            ld a,(hl) | inc hl
                            cpl
                            exx
                                ld b,a
                            exx
                            ld a,(hl) | inc hl
                            cpl
                            exx
                                ld c,a
                            exx
                            ld c,PlaneCount
                            do
                                exx
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
                                dec c
                            while nz | wend
                        xor a | out (2ah),a | ei
                    dwnz
                pop bc
            dwnz
            ld a,e | add a,VVramWidth-2 | ld e,a
            ld a,d | adc a,0 | ld d,a
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
