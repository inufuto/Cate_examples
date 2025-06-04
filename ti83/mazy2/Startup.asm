ext Main_

_LCD_BUSY_QUICK equ 000bh
_ClrLCDFull		equ 4540h

cseg
defb 0bbh,6dh
Startup: public Startup
    rst 28h | defw _ClrLCDFull
    di
        ld a,01h | out (10h),a
        call _LCD_BUSY_QUICK

        call Main_

        xor a | out (10h),a
        call _LCD_BUSY_QUICK
    ei
ret


; void Wait(byte t);
cseg
Wait_: public Wait_
    push af | push de | push bc
        ld e,a
        do
            ld bc,4000
            do
                dec bc
                ld a,c | or b
            while nz | wend
            dec e
        while nz | wend
    pop bc | pop de | pop af
ret
