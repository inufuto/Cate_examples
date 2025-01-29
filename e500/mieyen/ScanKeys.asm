include "e500.inc"

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h


; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    pushs i | mv il,dl
        mv dl,0

        mvw (KEYOUT),0001h
        test (KEYIN),40h ;Shift
        if nz
            or dl,Keys_Button1
        endif

        mvw (KEYOUT),0004h
        mv a,(KEYIN)
        test a,40h ;Space
        if nz
            or dl,Keys_Button0
        endif
        test a,80h ;Down
        if nz
            or dl,Keys_Down
        endif

        mvw (KEYOUT),0008h
        mv a,(KEYIN)
        test a,40h ;Up
        if nz
            or dl,Keys_Up
        endif
        test a,80h ;Left
        if nz
            or dl,Keys_Left
        endif

        mvw (KEYOUT),0010h
        test (KEYIN),40h ;Right
        if nz
            or dl,Keys_Right
        endif

        mvw (KEYOUT),0020h
        test (KEYIN),20h ;4
        if nz
            or dl,Keys_Left
        endif

        mvw (KEYOUT),0040h
        mv a,(KEYIN)
        test a,10h ;8
        if nz
            or dl,Keys_Up
        endif
        test a,40h ;2
        if nz
            or dl,Keys_Down
        endif

        mvw (KEYOUT),0080h
        test (KEYIN),20h ;6
        if nz
            or dl,Keys_Right
        endif

        mv a,dl
    mv dl,il | pops i
ret



; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    mv a,0
    mvw (KEYOUT),0080h
    test (KEYIN),01h
    if nz
        inc a
    endif
ret
