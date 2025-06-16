include 'BIOS.inc'

VRAM_PatternGenerator equ 0000h
VRAM_PtnName equ 1800h
VRAM_Color equ 2000h
VRAM_Width equ 32
VRAM_Height equ 24

Char_Wall equ 80h
Char_BG equ Char_Wall + 16
Char_Title equ Char_BG + 4*16
Char_End equ Char_Title + 4*6

Color_Wall equ 40h
Color_White equ 0f0h

extrn CharPatterns, BGColors, AsciiPatterns


    cseg

WritePattern:
; hl: destination
; de: source
; bc: count
    ld a,3
    do
        push af | push de | push bc
            push hl
                ex de,hl
                call LDIRVM
            pop hl
            ld de,8*256
            add hl,de
        pop bc | pop de | pop af
        dec a
    while nz | wend
ret

FillColor:
; hl: destination
; e: color
; bc: count
    ld d,3
    do
        push de | push bc
            push hl
                ld a,e
                call FILVRM
            pop hl
            ld bc,8*256
            add hl,bc
        pop bc | pop de
        dec d
    while nz | wend
ret

InitVram_:
    public InitVram_
    push af | push hl | push de | push bc
        ld hl, VRAM_PatternGenerator + Char_Wall*8
        ld de, CharPatterns
        ld bc, (Char_End-Char_Wall)*8
        call WritePattern

        ld hl, VRAM_PatternGenerator + ' '*8
        ld de, AsciiPatterns
        ld bc,(60h-' ')*8
        call WritePattern

        ld hl, VRAM_Color + Char_Wall*8
        ld e, Color_Wall
        ld bc, (Char_BG - Char_Wall)*8
        call FillColor

        ld hl, VRAM_Color + Char_BG*8
        ld c,3
        do
            push hl
                ld de, BGColors
                ld b,22 ;(Char_End - Char_BG)/4
                do
                    push bc
                        ld a,(de)
                        inc de
                        ld bc,8*4
                        ;push hl | push de
                            call FILVRM
                        ;pop de | pop hl
                        ld bc,8*4
                        add hl,bc
                    pop bc
                dwnz
            pop hl
            ld de,8*256
            add hl,de
            dec c
        while nz | wend

        ld hl, VRAM_Color + ' '*8
        ld e, Color_White
        ld bc,(60h-' ')*8
        call FillColor
    exit:
    pop bc | pop de | pop hl | pop af
ret


PrintC_:
    public PrintC_
    push af | push de
        ld a,e
        call WRTVRM
    pop de | pop af
    inc hl
ret

ReadVram_:
    public ReadVram_
        call RDVRM
ret


ClearScreen_:
    public ClearScreen_
    push af | push de | push bc
        ld hl,VRAM_PtnName
        ld bc,VRAM_Height*VRAM_Width
        ld a,' '
        call FILVRM
    pop bc | pop de | pop af
ret


PrintDigit:
    push hl
        ld l,a
        ex de,hl
            xor a
            do
                inc a
                sbc hl,bc
            while nc
            wend
            add hl,bc
            dec a
        ex de,hl
        if z
            dec l
            if nz
                ld a,' '-'0'
            endif
            inc l
        else
            ld l,1
        endif
        add a,'0'
        ld c,l
    pop hl
    push de
        ld e,a
        call PrintC_
    pop de
    ld a,c
ret

PrintNumber5_:
    public PrintNumber5_
; in
;   hl: address
;   de: number
; out
;   hl: next address
    push af
    push de
    push bc
        xor a
        ld bc,10000
        call PrintDigit
        ld bc,1000
        call PrintDigit
        PrintNumber3:
        ld bc,100
        call PrintDigit
        ld bc,10
        call PrintDigit
        ld a,e
        add a,'0'
        ld e,a
        call PrintC_
    pop bc
    pop de
    pop af
ret

PrintNumber3_:
    public PrintNumber3_
; in
;   hl: address
;   de: number
; out
;   hl: next address
    push af
    push de
    push bc
        xor a
        ld bc,100
        call PrintDigit
        ld bc,10
        call PrintDigit
        ld a,e
        add a,'0'
        ld e,a
        call PrintC_
    pop bc
    pop de
    pop af
ret


PrintDigitB:
    ld a,e
    ld e,0
    do
        inc e
        sub d
    while nc
    wend
    add a,d
    dec e
    if z
        dec c
        if nz
            ld e,' '-'0'
        endif
        inc c
    else
        ld c,1
    endif
    ex af,af'
        ld a,e
        add a,'0'
        ld e,a
    ex af,af'
    call PrintC_
    ld e,a
ret 

PrintByteNumber3_:
    public PrintByteNumber3_
; in
;   hl: address
;   e: number
; out
;   hl: next address
    push af
    push de
    push bc
        ld c,1
        ld d,100
        call PrintDigitB
        ld d,10
        call PrintDigitB
        ld a,e
        add a,'0'
        ld e,a
        call PrintC_
    pop bc
    pop de
    pop af
ret

PrintByteNumber2_:
    public PrintByteNumber2_
; in
;   hl: address
;   e: number
; out
;   hl: next address
    push af
    push de
        ld d,10
        call PrintDigitB
        ld a,e
        add a,'0'
        ld e,a
        call PrintC_
    pop de
    pop af
ret


VramAddress:
    ex de,hl
    ld h,0
    add hl,hl   ;*2
    add hl,hl   ;*4
    add hl,hl   ;*8
    add hl,hl   ;*16
    add hl,hl   ;*32
    ex de,hl
    ld hl,VRAM_PtnName
    add hl,de
    ld e,a
    ld d,0
    add hl,de
ret

VPut2_:
    public VPut2_
    push af
    push hl
    push de
    push bc
        call VramAddress
        set 6,h
        ld e,c
        ld a,(VdpOutPort)
        ld c,a
        ld b,2
        do
            di
                inc c
                out (c),l
                out (c),h
                dec c
                out (c),e
                nop | nop
                inc e
                out (c),e
                inc e
            ei
            push de
                ld de,VRAM_Width
                add hl,de
            pop de
        dwnz
    pop bc
    pop de
    pop hl
    pop af
ret


VErase2_:
    public VErase2_
    push af
    push hl
    push de
    push bc
        call VramAddress
        set 6,h
        ld a,(VdpOutPort)
        ld c,a
        ld a,' '
        ld de,VRAM_Width
        ld b,2
        do
            di
            inc c
            out (c),l
            out (c),h
            dec c
            out (c),a
            nop | nop | nop
            out (c),a
            ei
            add hl,de
        dwnz
    pop bc
    pop de
    pop hl
    pop af
ret
