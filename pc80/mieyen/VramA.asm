include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext Chars_, Ascii_
ext PollVSync_

VramTop equ Vram+VramWidth*1

dseg
Backup:
    defs VVramWidth*VVramHeight
RowFlags:
    defs 4


;   void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,Backup
        ld de,VVramFront_
        exx
            xor a
            ld hl,RowFlags
            ld b,4
            do
                ld (hl),a
                inc hl
            dwnz

            ld hl,RowFlags
            ld c,1
            ld b,(hl)
            ld e,0
        exx
        ld c,VVramHeight
        do
            push hl | push de
                ld b,VVramWidth
                do
                    ld a,(de)
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            ld a,b
                            or c
                            ld b,a
                            ld e,1
                        exx
                        jr VVramToVram_NextRow
                    endif
                    inc de
                    inc hl
                dwnz
                VVramToVram_NextRow:            
            pop de | pop hl
            push bc
                ld bc,VVramWidth
                add hl,bc
                ex de,hl
                    add hl,bc
                ex de,hl
            pop bc
            exx
                rlc c
                if c
                    ld (hl),b
                    inc hl
                    ld b,(hl)
                endif
            exx
            dec c
        while nz | wend
        exx
            ld (hl),b
            ld a,e
        exx
        or a
        if nz
            call VVramToVramChanged_
        endif
    pop bc | pop de | pop hl | pop af
ret


VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc | push ix | push iy
        ld hl,VVramFront_
        ld de,VramTop
        ld ix,Backup
        ld iy,VramTop+VramCharWidth ; pointer of attribute
        exx
            ld hl,RowFlags
            ld c,1
            ld b,(hl)
            inc hl
        exx
        ld a,0f8h | ld (rightColor+1),a
        ld b,VVramHeight
        do
            push bc
                exx
                    ld a,b
                    and c
                exx
                if nz
                    call PollVSync_
                    xor a
                    ld (VVramToVramChanged_cp+1),a
                    exx
                        ld de,VramAttrWidth/2-1 ; d=column, e=attribute count
                    exx
                    ld b,VVramWidth
                    do
                        push bc
                            ld a,(hl)   ; char code
                            inc hl
                            ld (ix),a
                            inc ix
                            push hl
                                ld l,a
                                ld h,0
                                add hl,hl
                                add hl,hl
                                ld bc,Chars_
                                add hl,bc
                                ld b,2
                                do
                                    ld a,(hl)
                                    inc hl
                                    ld (de),a
                                    inc de
                                    ld c,(hl)
                                    inc hl
                                    exx
                                        ld a,e ; attribute count
                                    exx
                                    or a
                                    if nz
                                        ld a,c
                                        VVramToVramChanged_cp:
                                        cp 0
                                        if nz
                                            ld (VVramToVramChanged_cp+1),a
                                            exx
                                                ld (iy),d; column
                                                inc iy
                                                dec e
                                            exx
                                            ld (iy),c
                                            inc iy
                                        endif
                                    endif
                                    exx
                                        inc d
                                    exx
                                dwnz
                            pop hl
                        pop bc
                    dwnz
                    exx
                        ld a,e ; attribute count
                    exx
                    inc a
                    ld b,a
                    rightColor:
                    ld a,0d8h
                    do
                        exx
                            ld (iy),d; column
                            inc iy
                        exx
                        ld (iy),a
                        inc iy
                    dwnz
                    ld bc,VramWidth-VVramWidth*2
                    ex de,hl
                        add hl,bc
                    ex de,hl
                    ld bc,VramWidth-VramAttrWidth
                else
                    ld bc,VVramWidth
                    add hl,bc
                    add ix,bc
                    ld bc,VramWidth
                    ex de,hl
                        add hl,bc
                    ex de,hl
                endif
                add iy,bc
                exx
                    rlc c
                    if c
                        ld b,(hl)
                        inc hl
                    endif
                exx
            pop bc
            ld a,b
            cp 5
            jr c,defalutColor
            cp 7
            if c
                ld a,0d8h
            else
                defalutColor:
                ld a,0f8h
            endif
            ld (rightColor+1),a
        dwnz
    pop iy | pop ix | pop bc | pop de | pop hl | pop af
ret    


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld c,VramHeight
        do
            ld b,VramCharWidth
            xor a
            do
                ld (hl),a
                inc hl
            dwnz
            ld (hl),0
            inc hl
            ld (hl),0f8h
            inc hl
            ld b,VramAttrWidth/2-1
            do
                ld (hl),VramCharWidth
                inc hl
                ld (hl),0f8h
                inc hl
            dwnz
            dec c
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight/2
        do
            ld (hl),0 | inc hl
            ld (hl),0f8h | inc hl
            dec bc
            ld a,b
            or c
        while nz | wend

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        do
            ld (hl),0 | inc hl
            dec bc
            ld a,b
            or c
        while nz | wend
    pop bc | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> address, byte c);
PrintC_: public PrintC_
    push af
    push bc
        ld a,e
        ex de,hl
            sub ' '
            add a,a
            add a,a
            ld c,a | ld b,0
                ld hl,Ascii_
                add hl,bc
            ld bc,2
            ldir
            push de
                ex de,hl
                ld bc,VramWidth-2
                add hl,bc
                ex de,hl
                ld bc,2
                ldir
            pop de
        ex de,hl
    pop bc
    pop af
ret 


;   ptr<byte> Put(ptr<byte> pVram, byte c);
Put_: public Put_
    push af
    push hl
    push de
    push bc
        ex de,hl
            ld h,0
            add hl,hl   ; *2
            add hl,hl   ; *4
            ld bc,Chars_
            add hl,bc
        ex de,hl
        ld b,2
        do
            ld a,(de)
            inc de
            inc de
            ld (hl),a
            inc hl
        dwnz
    pop bc
    pop de
    pop hl
    pop af
    inc hl | inc hl |
ret
