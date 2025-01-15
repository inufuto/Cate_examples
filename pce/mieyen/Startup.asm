ext InitVram
ext InitSprites, UpdateSprites
ext InitSound, SoundHandler
ext Main_

Interval equ 117

dseg
TimerCount: 
    defb 0

cseg
Startup: public Startup
    lda #$ff | defb $53,$01 ; tam ; I/O
    lda #$f8 | defb $53,$02 ; tam ; RAM
    lda #$00 | defb $53,$80 ; tam ; ROM(e000)
    lda #$01 | defb $53,$10 ; tam ; ROM(8000)
    lda #$02 | defb $53,$20 ; tam ; ROM(a000)
    lda #$03 | defb $53,$40 ; tam ; ROM(c000)

    defb $03,5 ; st0
    defb $13,$c8 ; st1
    defb $23,0 ; st2

    defb $03,9 ; st0
    defb $13,$00 ; st1
    defb $23,0 ; st2

    defb $03,7 ; st0
    defb $13,0 ; st1
    defb $23,0 ; st2

    defb $03,8 ; st0
    defb $13,248 ; st1
    defb $23,0 ; st2

    jsr InitVram
    jsr InitSprites
    jsr InitSound

    sei
        lda #Interval | sta $0c00
        lda #$01 | sta $0c01
        lda $1402 | and #not $06 | sta $1402
    cli
jmp Main_


VHandler: public VHandler
    pha
    phx
    phy
        lda >$0000
        and #$20
        if ne
            jsr UpdateSprites
        endif
    ply
    plx
    pla
rti


THandler: public THandler
    pha
    phx
    phy
        defb $9c | defw $1403 ; stz        
        lda #Interval | sta $0c00
        lda #$01 | sta $0c01

        inc TimerCount
        jsr SoundHandler
    ply
    plx
    pla
rti


; void WaitTimer(byte t);
dseg
WaitTimer_t:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    pha
        sty WaitTimer_t
        do
            lda TimerCount
            cmp WaitTimer_t
        while cc | wend
        sei
            lda #0 | sta TimerCount
        cli
    pla
rts