include "KeyBits.inc"
include "ZeroPage.inc"

ext Init, Fin, ScanStop, ScanKeys, ReadStick
ext MapToVVram, VVramToVram, ClearVram
ext InitMap, base.x, base.y
ext stage, Stage.Clear, Stage.Time
ext Man.Move, Man.Draw, Man.Die, Man.status.die
ext Kn.Draw, Kn.Move, Kn.Invent
ext Mon.Draw, Mon.Move
ext Goal.Draw
ext PrintStatus, Print.Over, TitleScreen, PrintTime, PrintTimeup
ext Snd.Get, Snd.Die, Snd.Start, Snd.Over, Snd.Clear

    dseg
Score	defw 0	| public Score
Score.low equ Score
Score.high equ Score+1
HiScore defw 0 | public HiScore
HiScore.low equ HiScore
HiScore.high equ HiScore+1
Man.Count defb 0 | public Man.Count
Snd.Address defw 0 | public Snd.Address
Clock defb 0
TimeRate defb 0 | public TimeRate

    cseg

entry:
    jsr Init
    lda #0
    sta Score
    sta Score+1
    sta HiScore
    sta HiScore+1
    sta Stage.Time
    sta Stage.Time+1
    sta Snd.Address
    sta Snd.Address+1
    sta Kn.Invent
    sta stage
    lda #3
    sta Man.Count
    Title:
    jsr TitleScreen
    do
        ;jsr ScanStop
        ;beq Exit
        jsr ScanKeys
        and #Keys.Button.0 or Keys.Button.1
    while eq | wend

    StartGame:
    lda #0
    sta Score
    sta Score+1
    lda #3
    sta Man.Count
    jsr ScanKeys
    and #Keys.Button.1
    if eq
        lda #0
        sta stage
    endif
                        ;lda #16 | sta stage
    StartStage:
    jsr ClearVram
    jsr PrintStatus
    lda #0
    sta man.status.die
    sta Clock
    sta base.x
    sta base.y
    sta Stage.Clear
    jsr InitMap
    jsr MapToVVram
    jsr Man.Draw
    jsr Mon.Draw
    jsr Goal.Draw
    jsr Kn.Draw
    jsr VVramToVram
    jsr PrintStatus
    jsr Snd.Start
                        ;;;lda #2 | sta Stage.Time

    loop:
        jsr Kn.Move
        jsr Man.Move
        jsr Mon.Move
        jsr Kn.Move

        jsr MapToVVram
        jsr Man.Draw
        jsr Mon.Draw
        jsr Goal.Draw
        jsr Kn.Draw
        jsr VVramToVram
        jsr Sound

        inc clock
        lda clock
        cmp TimeRate
        if cs
            lda #0
            sta clock
            lda Stage.Time | sec | sbc #1 | sta Stage.Time
            lda Stage.Time+1 | sbc #0 | sta Stage.Time+1
            jsr PrintTime
            lda Stage.Time
            ora Stage.Time+1
            if eq
                jsr PrintTimeup
                lda #15
                do
                    pha
                        jsr Snd.Die
                        lda #low 3000 | sta Zp.Word.low
                        lda #high 3000 | sta Zp.Word.high
                        do 
                            lda Zp.Word.low | sec | sbc #1 | sta Zp.Word.low
                            lda Zp.Word.high sbc #0 | sta Zp.Word.high
                        while ne | wend
                    pla
                    sec | sbc #1
                while ne | wend
                jmp Die
            endif
        endif

        lda man.status.die
        if ne
            jsr Man.Die
            Die:
            dec Man.Count
            beq GameOver
            jmp StartStage
        endif
        lda Stage.Clear
        if ne
            jsr Man.Draw
            jsr ReadStick
            jsr VVramToVram
            jsr Snd.Clear
            lda Stage.Time | ora Stage.Time+1
            do | while ne
                lda #1
                jsr AddScore
                lda Stage.Time | sec | sbc #1 | sta Stage.Time
                lda Stage.Time+1 | sbc #0 | sta Stage.Time+1
                jsr PrintTime
                jsr Snd.Get
                lda Stage.Time | ora Stage.Time+1
            wend
            inc stage
            jmp StartStage
        endif
        ;jsr ScanStop
        ;beq Exit
    jmp loop
    GameOver:
        jsr Print.Over
        jsr Snd.Over
        jmp Title
    Exit:
jmp Fin


Sound:
    lda Snd.Address
    ora Snd.Address+1
    if ne
        jsr SoundJump
        lda #0
        sta Snd.Address
        sta Snd.Address+1
    endif
rts
SoundJump:
    jmp (Snd.Address)


extrn PrintScore
AddScore: public AddScore
; in:
;	a : points to add
    clc | adc Score.low | sta Score.low
    lda Score.high | adc #0 | sta Score.high
    cmp HiScore.high
    if eq
        lda Score.low
        cmp HiScore.low
        bcs updateHi
    else
        if cs 
            updateHi:
            lda Score.low | sta HiScore.low
            lda Score.high | sta HiScore.high
        endif
    endif
    jsr PrintScore
rts
