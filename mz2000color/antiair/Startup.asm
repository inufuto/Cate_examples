ext Main_
ext InitVram, InitSound

Interval equ 31250/60
Text equ 0d000h

dseg
LastTimer:
    defb 0
TimerCount: public TimerCount
    defb 0

cseg
    ld hl,0c000h
    ld sp,hl

    ld hl,PortTable
    do
        ld c,(hl) | inc hl
        ld a,(hl) | inc hl
        out (c),a
        inc a
    while nz | wend

    ; ld a,0cfh | out (0e9h),a
    ; xor a | out (0e9h),a
    ; ld a,080h | out (0e8h),a
    
    ; ld a,00h | out (0f5h),a
    ; ld a,0fh | out (0f6h),a

    ; ld bc,0
    ; do
    ;     in a,(0e1h)
    ;     and 02h
    ;     jr nz,mz2500
    ;     dec bc
    ;     ld a,c | or b
    ; while nz | wend
    ; ld a,01h
    ; mz2500:

    call InitVram
    call InitSound
jp Main_

PortTable:
    defb 0e3h,02h
    defb 0e7h,34h
    defb 0e7h,74h
    defb 0e7h,0b4h
    defb 0e6h,00h
    defb 0e6h,00h
    defb 0e5h,60
    defb 0e5h,00h
    defb 0e4h,low Interval
    defb 0e4h,high Interval
    defb 0e9h,0cfh
    defb 0e9h,00h
    defb 0e8h,80h
    defb 0f5h,00h
    defb 0f6h,0fh
    defb 0f4h,00h
    defb 0ebh,0cfh
    defb 0ebh,0ffh

PollTimer_: public PollTimer_
    push af | push hl
        in a,(0e5h) | ld l,a
        in a,(0e5h) | ld h,a
        ld a,(LastTimer)
        cp l
        if nz
            ld a,l
            ld (LastTimer),a
            call Handler
        endif
    pop hl | pop af
ret

Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
ret


WaitTimer_:
    public WaitTimer_
    push af | push de
        ld e,a
        do
            call PollTimer_
            ld a,(TimerCount)
            cp e
        while c | wend
        ; di
            xor a
            ld (TimerCount),a
        ; ei
    pop de | pop af
ret
