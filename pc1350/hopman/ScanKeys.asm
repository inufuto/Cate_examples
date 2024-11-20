include "InternalRam.inc"

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

WaitValue equ 30

dseg
KeyByte0: public KeyByte0
    defb 0
    

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    exab|push
    lp RegisterI
    ldm|push
        lib 0
        lidp 7e00h

        lia 02h | std
        wait WaitValue
        ina
        tsia 10h ;Z
        if nz
            exab|oria Keys_Button0|exab
        endif
        exam

        lia 04h | std
        wait WaitValue
        ina
        tsia 02h ;6
        if nz
            exab|oria Keys_Right|exab
        endif
        tsia 10h ;X
        if nz
            exab|oria Keys_Button1|exab
        endif

        lia 08h | std
        wait WaitValue
        ina
        tsia 01h ;8
        if nz
            exab|oria Keys_Up|exab
        endif
        tsia 04h ;2
        if nz
            exab|oria Keys_Down|exab
        endif

        lia 10h | std
        wait WaitValue
        ina
        tsia 02h ;4
        if nz
            exab|oria Keys_Left|exab
        endif

        lia 20h | std
        wait WaitValue
        ina
        tsia 01h ;Up
        if nz
            exab|oria Keys_Up|exab
        endif
        tsia 02h ;Down
        if nz
            exab|oria Keys_Down|exab
        endif
        tsia 04h ;Left
        if nz
            exab|oria Keys_Left|exab
        endif
        tsia 08h ;Right
        if nz
            exab|oria Keys_Right|exab
        endif

        ldm
        lidp KeyByte0 | std
        exab
    exam|pop|exam
    exab|pop|exab
rtn


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    lidp KeyByte0
    ldd
    ania 40h ;Q
    if nz
        lia 1
    endif
rtn
