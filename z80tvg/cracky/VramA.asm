include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext CharPattern

GRam equ 0C25Dh
GRamWidth equ 30

VramTop equ Vram_+VramWidth*0

dseg
Vram_: public Vram_
    defs VramWidth*VramHeight
Backup: public Backup
    defs VramWidth*VramHeight

; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,0c000h
        ld bc,2000h
        call Clear

        ld hl,Vram_
        ld bc,VramWidth*VramHeight
        call Clear

        ld hl,Backup
        ld bc,VramWidth*VramHeight
        call Clear
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
Put_: public Put_
    ld (hl),e | inc hl
ret


; void PresentVram();
CharPtr:
    ld l,a | ld h,0
    add hl,hl ;*2    
    add hl,hl ;*4
    ld de,CharPattern
    add hl,de
ret
PresentVram_: public PresentVram_
    push af | push hl | push de | push bc
        ld hl,Backup
        ld de,Vram_
        exx
            ld hl,GRam
        exx
        ld c,VramHeight
        do
            ld b,VramWidth/2
            do
                push hl | push de | push bc
                    ld a,(de) | ld c,a | inc de
                    ld a,(de) | ld b,a
                    ld e,(hl) | inc hl
                    ld d,(hl)
                    ld a,e
                    cp c
                    jr nz,PresentVram_ne
                    ld a,d
                    cp b
                    if nz
                        PresentVram_ne:
                        ld (hl),b | dec hl
                        ld (hl),c
                        ld a,c
                        call CharPtr
                        push hl
                            ld a,b
                            call CharPtr
                        pop de
                        exx
                            ld de,GRamWidth
                        exx
                        ld b,8/2
                        do
                            ld a,(de)
                            and 0fh
                            ld c,a
                            ld a,(hl)
                            rlca | rlca | rlca | rlca | and 0f0h
                            or c
                            exx
                                ld (hl),a
                                add hl,de
                            exx
                            ld a,(de)
                            rrca | rrca | rrca | rrca | and 0fh
                            ld c,a
                            ld a,(hl)
                            and 0f0h
                            or c
                            exx
                                ld (hl),a
                                add hl,de
                            exx
                            inc de
                            inc hl
                        dwnz
                        exx
                            ld de,1-GRamWidth*8
                            add hl,de
                        exx
                    else
                        exx
                            inc hl
                        exx
                    endif
                pop bc | pop de | pop hl
                inc hl | inc hl
                inc de | inc de
            dwnz
            exx
                ld de,GRamWidth*8-VramWidth/2
                add hl,de
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,Vram_
        ld de,VVramFront_
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            push de
                ld de,VramWidth-VVramWidth
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
