include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_

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
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,hl ;*48
        ld de,PatternRam
        add hl,de
    pop de
ret


; void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
dseg
    MakePatternMono_@Param3: public MakePatternMono_@Param3
    defb 0
cseg
MakePatternMono_: public MakePatternMono_
    push af | push hl | push de | push bc
        exx
            call PatternAddress
        exx
        do
            ld a,(MakePatternMono_@Param3)
            exx
                ld d,a
            exx
            ld b,3
            do
                push de
                    ld h,8
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
                        ld a,(de)
                        exx
                            bit 4,d
                            if nz
                                cpl
                                or e
                                ld e,a
                            endif
                            ld a,e
                            ld e,2
                            do
                                ld bc,400h
                                do
                                    srl c
                                    srl c
                                    rlca
                                    if c
                                        set 7,c
                                        set 6,c
                                    endif
                                dwnz
                                ld (hl),c
                                inc hl
                                dec e
                            while nz | wend
                        exx
                        inc de
                        dec h
                    while nz | wend
                    exx
                        srl d
                    exx
                pop de
            dwnz    
            ex de,hl
                ld de,8
                add hl,de
            ex de,hl
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void MakePatternColor(byte c, ptr<byte> pSource, byte count);
cseg
MakePatternColor_: public MakePatternColor_
    push af | push hl | push de | push bc
        exx
            call PatternAddress
        exx
        do
            ld b,24
            do
                ld a,(de)
                inc de
                exx
                    ld e,2
                    do
                        ld bc,400h
                        do
                            srl c
                            srl c
                            rlca
                            if c
                                set 7,c
                                set 6,c
                            endif
                        dwnz
                        ld (hl),c
                        inc hl
                        dec e
                    while nz | wend
                exx
            dwnz
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
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


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc | push ix
        ld de,VVram_
        ld hl,Backup
        ld ix,Text
        exx
            ld hl,VramTop
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                                _deb : public _deb
                cp Char_Floor
                if z
                    ld a,1eh            ;ld a,5fh
                    wch:
                    ex af,af'
                        ld a,0c0h | out (0e8h),a
                    ex af,af'
                    ld (ix),a
                    ex af,af'
                        ld a,80h | out (0e8h),a
                    ex af,af'
                    xor a
                    jr wchex
                endif
                cp Char_Wall
                if z
                    ld a,1eh
                    jr wch
                endif
                cp Char_Space
                jr z,wch
                ex af,af'
                    ld a,0c0h | out (0e8h),a
                ex af,af'
                ld (ix),0
                ex af,af'
                    ld a,80h | out (0e8h),a
                ex af,af'
                wchex:
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call Put
                    exx
                endif
                exx
                    inc hl
                    inc hl
                exx
                inc hl
                inc ix
            dwnz
            exx
                ld bc,VramRowSize-VVramWidth*2
                add hl,bc
                ld bc,40-VVramWidth
                add ix,bc
            exx
            dec c
        while nz | wend
    pop ix | pop bc | pop de | pop hl | pop af
ret
