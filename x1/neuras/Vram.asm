include 'X1.inc'
include 'Chars.inc'

StageWidth  equ 32
StageHeight equ 22

    dseg
VVram_:
    public VVram_
    defs StageWidth * StageHeight
Backgnd_:
    public Backgnd_
    defs StageWidth * StageHeight
RowFlags_:
    public RowFlags_
    defs 3

    cseg

    cseg
SetRowFlag2_:
    public SetRowFlag2_
	push	af
	push	hl
	push	de
        ld	e,a
        srl	e
        srl	e
        srl	e
        ld d,0
        ld hl,RowFlags_
        add hl,de

        ex de,hl
            ld hl,3
            and 7
            do 
            while nz
                add hl,hl
                dec a
            wend
        ex de,hl

        ld a,(hl)
        or e
        ld (hl),a
        inc hl
        ld a,(hl)
        or d
        ld (hl),a
	pop	de
	pop	hl
	pop	af
ret


BackgndToVVram_:
    public BackgndToVVram_
    push hl
    push de
    push bc
        ld de,VVram_
        ld hl,Backgnd_
        ld bc,StageWidth * StageHeight
        ldir  
    pop bc
    pop de
    pop hl
ret

VVramToVram_:
    public VVramToVram_
    push af | push hl | push de | push bc
        ld bc,Vram+VramWidth
        ld hl,VVram_
        exx
            ld hl,RowFlags_
            ld c,1
            ld b,(hl)
            inc hl
        exx
        ld d,StageHeight
        do
            exx
                ld a,b
                and c
            exx
            if nz
                ld e, StageWidth
                do
                    ld a,(hl)
                    inc hl
                    out (c),a
                    inc bc
                    dec e
                while nz | wend
                ld a,c
                add a,VramWidth-StageWidth
                ld c,a
                ld a,b
                adc a,0
                ld b,a
            else
                ld a,c
                add a,VramWidth
                ld c,a
                ld a,b
                adc a,0
                ld b,a
                push de
                    ld de,StageWidth
                    add hl,de
                pop de
            endif
            exx
                rlc c
                if c
                    ld b,(hl)
                    inc hl
                endif
            exx
            dec d
        while nz | wend
        ld hl,RowFlags_
        ld b,3
        do
            ld (hl),0
            inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret


PrintC_: 
    public PrintC_
    push bc
        ld c,l
        ld b,h
        out (c),e
    pop bc
    inc hl
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


Print2x2_:
    public Print2x2_
    push af | push hl | push bc
        ld c,l
        ld b,h
        ld a,e
        add a,a
        add a,a
        add a,Char_Sprite
        ld h,2
        do
            ld l,2
            do
                out (c),a
                inc bc
                inc a
                dec l
            while nz | wend
            ex af,af'
                ld l,a
                ld a,c
                add a,VramWidth-2
                ld c,a
                ld a,b
                adc a,0
                ld b,a
                ld a,l
            ex af,af'
            dec h
        while nz | wend
    pop bc | pop hl | pop af
ret


Erase2x2_:
    public Erase2x2_
    push af | push hl | push bc
        ld c,l
        ld b,h
        ld h,2
        do
            ld l,2
            ld a,Char_Space
            do
                out (c),a
                inc bc
                dec l
            while nz | wend
            ld a,c
            add a,VramWidth-2
            ld c,a
            ld a,b
            adc a,0
            ld b,a
            dec h
        while nz | wend
    pop bc | pop hl | pop af
ret


ClearScreen_:
    public ClearScreen_
    push af | push hl | push bc
        ld bc,Vram
        ld hl,VramWidth*VramHeight
        do
            ld a,Char_Space
            out (c),a
            res 4,b
            ld a,Attribute_PCG or 7
            out (c),a
            set 4,b
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend
    pop bc | pop hl | pop af
ret
