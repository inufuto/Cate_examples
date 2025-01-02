include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern
ext VVramBack_,VVramFront_
ext PollVSync_

Char_PCG equ 80h
CharHeight equ 8
VramTop equ Vram+VramRowSize*1

dseg
CharColors: public CharColors
    defs Char_End
Backup:
    defs VVramWidth*VVramHeight
RowFlags:
    defs 4


cseg
ColorTable:
defb 1,0c8h
defb 15,28h ; Wall
defb 32,0e8h ; Man
defb 32,68h ; Monster
defb 4,48h ; FireBullet
defb 4,48h ; Fire
defb 4,0c8h ; Dot
defb 4,0c8h ; Food
defb 0
InitVram: public InitVram
    ld de,CharColors
	ld a,0e8h
	ld b,Char_PCG
	do
		ld (de),a | inc de
	dwnz
    ld hl,ColorTable
    do
        ld b,(hl)
        inc b | dec b
    while nz
        inc hl
        ld a,(hl) | inc hl
        do
            ld (de),a | inc de
        dwnz
    wend
    
    ld hl,CharPattern
    ld de,0
    ld bc,CharHeight*(Char_End-Char_PCG)
    call InitPCG
ret

InitPCG:
    do
        ld a,(hl) | inc hl
        out (00h),a
        ld a,e | out (01h),a
        ld a,d | out (02h),a
        or 10h | out (02h),a
        and not 10h | out (02h),a
        inc de
        dec bc
        ld a,c | or b
    while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld c,VramHeight
        do
            ld b,VramWidth
            xor a
            do
                ld (hl),a
                inc hl | inc hl
            dwnz
            ld (hl),0
            inc hl
            ld (hl),0e8h
            inc hl
            ld b,VramAttrWidth/2-1
            do
                ld (hl),80
                inc hl
                ld (hl),0e8h
                inc hl
            dwnz
            dec c
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight/2
        do
            ld (hl),0 | inc hl
            ld (hl),0e8h | inc hl
            dec bc
            ld a,b
            or c
        while nz | wend

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        do
            ld (hl),0 | inc hl
            dec bc
            ld a,b
            or c
        while nz | wend
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
PrintC_: public PrintC_
	ld (hl),e
	inc hl | inc hl
ret


;   void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,Backup
        ld de,VVramFront_
        exx
            xor a
            ld hl,RowFlags
            ld b,4
            do
                ld (hl),a
                inc hl
            dwnz

            ld hl,RowFlags
            ld c,1
            ld b,(hl)
            ld e,0
        exx
        ld c,VVramHeight
        do
			call PollVSync_
            push hl | push de
                ld b,VVramWidth
                do
                    ld a,(de)
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            ld a,b
                            or c
                            ld b,a
                            ld e,1
                        exx
                        jr VVramToVram_NextRow
                    endif
                    inc de
                    inc hl
                dwnz
                VVramToVram_NextRow:            
            pop de | pop hl
            push bc
                ld bc,VVramWidth
                add hl,bc
                ex de,hl
                    add hl,bc
                ex de,hl
            pop bc
            exx
                rlc c
                if c
                    ld (hl),b
                    inc hl
                    ld b,(hl)
                endif
            exx
            dec c
        while nz | wend
        exx
            ld (hl),b
            ld a,e
        exx
        or a
        if nz
            call VVramToVramChanged_
        endif
    pop bc | pop de | pop hl | pop af
ret


VVramToVramChanged_: public VVramToVramChanged_
    push af | push hl | push de | push bc | push ix | push iy
        ld hl,VVramFront_
        ld de,VramTop
        ld ix,Backup
        ld iy,VramTop+VramWidth*2 ; pointer of attribute
        exx
            ld hl,RowFlags
            ld c,1
            ld b,(hl) | inc hl
        exx
        ld a,0e8h | ld (rightColor+1),a
        ld b,VVramHeight
        do
            push bc
                exx
                    ld a,b
                    and c
                exx
                if nz
                    xor a
                    ld (VVramToVramChanged_cp+1),a
                    exx
                        ld de,VramAttrWidth/2-1 ; d=column, e=attribute count
                    exx
                    ld b,VVramWidth
                    do
                        push bc
                            ld a,(hl) | inc hl ; char code
                            ld (ix),a | inc ix
                            push hl
                                cp 80h
                                jr nc,vtvc_fromCharColors
                                cp 60h
                                if c
                                    vtvc_fromCharColors:
                                    ld c,a
                                    add a,low CharColors | ld l,a
                                    ld a,high CharColors | adc a,0 | ld h,a
                                    ld a,c
                                    ld c,(hl)
                                else
                                    add a,20h
                                    ld c,28h
                                endif
    							ld (de),a | inc de | inc de
								exx
									ld a,e ; attribute count
								exx
								or a
								if nz
									ld a,c
									VVramToVramChanged_cp:
									cp 0
									if nz
										ld (VVramToVramChanged_cp+1),a
										exx
											ld (iy),d; column
											inc iy
											dec e
										exx
										ld (iy),c
										inc iy
									endif
								endif
								exx
									inc d | inc d
								exx
                            pop hl
                        pop bc
                    dwnz
                    exx
                        ld a,e ; attribute count
                    exx
                    inc a
                    ld b,a
                    rightColor:
                    ld a,0e8h
                    do
                        exx
                            ld (iy),d; column
                            inc iy
                            ld d,VramWidth*VramStep
                        exx
                        ld (iy),a
                        inc iy
                    dwnz
                    ld bc,VramRowSize-VVramWidth*2
                    ex de,hl
                        add hl,bc
                    ex de,hl
                    ld bc,VramRowSize-VramAttrWidth
                else
                    ld bc,VVramWidth
                    add hl,bc
                    add ix,bc
                    ld bc,VramRowSize
                    ex de,hl
                        add hl,bc
                    ex de,hl
                endif
                add iy,bc
                exx
                    rlc c
                    if c
                        ld b,(hl)
                        inc hl
                    endif
                exx
                call PollVSync_
            pop bc
            ld a,b
            cp 5
            jr c,defalutColor
            cp 7
            if c
                ld a,0c8h
            else
                defalutColor:
                ld a,0e8h
            endif
            ld (rightColor+1),a
        dwnz
    pop iy | pop ix | pop bc | pop de | pop hl | pop af
ret


; void SetColorXY(byte x, byte y, byte color);
cseg
SetColorXY_: public SetColorXY_
    push af | push hl | push de | push bc
        ld h,a
        ld l,e | inc l
        ld a,c
        call 4f8h
    pop bc | pop de | pop hl | pop af
ret
