include 'BIOS.inc'
include 'Vram.inc'

Char_Barrier equ 00h
Char_Fighter equ 04h
Char_Map equ 08h
Char_Logo equ 10h
Char_Ascii equ ' '
Char_Fort equ 60h
Char_Star equ 0f0h

FortSize equ 6
WindowWidth equ 24
WindowHeight equ 24

ext FortPattern, BarrierPattern, FighterPattern, MapPattern, LogoPattern, AsciiPattern

cseg

ColorSource:
    defb Char_Barrier, 0a0h, 4
    defb Char_Fighter, 0f0h, 4
    defb Char_Map, 74h, 2
    defb Char_Logo, 70h, 16
    defb Char_Ascii, 0f0h, 40h
    defb Char_Fort, 70h, 6*6*4
    defb Char_Star, 0f0h, 16


SetAddress:
    ld a,(VdpOutPort)
    ld c,a
    inc c
    out (c),l
    out (c),h
    dec c
ret

CopyPattern:
    do
        ld a,(hl)
        inc hl
        out (c),a
        dec de
        ld a,e
        or d
    while nz | wend
ret


InitFormPattern:
    di
        ld hl,(Vram_PatternGenerator+Char_Fort*8) or 4000h
        call SetAddress

        ;   gap 0,0
        ld hl,FortPattern
        ld de,FortSize*FortSize*8
        call CopyPattern

        ; gap 1,0
        ld ix,FortPattern
        ld d,FortSize
        do
            ld b,8
            do
                ld a,(ix)
                inc ix
                srl a | srl a | srl a | srl a 
                out (c),a
            dwnz
            ld e,FortSize-1
            do
                push de
                    ld b,8
                    do
                        ld d,(ix-8)
                        ld e,(ix)
                        inc ix
                        srl d | rr e
                        srl d | rr e
                        srl d | rr e
                        srl d | rr e
                        out (c),e
                    dwnz
                pop de
                dec e
            while nz | wend
            dec d
        while nz | wend

        ; gap 0,1
        ld ix,FortPattern

        ld e,FortSize
        do
            ld b,4
            do
                xor a
                out (c),a
                nop
            dwnz
            ld b,4
            do
                ld a,(ix)
                inc ix
                out (c),a
            dwnz
            inc ix | inc ix | inc ix | inc ix
            dec e
        while nz | wend

        ld d,FortSize-1
        do
            ld e,FortSize
            do
                ld b,4
                do
                    ld a,(ix-FortSize*8+4)
                    inc ix
                    out (c),a
                dwnz
                dec ix | dec ix | dec ix | dec ix
                ld b,4
                do
                    ld a,(ix)
                    inc ix
                    out (c),a
                dwnz
                inc ix | inc ix | inc ix | inc ix
                dec e
            while nz | wend
            dec d
        while nz | wend

        ; gap 1,1
        ld ix,FortPattern

        ld b,4
        do
            xor a
            out (c),a
            nop
        dwnz
        ld b,4
        do
            ld a,(ix)
            inc ix
            srl a | srl a | srl a | srl a 
            out (c),a
        dwnz
        inc ix | inc ix | inc ix | inc ix

        ld e,FortSize-1
        do
            push de
                ld b,4
                do
                    xor a
                    out (c),a
                    nop
                dwnz
                ld b,4
                do
                    ld d,(ix-8)
                    ld e,(ix)
                    inc ix
                    srl d | rr e
                    srl d | rr e
                    srl d | rr e
                    srl d | rr e
                    out (c),e
                dwnz
                inc ix | inc ix | inc ix | inc ix
            pop de
            dec e
        while nz | wend

        ld d,FortSize-1
        do
            ld b,4
            do
                xor a
                out (c),a
                nop
            dwnz
            ld b,4
            do
                ld a,(ix)
                inc ix
                srl a | srl a | srl a | srl a 
                out (c),a
            dwnz
            inc ix | inc ix | inc ix | inc ix

            ld e,FortSize-1
            do
                push de
                    ld b,4
                    do
                        ld d,(ix-FortSize*8+4-8)
                        ld e,(ix-FortSize*8+4)
                        inc ix
                        srl d | rr e
                        srl d | rr e
                        srl d | rr e
                        srl d | rr e
                        out (c),e
                    dwnz
                    dec ix | dec ix | dec ix | dec ix
                    ld b,4
                    do
                        ld d,(ix-8)
                        ld e,(ix)
                        inc ix
                        srl d | rr e
                        srl d | rr e
                        srl d | rr e
                        srl d | rr e
                        out (c),e
                    dwnz
                    inc ix | inc ix | inc ix | inc ix
                pop de
                dec e
            while nz | wend
            dec d
        while nz | wend
    ei
ret


InitStarPattern:
    di
        ld hl,(Vram_PatternGenerator+Char_Star*8) or 4000h
        call SetAddress
        ld d,0 
        do
            ld e,80h
            do
                xor a
                ld b,0
                do
                    cp d
                    if z
                        out (c),e
                    else
                        out (c),b
                    endif
                    inc a
                    cp 8
                while nz | wend                    
                srl e
                srl e
            while nz | wend
            inc d
            inc d
            ld a,d
            cp 8
        while nz | wend
    ei
ret


; void InitPattern();
InitPattern_: public InitPattern_
    push af | push hl | push de | push bc
        call InitStarPattern
        call InitFormPattern

        di
            ld hl,(Vram_PatternGenerator+Char_Barrier*8) or 4000h
            call SetAddress
            ld hl,BarrierPattern
            ld de,8*4
            call CopyPattern

            ld hl,(Vram_PatternGenerator+Char_Fighter*8) or 4000h
            call SetAddress
            ld hl,FighterPattern
            ld de,8*4
            call CopyPattern

            ld hl,(Vram_PatternGenerator+Char_Map*8) or 4000h
            call SetAddress
            ld hl,MapPattern
            ld de,8*2
            call CopyPattern

            ld hl,(Vram_PatternGenerator+Char_Logo*8) or 4000h
            call SetAddress
            ld hl,LogoPattern
            ld de,8*16
            call CopyPattern

            ld hl,(Vram_PatternGenerator+Char_Ascii*8) or 4000h
            call SetAddress
            ld hl,AsciiPattern
            ld de,40h*8
            call CopyPattern

            ld hl,ColorSource
            ld b, 7
            do
                ld a,(hl) | inc hl
                ld e,(hl) | inc hl
                ld d,(hl) | inc hl
                push hl
                    ld l,a | ld h,0
                    add hl,hl   ; *2
                    add hl,hl   ; *4
                    add hl,hl   ; *8
                    push de
                        ld de,Vram_Color or 4000h
                        add hl,de
                    pop de
                    call SetAddress
                    ld l,d | ld h,0
                    add hl,hl   ; *2
                    add hl,hl   ; *4
                    add hl,hl   ; *8
                    do
                        out (c),e
                        dec hl
                        ld a,l
                        or h
                    while nz | wend
                pop hl
            dwnz
        ei

        ld hl,Vram_PatternGenerator+2048
        ld b,2
        do
            ld de,2048
            exx
                ld hl,Vram_PatternGenerator
            exx
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
        
        ld hl,Vram_Color+2048
        ld b,2
        do
            ld de,2048
            exx
                ld hl,Vram_Color
            exx
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
    pop bc | pop de | pop hl | pop af
ret


ClearScreen_:
    public ClearScreen_
    push af | push de | push bc
        ld hl,Vram_PatternName
        ld bc,VramHeight*VramWidth
        ld a,' '
        call FILVRM
    pop bc | pop de | pop af
ret


ext Window_
;   void WindowToVram();
WindowToVram_: public WindowToVram_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort)
        ld c,a
        di
            exx
                ld hl,Vram_PatternName or 4000h
                ld de,VramWidth
                ld c,a
                inc c
            exx
            ld hl,Window_
            ld e,WindowHeight
            do
                exx
                    out (c),l
                    out (c),h
                exx
                ld b,WindowWidth
                do
                    ld a,(hl) | inc hl
                    out (c),a
                dwnz
                exx
                    add hl,de
                exx
                dec e
            while nz | wend
        ei
    pop bc | pop de | pop hl | pop af
ret


PrintC_: public PrintC_
    push af | push de
        ld a,e
        call WRTVRM
    pop de | pop af
    inc hl
ret


VPut2_:
    public VPut2_
    push af
    push hl
    push de
    push bc
        set 6,h
        ld a,(VdpOutPort)
        ld c,a
        ld b,2
        do
            di
                inc c
                out (c),l
                out (c),h
                dec c
                out (c),e
                nop
                inc e
                out (c),e
                nop
                inc e
            ei
            push de
                ld de,VramWidth
                add hl,de
            pop de
        dwnz
    pop bc
    pop de
    pop hl
    pop af
ret


VErase2_:
    public VErase2_
    push af
    push hl
    push de
    push bc
        set 6,h
        ld a,(VdpOutPort)
        ld c,a
        ld a,' '
        ld de,VramWidth
        ld b,2
        do
            di
            inc c
            out (c),l
            out (c),h
            dec c
            out (c),a
            nop | nop | nop
            out (c),a
            ei
            add hl,de
        dwnz
    pop bc
    pop de
    pop hl
    pop af
ret


VPut4_:
    public VPut4_
    push af
    push hl
    push de
    push bc
        set 6,h
        ld a,(VdpOutPort)
        ld c,a
        ld b,4
        do
            di
                inc c
                out (c),l
                out (c),h
                dec c
                push bc
                    ld b,4
                    do 
                            ld a,(de)
                            inc de
                            out (c),a
                    dwnz
                    push de
                        ld de,VramWidth
                        add hl,de
                    pop de
                pop bc
            ei
        dwnz
    pop bc
    pop de
    pop hl
    pop af
ret
