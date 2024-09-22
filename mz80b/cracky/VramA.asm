include "Vram.inc"
include "VVram.inc"


ext VVramFront_, RowFlags_
ext Chars_

    dseg
Backup: public Backup
    defs VVramWidth*VVramHeight


cseg
ClearRowFlags:
    xor a
    ld hl,RowFlags_
    ld b,4
    do
        ld (hl),a
        inc hl
    dwnz
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramRowSize*VramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
        
        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
        call ClearRowFlags
    pop bc | pop hl | pop af
ret


; void VPut(word vram, byte c);
cseg
Put:
    push hl | push de | push bc
        ex de,hl
            ld l,a
            ld h,0
            add hl,hl ; *2
            add hl,hl ; *4
            add hl,hl ; *8
            ld bc,Chars_
            add hl,bc
        ex de,hl
        ld bc,VramWidth
        ld a,CharHeight
        do
            ex af,af'
                ld a,(de)
                inc de
                ld (hl),a
            ex af,af'
            add hl,bc
            dec a
        while nz | wend
    pop bc | pop de | pop hl
ret

Put_: public Put_
    push af
        ld a,e
        call Put
    pop af
    inc hl
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
                    call Put
                exx
            endif
            exx
                inc hl
            exx
            inc hl
        pop bc
    dwnz
    exx
        push bc
            ld bc,VramRowSize-VVramWidth
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
        call ClearRowFlags
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
        call ClearRowFlags
    pop bc | pop de | pop hl | pop af
ret