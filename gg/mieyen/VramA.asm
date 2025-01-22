include "Vdp.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern,SpritePattern
ext VVram_

ext SetVdpAddressHL
ext WRTVRM
ext RDVRM
ext FILVRM
ext WRTVDP

dseg
Backup: public Backup
    defs VVramWidth*VVramHeight

cseg
OutW:
    out (VdpPort),a
    nop | nop | nop
    xor a | out (VdpPort),a
    nop | nop | nop
ret
InitVram: public InitVram
    ld hl,Vram_PatternName
    call SetVdpAddressHL
    ld b,32*(3+3)
    do
        ld a,0ffh | call OutW
    dwnz
    ld e,0
    ld c,13
    do
        ld b,7
        do
            ld a,0feh | call OutW
        dwnz
        ld b,18
        do
            ld a,e | call OutW
            inc e
        dwnz
        ld b,7
        do
            ld a,0ffh | call OutW
        dwnz
        dec c
    while nz | wend
    ld b,32*2
    do
        ld a,0ffh | call OutW
    dwnz

    ld hl,Vram_SpritePatternGenerator
    call SetVdpAddressHL
    ld hl,SpritePattern
    ld c,Pattern_End*2
    do
        ld b,4*12
        do
            ld a,(hl) | inc hl
            out (VdpPort),a
            nop | nop | nop
        dwnz
        xor a
        ld b,4*4
        do
            out (VdpPort),a
            nop | nop | nop
        dwnz
        dec c
    while nz | wend
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
        ld hl,0
        ld bc,2000h
        xor a
        call FILVRM

        ld hl,Vram_SpriteAttribute
        ld bc,64
        ld a,0c8h
        call FILVRM

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVram_
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


cseg
Put0:
    do
        ld b,PlaneCount
        do
            push bc
                call RDVRM
                and 03h | ld c,a
                ld a,(de) | inc de
                or c
                call WRTVRM
                inc hl
            pop bc
        dwnz
        dec c
    while nz | wend
ret
Put2:
    do
        ld b,PlaneCount
        do
            push bc
                call RDVRM
                and 0c0h | ld c,a
                ld a,(de) | inc de
                rrca | rrca
                or c
                call WRTVRM
                inc hl
            pop bc
        dwnz
        dec c
    while nz | wend
ret
Put4:
    do
        ld b,PlaneCount
        do
            push bc
                call RDVRM
                and 0f0h | ld c,a
                ld a,(de)
                rrca | rrca | rrca | rrca
                and 0fh
                or c
                call WRTVRM
                push de
                    ld de,8*PlaneCount
                    add hl,de
                pop de
                call RDVRM
                and 3fh | ld c,a
                ld a,(de)
                rlca | rlca | rlca | rlca
                and 0c0h
                or c
                call WRTVRM
                push de
                    ld de,1-8*PlaneCount
                    add hl,de
                pop de
                inc de
            pop bc
        dwnz
        dec c
    while nz | wend
ret
Put6:
    do
        ld b,PlaneCount
        do
            push bc
                call RDVRM
                and 0fch | ld c,a
                ld a,(de)
                rlca | rlca
                and 03h
                or c
                call WRTVRM
                push de
                    ld de,8*PlaneCount
                    add hl,de
                pop de
                call RDVRM
                and 0fh | ld c,a
                ld a,(de)
                rlca | rlca
                and 0f0h
                or c
                call WRTVRM
                push de
                    ld de,1-8*PlaneCount
                    add hl,de
                pop de
                inc de
            pop bc
        dwnz
        dec c
    while nz | wend
ret
; hl=destination, de=source
Put00:
    ld c,CharHeight
    call Put0
    ; ld de,-CharHeight*PlaneCount
    ; add hl,de
ret
Put20:
    ld c,CharHeight
    call Put2
    ; ld de,(8-CharHeight)*PlaneCount
    ; add hl,de
ret
Put40:
    ld c,CharHeight
    call Put4
ret
Put60:
    ld c,CharHeight
    call Put6
ret
Put04:
    ld c,4
    call Put0
    push de
        ld de,(8*18-8)*PlaneCount
        add hl,de
    pop de
    ld c,2
    call Put0
ret
Put24:
    ld c,4
    call Put2
    push de
        ld de,(8*18-8)*PlaneCount
        add hl,de
    pop de
    ld c,2
    call Put2
ret
Put44:
    ld c,4
    call Put4
    push de
        ld de,(8*18-8)*PlaneCount
        add hl,de
    pop de
    ld c,2
    call Put4
ret
Put64:
    ld c,4
    call Put6
    push de
        ld de,(8*18-8)*PlaneCount
        add hl,de
    pop de
    ld c,2
    call Put6
ret
Put06:
    ld c,2
    call Put0
    push de
        ld de,(8*18-8)*PlaneCount
        add hl,de
    pop de
    ld c,4
    call Put0
ret
Put26:
    ld c,2
    call Put2
    push de
        ld de,(8*18-8)*PlaneCount
        add hl,de
    pop de
    ld c,4
    call Put2
ret
Put46:
    ld c,2
    call Put4
    push de
        ld de,(8*18-8)*PlaneCount
        add hl,de
    pop de
    ld c,4
    call Put4
ret
Put66:
    ld c,2
    call Put6
    push de
        ld de,(8*18-8)*PlaneCount
        add hl,de
    pop de
    ld c,4
    call Put6
ret

PatternPtr: ; e->de
    push hl
        ld d,0
        ld l,e | ld h,d
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld de,CharPattern
        add hl,de
        ex de,hl
    pop hl
ret
        

; word Put(word vram, byte c);
cseg
YTable:
    defw 0h,18h,250h,488h,6C0h,6D8h,910h,0B48h,0D80h,0D98h,0FD0h,1208h,1440h,1458h,1690h,18C8h,1B00h
XTable:
    defw 0,0,32,64,96,96,128,160,192,192,224,256,288,288,320,352,384,384,416,448,480,480,512,544
Put_: public Put_
    push af | push hl | push de | push bc
        ld c,l | ld b,h
        call PatternPtr
        push de
            ld a,b ;y
            add a,a ;*2
            ld e,a | ld d,0
            ld hl,YTable |  add hl,de
            ld a,(hl) | inc hl
            ld h,(hl) | ld l,a
            push hl
                ld a,c ;x
                add a,a ;*2
                ld e,a | ld d,0
                ld hl,XTable
                add hl,de
                ld a,(hl) | inc hl
                ld h,(hl) | ld l,a
            pop de
            add hl,de
        pop de
        ld a,b | and 3
        if z
            Put_y0:
            ld a,c | and 3
            if z
                call Put00
                jr Put_exit
            endif
            dec a
            if z
                call Put60
                jr Put_exit
            endif
            dec a
            if z
                call Put40
                jr Put_exit
            endif
            call Put20
            jr Put_exit
        endif
        dec a
        if z
            ld a,c | and 3
            if z
                call Put06
                jr Put_exit
            endif
            dec a
            if z
                call Put66
                jr Put_exit
            endif
            dec a
            if z
                call Put46
                jr Put_exit
            endif
            call Put26
            jr Put_exit
        endif
        dec a
        if z
            ld a,c | and 3
            if z
                call Put04
                jr Put_exit
            endif
            dec a
            if z
                call Put64
                jr Put_exit
            endif
            dec a
            if z
                call Put44
                jr Put_exit
            endif
            call Put24
            jr Put_exit
        endif
        jr Put_y0
        Put_exit:
    pop bc | pop de | pop hl | pop af
    inc l
ret


; void VVramToVram();
SkipHL:
    exx
        ld de,8*PlaneCount
        add hl,de
    exx
ret
VVramToVramRow0:
VVramToVramRow2:
    ld b,VVramWidth/4
    do
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put00
                ld de,(-6)*PlaneCount
                add hl,de
            exx
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put60
                ld de,(-6+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put40
                ld de,(-6+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put20
                ld de,(-6+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
    dwnz
ret
VVramToVramRow4:
    ld b,VVramWidth/4
    do
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put04
                ld de,(-2-8*18+4)*PlaneCount
                add hl,de
            exx
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put64
                ld de,(-2-8*18+4+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put44
                ld de,(-2-8*18+4+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put24
                ld de,(-2-8*18+4+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
    dwnz
    exx
        ld de,-2*PlaneCount
        add hl,de
    exx
ret
VVramToVramRow6:
    ld b,VVramWidth/4
    do
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put06
                ld de,(-4-8*18+6)*PlaneCount
                add hl,de
            exx
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put66
                ld de,(-4-8*18+6+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put46
                ld de,(-4-8*18+6+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
        ld a,(de) | inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                ld e,a
                call PatternPtr
                call Put26
                ld de,(-4-8*18+6+8)*PlaneCount
                add hl,de
            exx
        else
            call SkipHL
        endif
        inc hl
    dwnz
    exx
        ld de,-2*PlaneCount
        add hl,de
    exx
ret
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,(18*8+4)*PlaneCount
        exx
        call VVramToVramRow4
        call VVramToVramRow2
        exx
            ld de,-2*PlaneCount
            add hl,de
        exx
        ld c,VVramHeight/4
        do
            call VVramToVramRow0
            exx
                ld de,(6-8*18)*PlaneCount
                add hl,de
            exx
            call VVramToVramRow6
            call VVramToVramRow4
            call VVramToVramRow2
            exx
                ld de,-2*PlaneCount
                add hl,de
            exx
            dec c
        while nz | wend
        call VVramToVramRow0
    pop bc | pop de | pop hl | pop af
ret
