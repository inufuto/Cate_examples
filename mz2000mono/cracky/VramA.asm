include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern
ext VVramFront_, RowFlags_

Text equ 0d000h
VramTop equ Vram

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
PatternAddress:
    push de
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        ld de,PatternRam
        add hl,de
    pop de
ret


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
    push af | push hl | push de | push bc
        ld a,0c0h
        out (0e8h),a

        ld hl,Text
        ld bc,2000
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend

        ld a,080h
        out (0e8h),a

        ; di
            ld a,1
            do
                out (0f7h),a
                ld hl,0c000h
                ld de,0c001h
                ld bc,640/8*200-1
                ld (hl),0
                ldir
                inc a
                cp 4
            while nz | wend
            xor a
            out (0f7h),a
        ; ei

        ld hl,Backup
        ld bc,VVramWidth * VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
        call ClearRowFlags
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put:
    ex de,hl
        call PatternAddress
    ex de,hl
    ; di
        ld a,1
        do
            out (0f7h),a
            ex af,af'
                ld a,CharHeight
                ld bc,VramWidth-1
                do
                    ld i,a
                    ; ld (Put_count+1),a
                    ld a,(de) | inc de
                    ld (hl),a | inc hl
                    ld a,(de) | inc de
                    ld (hl),a | add hl,bc
                    ld a,i
                    dec a
                while nz | wend
                ld bc,-VramWidth*CharHeight
                add hl,bc
            ex af,af'
            inc a
            cp 4
        while nz | wend
        xor a
        out (0f7h),a
    ; ei
ret

Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        call Put
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
