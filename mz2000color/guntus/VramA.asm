include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPatternSource_, ColorPatternSource_
ext VVramFront_, RowFlags_

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
MakeDouble:
    ld bc,00300h
    do
        rrca
        if c
            ex af,af'
                ld a,c
                or b
                ld c,a
            ex af,af'
        endif
        sla b | sla b
    while nz | wend
ret


; void InitMonoPattern();
cseg
Colors:
    defb 64,0fh
    defb 16,05h
    defb 2,07h
    defb 1,06h
    defb 0
InitMonoPattern_: public InitMonoPattern_
    push af | push hl | push de | push bc
        ld hl,PatternRam
        ld de,MonoPatternSource_
        ld bc,Colors
        do
            ld a,(bc) | inc bc
            or a
        while nz
            exx
                ld e,a ; count
            exx
            ld a,(bc) | inc bc ; color
            push bc
                exx
                    ld b,a ; color
                    ld a,e ; count
                exx
                ld b,a ; count
                do
                    exx
                        ld d,b ; color
                    exx
                    ld c,3
                    do
                        push de | push bc
                            ld b,8
                            do
                                ld a,(de)
                                exx
                                    ld e,0
                                    bit 0,d
                                    if nz
                                        or e
                                        ld e,a
                                    endif
                                exx
                                ld a,(de) | inc de
                                exx
                                    bit 4,d
                                    if nz
                                        cpl
                                        or e
                                        ld e,a
                                    endif
                                    ld a,e
                                exx
                                push bc
                                    call MakeDouble
                                    ld (hl),c | inc hl
                                    call MakeDouble
                                    ld (hl),c | inc hl
                                pop bc
                            dwnz
                        pop bc | pop de
                        exx
                            srl d
                        exx
                        dec c
                    while nz | wend
                    push bc
                        ex de,hl
                            ld bc,CharHeight
                            add hl,bc
                        ex de,hl
                    pop bc
                dwnz
            pop bc
        wend
    pop bc | pop de | pop hl | pop af
ret


; void InitColorPattern();
cseg
InitColorPattern_: public InitColorPattern_
    push af | push hl | push de | push bc
        ld hl,PatternRam+CharHeight*3*2*Char_Enemy
        ld de,ColorPatternSource_
        ld bc,(Char_End-Char_Enemy)*CharHeight*3
        do
            push bc
                ld a,(de) | inc de
                call MakeDouble
                ld (hl),c | inc hl
                call MakeDouble
                ld (hl),c | inc hl
            pop bc
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        di
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
        ei

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
            ld c,l
            ld b,h
            add hl,hl ;*2
            add hl,bc ;*3
            add hl,hl ;*6
            add hl,hl ;*12
            add hl,hl ;*24
            add hl,hl ;*48
            ld bc,PatternRam
            add hl,bc
        ex de,hl
        di
            ld a,1
            do
                push af
                    out (0f7h),a
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
                pop af
                inc a
                cp 4
            while nz | wend
            xor a
            out (0f7h),a
        ei
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
