ext Direct
ext InitSound
ext Main_

dseg
DpBackup: 
    defb 0
IrqJmp:
    defs 3
TimerCount: 
    defb 0 public TimerCount
    
cseg
    tfr dp,a
    sta DpBackup
    lda #high Direct
    tfr a,dp

    ;Sound
    lda $FF23
    ora #$08
    sta $FF23

    ;VDP
    sta $FFC0
    sta $FFC3
    sta $FFC5
    lda #$e0
    sta $FF22

    lda #$7e
    sta IrqJmp
    ldx $10d
    stx IrqJmp+1
    clr TimerCount
    orcc #$60
        ldx #Handler
        stx $10d
    andcc #not $60

    jsr InitSound
jmp Main_


Handler:
    inc TimerCount
jmp IrqJmp


dseg
WaitTimer_param:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    sta WaitTimer_param
        do
            lda TimerCount
            cmpa WaitTimer_param
        while cs | wend
    lda WaitTimer_param
    orcc #$50
        clr TimerCount
    andcc #not $50
rts
