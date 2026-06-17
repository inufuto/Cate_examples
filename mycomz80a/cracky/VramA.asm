include "Port.inc"
include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramFront_, RowFlags_
ext PollVsync_

VramTop equ Vram+VramRowSize*0

dseg
Backup:
    defs VVramWidth * VVramHeight

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
        do
            ld a,l | out (VramAddressLow),a
            ld a,h | out (VramAddressHigh),a
            xor a | out (VramData),a
            inc hl
            dec bc
            ld a,c | or b
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
        
        call ClearRowFlags
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ex de,hl
            ld h,0
            add hl,hl
            ld bc,CharPattern | add hl,bc
        ex de,hl
        ld b,2
        do
            ld a,l | out (VramAddressLow),a
            ld a,h | out (VramAddressHigh),a
            ld a,(de) | inc de
            out (VramData),a
            inc hl
        dwnz
    pop bc | pop de | pop af
ret


; word PrintC(word vram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIKLMNOPRSTUVWY"
PrintC_: public PrintC_
    push af | push de | push bc
        ld a,e
        ex de,hl
            ld bc,33 shl 8
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
            ld l,c | ld h,0
            add hl,hl ; *2
            add hl,hl ; *4
            ld bc,AsciiPattern | add hl,bc
        ex de,hl
        ld c,2
        do
            ld b,2
            do
                ld a,l | out (VramAddressLow),a
                ld a,h | out (VramAddressHigh),a
                ld a,(de) | inc de
                out (VramData),a
                inc hl
            dwnz
            ld a,l | add a,VramRowSize-2 | ld l,a
            ld a,h | adc a,0 | ld h,a
            dec c
        while nz | wend
        ld de,2-VramRowSize*2 | add hl,de
    pop bc | pop de | pop af
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
    call PollVsync_
ret


; void VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,VramTop
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
            ld hl,VramTop
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
