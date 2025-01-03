include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext AsciiPattern, ColorPattern

dseg
Backup:
    defs VVramWidth * VVramHeight


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
ClearScreen_:
    public ClearScreen_
    push af | push hl | push de | push bc
        call 8cbh

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret



WaitReady:
    in a,(09h)
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
            ld bc,ColorPattern
            add hl,bc
        ex de,hl
        ld c,2
        do
            ld b,4
            do
                ld a,(de)
                inc de
                out (01h),a
                di
                    call WaitReady
                    ld a,l | out (00h),a
                    ld a,h | or 80h | and not 40h | out (0ah),a
                    call WaitReady
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


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*1
        exx
        ld c, VVramHeight
        do
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
                    ld bc,VramRowSize-VVramWidth*2
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; word PrintC(word vram, byte c);
cseg
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
            ld bc,AsciiPattern
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
