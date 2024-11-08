include "GameCom.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern

Backup0 equ 0e200h
Backup1 equ 0e400h

dseg
pCurrentBackup: public pCurrentBackup
	defw 0


; void ClearScreen();
cseg
ClearScreen_:  public ClearScreen_
    pushw rr0 | push r3
        mov r DMX1,0
        mov r DMY1,0
        mov r DMX2,0
        mov r DMY2,0
        mov r DMDX,160-1
        mov r DMDY,200-1
        mov r DMBR,CharBank
        mov r DMPL,0
        mov r DMVP,00h
        call DoDma83
        mov r DMVP,02h
        call DoDma83

        clr r3
        movw rr0,Backup0
        do
            mov (rr0)+,r3
            cmpw rr0,Backup1+(Backup1-Backup0)
        while nz|wend
        movw rr0,Backup1 | movw @pCurrentBackup,rr0

        bclr r LCC,6
    pop r3 | popw rr0
ret


; word Put(word yx, byte c);
cseg
PrepareSource:
    mov r2,r3
    sll r2 | sll r2 | sll r2
    ; and r2,0f8h
    mov r DMX1,r2
    srl r3 | srl r3
    and r3,0f8h
    ; inc r3
    mov r DMY1,r3
ret
PreparePut:
    sll r0 | sll r0 | sll r0
    add r0,TopMargin
    mov r DMX2,r0
    sll r1 | sll r1 | sll r1
    add r1,LeftMargin
    mov r DMY2,r1

    call PrepareSource

    mov r DMDX,CharHeight-1
    mov r DMDY,CharWidth-1
    mov r DMBR,CharBank
    mov r DMPL,0e4h
ret
DoDma83:
    ; di
        pushw rr IE0_
            mov IE0,80h
            clr r IE1_
            mov r DMC,83h
            halt | bclr r IR0_,7
        popw rr IE0_
    ; ei
ret
Put_: public Put_
    pushw rr0 | pushw rr2
        call PreparePut
        mov r DMVP,00h
        call DoDma83
        mov r DMVP,02h
        call DoDma83
    popw rr2 | popw rr0
    inc r1
ret


; word PrintC(word yx, byte c);
cseg
PrintC_: public PrintC_
    push r3
        sub r3,20h
        call Put_
    pop r3
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push r0 | pushw rr2 | pushw rr4 | pushw rr6
        mov r0,r LCC
        and r0,40h
        rl r0 | rl r0 | rl r0
        xor r0,02h
        mov r DMVP,r0
        mov r DMDX,CharHeight-1
        mov r DMDY,CharWidth-1
        mov r DMBR,CharBank
        mov r DMPL,0e4h

        movw rr4,VVram
        movw rr6,@pCurrentBackup
        mov r DMX2,TopMargin+CharHeight*2
        do
            mov r DMY2,LeftMargin
            do
                mov r3,(rr4)+
                cmp r3,@rr6
                if nz
                    mov @rr6,r3
                    call PrepareSource
                    call DoDma83
                endif
                incw rr6
                mov r3,r DMY2
                add r3,CharWidth
                mov r DMY2,r3
                cmp r3,LeftMargin+CharWidth*VVramWidth
            while c|wend
            mov r3,r DMX2
            add r3,CharHeight
            mov r DMX2,r3
            cmp r3,TopMargin+CharHeight*(2+VVramHeight)
        while c|wend
    popw rr6 | popw rr4 | popw rr2 | pop r0
ret


; void SwapPage();
cseg
SwapPage_: public SwapPage_
    push r0
        if bs,r LCC,6
            bclr r LCC,6
            mov r0,high Backup1
        else
            bset r LCC,6
            mov r0,high Backup0
        endif
        mov @pCurrentBackup,r0
    pop r0
ret
