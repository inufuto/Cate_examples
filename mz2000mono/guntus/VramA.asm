include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern
ext VVramFront_, RowFlags_

dseg
Backup:
    defs VVramWidth*VVramHeight


cseg
InitVram: public InitVram
    ld hl,CharPattern
    exx
        ld hl,PatternRam
    exx
    ld c,Char_End
    do
        ld b,CharHeight
        do
            ld a,(hl) | inc hl
            exx
                ld de,0
                ld b,8
                do
                    srl d | rr e
                    srl d | rr e
                    rlca
                    if c
                        set 7,d | set 6,d
                    endif
                dwnz
                ld (hl),e | inc hl
                ld (hl),d | inc hl
            exx
        dwnz
        dec c
    while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld de,Vram+1
        ld bc,640/8*200-1
        ld (hl),0
        ldir

        ld hl,Backup
        ld bc,VVramWidth * VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            ld bc,PatternRam
            add hl,bc
        ex de,hl
        ld b,CharHeight
        do
            ld a,(de)
            inc de
            ld (hl),a
            inc hl
            ld a,(de)
            inc de
            ld (hl),a
            dec hl
            ld a,l
            add a,VramWidth
            ld l,a
            ld a,h
            adc a,0
            ld h,a
        dwnz
        ld bc,-VramWidth*CharHeight
        add hl,bc
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
            ld bc,VramRowSize-VVramWidth*2
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
            ld hl,Vram
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
            ld hl,Vram
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
                        ld bc,VramRowSize
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
