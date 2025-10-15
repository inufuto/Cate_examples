include 'Vram.inc'

WindowWidth equ 24;
WindowHeight equ 24;

ext WindowFront_, RowFlags_
ext Chars_, Ascii_
ext PollVSync_

    dseg
Backup:
    public Backup
    defs WindowWidth*WindowHeight


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
        ld bc,WindowWidth*WindowHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop hl | pop af
ret


cseg
Print1x1:
;   in:
;       a: code
;       de: Vram address
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


WindowToVramRow:
    ld b,WindowWidth
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
        inc hl
    dwnz
    exx
        ex de,hl
            push bc
                ld bc,VramRowSize-WindowWidth
                add hl,bc
            pop bc
        ex de,hl
    exx
ret

; void WindowToVramAll();
cseg
WindowToVramAll_: public WindowToVramAll_
    push af | push hl | push de | push bc
        ld de,WindowFront_
        ld hl,Backup
        exx
            ld de,Vram
        exx
        ld c, WindowHeight ; vertical count    
        do
            call WindowToVramRow
            call PollVSync_
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void WindowToVramChanged();
cseg
WindowToVramChanged_: public WindowToVramChanged_
    push af | push hl | push de | push bc
        ld de,WindowFront_
        ld hl,Backup
        exx
            ld de,Vram
            ld hl,RowFlags_
            ld c,1
            ld b,(hl)
            inc hl
        exx
        ld c, WindowHeight ; vertical count    
        do
            exx
                ld a,b
                and c
            exx
            if nz
                call WindowToVramRow            
            else
                push bc
                    ld bc,WindowWidth
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


; void VPut2(ptr<byte> pVram, byte c)
cseg
VPut2_: public VPut2_
    push af | push hl | push de | push bc
        ld a,e
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


; void VErase2(ptr<byte> pVram);
cseg
VErase2_: public VErase2_
    push hl | push de | push bc
        ld b,CharHeight*2
        ld de,VramWidth-1
        do
            ld (hl),0aah
            inc hl
            ld (hl),0aah
            add hl,de
        dwnz
    pop bc | pop de | pop hl
ret


; void VPut4(ptr<byte> pVram, ptr<byte> pChars);
cseg
VPut4_: public VPut4_
    push af | push hl | push de | push bc
        ld c,4
        do
            ld b,4
            do
                ld a,(de)
                inc de
                ex de,hl
                    call Print1x1
                ex de,hl
                inc hl
            dwnz
            push de
                ld de,VramRowSize-4
                add hl,de
            pop de
            dec c
        while nz | wend
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
