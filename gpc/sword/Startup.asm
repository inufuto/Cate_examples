ext Main_

Reset		equ	0

cseg
    defb 55h
    defw Start,Start
    defw 0
    defw 0
IntT:
    jmp Interrupt
Int0:
    jmp Reset
Int1:
    jmp Reset

Start:
    di
        lxi sp,0c800h
    ei
jmp Main_


Interrupt:
	 di
jmp $0128


; void Wait(byte t);
cseg
Wait_: public Wait_
    push v | push b
        mov c,a
        do
            push b
                lxi b,20
                do
                    dcx b
                    mov a,c | ora a,b
                    sknz | eqa a,a
                repeat
            pop b
            dcr c
            sknz | eqa a,a
        repeat
    pop b | pop v
ret
