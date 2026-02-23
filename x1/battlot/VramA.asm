include 'Vram.inc'

VVramWidth    equ 32
VVramHeight    equ 22

VramTop equ Vram+VramWidth

ext VVramFront_, VVramBack_, RowFlags_
ext ClearVVramFront_
ext PollVSync_


cseg
WaitVSync_: public WaitVSync_
    push af | push bc
        ld bc,1a01h
        do
            in a,(c)
            and 80h
        while z | wend
        do
            in a,(c)
            and 80h
        while nz | wend
    pop bc | pop af
ret

FillVramExtra:
    ld bc,VRAM+VramWidth*VramHeight
    ld d,20h
    do
        out (c),e
        res 4,b
        out (c),d
        set 4,b
        inc bc
        ld a,c
        or a
    while nz | wend
ret

WriteCG:
    ld d,8
    di
        call WaitVSync_
        WriteCG0:
            ld a,(hl)
            out (c),a
            inc hl
            inc bc
            nop
            inc hl
            dec hl
            ld a,13
            WriteCG1:
                dec a
            jp nz,WriteCG1
            dec d
        jp nz,WriteCG0
    ei
ret

SetPcg: public SetPcg
; a: char code
; hl: pPattern
    push af | push hl | push de | push bc
        ld e,a
        ld bc,Attributes
        ld a,Attribute_PCG or 7
        out (c),a
        ld bc,VRAM
        out (c),e

        call FillVramExtra
        ld bc,1500h
        do 
            call WriteCG
            inc b
            ld a,b
            cp 18h
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void SetPcgColor(byte code, ptr<byte> pPattern, byte count);
cseg
SetPcgColor_: public SetPcgColor_
    push af | push hl | push de | push bc
        ex de,hl
        ld de,PatternSize
        do
            call SetPcg
            add hl,de
            inc a
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void SetPcgMono(byte code, ptr<byte> pPattern, byte color, byte count);
dseg
    SetPcgMono_@Param3: public SetPcgMono_@Param3
        defb 0
    tempPattern:
        defs 24
cseg
SetPcgMono_: public SetPcgMono_
    push af | push hl | push de | push bc
        ex af,af'
            ld a,(SetPcgMono_@Param3)
            ld b,a
        ex af,af'
        do
            push bc
                push af
                    exx
                        ld hl,tempPattern
                    exx
                    ld b,3
                    do 
                        push de
                            ld h,8
                            do
                                ld l,0
                                ld a,(de)
                                bit 0,c
                                if nz
                                    or l
                                    ld l,a
                                endif
                                bit 4,c
                                if nz
                                    cpl
                                    or l
                                    ld l,a
                                endif
                                ld a,l
                                exx
                                    ld (hl),a
                                    inc hl
                                exx
                                inc de
                                dec h
                            while nz | wend
                        pop de
                        srl c
                    dwnz
                pop af
                ld hl,tempPattern
                call SetPcg
                ex de,hl
                    ld de,8
                    add hl,de
                ex de,hl
            pop bc
            inc a
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld bc,Vram
        ld hl,VramWidth*VramHeight
        do
            xor a
            out (c),a
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend

        ld bc,Attributes
        ld hl,VramWidth*VramHeight
        do
            ld a,Attribute_PCG or 7
            out (c),a
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend
    pop bc | pop hl | pop af
ret

VVramToVramRow:
; hl: pVVram
; bc: pVram
    ; push bc
            ld e,VVramWidth
            do
                ld a,(hl)
                inc hl
                out (c),a
                inc bc
                dec e
            while nz | wend
            ld a,c
            add a,VramWidth-VVramWidth
            ld c,a
            ld a,b
            adc a,0
            ld b,a
    ; pop bc
ret

; VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    push af | push hl | push de | push bc
        ld hl,VVramFront_
        ld bc,VramTop
        ld d,VVramHeight
        do
            call PollVSync_
            call VVramToVramRow
            dec d
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret



; void VVramToVramChanged();
cseg
VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc
        ld hl,VVramFront_
        ld bc,VramTop
        exx
            ld hl,RowFlags_
            ld c,1
            ld b,(hl)
            inc hl
        exx
        ld d,VVramHeight ; vertical count    
        do
            push de
                exx
                    ld a,b
                    and c
                exx
                if nz
                    call VVramToVramRow         
                else
                    ld a,c
                    add a,VramWidth
                    ld c,a
                    ld a,b
                    adc a,0
                    ld b,a
                    ld de,VVramWidth
                    add hl,de
                endif
                exx
                    rlc c
                    if c
                        ld b,(hl)
                        inc hl
                    endif
                exx
            pop de
            dec d
        while nz | wend

        xor a
        ld (RowFlags_),a
        ld (RowFlags_+1),a
        ld (RowFlags_+2),a
    pop bc | pop de | pop hl | pop af
ret


; void VPut(word vram, byte c);
cseg
VPut_: public VPut_
    push af | push bc
        ld a,e
        ld c,l
        ld b,h
        out (c),a
    pop bc | pop af
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    push af | push bc
        ld a,e
        sub ' '
        ld c,l
        ld b,h
        out (c),a
        inc hl
    pop bc | pop af
ret
