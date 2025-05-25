Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

Keys_Bit_Left equ 0
Keys_Bit_Right equ 1
Keys_Bit_Up equ 2
Keys_Bit_Down equ 3
Keys_Bit_Button0 equ 4
Keys_Bit_Button1 equ 5



cseg
ScanKeys_: public ScanKeys_
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
        clr r0
        
        clr r1
        li r12,>0024
        ldcr r1,3
        li r12,>0006
        stcr r2,8        
        mov r2,r1 | andi r1,>0200 ; Space
        if eq
            ori r0,Keys_Button0 shl 8
        endif
        mov r2,r1 | andi r1,>0400 ; ENTER
        if eq
            ori r0,Keys_Button0 shl 8
        endif
        mov r2,r1 | andi r1,>2000 ; SHIFT
        if eq
            ori r0,Keys_Button1 shl 8
        endif

        li r1,>1 shl 8
        li r12,>0024
        ldcr r1,3
        li r12,>0006
        stcr r2,8        
        mov r2,r1 | andi r1,>8000 ; X
        if eq
            ori r0,Keys_Down shl 8
        endif
        mov r2,r1 | andi r1,>2000 ; S
        if eq
            ori r0,Keys_Left shl 8
        endif

        li r1,>2 shl 8
        li r12,>0024
        ldcr r1,3
        li r12,>0006
        stcr r2,8        
        mov r2,r1 | andi r1,>2000 ; D
        if eq
            ori r0,Keys_Right shl 8
        endif
        mov r2,r1 | andi r1,>4000 ; E
        if eq
            ori r0,Keys_Up shl 8
        endif

        li r1,>5 shl 8
        li r12,>0024
        ldcr r1,3
        li r12,>0006
        stcr r2,8        
        mov r2,r1 | andi r1,>4000 ; Q
        if eq
            ori r0,Keys_Button0 shl 8
        endif

        li r1,>6 shl 8
        li r12,>0024
        ldcr r1,3
        li r12,>0006
        stcr r2,8        
        mov r2,r1 | andi r1,>0100 ; J1-Fire
        if eq
            ori r0,Keys_Button0 shl 8
        endif
        mov r2,r1 | andi r1,>0200 ; J1-Left
        if eq
            ori r0,Keys_Left shl 8
        endif
        mov r2,r1 | andi r1,>0400 ; J1-Right
        if eq
            ori r0,Keys_Right shl 8
        endif
        mov r2,r1 | andi r1,>0800 ; J1-Down
        if eq
            ori r0,Keys_Down shl 8
        endif
        mov r2,r1 | andi r1,>1000 ; J1-Up
        if eq
            ori r0,Keys_Up shl 8
        endif
    mov *r10+,r2
    mov *r10+,r1
rt
