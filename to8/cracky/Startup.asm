zext @Temp@word

ext InitVram
; ext InitKeys
ext InitSound, SoundHandler
ext Main_

Interval equ 2028 ; 60Hz

dseg
; OldHandler:
;     defw 0
TimerCount: public TimerCount
    defb 0
division:
    defb 0

cseg
    lda #high @Temp@word
    tfr a,dp

    LDA   #$03       ; マスターリセット
    STA   $E7DE
    
    LDA   #$15       ; 8ビット、パリティなし、ストップビット1、割り込みなし
    STA   $E7DE      ; (割り込みを使う場合は #$95)

    jsr InitVram
    ; jsr InitKeys
    jsr InitSound

    pshs cc | orcc #$50
        ldd #Interval | std $E7C6
        lda #$46 | sta $E7C5

        ; ldd $6027
        ; std OldHandler
        ldd #Handler
        std $6027
    puls cc
jmp Main_

Handler: public Handler
    pshs cc
        jsr SoundHandler
        inc TimerCount
        cmpx $E7C6
    puls cc
; jmp [OldHandler]
rti

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
    ; lda WaitTimer_param
    pshs cc | orcc #$50
        clr TimerCount
    puls cc
rts
