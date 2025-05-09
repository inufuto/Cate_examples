include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern
ext VVramBack_, VVramFront_

GdcParamPort equ 38h
GdcCmdPort equ 39h

ResetCmd equ 00h
SyncCmd equ 0fh
WDatCmd equ 20h
PitchCmd equ 47h
CursCmd equ 49h
VSyncCmd equ 6fh
PRamCmd equ 70h

dseg
Backup: public Backup
    defs VVramWidth*VVramHeight
CharRam: public CharRam
    defs 2*CharHeight*Char_End

cseg
InitVram: public InitVram
    push af | push hl | push de | push bc
        ld a,PRamCmd
        out (GdcCmdPort),a
        xor a
        out (GdcParamPort),a
        out (GdcParamPort),a
        out (GdcParamPort),a
        ld a,7fh  
        out (GdcParamPort),a

        ld hl,CharPattern
        ld de,CharRam
        ld bc,Char_End*CharHeight/2
        do
            push bc
                ld c,(hl) | inc hl
                push hl
                    ld hl,0
                    ld b,8
                    do
                        add hl,hl | add hl,hl
                        srl c
                        if c
                            ld a,l | or 3 | ld l,a
                        endif
                    dwnz
                    ld a,l | ld (de),a | inc de
                    ld a,h | ld (de),a | inc de
                pop hl
            pop bc
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


cseg
SetAddress:
    ld a,CursCmd | out (GdcCmdPort),a
    ld a,l | out (GdcParamPort),a
    ld a,h | out (GdcParamPort),a
ret

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
    push af | push hl | push bc
        ld hl,Vram
        call SetAddress

        ld a,WDatCmd | out (GdcCmdPort),a
        ld bc,VramRowSize*VramHeight*2
        do
            xor a | out (GdcParamPort),a
            dec bc
            ld a,c | or b
        while nz | wend
        
        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop hl | pop af
ret



; word Put(word vram, byte c);
cseg
PutE:
    push hl | push bc
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            ld bc,CharRam
            add hl,bc
        ex de,hl

        ld c,CharHeight/2
        do
            ld b,2
            do
                call SetAddress

                ld a,WDatCmd | out (GdcCmdPort),a
                ld a,(de) | inc de | out (GdcParamPort),a
                ld a,(de) | dec de | out (GdcParamPort),a
                push de
                    ld de,VramWidth
                    add hl,de
                pop de
            dwnz
            inc de | inc de
            dec c
        while nz | wend
    pop bc | pop hl
ret
Put_: public Put_
    push af | push de
        call PutE
    pop de | pop af
    inc hl
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
                                call PutE
                            pop de
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
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
