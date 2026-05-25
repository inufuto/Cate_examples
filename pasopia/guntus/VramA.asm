include "Vram.inc"
include "VVram.inc"

ext Chars_, Ascii_
ext VVramFront_, RowFlags_

VramTop equ Vram

    dseg
Backup:
    defs VVramWidth * VVramHeight


; void ClearScreen();
cseg
ClearScreen_:
    public ClearScreen_
    push af | push hl | push de | push bc
        call 8cbh

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret



WaitReady:
    in a,(09h)
    do
        in a,(09h)
        and 40h
    while nz | wend
    do
        in a,(09h)
        and 40h
    while z | wend
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        ex de,hl
            ld h,0
            add hl,hl ; *2
            add hl,hl ; *4
            add hl,hl ; *8
            ld bc,Chars_
            add hl,bc
        ex de,hl
        ld c,2
        do
            call WaitReady
            ld b,4
            do
                di
                ld a,(de)
                inc de
                out (01h),a
                ld a,l
                out (00h),a
                ld a,h
                or 80h
                out (0ah),a
                call WaitReady
                ld a,40h
                out (0ah),a
                ei
                ld a,h
                add a,16
                ld h,a
            dwnz
            push bc
                ld bc, 1-1000h*4
                add hl,bc
            pop bc
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret


VVramToVramRow:
    ld b,VVramWidth
    do 
        push bc 
            ld a,(de)
            inc de
            cp (hl)
            if nz
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
            ld bc,VramWidth-VVramWidth*2
            add hl,bc
        pop bc
    exx
ret


; void VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
        ld c, VVramHeight
        do
            call VVramToVramRow
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void VVramToVramChanged();
VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,VramTop
            ld de,RowFlags_
            ex de,hl
                ld c,1
                ld b,(hl)
                inc hl
            ex de,hl
        exx
        ld c, VVramHeight ; vertical count    
        do
            exx
                ld a,b
                and c
            exx
            if nz
                call VVramToVramRow            
            else
                push bc
                    ld bc,VVramWidth
                    add hl,bc
                    ex de,hl
                        add hl,bc
                    ex de,hl
                pop bc
                exx
                    push bc
                        ld bc,VramWidth
                        add hl,bc
                    pop bc
                exx
            endif
            exx
                sla c
                if z
                    ex de,hl
                        ld c,1
                        ld b,(hl)
                        inc hl
                    ex de,hl
                endif
            exx
            dec c
        while nz | wend

        xor a
        ld (RowFlags_),a
        ld (RowFlags_+1),a
        ld (RowFlags_+2),a
    pop bc | pop de | pop hl | pop af
ret


PrintC_: 
    public PrintC_
    push af | push hl | push de | push bc
        ex de,hl
            ld a,l
            sub ' '
            ld l,a
            ld h,0
            add hl,hl ; *2
            add hl,hl ; *4
            add hl,hl ; *8
            add hl,hl ; *16
            ld bc,Ascii_
            add hl,bc
        ex de,hl
        ld b,2
        do
            push bc
                ld c,2
                do
                    call WaitReady
                    ld b,4
                    do
                        di
                        ld a,(de)
                        inc de
                        out (01h),a
                        ld a,l
                        out (00h),a
                        ld a,h
                        or 80h
                        out (0ah),a
                        call WaitReady
                        ld a,40h
                        out (0ah),a
                        ei
                        ld a,h
                        add a,16
                        ld h,a
                    dwnz
                    ld a,h
                    sub 16*4
                    ld h,a                    
                    inc hl
                    dec c
                while nz | wend
                ld bc, VramWidth-2
                add hl,bc
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
    inc hl
    inc hl
ret