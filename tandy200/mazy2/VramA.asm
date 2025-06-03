include "Vram.inc"
include "VVram.inc"

ext CharPattern
ext VVramBack_, VVramFront_

LcdCmdPort equ $f1
LcdParamPort equ $f0

Cmd_Mode equ $00
Cmd_CharPitch equ $01
Cmd_NumOfChar equ $02
Cmd_SetAddressL equ $0a
Cmd_SetAddressH equ $0b
Cmd_Write equ $0c

dseg
Backup: public Backup
    defs VVramWidth*VVramHeight


cseg
SetLcdAddress:
    mvi a,Cmd_SetAddressL | out LcdCmdPort
    mov a,l | out LcdParamPort
    mvi a,Cmd_SetAddressH | out LcdCmdPort
    mov a,h | out LcdParamPort
ret


cseg
InitVram: public InitVram
    ; mvi a,Cmd_Mode | out LcdCmdPort
    ; mvi a,$22 | out LcdParamPort

    mvi a,Cmd_CharPitch | out LcdCmdPort
    mvi a,8-1 | out LcdParamPort

    mvi a,Cmd_NumOfChar | out LcdCmdPort
    mvi a,VramWidth-1 | out LcdParamPort
ret


EndVram: public EndVram
    mvi a,Cmd_CharPitch | out LcdCmdPort
    mvi a,6-1 | out LcdParamPort

    mvi a,Cmd_NumOfChar | out LcdCmdPort
    mvi a,40-1 | out LcdParamPort
ret


; void ClearScreen();
cseg
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
        lxi h,Vram
        call SetLcdAddress
        lxi b,VramWidth*VramHeight*CharHeight
        do
            mvi a,Cmd_Write | out LcdCmdPort
            xra a | out LcdParamPort
            dcx b
            mov a,c | ora b
        while nz | wend

        lxi h,Backup
        lxi b,VramWidth*VramHeight
        call Clear

        lxi h,VVramBack_
        lxi b,VramWidth*VramHeight*2
        call Clear
    pop b | pop h | pop psw
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push psw | push h | push d | push b
        xchg
            mvi h,0
            dad h ;*2
            dad h ;*4
            dad h ;*8
            lxi b,CharPattern | dad b
        xchg
        mvi b,8
        do
            call SetLcdAddress
            mvi a,Cmd_Write | out LcdCmdPort
            ldax d | inx d
            out LcdParamPort
            push d
                lxi d,VramWidth
                dad d
            pop d
            dcr b
        while nz | wend
    pop b | pop d | pop h | pop psw
    inx h
ret


; void VVramToVram();
dseg
xCount:
    defb 0
yCount:
    defb 0
cseg
VVramToVram_: public VVramToVram_
    push psw | push h | push d | push b
        lxi d,Vram+VramRowSize*0
        lxi b,VVramFront_+1
        lxi h,Backup
        mvi a,WindowHeight | sta yCount
        do
            mvi a,WindowWidth | sta xCount
            do
                ldax b | inx b
                cmp m
                if nz
                    mov m,a
                    xchg
                        push d
                            mov e,a
                            call Put_
                        pop d
                    xchg
                else
                    inx d
                endif
                inx h
                lda xCount | dcr a | sta xCount    
            while nz | wend
            inx b | inx b
            xchg
                push d
                    lxi d,VramRowSize-WindowWidth
                    dad d
                pop d
            xchg

            lda yCount | dcr a | sta yCount
        while nz | wend
    pop b | pop d | pop h | pop psw
ret