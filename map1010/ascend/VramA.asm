include 'Vram.inc'
include 'VVram.inc'

ext VVram_
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
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld de,Vram+VramRowSize*2
        exx
        ld c, VVramHeight ; vertical count    
        do
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
                    call PollVSync_
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
            call PollVSync_
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


; void Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af
        ld a,e
        ex de,hl
            call Put1
        ex de,hl
    pop af
    inc hl
ret