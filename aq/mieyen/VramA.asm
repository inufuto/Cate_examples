include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Chars
ext PollVSync_

dseg
Backup: defs VVramWidth*VVramHeight

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

ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld bc,VramWidth*VramHeight
        call Clear
    
        ld hl,Atributes
        ld bc,VramWidth*VramHeight
        call Clear

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVram_
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop de | pop hl | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld de,Vram+VramRowSize*1
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de)
                inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        push hl | push bc
                            ld l,a
                            ld h,0
                            add hl,hl
                            ld bc,Chars
                            add hl,bc
                            ld a,(hl)
                            inc hl
                            ld (de),a
                            ld a,(hl)
                            set 2,d
                            ld (de),a
                            res 2,d
                        pop bc | pop hl
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
            call PollVSync_
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
PrintC_: public PrintC_
    push af
        ld a,e
        ld (hl),a
        set 2,h
        ld (hl),70h
        res 2,h
        inc hl
    pop af
ret


; void ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        ex de,hl
            ld h,0
            add hl,hl
            ld bc,Chars
            add hl,bc
        ex de,hl
        ld a,(de)
        inc de
        ld (hl),a
        ld a,(de)
        set 2,h
        ld (hl),a

        call PollVSync_
    pop bc | pop de | pop hl | pop af
    inc hl
ret
