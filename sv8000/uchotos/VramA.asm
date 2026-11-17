include "sv8000.inc"
include "Vram.inc"

ext AsciiPattern, CharPattern

VBuffer_position equ 0
VBuffer_pattern equ 2
VBuffer_unitSize equ 4
VBufferCount equ 64

dseg
VBuffer: public VBuffer
    defs VBuffer_unitSize * VBufferCount
VBufferIndex:
    defb 0
cseg
InitVram: public InitVram
    ld a,Psg_Mixer | out (PsgAddressPort),a
    ld a,0ffh | out (PsgDataPort),a

    ld a,Psg_IoA | out (PsgAddressPort),a
    ld a,3ah | out (PsgDataPort),a
ret

; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,ActualVram
        ld bc,600h
        call Clear

        xor a | ld (VBufferIndex),a
    pop bc | pop de | pop hl | pop af
ret

cseg
NextLine:
    ld a,l | add a,ActualVramWidth | ld l,a
    ld a,h | adc a,0 | ld h,a
ret
PutLeft:
    ld a,(hl)
    and 0fh | ld c,a
    ld a,(de) | inc de
    ld b,a
    and 0f0h | or c
    ld (hl),a
    call NextLine
    
    ld a,(hl)
    and 0fh | ld c,a
    ld a,b
    rlca | rlca | rlca | rlca
    and 0f0h | or c
    ld (hl),a
    call NextLine
ret
PutRight:
    ld a,(hl)
    and 0f0h | ld c,a
    ld a,(de) | inc de
    ld b,a
    rrca | rrca | rrca | rrca
    and 0fh | or c
    ld (hl),a
    call NextLine
    
    ld a,(hl)
    and 0f0h | ld c,a
    ld a,b
    and 0fh | or c
    ld (hl),a
    call NextLine
ret

PatternPtr:
    ex de,hl
        ld h,0
        add hl,hl
        ld bc,CharPattern | add hl,bc
    ex de,hl
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        call PatternPtr
        scf | rr h | rr l
        if nc
            call PutLeft
            call PutLeft
        else
            call PutRight
            call PutRight
        endif
    pop bc | pop de | pop hl | pop af
    inc hl
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
CharTable:
    defb " 0123456789:ACEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            ld bc,28 shl 8
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
            ld a,c
            add a,a ;*2
            add a,c ;*3
            ld l,a | ld h,0
            ld bc,AsciiPattern | add hl,bc
        ex de,hl

        scf | rr h | rr l
        if nc
            call PutLeft
            call PutLeft
            call PutLeft
        else
            call PutRight
            call PutRight
            call PutRight
        endif
    pop bc | pop de | pop hl | pop af
    inc hl
ret


; void FlushVBuffer();
cseg
FlushVBuffer_: public FlushVBuffer_
    push af | push hl | push de | push bc
        ld a,(VBufferIndex)
        or a
        if nz
            ld c,a | ld b,0
            ld hl,VBuffer
            do
                push bc
                    ld c,(hl) | inc hl
                    ld b,(hl) | inc hl
                    ld e,(hl) | inc hl
                    ld d,(hl) | inc hl
                    push hl
                        ld l,c | ld h,b
                        scf | rr h | rr l
                        if nc
                            call PutLeft
                            call PutLeft
                        else
                            call PutRight
                            call PutRight
                        endif
                    pop hl
                pop bc
                inc b
                ld a,b | cp c
            while nz | wend
            xor a | ld (VBufferIndex),a
        endif
    pop bc | pop de | pop hl | pop af
ret

; word VAdd(word position, byte c);
cseg
VAdd_: public VAdd_
    push af
        ld a,(VBufferIndex)
        cp VBufferCount
        call z,FlushVBuffer_
        push hl | push de | push bc
            call PatternPtr
            ld c,e | ld b,d
            ex de,hl
            ld a,(VBufferIndex)
            rlca | rlca
            add a,low VBuffer | ld l,a
            ld a,high VBuffer | adc a,0 | ld h,a
            ld (hl),e | inc hl
            ld (hl),d | inc hl
            ld (hl),c | inc hl
            ld (hl),b
            ld a,(VBufferIndex)
            inc a
            ld (VBufferIndex),a
        pop bc | pop de | pop hl
    pop af
    inc hl
ret

; word VAddOver(word position, byte c);
cseg
VAddOver_: public VAddOver_
    push af
        ld a,(VBufferIndex)
        cp VBufferCount
        call z,FlushVBuffer_
        push hl | push de | push bc
            call PatternPtr
            push de
                ex de,hl
                ld hl,VBuffer
                ld a,(VBufferIndex)
                or a
                if nz
                    ld c,a | ld b,0
                    do
                        ld a,e | cp (hl)
                        if nz
                            inc hl
                            jr VAddOver_next
                        endif
                        inc hl
                        ld a,d | cp (hl)
                        if z
                            inc hl
                            jr VAddOver_over
                        endif
                        VAddOver_next:
                        inc hl | inc hl | inc hl
                        inc b
                        ld a,b | cp c
                    while nz | wend
                endif
                ld (hl),e | inc hl
                ld (hl),d | inc hl
                ld a,(VBufferIndex)
                inc a
                ld (VBufferIndex),a
            VAddOver_over:
            pop de
            ld (hl),e | inc hl
            ld (hl),d | inc hl
        pop bc | pop de | pop hl
    pop af
    inc hl
ret


; word VramAddress(byte x, byte y);
cseg
VramAddress_: public VramAddress_
    push de
        ld d,e | ld e,0
        srl d | rr e
        ld l,a | ld h,high Vram
        add hl,de
    pop de
ret