include "MegaDuck.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern,SpritePattern
ext VVram_

Mode equ LCDCF_OBJ16 or LCDCF_OBJON or LCDCF_BGON
LcdOn equ Mode or LCDCF_ON
LcdOff equ Mode

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
Repeat7F:
    ld a,7fh
    do
        ld (hl+),a
        dec b
    while nz | wend
ret
InitVram: public InitVram
    ld a,LcdOff | ldh (LCDC),a
    ld a,0d0h | ldh (OBP0),a
    ld a,0e4h | ldh (BGP),a

    ld de,SpritePattern
    ld hl,8000h
    ld c,Pattern_End*2
    do
        ld b,PlaneCount*CharHeight*2
        do
            ld a,(de) | inc de
            ld (hl+),a
            dec b
        while nz | wend

        xor a,a
        ld b,PlaneCount*(16-CharHeight*2)
        do
            ld (hl+),a
            dec b
        while nz | wend

        dec c
    while nz | wend
                            _deb: public _deb

    ld hl,Vram
    ld b,32*3 | call Repeat7F
    ld de,80h or (13 shl 8)
    do
        ld a,7fh | ld (hl+),a
        ld b,18
        do
            ld a,e | ld (hl+),a
            inc e
            dec b
        while nz | wend
        ld b,32-20+1 | call Repeat7F

        dec d
    while nz | wend
    ld b,32*16 | call Repeat7F

    ld a,LcdOn | ldh (LCDC),a
ret


; void ClearScreen();
cseg
Clear:
    do
        xor a,a
        ld (hl+),a
        dec bc
        ld a,c | or a,b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld a,LcdOff | ldh (LCDC),a

        ld hl,CharRam0
        ld bc,800h
        call Clear

        ld hl,CharRam1
        ld bc,800h
        call Clear

        ld a,LcdOn | ldh (LCDC),a

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVram_
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; void LcdOn();
cseg
LcdOn_: public LcdOn_
    push af
        ld a,LcdOn | ldh (LCDC),a
    pop af
ret

; void LcdOff();
cseg
LcdOff_: public LcdOff_
    push af
        ld a,LcdOff | ldh (LCDC),a
    pop af
ret


cseg
PatternPtr: ; e->de
    ; push hl
        ld d,0
        ld l,e | ld h,d
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        ld de,CharPattern
        add hl,de
        ld e,l | ld d,h
    ; pop hl
ret

WaitH:
    do
        ldh a,(STAT)
        bit 1,a
    while nz | wend
ret
WaitV:
    ld a,(LCDC)
    bit LCDCF_B_ON,a
    if nz
        do
            ldh a,(STAT)
            and a,3
            dec a
        while nz | wend
    endif
ret
ReadVram:
    call WaitH
    ld a,(hl)
ret
WriteVram:
    ld b,a
    call WaitH
    ld (hl),b
ret

Put0:
    do
        ld b,PlaneCount
        do
            push bc
                call ReadVram
                and a,03h | ld c,a
                ld a,(de) | inc de
                or a,c
                call WriteVram
                inc hl
            pop bc
            dec b
        while nz | wend
        dec c
    while nz | wend
ret
Put2:
    do
        ld b,PlaneCount
        do
            push bc
                call ReadVram
                and a,0c0h | ld c,a
                ld a,(de) | inc de
                rrca | rrca
                or a,c
                call WriteVram
                inc hl
            pop bc
            dec b
        while nz | wend
        dec c
    while nz | wend
ret
Put4:
    do
        ld b,PlaneCount
        do
            push bc
                call ReadVram
                and a,0f0h | ld c,a
                ld a,(de)
                rrca | rrca | rrca | rrca
                and a,0fh
                or a,c
                call WriteVram
                push de
                    ld de,8*PlaneCount
                    add hl,de
                pop de
                call ReadVram
                and a,3fh | ld c,a
                ld a,(de)
                rlca | rlca | rlca | rlca
                and a,0c0h
                or a,c
                call WriteVram
                push de
                    ld de,1-8*PlaneCount
                    add hl,de
                pop de
                inc de
            pop bc
            dec b
        while nz | wend
        dec c
    while nz | wend
ret
Put6:
    do
        ld b,PlaneCount
        do
            push bc
                call ReadVram
                and a,0fch | ld c,a
                ld a,(de)
                rlca | rlca
                and a,03h
                or a,c
                call WriteVram
                push de
                    ld de,8*PlaneCount
                    add hl,de
                pop de
                call ReadVram
                and a,0fh | ld c,a
                ld a,(de)
                rlca | rlca
                and a,0f0h
                or a,c
                call WriteVram
                push de
                    ld de,1-8*PlaneCount
                    add hl,de
                pop de
                inc de
            pop bc
            dec b
        while nz | wend
        dec c
    while nz | wend
ret

; hl=destination, de=source
Put00:
    ld c,CharHeight
jp Put0
Put20:
    ld c,CharHeight
jp Put2
Put40:
    ld c,CharHeight
jp Put4
Put60:
    ld c,CharHeight
jp Put6
Put04:
    ld c,4
    call Put0
    push de
        ld de,PlaneCount*(8*18-8)
        add hl,de
    pop de
    ld c,2
jp Put0
Put24:
    ld c,4
    call Put2
    push de
        ld de,PlaneCount*(8*18-8)
        add hl,de
    pop de
    ld c,2
jp Put2
Put44:
    ld c,4
    call Put4
    push de
        ld de,PlaneCount*(8*18-8)
        add hl,de
    pop de
    ld c,2
jp Put4
Put64:
    ld c,4
    call Put6
    push de
        ld de,PlaneCount*(8*18-8)
        add hl,de
    pop de
    ld c,2
jp Put6
Put06:
    ld c,2
    call Put0
    push de
        ld de,PlaneCount*(8*18-8)
        add hl,de
    pop de
    ld c,4
jp Put0
Put26:
    ld c,2
    call Put2
    push de
        ld de,PlaneCount*(8*18-8)
        add hl,de
    pop de
    ld c,4
jp Put2
Put46:
    ld c,2
    call Put4
    push de
        ld de,PlaneCount*(8*18-8)
        add hl,de
    pop de
    ld c,4
jp Put4
Put66:
    ld c,2
    call Put6
    push de
        ld de,PlaneCount*(8*18-8)
        add hl,de
    pop de
    ld c,4
jp Put6


; word Put(word vram, byte c);
cseg
YTable:
    defw 8800h,880Ch,8928h,8A44h,8B60h,8B6Ch,8C88h,8DA4h,8EC0h,8ECCh,8FE8h,9104h,9220h,922Ch,9348h,9464h,9580h
XTable:
    defw 0,0,16,32,48,48,64,80,96,96,112,128,144,144,160,176,192,192,208,224,240,240,256,272
Put_: public Put_
    push af | push hl | push de | push bc
        ld c,l | ld b,h
        call PatternPtr
        push de
            ld a,b ;y
            add a,a ;*2
            ld e,a | ld d,0
            ld hl,YTable |  add hl,de
            ld a,(hl) | inc hl
            ld h,(hl) | ld l,a
            push hl
                ld a,c ;x
                add a,a ;*2
                ld e,a | ld d,0
                ld hl,XTable
                add hl,de
                ld a,(hl) | inc hl
                ld h,(hl) | ld l,a
            pop de
            add hl,de
        pop de
        ; call WaitV
        ld a,b | and a,3
        if z
            Put_y0:
            ld a,c | and a,3
            if z
                call Put00
                jr Put_exit
            endif
            dec a
            if z
                call Put60
                jr Put_exit
            endif
            dec a
            if z
                call Put40
                jr Put_exit
            endif
            call Put20
            jr Put_exit
        endif
        dec a
        if z
            ld a,c | and a,3
            if z
                call Put06
                jr Put_exit
            endif
            dec a
            if z
                call Put66
                jr Put_exit
            endif
            dec a
            if z
                call Put46
                jr Put_exit
            endif
            call Put26
            jr Put_exit
        endif
        dec a
        if z
            ld a,c | and a,3
            if z
                call Put04
                jr Put_exit
            endif
            dec a
            if z
                call Put64
                jr Put_exit
            endif
            dec a
            if z
                call Put44
                jr Put_exit
            endif
            call Put24
            jr Put_exit
        endif
        jr Put_y0
        Put_exit:
    pop bc | pop de | pop hl | pop af
    inc l
ret


; void VVramToVram();
dseg
xCount:
    defb 0
yCount:
    defb 0
cseg
SkipBc:
    push hl
        ld hl,8*PlaneCount
        add hl,bc
        ld c,l | ld b,h
    pop hl
ret
VVramToVramRow0:
VVramToVramRow2:
    ld a,VVramWidth/4 | ld (xCount),a
    do
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put00
                ld de,PlaneCount*(-6)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put60
                ld de,PlaneCount*(-6+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put40
                ld de,PlaneCount*(-6+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put20
                ld de,PlaneCount*(-6+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(xCount) | dec a | ld (xCount),a
    while nz | wend
ret
VVramToVramRow4:
    ld a,VVramWidth/4 | ld (xCount),a
    do
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put04
                ld de,PlaneCount*(-2-8*18+4)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put64
                ld de,PlaneCount*(-2-8*18+4+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put44
                ld de,PlaneCount*(-2-8*18+4+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put24
                ld de,PlaneCount*(-2-8*18+4+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(xCount) | dec a | ld (xCount),a
    while nz | wend
    push hl
        ld hl,PlaneCount*-2
        add hl,bc
        ld c,l | ld b,h
    pop hl
ret
VVramToVramRow6:
    ld a,VVramWidth/4 | ld (xCount),a
    do
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put06
                ld de,PlaneCount*(-4-8*18+6)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put66
                ld de,PlaneCount*(-4-8*18+6+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put46
                ld de,PlaneCount*(-4-8*18+6+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(de) | inc de
        cp a,(hl)
        if nz
            ld (hl),a
            push hl | push de
                ld e,a
                call PatternPtr
                ld l,c | ld h,b
                call Put26
                ld de,PlaneCount*(-4-8*18+6+8)
                add hl,de
                ld c,l | ld b,h
            pop de | pop hl
        else
            call SkipBc
        endif
        inc hl
        ld a,(xCount) | dec a | ld (xCount),a
    while nz | wend
    push hl
        ld hl,PlaneCount*-2
        add hl,bc
        ld c,l | ld b,h
    pop hl
ret
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        ld bc,CharRam1+PlaneCount*(18*8+4)
        call VVramToVramRow4
        call VVramToVramRow2
        push hl
            ld hl,PlaneCount*-2
            add hl,bc
            ld c,l | ld b,h
        pop hl
        ld a,VVramHeight/4 | ld (yCount),a
        do
            call VVramToVramRow0
            push hl
                ld hl,PlaneCount*(6-8*18)
                add hl,bc
                ld c,l | ld b,h
            pop hl
            call VVramToVramRow6
            call VVramToVramRow4
            call VVramToVramRow2
            push hl
                ld hl,PlaneCount*-2
                add hl,bc
                ld c,l | ld b,h
            pop hl
            ld a,(yCount) | dec a | ld (yCount),a
        while nz | wend
        call VVramToVramRow0
    pop bc | pop de | pop hl | pop af
ret
