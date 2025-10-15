extrn Chars
extrn PollVSync_

StageWidth  equ 32
StageHeight equ 22

Vram equ 6000h
VramWidth equ 32
CharHeight equ 8
VramRowSize equ VramWidth * CharHeight

Char_Wall equ 0
Char_Sprite equ Char_Wall + 16
Char_Title equ Char_Sprite + 30 * 4
Char_Ascii equ Char_Title + 6 * 4

    dseg
VVram_:
    public VVram_
    defs StageWidth * StageHeight
Backgnd_:
    public Backgnd_
    defs StageWidth * StageHeight
Backup:
    public Backup
    defs StageWidth * StageHeight
RowFlags_:
    public RowFlags_
    defs 3

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
    call PollVSync_
ret


Print1x1:
    push af | push hl | push de | push bc
        ld l,a
        ld h,0
        add hl,hl ; *2
        add hl,hl ; *4
        add hl,hl ; *8
        ld bc,Chars
        add hl,bc
        ld bc,VramWidth
        ld a,CharHeight
        do
            ex af,af'
                ld a,(hl)
                inc hl
                ld (de),a
            ex af,af'
            ex de,hl
                add hl,bc
            ex de,hl
            dec a
        while nz | wend
    pop bc | pop de | pop hl | pop af
    call PollVSync_
ret


VVramToVram_:
    public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld de,Vram+VramRowSize*2
            ld hl,RowFlags_
            ld c,1
            ld b,(hl)
            inc hl
        exx
        ld c, StageHeight ; vertical count    
        do
            exx
                ld a,b
                and c
            exx
            if nz
                ld b,StageWidth
                do 
                    ld a,(de)
                    inc de
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            call Print1x1
                        exx
                    endif
                    exx
                        inc de
                    exx
                    call PollVSync_
                    inc hl
                dwnz
                exx
                    ex de,hl
                        push bc
                            ld bc,VramRowSize-StageWidth
                            add hl,bc
                        pop bc
                    ex de,hl
                exx
            else
                push bc
                    ld bc,StageWidth
                    add hl,bc
                    ex de,hl
                        add hl,bc
                    ex de,hl
                pop bc
                exx
                    ex de,hl
                        push bc
                            ld bc,VramRowSize
                            add hl,bc
                        pop bc
                    ex de,hl
                exx
            endif
            exx
                rlc c
                if c
                    ld b,(hl)
                    inc hl
                endif
            exx
            call PollVSync_
            dec c
        while nz | wend
        ld hl,RowFlags_
        ld b,3
        do
            ld (hl),0
            inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret


Print2x2_:
    public Print2x2_
    push af | push hl | push de | push bc
        ld a,e
        add a,a
        add a,a
        add a,Char_Sprite
        ld b,2
        do
            push bc
            ex de,hl
                call Print1x1
                inc de
                inc a
                call Print1x1
                inc a
            ex de,hl
            ld bc,VramRowSize - 1
            add hl,bc
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
ret


Erase2x2_:
    public Erase2x2_
    push hl | push de | push bc
        ld b,8*2
        ld de,32-1
        do
            ld (hl),0aah
            inc hl
            ld (hl),0aah
            add hl,de
        dwnz
    pop bc | pop de | pop hl
ret


PrintC_: 
    public PrintC_
    push af | push hl | push de | push bc
        ld a,e
        add a,Char_Ascii-' '
        ex de,hl
        call Print1x1
        ex de,hl
    pop bc | pop de | pop hl | pop af
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


ClearScreen_:
    public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramRowSize*24
        do
            ld (hl),0aah
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
        ld hl,Backup
        ld bc,StageWidth*StageHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop hl | pop af
ret
