include "Vram.inc"
include "VVram.inc"

ext SubParam
ext VVram_

dseg
Backup: public Backup
    defs VVramWidth*VVramHeight


cseg
InitChars: public InitChars
    ld bc,0900h
    ld hl,ParamChars
    ld a,1ah
    call 0c92fh
ret
ParamChars:
    defb Char_Remain
	defb 00h,00h,30h,30h,10h,28h,00h,00h


; void ClearScreen();
cseg
Clear:
    ld bc,VVramWidth*VVramHeight
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld a,2eh ; CLS
        call 0e428h

        ld hl,Backup
        call Clear
        ld hl,VVram_
        call Clear
    pop bc | pop hl | pop af
ret


; word PrintC(word yx, byte c);
cseg
PrintC_: public PrintC_
    push af | push hl | push de | push bc
        ld a,e
        ld (SubParam+2),a
        ld (SubParam),hl
        ld bc,300h
        ld hl,SubParam
        ; ld de,26eh
        ld a,24h
        call 0c92fh
    pop bc | pop de | pop hl | pop af
    inc l
ret


; void VVramToVram();
cseg
ClearParam1a:
    ld hl,Param1a+1
    ld bc,800h
    do
        ld (hl),c | inc hl
    dwnz
ret
VVramToVram_:public VVramToVram_
    push af | push hl | push de | push bc
        call ClearParam1a
        exx
            ld d,0
        exx
        
        ld de,VVram_
        ld hl,Backup
        ld c,VVramHeight/4
        do
            exx
                ld e,0
            exx
            ld b,VVramWidth/3
            do
                push bc
                    exx
                        ld c,0
                    exx
                    ld c,4
                    do
                        ld b,3
                        do
                            ld a,(de) | inc de
                            cp (hl)
                            if nz
                                ld (hl),a
                                exx
                                    inc c
                                exx
                            endif
                            inc hl
                        dwnz
                        push bc
                            ld bc,VVramWidth-3
                            add hl,bc
                            ex de,hl
                                add hl,bc
                            ex de,hl
                        pop bc
                        dec c
                    while nz | wend
                    ld bc,-VVramWidth*4
                    add hl,bc
                    ex de,hl
                        add hl,bc
                    ex de,hl
                    exx
                        ld a,c
                    exx
                    or a
                    if nz
                        push de
                            ld de,VVramWidth-2
                            exx
                                ld hl,Param1a+1
                            exx
                            ld b,4
                            do
                                ld a,(hl)
                                exx
                                    ld c,a
                                    and 0c0h
                                    ld b,a
                                    ld a,(hl)
                                    and 3fh
                                    or b
                                    ld (hl),a
                                    inc hl

                                    ld a,c
                                    rlca | rlca
                                    and 0c0h
                                    ld b,a
                                    ld a,(hl)
                                    and 3fh
                                    or b
                                    ld (hl),a
                                    dec hl
                                exx
                                inc hl
        
                                ld a,(hl)
                                exx
                                    ld c,a
                                    rrca|rrca
                                    and 30h
                                    ld b,a
                                    ld a,(hl)
                                    and 0cfh
                                    or b
                                    ld (hl),a
                                    inc hl

                                    ld a,c
                                    and 30h
                                    ld b,a
                                    ld a,(hl)
                                    and 0cfh
                                    or b
                                    ld (hl),a
                                    dec hl
                                exx
                                inc hl

                                ld a,(hl)
                                exx
                                    ld c,a
                                    rrca|rrca|rrca|rrca
                                    and 0ch
                                    ld b,a
                                    ld a,(hl)
                                    and 0f3h
                                    or b
                                    ld (hl),a
                                    inc hl

                                    ld a,c
                                    rrca|rrca
                                    and 0ch
                                    ld b,a
                                    ld a,(hl)
                                    and 0f3h
                                    or b
                                    ld (hl),a
                                    inc hl
                                exx
                                add hl,de
                            dwnz
                            ld bc,-VVramWidth*4
                            add hl,bc
                            push hl
                                exx
                                    ld (Param24),de
                                exx
                                ld bc,0900h
                                ld hl,Param1a
                                ld a,1ah
                                call 0c92fh

                                ld bc,300h
                                ld hl,Param24
                                ld a,24h
                                call 0c92fh
                                call ClearParam1a
                            pop hl
                        pop de
                    endif
                    inc hl | inc hl | inc hl
                    inc de | inc de | inc de
                pop bc
                exx
                    inc e
                exx
            dwnz
            push bc
                ld bc,VVramWidth*4-VVramWidth
                add hl,bc
                ex de,hl
                    add hl,bc
                ex de,hl
            pop bc
            exx
                inc d
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
Param24:
    defb 0,0,80h
Param1a:
    defb 80h
    defb 0,0,0,0,0,0,0,0
