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

dseg
; ScanKeys_r12:
;     defw 0
cseg
ScanKeys_: public ScanKeys_
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
        clr r0

        li r12,>ec60
        stcr r2,8 
        mov r2,r1 | andi r1,>8000 ; Space
        if ne
            ori r0,Keys_Button0 shl 8
        endif
        mov r2,r1 | andi r1,>1000 ; RT
        if ne
            ori r0,Keys_Button1 shl 8
        endif

        li r12,>ec70
        stcr r2,8 
        mov r2,r1 | andi r1,>0800 ; Right
        if ne
            ori r0,Keys_Right shl 8
        endif
        mov r2,r1 | andi r1,>0400 ; Down
        if ne
            ori r0,Keys_Down shl 8
        endif
        mov r2,r1 | andi r1,>0200 ; Up
        if ne
            ori r0,Keys_Up shl 8
        endif
        mov r2,r1 | andi r1,>0100 ; Left
        if ne
            ori r0,Keys_Left shl 8
        endif

        li r12,>ec30
        stcr r2,8 
        mov r2,r1 | andi r1,>8000 ; M
        if ne
            ori r0,Keys_Down shl 8
        endif
        mov r2,r1 | andi r1,>4000 ; K
        if ne
            ori r0,Keys_Right shl 8
        endif
        mov r2,r1 | andi r1,>2000 ; J
        if ne
            ori r0,Keys_Left shl 8
        endif
        mov r2,r1 | andi r1,>1000 ; I
        if ne
            ori r0,Keys_Up shl 8
        endif

        li r12,>ec40
        stcr r2,8 
        mov r2,r1 | andi r1,>0400
        if ne
            ori r0,Keys_Button0 shl 8
        endif
        mov r2,r1 | andi r1,>0800
        if ne
            ori r0,Keys_Button1 shl 8
        endif
        mov r2,r1 | andi r1,>1000
        if ne
            ori r0,Keys_Down shl 8
        endif
        mov r2,r1 | andi r1,>2000
        if ne
            ori r0,Keys_Left shl 8
        endif
        mov r2,r1 | andi r1,>4000
        if ne
            ori r0,Keys_Up shl 8
        endif
        mov r2,r1 | andi r1,>8000
        if ne
            ori r0,Keys_Right shl 8
        endif
    mov *r10+,r2
    mov *r10+,r1
rt
