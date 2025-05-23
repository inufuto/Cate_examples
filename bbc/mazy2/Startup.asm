include "Vram.inc"
include "ZeroPage.inc"

ext InitSound, SoundHandler
ext Main_

dseg
SaveInt:
    defw 0
TimerCount: 
    defb 0
Division:
    defb 0

cseg
    ldx #$c4 | lda #154 | jsr $fff4

    ldx #0
    do
        stx $fe00
        lda ScreenMode,x
        sta $fe01
        inx
        cpx #14
    while ne | wend

    ldx #0
    do
        lda PaletteValues,x
        sta $fe21
        inx
        cpx #16
    while ne | wend

    jsr InitSound

    sei
        lda #0 | sta TimerCount | sta Division
        lda $0204 | sta SaveInt
        lda $0205 | sta SaveInt+1
        lda #low Handler | sta $0204
        lda #high Handler | sta $0205
        ; lda #not 2 | sta $fe4e
        ; lda #$80 or 2 | sta $fe4e
    cli
jmp Main_

ScreenMode:
    defb $3F ; Horizontal total	
    defb $28 ; Horizontal displayed characters
    defb $31 ; Horizontal sync position
    defb $24 ; Horizontal sync width/Vertical sync time
    defb $26 ; Vertical total
    defb $00 ; Vertical total adjust
    defb $20 ; Vertical displayed characters
    defb $22 ; Vertical sync position
    defb $01 ; Interlace/Display delay/Cursor delay
    defb $07 ; Scan lines per character
    defb $67 ; Cursor start line and blink type
    defb $08 ; Cursor end line
    defb (high VramOrg) shr 3 ; Screen start address H (Address /8)
    defb (low VramOrg) shr 3 ; Screen start address L  (Address /8)

PaletteValues:
defb $7
defb $17
defb $26
defb $36
defb $47
defb $57
defb $66
defb $76
defb $85
defb $95
defb $A0
defb $B0
defb $C5
defb $D5
defb $E0
defb $F0


Handler: public Handler
    pha
        lda $fe4d
        and #$40
        if ne
            lda Division
            sec | sbc #6
            if cc
                adc #10
                pha
                txa | pha
                tya | pha
                    inc TimerCount
                    jsr SoundHandler
                pla | tay
                pla | tax
                pla
            endif
            sta Division
        endif
    pla
jmp (SaveInt)


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