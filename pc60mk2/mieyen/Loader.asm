include "BinSize.inc"

Top equ 8200h
SectorSize equ 256
SectorCount equ (BinSize+SectorSize-1)/SectorSize

dseg
bytes:
    defs 28
cseg
ipl:
    defb 'SYS'

    di
        ld ix,bytes
        ld (ix),0
        ld (ix+27),10

        ld de,Top
        ld bc,0002h
        ld l,SectorCount
        ld a,16-1
        do
            cp l
            if nc
                ld a,l
            endif
            or a
            push de
                call 4274h
            pop de
            push hl
                ex de,hl
                    ld d,a
                    ld e,0
                    add hl,de
                ex de,hl
            pop hl
            inc b
            ld c,1
            ld h,a
            ld a,l
            sub h
            ld l,a
            ld a,16
        while nz | wend

        ; ld a,0ffh
        ; out (0f1h),a
    ei
    ld sp,ipl
jp Top
