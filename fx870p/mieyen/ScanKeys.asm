Keys_Left equ &h01
Keys_Right equ &h02
Keys_Up equ &h04
Keys_Down equ &h08
Keys_Dir equ &h0f
Keys_Button0 equ &h10
Keys_Button1 equ &h20

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    phsw $3
        ld $0,$sx

        pst ia,2
        gre ky,$2
        anc $2,&h08 ; Right
        if nz
            or $0,Keys_Right
        endif
        anc $2,&h10 ; Down
        if nz
            or $0,Keys_Down
        endif

        pst ia,3
        gre ky,$2
        anc $2,&h10 ; Left
        if nz
            or $0,Keys_Left
        endif
        anc $2,&h20 ; Up
        if nz
            or $0,Keys_Up
        endif

        pst ia,5
        gre ky,$2
        anc $2,&h04 ; 4
        if nz
            or $0,Keys_Left
        endif

        pst ia,6
        gre ky,$2
        anc $2,&h02 ; 8
        if nz
            or $0,Keys_Up
        endif

        pst ia,7
        gre ky,$2
        anc $2,&h01 ; 6
        if nz
            or $0,Keys_Right
        endif

        pst ia,8
        gre ky,$2
        anc $2,&h02 ; 2
        if nz
            or $0,Keys_Down
        endif
        anc $2,&h04 ; SPC
        if nz
            or $0,Keys_Button0
        endif
        anc $2,&h40 ; X
        if nz
            or $0,Keys_Button0 or Keys_Right
        endif

        pst ia,9
        gre ky,$2
        anc $2,&h02 ; .
        if nz
            or $0,Keys_Button1
        endif
        anc $2,&h04 ; 0
        if nz
            or $0,Keys_Button0
        endif
        anc $2,&h08 ; =
        if nz
            or $0,Keys_Button1
        endif
        anc $2,&h80 ; Z
        if nz
            or $0,Keys_Button0 or Keys_Left
        endif
    ppsw $2
rtn


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    phs $1
        pst ia,1
        gre ky,$0
        an $0,&h80
        if nz
            ld $0,$sy
        endif
    pps $1
rtn