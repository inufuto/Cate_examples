include "InternalRam.inc"
include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
; ext KeyBytes

dseg
Backup:public Backup
    defs VVramWidth*VVramHeight

; void ClearScreen();
cseg
ClearWH:
    lii VVramHeight
    lij VVramWidth
    do
        fild
        decj
    while nz | wend
rtn
ClearScreen_: public ClearScreen_
    push
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
        lia 0
        lii 7bh
        lidp 7000h | fild
        lidp 7200h | fild
        lidp 7400h | fild
        lidp 7600h | fild
        lidp 7800h | fild

        lidp Backup
        call ClearWH
        lidp VVramBack_
        call ClearWH
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    pop 
rtn


; ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
cseg
Put:
    exab|push|exab
    lp RegisterJ|exam|push|exam
    lp RegisterK|exam|push|exam
    lp RegisterL|exam|push|exam
    lp RegisterY+1|exam|push|exam
    lp RegisterY|exam|push|exam
        lp RegisterB|ldm
        ania 03h
        lp RegisterK|exam ; left

        lp RegisterB|ldm
        sr|sr|ania 03h
        lp RegisterL|exam ; right

        lij 0fch ; mask

        lp RegisterI|ldm ; shift
        ania 7
        if nz
            exab
            do
                lp RegisterJ|ldm
                sc|sl
                exam
                lp RegisterK|ldm
                rc|sl
                exam
                lp RegisterL|ldm
                rc|sl
                exam
                decb
            while nz | wend
        endif

        dx
        lp RegisterX|ldm|lp RegisterY|exam
        lp RegisterX+1|ldm|lp RegisterY+1|exam
        ixl
        lp RegisterB | exam
        lp RegisterJ | ldm ; mask
        lp RegisterB | anma
        lp RegisterK | ldm ; left
        lp RegisterB | orma | ldm
        iys

        ixl
        lp RegisterB | exam
        lp RegisterJ | ldm ; mask
        lp RegisterB | anma
        lp RegisterL | ldm ; right
        lp RegisterB | orma | ldm
        iys
        ix
    lp RegisterY|exam|pop|exam
    lp RegisterY+1|exam|pop|exam
    lp RegisterL|exam|pop|exam
    lp RegisterK|exam|pop|exam
    lp RegisterJ|exam|pop|exam
    exab|pop|exab
rtn
NextX:
    lp RegisterX|ldm
    cpia 1eh
    if z
        lia 00h
        jr NextX_next
    endif
    cpia 3ch
    if z
        lia 1eh
        jr NextX_next
    endif
    cpia 5eh
    if z
        lia 40h
        jr NextX_next
    endif
    cpia 7ch
    if z
        lia 5eh
        jr NextX_next
    endif
    jr NextX_skip
    NextX_next:
    exam
    lp RegisterX+1|ldm
    adia 2
    exam
    NextX_skip:
rtn
Put_: public Put_
    push
        call Put
        call NextX
    pop
rtn


; void VVramToVram();
VVramToVram_block:
    do
        liq Word0 | lp RegisterX | exw ; pBackup
        ixl | exab
        liq Word0 | lp RegisterX | exw ; pBackup
        ixl ; pVVram
        
        lp RegisterB | cpma
        if nz
            liq Word0 | lp RegisterY | exw ; pBackup
            dy | iys
            liq Word0 | lp RegisterY | exw ; pBackup
            exab
            liq RegisterY | lp RegisterX | lii 2-1 | exw ; pVram
            lp RegisterM|ldm
            lp RegisterI|exam
            call Put
            liq RegisterY | lp RegisterX | lii 2-1 | exw ; pVram
        else
            iy | iy
        endif
        decj
    while nz|wend
rtn
VVramToVram_: public VVramToVram_
    push
    exab|push
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
    lp RegisterX+1|ldm|push
    lp RegisterX|ldm|push
    lp RegisterY+1|ldm|push
    lp RegisterY|ldm|push
    lp RegisterM|ldm|push
    lp Word0+1|ldm|push
    lp Word0|ldm|push
        lia low(Backup-1)|lp Word0|exam ; 9
        lia high(Backup-1)|lp Word0+1|exam; 9
        lia low(VVramFront_-1)|lp RegisterX|exam; 9
        lia high(VVramFront_-1)|lp RegisterX+1|exam; 9

        lia 0
        do
            lp RegisterM|exam
            lia low Vram00|lp RegisterY|exam
            lia high Vram00|lp RegisterY+1|exam
            lij 30/2
            call VVramToVram_block
            lia low Vram01|lp RegisterY|exam
            lia high Vram01|lp RegisterY+1|exam
            lij VVramWidth-30/2
            call VVramToVram_block
            lp RegisterM|ldm
            adia 2 | ania 7
        while nz|wend

        lia 0
        do
            lp RegisterM|exam
            lia low Vram10|lp RegisterY|exam
            lia high Vram10|lp RegisterY+1|exam
            lij 30/2
            call VVramToVram_block
            lia low Vram11|lp RegisterY|exam
            lia high Vram11|lp RegisterY+1|exam
            lij VVramWidth-30/2
            call VVramToVram_block
            lp RegisterM|ldm
            adia 2 | ania 7
        while nz|wend

        lia 0
        do
            lp RegisterM|exam ; 5
            lia low Vram20|lp RegisterY|exam ; 9
            lia high Vram20|lp RegisterY+1|exam ; 9
            lij 30/2 ; 4
            call VVramToVram_block
            lia low Vram21|lp RegisterY|exam
            lia high Vram21|lp RegisterY+1|exam
            lij VVramWidth-30/2
            call VVramToVram_block
            lp RegisterM|ldm
            adia 2 | ania 7
        while nz|wend

        lia 0
        do
            lp RegisterM|exam
            lia low Vram30|lp RegisterY|exam
            lia high Vram30|lp RegisterY+1|exam
            lij 30/2
            call VVramToVram_block
            lia low Vram31|lp RegisterY|exam
            lia high Vram31|lp RegisterY+1|exam
            lij VVramWidth-30/2
            call VVramToVram_block
            lp RegisterM|ldm
            adia 2 | ania 7
        while nz|wend
    lp Word0|pop|exam
    lp Word0+1|pop|exam
    lp RegisterM|pop|exam
    lp RegisterY|pop|exam
    lp RegisterY+1|pop|exam
    lp RegisterX|pop|exam
    lp RegisterX+1|pop|exam
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    pop|exab
    pop
rtn


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
PrintC_: public PrintC_
    push
    lp RegisterI|exam|push|exam
    lp RegisterJ|exam|push|exam
    lp RegisterY+1|exam|push|exam
    lp RegisterY|exam|push|exam
        dx
        lp RegisterX|ldm|lp RegisterY|exam
        lp RegisterX+1|ldm|lp RegisterY+1|exam

        lia low(CharTable-1)|lp RegisterX|exam
        lia high(CharTable-1)|lp RegisterX+1|exam
        lii 32
        lij 0
        lp RegisterB
        do
            ixl
            cpma
            jrz PrintC_break
            incj
            deci
        while nz | wend
        lij 0
        PrintC_break:
        lia low(AsciiPattern-1)|lp RegisterX|exam
        lia high(AsciiPattern-1)|lp RegisterX+1|exam
        lib 0
        lp RegisterJ|ldm
        rc|sl|exab|sl|exab ;*2
        rc|sl|exab|sl|exab ;*4
        lp RegisterX|adb

        lii CharWidth/2
        do
            ixl | iys
            ixl | iys
            iy
            lp RegisterY|ldm
            cpia 1eh
            if z
                lia 00h
                jr PrintC_next
            endif
            cpia 3ch
            if z
                lia 1eh
                jr PrintC_next
            endif
            cpia 5eh
            if z
                lia 40h
                jr PrintC_next
            endif
            cpia 7ch
            jrnz PrintC_skip
            lia 5eh
            PrintC_next:
            exam
            lp RegisterY+1|ldm
            adia 2
            exam
            PrintC_skip:
            dy

            deci
        while nz | wend
        lp RegisterY|ldm|lp RegisterX|exam
        lp RegisterY+1|ldm|lp RegisterX+1|exam
        ix
    lp RegisterY|exam|pop|exam
    lp RegisterY+1|exam|pop|exam
    lp RegisterJ|exam|pop|exam
    lp RegisterI|exam|pop|exam
    pop
rtn
cseg
CharTable:
    defb " '0123456789ACEFGHIKMNOPRSTUVXYZ"
AsciiPattern: public AsciiPattern
	; ascii 32
	; " '0123456789ACEFGHIKMNOPRSTUVXYZ"
	defb 00h,00h,00h,00h,00h,03h,00h,00h
	defb 1fh,11h,1fh,00h,00h,00h,1fh,00h
	defb 1dh,15h,17h,00h,15h,15h,1fh,00h
	defb 07h,04h,1fh,00h,17h,15h,1dh,00h
	defb 1fh,15h,1dh,00h,01h,1dh,03h,00h
	defb 1fh,15h,1fh,00h,17h,15h,1fh,00h
	defb 1eh,09h,1eh,00h,0eh,11h,0ah,00h
	defb 1fh,15h,11h,00h,1fh,05h,01h,00h
	defb 0eh,11h,0dh,00h,1fh,04h,1fh,00h
	defb 11h,1fh,11h,00h,1fh,04h,1bh,00h
	defb 1fh,06h,1fh,00h,1fh,01h,1eh,00h
	defb 0eh,11h,0eh,00h,1fh,05h,07h,00h
	defb 1fh,05h,1ah,00h,16h,15h,0dh,00h
	defb 01h,1fh,01h,00h,1fh,10h,1fh,00h
	defb 0fh,10h,0fh,00h,1bh,04h,1bh,00h
	defb 03h,1ch,03h,00h,19h,15h,13h,00h


; ptr<byte> PutByte(ptr<byte> pVram, byte c);
cseg
PutByte_: public PutByte_
    push
    lp RegisterI|ldm|push
        lii 2-1
        liq RegisterY | lp RegisterX | exw ; pVram
        exab
        dy
        iys
        iy
        liq RegisterY | lp RegisterX | exw ; pVram
        call NextX
    lp RegisterI|pop|exam
    pop
rtn
