include 'Vram.inc'


; void ClearSpriteRam();
ClearSpriteRam_: public ClearSpriteRam_
    push af | push hl | push de | push bc
        ld hl,SpriteRam
        ld e,0
        ld bc,PatternSize*256*3
        do
            ld (hl),e
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


CharToAddress:
; in
;   hl code
; out
;   hl pDestination
    push de
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld de,SpriteRam
        add hl,de
    pop de
ret

WidthToOffset:
; in
;   c width
; out
;   bc offset
    push af
        ld a,c
        add a,a ;*2
        add a,c ;*3
        add a,a ;*6
        add a,a ;*12
        add a,a ;*24
        sub 8
        ld c,a
        ld b,0
    pop af
ret


; void WritePattern(word c, ptr<byte> pSource);
WritePattern_: public WritePattern_
    push hl | push de | push bc
        call CharToAddress
        ex de,hl
        ld bc,PatternSize
        ldir
    pop bc | pop de | pop hl
ret


; void WritePatternH(word c, ptr<byte> pSource);
WritePatternH_: public WritePatternH_
    push af | push hl | push de | push bc
        call CharToAddress
        ld b,3
        do
            push bc
                push hl 
                    ld c,CharHeight
                    do
                        ld a,(de)
                        inc de
                        push de
                            exx
                                ld h,a
                                ld l,0
                                srl h | rr l 
                                srl h | rr l 
                                srl h | rr l 
                                srl h | rr l 
                                ld a,h
                            exx
                            or (hl)
                            ld (hl),a
                            ld de,PatternSize
                            add hl,de
                            exx
                                ld a,l
                            exx
                            or (hl)
                            ld (hl),a
                            ld de,-PatternSize+1
                            add hl,de
                        pop de
                        dec c
                    while nz | wend
                pop hl
                ld bc,CharHeight
                add hl,bc
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void WritePatternV(word c, ptr<byte> pSource, byte width);
WritePatternV_: public WritePatternV_
    push af | push hl | push de | push bc
        call CharToAddress
        call WidthToOffset
        inc hl
        inc hl
        inc hl
        inc hl

        ld a,3
        do
            push af | push hl
                ld a,2
                do
                    push bc
                        ex de,hl
                        ld bc,CharHeight/2
                        ldir
                        ex de,hl
                    pop bc
                    add hl,bc
                    dec a
                while nz | wend
            pop hl | pop af
            push bc
                ld bc,CharHeight
                add hl,bc
            pop bc
            dec a
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void WritePatternHV(word c, ptr<byte> pSource, byte width);
WritePatternHV_: public WritePatternHV_
    push af | push hl | push de | push bc
        call CharToAddress
        call WidthToOffset
        inc hl
        inc hl
        inc hl
        inc hl

        ld a,3
        do
            push af | push hl
                ld a,2
                do
                    push af | push bc
                        ld b,CharHeight/2
                        do
                            ld a,(de)
                            inc de
                            push de
                                exx
                                    ld h,a
                                    ld l,0
                                    srl h | rr l 
                                    srl h | rr l 
                                    srl h | rr l 
                                    srl h | rr l 
                                    ld a,h
                                exx
                                or (hl)
                                ld (hl),a
                                ld de,PatternSize
                                add hl,de
                                exx
                                    ld a,l
                                exx
                                or (hl)
                                ld (hl),a
                                ld de,-PatternSize+1
                                add hl,de
                            pop de
                        dwnz
                    pop bc | pop af
                    add hl,bc
                    dec a
                while nz | wend
            pop hl | pop af
            push bc
                ld bc,CharHeight
                add hl,bc
            pop bc
            dec a
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret