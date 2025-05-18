include "SubBin.inc"
include "Share.inc"

ext SubBin

cseg
HaltSubsys: public HaltSubsys
    pshs a
        do
            lda $FD05
        while mi | wend
        orcc #$40
        lda #$80 | sta $FD05
    puls a
rts

ResumeSubsys: public ResumeSubsys
    pshs a
        clr $FD05
        andcc #not $40
        nop | nop | nop | nop
        do
            lda $FD05
        while pl | wend
    puls a
    ; pshs a,b
    ;     ldb #200
    ;     do 
    ;         lda $FD05
    ;         bmi ResumeSubsys_exit
    ;         decb
    ;     while ne | wend
    ;     ResumeSubsys_exit:
    ; puls a,b
rts

WriteSharedRam: public WriteSharedRam ; (x, b)
    ldy #ShareRam
    do
        lda ,x+
        sta ,y+
        decb
    while ne | wend
rts


SendSubsys: public SendSubsys ; (x, b)
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
    lda ShareRam
    ora #$80
    sta ShareRam
rts


SendSubProgram_unitSize equ 100
    cseg
SendSubProgram_Command:
    defb 0,0
    defb $3f
    defb 'YAMAUCHI'
    defb $91
    defw SubShareRam+19
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

SendSubProgram: public SendSubProgram
    pshs a,b,x,y
        ldy #SubBin_start
        ldx #SubBin
        ldd #SubBin_size
        bsr SendSubProgramAny
    puls a,b,x,y
rts


cseg
StartSubProgram_Command:
    defb 0,0
    defb $3f
    defb 'YAMAUCHI'
    defb $93
    defw SubBin_start
    defb $90
StartSubProgram: public StartSubProgram
    pshs x,b,a
        ldx #StartSubProgram_Command
        ldb #StartSubProgram-StartSubProgram_Command
        jsr SendSubsys
    puls x,b,a
rts
