include "KeyBits.inc"
include "mazy.inc"
include "char.inc"

    extrn ScanKeys
    extrn Put2x2
    extrn ToMapSize, Tst2x2
    extrn BaseX,BaseY, Stage.Clear
    extrn map.width,map.height
    extrn Kn.Start, Kn.Invnt
    extrn goal.x,goal.y

    dseg
man.x defb 0 | public man.x
man.y defb 0 | public man.y
man.status.die defb 0 | public man.status.die
prevDir defw 0
seq.ptr defw 0
seq.index defb 0
default defb 0
chr defb 0
lastButton defb 0

    cseg
; direction structure
Dir.key equ 0
Dir.x equ Dir.key+1
Dir.y equ Dir.x+1
Dir.seq equ Dir.y+1
Dir.stop equ Dir.seq+4
Dir.knife.dir equ Dir.stop+1
Dir.knife.x equ Dir.knife.dir+1
Dir.knife.y equ Dir.knife.x+1
Dir.size equ Dir.knife.y+1
Dir.count equ 4

Directions:
    ; left direction
    defb Keys_Left
    defb -1,0
    defb Char.Man.Left.1, Char.Man.Left.0, Char.Man.Left.1, Char.Man.Left.2
    defb Char.Man.Stop.Left
    defb 0
    defb 0,0
    ; right direction
    defb Keys_Right
    defb 1,0
    defb Char.Man.Right.1, Char.Man.Right.0, Char.Man.Right.1, Char.Man.Right.2
    defb Char.Man.Stop.Right
    defb 1
    defb 1,0
    ; up direction
    defb Keys_Up
    defb 0,-1
    defb Char.Man.Up.1, Char.Man.Up.0, Char.Man.Up.1, Char.Man.Up.2
    defb Char.Man.Stop.Up
    defb 2
    defb 0,0
    ; down direction
    defb Keys_Down
    defb 0,1
    defb Char.Man.Down.1, Char.Man.Down.0, Char.Man.Down.1, Char.Man.Down.2
    defb Char.Man.Stop.Down
    defb 3
    defb 0,1
Die.Seq:
    defb Char.Man.Stop.Left, Char.Man.Stop.Down, Char.Man.Die.2, Char.Man.Die.3

Man.Init:    public Man.Init
	ld a,(hl)
	inc hl
	call ToMapSize
	ld (man.x),a
	ld a,(hl)
	inc hl
	call ToMapSize
	ld (man.y),a
    ld bc,directions + Dir.size ; right direction
    ld (prevDir),bc
    ld a,Char.Man.Stop.Right
    ld (chr),a
    xor a
    ld (seq.index),a

UpdateBasePosition:
    push hl
        ld hl,(map.width)
        ld a,l
        sub WindowWidth
        ld l,a
        ld a,h
        sub WindowHeight
        ld h,a
        
        ld a,(man.x)
        sub WindowWidth / 2
        if c
            xor a
        endif
        cp l
        if nc
            ld a,l
        endif
        ld (BaseX),a

        ld a,(man.y)
        sub WindowHeight / 2
        if c
            xor a
        endif
        cp h
        if nc
            ld a,h
        endif
        ld (BaseY),a
    pop hl
ret

Man.Move:    public Man.Move
    ld a,(man.status.die)
    or a
    ret nz

    call ScanKeys   ; -> a
    push af
        ld ix,directions
        ld de,Dir.size
        ld b,Dir.count
        ld c,a
        do
                ld a,c
                and (ix+Dir.key)
                if nz
                    ld hl,(man.x)
                    ld a,l | add a,(ix+Dir.x) | ld l,a
                    ld a,h | add a,(ix+Dir.y) | ld h,a
                    call Tst2x2
                    jr z,CanMove
                endif
                add ix,de
        dwnz
        ld ix,(prevDir) 
        ld a,c  ;key
        and Keys_Dir
        if nz
            ; cannot move but any direction key is on
            ld hl,(man.x)
            ld a,l | add a,(ix+Dir.x) | ld l,a
            ld a,h | add a,(ix+Dir.y) | ld h,a
            call Tst2x2
            if z
                CanMove:
                ld (prevDir),ix
                ld (man.x),hl

                ld a,(goal.x)
                cp l
                if z
                    ld a,(goal.y)
                    cp h
                    if z
                        ld a,1
                        ld (Stage.Clear),a
                    endif   
                endif

                ld a,(seq.index) | inc a | and 3 | ld (seq.index),a
                add a,Dir.seq
                ld e,a | ld d,0
                push ix | pop hl
                add hl,de
                ld a,(hl) | ld (chr),a
                call UpdateBasePosition
                jr TestButton
            endif
        endif
        ld a,(ix+Dir.stop)
        ld (chr),a
        ld a,-1
        ld (seq.index),a
TestButton:
    pop af
    and Keys_Button0
    if z
        xor a
        ld (lastButton),a
        ret
    endif
    ld a,(lastButton)
    or a
    ret nz
    inc a
    ld (lastButton),a
    ld a,(Kn.Invnt)
    or a
    ret z
    ; throw a knife
    ld hl,(man.x)
    ld a,l | add a,(ix+Dir.knife.x) | ld l,a
    ld a,h | add a,(ix+Dir.knife.y) | ld h,a
    ld a,(ix+Dir.knife.dir)
jp Kn.Start        

Man.Draw:    public Man.Draw
    ld hl,(man.x)
    ld a,(chr)
    call Put2x2
ret 

extrn VVramToVram, Sound_Loose
Man.Die:    public Man.Die
    ld bc,0a00h
    do
        push bc
            ld a,c
            and 3
            ld e,a
            ld d,0
            ld hl,Die.Seq
            add hl,de
            ld a,(hl)
            ld hl,(man.x) 
            call Put2x2
            call VVramToVram
            call Sound_Loose
        pop bc
        inc c
    dwnz
ret 
