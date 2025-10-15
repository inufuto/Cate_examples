include 'Vram.inc'

VVramWidth    equ 32
VVramHeight    equ 22

ext VVramFront_, RowFlags_, ClearVVram_, VVramBackToFront_
ext Chars_, Ascii_
ext PollVSync_

dseg
Backup: defs VVramWidth*VVramHeight

cseg

; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramRowSize*VramHeight
        do
            ld (hl),0aah
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
    pop bc | pop hl | pop af
ret


Put1: 
    push af | push hl | push de | push bc
        ld l,a
        ld h,0
        add hl,hl ; *2
        add hl,hl ; *4
        add hl,hl ; *8
        ld bc,Chars_
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


VVramToVramRow:
    ld b,VVramWidth
    do 
        ld a,(de)
        inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                call Put1
            exx
        endif
        exx
            inc de
        exx
        inc hl
    dwnz
    exx
        ex de,hl
            push bc
                ld bc,VramRowSize-VVramWidth
                add hl,bc
            pop bc
        ex de,hl
    exx
ret

; void VVramToVramAll();
cseg
VVramToVramAll_: public VVramToVramAll_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld de,Vram+VramRowSize*2
        exx
        ld c, VVramHeight ; vertical count    
        do
            call VVramToVramRow
            call PollVSync_
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void VVramToVramChanged();
cseg
VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld de,Vram+VramRowSize*2
            ld hl,RowFlags_
            ld c,1
            ld b,(hl)
            inc hl
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

        xor a
        ld (RowFlags_),a
        ld (RowFlags_+1),a
        ld (RowFlags_+2),a
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            sub ' '
            ld l,a
            ld h,0
            add hl,hl ; *2
            add hl,hl ; *4
            add hl,hl ; *8
            ld bc,Ascii_
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
    pop bc | pop de | pop hl | pop af
    inc hl
ret 


; void VPut(ptr<byte> pVram, byte c);
cseg
VPut_: public VPut_
    push af
        ld a,e
        ex de,hl
            call Put1
        ex de,hl
    pop af
ret