include 'BIOS.inc'
include 'Vram.inc'
include 'Chars.inc'

ext Chars, SpritePattern
ext VVram_, RowFlags_, Status_

cseg
ColorSource:
	defb 64, 0f0h
	defb 16, 70h
	defb 4, 0f0h
	defb 8, 0a0h
	defb 84, 70h
    defb 0

; void InitVram();
cseg
InitVram_: public InitVram_
    push af | push hl | push de | push bc
        ld hl,Chars
        ld de,Vram_PatternGenerator
        ld bc,(Char_Barrier-0)*CharHeight
        call LDIRVM

        ld hl,Vram_PatternGenerator+Char_Barrier*CharHeight
        ld b,8
        do
            ld a,8
            sub b
            if nz
                ld c,a
                do
                    xor a
                    call WRTVRM
                    inc hl
                    dec c
                while nz | wend
            endif
            
            ld a,0ffh
            call WRTVRM
            inc hl
            
            ld a,b
            dec a
            if nz
                ld c,a
                xor a
                do
                    call WRTVRM
                    inc hl
                    dec c
                while nz | wend
            endif
        dwnz

        ld hl,Vram_Color
        ld de,ColorSource
        do
            ld a,(de)
            or a
        while nz
            ld c,a
            inc de
            ld a,(de)
            inc de
            do
                ld b,8
                do
                    push af
                        call WRTVRM
                    pop af
                    inc hl
                dwnz
                dec c
            while nz | wend
        wend

        ld hl,Vram_PatternGenerator+800h
        exx
            ld hl,Vram_PatternGenerator
        exx
        ld c,2
        do
            ld b,2
            do
                ld de,800h
                do
                    exx
                        call RDVRM
                        inc hl
                    exx
                    call WRTVRM
                    inc hl
                    dec de
                    ld a,e
                    or d
                while nz | wend
            dwnz
            ld hl,Vram_Color+800h
            exx
                ld hl,Vram_Color
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
cseg
ClearScreen_:
    public ClearScreen_
    push af | push de | push bc
        ld hl,Vram_PatternName
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM
    pop bc | pop de | pop af
ret


; word VramAddress(byte x, byte y);
VramAddress_: public VramAddress_
    push de
        ld l,e
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,a
        ld d,0
        add hl,de
        ld de,Vram
        add hl,de
    pop de
ret


; void VPut(word vram, byte c);
cseg
VPut_: public VPut_
    ex af,af'
        ld a,e
        call WRTVRM
    ex af,af'
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    ex af,af'
        ld a,e
        sub ' '
        call WRTVRM
    ex af,af'
    inc hl
ret


VVramToVramRow:
    push bc
        ld a,(VdpOutPort)
        ld c,a
        di
            inc c
            out (c),l
            out (c),h
            dec c
            ld b,VVramWidth
            do
                ld a,(de)
                inc de
                out (c),a
            dwnz
        ei
        ld bc,VramWidth
        add hl,bc
    pop bc
ret


; void VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,VramTopLeft or 4000h
        ld c,VVramHeight
        do
            call VVramToVramRow
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void VVramToVramChanged();
VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,VramTopLeft or 4000h
        exx
            ld hl,RowFlags_
            ld c,1
            ld b,(hl)
            inc hl
        exx
        ld c,VVramHeight
        do
            exx
                ld a,b
                and c
            exx
            if nz
                call VVramToVramRow            
            else
                push bc
                    ld bc,VramWidth
                    add hl,bc
                    ex de,hl
                        ld bc,VVramWidth
                        add hl,bc
                    ex de,hl
                pop bc
            endif
            exx
                sla c
                if z
                    ld c,1
                    ld b,(hl)
                    inc hl
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


; void StatusToVram();
StatusToVram_: public StatusToVram_
cseg
    push af | push hl | push de | push bc
        ld hl, Status_
        ld de, Vram
        ld bc, VramWidth*2
        call LDIRVM
    pop bc | pop de | pop hl | pop af
ret
