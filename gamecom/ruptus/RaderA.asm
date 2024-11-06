include "GameCom.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext FighterX_, FighterY_
ext DoDma82

; Rader equ 0e168h
RaderWidth equ 6
RaderHeight equ 8
RaderLeft equ VVramWidth
RaderTop equ VVramHeight-RaderHeight

; void DrawFighterOnRader(bool visible);
cseg
DrawFighterOnRader_: public DrawFighterOnRader_
    push r0
        mov r DMBR,CharBank
        mov r DMPL,0d0h
        mov r DMDY,3
        mov r DMDX,3
        mov r DMX1,(Char_FighterOnMap and 31)*CharWidth
        mov r0,1+(Char_FighterOnMap/32)*CharHeight
        or r1,r1
        if z
            add r0,4
        endif
        mov r DMY1,r0
        
        mov r0,@FighterX_
        srl r0
        dec r0
        cmp r0,48-1
        if nc
            clr r0
        endif
        add r0,LeftMargin+RaderLeft*CharWidth
        mov r DMY2,r0
        
        mov r0,@FighterY_
        srl r0
        dec r0
        cmp r0,64-1
        if nc
            clr r0
        endif
        add r0,TopMargin+RaderTop*CharHeight
        mov r DMX2,r0

        mov r DMVP,00h
        call DoDma82
        mov r DMVP,02h
        call DoDma82
    pop r0
ret
