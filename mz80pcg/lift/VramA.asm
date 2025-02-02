include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CharPattern

Char_PCG equ 80h
CharHeight equ 8
VramTop equ Vram+VramRowSize*1

dseg
Backup: defs VVramWidth*VVramHeight


cseg
SetPatterns:
    do
        ld a,(hl) | inc hl
        ld (0E010h),a
        ld a,e | ld (0E011h),a
        ld a,d | ld (0E012h),a
        or 10h | ld (0E012h),a
        and not 10h | ld (0E012h),a
        inc de
        dec bc
        ld a,c | or b
    while nz | wend
ret
InitVram: public InitVram
    ld hl,CharPattern
    ld de,000h
    ld bc,CharHeight*(Char_End-Char_PCG)
    call SetPatterns
ret


cseg
WaitVBlank:
    ex af,af'
        do 
            ld a,(0e002h)
            and 80h
        while nz | wend
    ex af,af'
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
        ld hl,Vram
        ld bc,VramWidth*VramHeight
        call Clear

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
        ld c, VVramHeight ; vertical count    
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    call WaitVBlank
                    exx
                        ld (hl),a
                    exx
                endif
                inc hl
                exx
                    inc hl
                exx
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
    defb 0,61h,62h,63h,64h,65h,66h,67h,68h,69h,6bh,6ah,2fh,2ah,2eh,2dh
    defb 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,4fh,2ch,51h,2bh,57h,49h
    defb 55h,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
    defb 16,17,18,19,20,21,22,23,24,25,26,52h,59h,54h,46h,3ch
PrintC_: public PrintC_
    push af
        ld a,e
        exx
            ld l,a
            ld h,0
            ld de,CharTable - ' '
            add hl,de
            ld a,(hl)
        exx
        ld (hl),a
        inc hl
    pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
Put_: public Put_
    ld (hl),e
    inc hl
ret
