include "SharedRam.inc"
include "Share.inc"
include "SubBin.inc"

ext TimerHandler

cseg
HaltSubsys: public HaltSubsys
    pshs a
        do
            lda $FD05
        while mi | wend
        orcc #$40
        lda #$80
        sta $FD05
    puls a
rts

ResumeSubsys: public ResumeSubsys
    clr $FD05
    andcc #not $40
    nop | nop | nop | nop
    do
        tst $FD05
    while pl | wend
    ; pshs a,b
    ;     ldb #200
    ;     do 
    ;         lda $FD05
    ;         bmi exit
    ;         decb
    ;     while ne | wend
    ;     exit:
    ; puls a,b
rts

WriteSharedRam: public WriteSharedRam ; (y, b)
    ldy #SharedRam
    do
        lda ,x+
        sta ,y+
        decb
    while ne | wend
rts


SendSubsys: public SendSubsys
    pshs a,y
        bsr HaltSubsys
        bsr WriteSharedRam
        bsr ResumeSubsys
    puls a,y
rts


WaitSubsys: public WaitSubsys
    lda #24
    do
        deca
    while ne | wend
rts

EndCommand:
    lda $FC80
    ora #$80
    sta $FC80
rts

ext subbin
SendSubProgram_unitSize equ 100
cseg
SendSubProgram_Command:
    defb 0,0
    defb $3f ; TEST
    defb 'YAMAUCHI'
    defb $91
    defw $d380+19
SendSubProgramAny:
    do
        pshs a,b,y,cc | orcc #$40
            bsr HaltSubsys
            pshs x
                pshs y
                    ldx #SendSubProgram_Command
                    ldb #14
                    bsr WriteSharedRam
                puls x
                stx ,y++
                ldd #SendSubProgram_unitSize
                std ,y++
                lda #$90
                sta ,y+
            puls x
            ldb #SendSubProgram_unitSize
            do
                lda ,x+
                sta ,y+
                decb
            while ne | wend
            bsr ResumeSubsys
            bsr WaitSubsys
            bsr HaltSubsys
            bsr EndCommand
            bsr ResumeSubsys
        puls a,b,y,cc
        leay SendSubProgram_unitSize,y
        subd #SendSubProgram_unitSize
    while cc | wend
rts

SubMain_Command:
    defb 0,0
    defb $3f ;TEST
    defb 'YAMAUCHI'
    defb $93
    defw SubMain
    defb $90
SendSubProgram: public SendSubProgram
    pshs a,b,x,y
        ldy #subbin_start
        ldx #subbin
        ldd #subbin_size
        bsr SendSubProgramAny

        ldx #SubMain_Command
        ldb #15
        bsr SendSubsys
    puls a,b,x,y
rts
