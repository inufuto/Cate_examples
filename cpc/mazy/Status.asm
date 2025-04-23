include "cpc.inc"
include "Mazy.inc"
include "Char.inc"

ext PrintS, PrintC, Print2x2, Print1x1, PrintSpace2x2, ClearVram
ext Score, HiScore, Stage, Stage.Time, Man.Count

status.x equ XOffset + (WindowWidth + 2)*2

    cseg

PrintNumber:
; in
;   hl: number
;   de: address
; out
;   de: next address
; use af bc
    ld bc,10000
    call PrintDigit
    ld bc,1000
    call PrintDigit
    PrintNumber3:
    ld bc,100
    call PrintDigit
    ld bc,10
    call PrintDigit
    ld a,l
    add a,'0'
jp PrintC

PrintDigit:
    xor a
    do
        inc a
        sbc hl,bc
    while nc
    wend
    dec a
    add hl,bc
    add a,'0'
jp PrintC

PrintByte:
; in
;   a: number
;   de: address
; out
;   de: next address
; use af c
    ld c,100
    call PrintDigitB
PrintByte2:
    ld c,10
    call PrintDigitB
    add a,'0'
jp PrintC

PrintDigitB:
    ld b,0
    do
        inc b
        sub c
    while nc
    wend
    add a,c
    dec b
    push af
        ld a,b
        add a,'0'
        call PrintC
    pop af
ret 


PrintScore: public PrintScore
    ld hl,(Score)
    ld de, Vram + status.x + VramRowSize * 1
    call PrintNumber
    ld a,'0'
    call PrintC

    ld hl,(HiScore)
    ld de, Vram + status.x + VramRowSize * 5
    call PrintNumber
    ld a,'0'
    call PrintC
ret


PrintTime: public PrintTime
    ld hl,(Stage.Time)
    ld de, Vram + status.x + VramRowSize * 11 + 3*2
jp PrintNumber3


    extrn Kn.Invnt
Print.Kn.Invent:  public Print.Kn.Invent
    ld de, Vram + status.x + VramRowSize*(WindowHeight - 4)
    ld a,(Kn.Invnt)
    or a
    do | while nz
        push af
            ld a, Char.Kn.Left
            call Print1x1
        pop af
        inc de | inc de
        dec a
    wend
    ld a,(Kn.Invnt)
    neg
    add a,4
    do | while nz
        push af
            ld a, Char.Space
            call Print1x1
        pop af
        inc de | inc de
        dec a
    wend
ret 


Print.Men:
    ld de, Vram + status.x + VramRowSize * (WindowHeight-2)
    ld a,(Man.Count)
    or a
    ret z
    do
        dec a
    while nz
        push af
            ld a,Char.Man.Stop.Left
            call Print2x2
        pop af
    wend
ret


Str.Score: defb 'SCORE',0
Str.High: defb 'HIGH',0
Str.Stage: defb 'STAGE',0
Str.Time: defb 'TIME',0

PrintStatus: public PrintStatus
    call ClearVram

    ld de, Vram + status.x + VramRowSize * 0
    ld hl,Str.Score
    call PrintS

    ld de, Vram + status.x + VramRowSize * 3
    ld hl,Str.High
    call PrintS
    ld de, Vram + status.x + VramRowSize * 4
    ld hl,Str.Score
    call PrintS

    ld de, Vram + status.x + VramRowSize * 7
    ld hl,Str.Stage
    call PrintS
    ld de, Vram + status.x + VramRowSize * 8 + 4*2
    ld a,(Stage)
    inc a
    call PrintByte2

    ld de, Vram + status.x + VramRowSize * 10
    ld hl,Str.Time
    call PrintS

    call PrintScore    
    call PrintTime
    call Print.Kn.Invent
jr Print.Men


WhiteBox:
    ld de, Vram + XOffset + (WindowWidth - 9)/2*2 + VramRowSize * (WindowHeight/2 - 1)
    ld c,3
    do 
        ld b, 9
        do 
            push bc
                ld a,Char.Space
                call Print1x1
            pop bc
            inc de | inc de
        dwnz
        ex de,hl
            ld de, VramRowSize - 9*2
            add hl,de
        ex de,hl
        dec c
    while nz | wend
ret



Str.Over:   defb 'GAME OVER',0
Print.Over: public Print.Over
    call WhiteBox    
    ld de, Vram + XOffset + (WindowWidth - 9)/2*2 + VramRowSize * (WindowHeight / 2)
    ld hl, Str.Over
jp PrintS

Str.Timeup:   defb 'TIME UP',0
PrintTimeup: public PrintTimeup
    call WhiteBox    
    ld de, Vram + XOffset + (WindowWidth - 7)/2*2 + VramRowSize * (WindowHeight / 2)
    ld hl, Str.Timeup
jp PrintS


Str.Chars: defb '--- CHARACTERS ---',0
Str.Man: defb 'MAN',0
Str.Chaser: defb 'CHASER',0
Str.Disturber: defb 'DISTURBER',0
Str.Exit: defb 'EXIT',0
Str.Push: defb 'PUSH SPACE KEY',0

TitleScreen: public TitleScreen
    call PrintStatus

    ld de,Vram + XOffset + 8*2 + VramRowSize*1
    ld a, Char.Title
    ld b,4
    do
        call Print2x2
    dwnz

    ld de,Vram + XOffset + 6*2 + VramRowSize*7
    ld a, Char.Man.Remain
    call Print2x2

    ld de,Vram + XOffset + 6*2 + VramRowSize*10
    ld a, Char.Chaser
    call Print2x2

    ld de,Vram + XOffset + 6*2 + VramRowSize*13
    ld a, Char.Disturber
    call Print2x2

    ld de,Vram + XOffset + 6*2 + VramRowSize*16
    ld a, Char.Goal
    call Print2x2

    ld de, VRAM + XOffset + 4*2 + VramRowSize*4
    ld hl, Str.Chars
    call PrintS

    ld de, VRAM + XOffset + 10*2 + VramRowSize*8
    ld hl, Str.Man
    call PrintS

    ld de, VRAM + XOffset + 10*2 + VramRowSize*11
    ld hl, Str.Chaser
    call PrintS

    ld de, VRAM + XOffset + 10*2 + VramRowSize*14
    ld hl, Str.Disturber
    call PrintS

    ld de, VRAM + XOffset + 10*2 + VramRowSize*17
    ld hl, Str.Exit
    call PrintS

    ld de, VRAM + XOffset + 5*2 + VramRowSize*20
    ld hl, Str.Push
    call PrintS
ret 
