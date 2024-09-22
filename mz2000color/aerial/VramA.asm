include 'Vram.inc'
include 'VVram.inc'

ext VVramFront_, RowFlags_

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


; void VPut(word vram, byte c);
cseg
VPut_: public VPut_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            call PatternAddress
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
                        call VPut_
                    pop de
                exx
            endif
            exx
                inc hl
                inc hl
            exx
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
