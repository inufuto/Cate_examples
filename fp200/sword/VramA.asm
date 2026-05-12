include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

dseg
Backup:
    defs VVramWidth*VVramHeight

LeftLcdPort equ 01h
RightLcdPort equ 02h
LcdStatusPort equ 08h
LcdAddressPort equ 09h

BackBytes equ 835dh

; void ClearScreen();
cseg
WriteCommand:
    push psw
        mvi a,0b0h | out LcdStatusPort
        mvi a,00h | out LcdAddressPort
    pop psw
    out LeftLcdPort | out RightLcdPort
ret
Clear:
    do
        mvi m,0 | inx h
        dcx b
        mov a,c
        ora b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push psw | push h | push b
        call 2f7h ; CLS

        ; offset
        mvi a,50h | call WriteCommand
        ; ; graphics mode
        ; mvi a,40h | call WriteCommand

        lxi h,BackBytes
        lxi b,VramWidth*8*8
        call Clear

        lxi h,Backup
        lxi b,VVramWidth*VVramHeight
        call Clear

        ; lxi h,VVramBack_
        ; lxi b,VVramWidth*VVramHeight*2
        ; call Clear
    pop b | pop h | pop psw
ret


cseg
ReadByte:
    push h | push d
        lxi d,BackBytes
        dad d
        mov a,m
    pop d | pop h
ret
WriteByte:
    mov c,a
    mvi a,10h | out LcdStatusPort
    mov a,l
    SetAddress_offset:
    adi 00h | out LcdAddressPort

    mov a,h
    ori 0b0h | out LcdStatusPort
    mvi a,40h
    SetAddress_port:
    out 0

    mvi a,10h | out LcdStatusPort
    mov a,c
    WriteByte_port:
    out 0

    push h | push d
        lxi d,BackBytes
        dad d
        mov m,a
    pop d | pop h
ret
PrepareLeft:
    xra a | sta SetAddress_offset+1
    mvi a,LeftLcdPort
    sta SetAddress_port+1
    ; sta ReadByte_port+1
    sta WriteByte_port+1
ret
PrepareRight:
    mvi a,-10 | sta SetAddress_offset+1
    mvi a,RightLcdPort
    sta SetAddress_port+1
    ; sta ReadByte_port+1
    sta WriteByte_port+1
ret
AlterPanel:
    mov a,l
    ani 0fh
    cpi 10
    if c
        call PrepareLeft
    else
        call PrepareRight
    endif
ret
NextRow:
    mov a,l | adi VramWidth | mov l,a
    mov a,h | aci 0 | mov h,a
ret
PutL:
    do
        call ReadByte
        ani 0f0h
        mov c,a
        ldax d
        ani 0fh
        ora c
        call WriteByte
        call NextRow

        call ReadByte
        ani 0f0h
        mov c,a
        ldax d
        rrc | rrc | rrc | rrc
        ani 0fh
        ora c
        call WriteByte
        call NextRow

        inx d
        dcr b
    while nz | wend
ret

PutR:
    do
        call ReadByte
        ani 0fh
        mov c,a
        ldax d
        rlc | rlc | rlc | rlc
        ani 0f0h
        ora c
        call WriteByte
        call NextRow

        call ReadByte
        ani 0fh
        mov c,a
        ldax d
        ani 0f0h
        ora c
        call WriteByte
        call NextRow

        inx d
        dcr b
    while nz | wend
ret

CharPatternADe:
    push h
        mov l,a
        mvi h,0
        dad h ;*2
        lxi d,CharPattern
        dad d
        xchg
    pop h
ret

; ptr<byte> Put(ptr<byte> pVram, byte c, bool right);
cseg
Put_: public Put_
    push psw | push d | push b
        call AlterPanel
        mov a,e
        call CharPatternADe
        mov a,c
        ora a
        if z
            mvi b,4/2
            call PutL
            lxi d,-VramWidth*4
        else
            mvi b,4/2
            call PutR
            lxi d,-VramWidth*4+1
        endif
        dad d
    pop b | pop d | pop psw
ret


; void VVramToVram();
dseg
xCount:
    defb 0
yCount:
    defb 0
cseg
VVramToVram_L:
    ldax b | inx b
    cmp m
    if nz
        mov m,a
        xchg
            push d | push b
                call CharPatternADe
                mvi b,CharHeight/2
                call PutL
                lxi d,-VramWidth*4
                dad d
            pop b | pop d
        xchg
    endif
    inx h
ret
VVramToVram_R:
    ldax b | inx b
    cmp m
    if nz
        mov m,a
        xchg
            push d | push b
                call CharPatternADe
                mvi b,CharHeight/2
                call PutR
                lxi d,-VramWidth*4+1
                dad d
            pop b | pop d
        xchg
    else
        inx d
    endif
    inx h
ret
VVramToVram_: public VVramToVram_
    push psw | push h | push d | push b
        lxi d,Vram+VramRowSize*2
        lxi b,VVramFront_
        lxi h,Backup
        mvi a,VVramHeight | sta yCount
        do
            call PrepareLeft
            mvi a,VVramWidth/2 | sta xCount
            do
                call VVramToVram_L
                call VVramToVram_R

                lda xCount
                cpi 3
                if z
                    push psw
                        call PrepareRight
                    pop psw
                endif
                dcr a | sta xCount
            while nz | wend
            xchg
                push d
                    lxi d,VramRowSize-VVramWidth/2
                    dad d
                pop d
            xchg

            lda yCount | dcr a | sta yCount
        while nz | wend
    pop b | pop d | pop h | pop psw
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c, bool right);
cseg
CharTable:
    defb " 0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push psw | push d | push b
        call AlterPanel
        push h
            lxi h,CharTable
            mov a,e
            lxi d,29*256
            do
                cmp m
                jz PrintC_break
                inx h
                inr e
                dcr d
            while nz | wend
            mvi e,0
            PrintC_break:
            mov a,e
            add a ;*2
            add a ;*4
            mov l,a | mvi h,0
            lxi d,AsciiPattern
            dad d
            xchg
        pop h
        mov a,c
        ora a
        if z
            mvi b,8/2
            call PutL
            lxi d,-VramWidth*8
        else
            mvi b,8/2
            call PutR
            lxi d,-VramWidth*8+1
        endif
        dad d
    pop b | pop d | pop psw
ret
