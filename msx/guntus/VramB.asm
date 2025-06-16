include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext EnemyPattern
ext EnemyRowLeft_
ext GeneratorFlag, NameFlag


; void ClearBackgound();
cseg
ClearBackgound_: public ClearBackgound_
    push af | push hl | push bc
        ld a,(NameFlag)
        or a
        if z
            ld hl,Vram_PatternName2
        else
            ld hl,Vram_PatternName
        endif
        ld e,VramHeight
        do
            xor a
            ld bc,WindowWidth
            call FILVRM
            ld bc,VramWidth
            add hl,bc
            dec e
        while nz | wend
    pop bc | pop hl | pop af
ret


; word OffPut(word vram, byte c);
cseg
OffPut_: public OffPut_
    ex af,af'
        ld a,(NameFlag)
        or a
        if z
            ld a,h
            add a,4
            ld h,a
            ld a,e
            call WRTVRM
            ld a,h
            sub 4
            ld h,a
        else
            ld a,e
            call WRTVRM
        endif
        inc hl
    ex af,af'
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    push af | push bc
        ld a,(NameFlag)
        xor 1
        ld (NameFlag),a
        add a,6
        ld b,a
        ld c,2
        call WRTVDP
    pop bc | pop af
ret


; void UpdateEnemyChars();
cseg
UpdateEnemyChars_: public UpdateEnemyChars_
    push af | push hl | push de | push bc
        ld a,(GeneratorFlag)
        or a
        if z
            ld hl,4000h+Vram_PatternGenerator2+Char_Enemy*CharHeight
        else
            ld hl,4000h+Vram_PatternGenerator+Char_Enemy*CharHeight
        endif
        ld a,(VdpOutPort)
        ld c,a
        exx
            ld a,(EnemyRowLeft_)
            and 7
            ld e,a
            ld a,8
            sub e
            ld d,a
        exx
        di
            inc c
            out (c),l
            out (c),h
            dec c

            ld hl,EnemyPattern
            ld e,3
            do
                push de
                    push hl
                        ld b,CharHeight*2
                        do
                            ld e,(hl) | inc hl
                            inc hl
                            exx
                                ld a,e
                            exx
                            or a
                            if nz
                                push bc
                                    ld b,a
                                    do
                                        srl e
                                    dwnz
                                pop bc
                            endif
                            out (c),e
                        dwnz
                    pop hl
                    push hl
                        ld b,CharHeight*2
                        do
                            inc hl
                            ld d,(hl) | inc hl
                            exx
                                ld a,d
                            exx
                            or a
                            if nz
                                push bc
                                    ld b,a
                                    do
                                        sla d
                                    dwnz
                                pop bc
                            endif
                            out (c),d
                        dwnz
                    pop hl
                    push hl
                        ld b,CharHeight*2
                        do
                            ld e,(hl) | inc hl
                            ld d,(hl) | inc hl
                            exx
                                ld a,e
                            exx
                            or a
                            if nz
                                push bc
                                    ld b,a
                                    do
                                        srl d
                                        rr e
                                    dwnz
                                pop bc
                            endif
                            out (c),e
                        dwnz
                    pop hl
                    push hl
                        ld b,CharHeight*2
                        do
                            ld e,(hl) | inc hl
                            ld d,(hl) | inc hl
                            exx
                                ld a,d
                            exx
                            or a
                            if nz
                                push bc
                                    ld b,a
                                    do
                                        sla d
                                        rl e
                                    dwnz
                                pop bc
                            endif
                            out (c),e
                        dwnz
                    pop hl
                    ld de,CharHeight*4
                    add hl,de
                pop de
                dec e
            while nz | wend
        ei
    pop bc | pop de | pop hl | pop af
ret


; void SwitchChars();
cseg
SwitchChars_: public SwitchChars_
    push af | push bc
        ld a,(GeneratorFlag)
        xor 1
        ld (GeneratorFlag),a
        ld b,a
        ld c,4
        call WRTVDP
    pop bc | pop af
ret


; word ForegoundAddress();
cseg
ForegoundAddress_: public ForegoundAddress_
    push af
        ld a,(NameFlag)
        or a
        if z
            ld hl,Vram_PatternName
        else
            ld hl,Vram_PatternName2
        endif
    pop af
ret


; word BackgoundAddress();
cseg
BackgoundAddress_: public BackgoundAddress_
    push af
        ld a,(NameFlag)
        or a
        if z
            ld hl,Vram_PatternName2
        else
            ld hl,Vram_PatternName
        endif
    pop af
ret


; void WriteVram(word vram, byte c);
cseg
WriteVram_: public WriteVram_
    push af
        ld a,e
        call WRTVRM
    pop af
ret


; byte ReadVram(word vram);
cseg
ReadVram_: public ReadVram_
jp RDVRM


; void EnemyRowsToVram(word vram, ptr<byte> pSource, byte width);
cseg
EnemyRowsToVram_: public EnemyRowsToVram_
    push af | push hl | push de | push bc
        ld a,(NameFlag)
        or a
        if z
            inc h | inc h | inc h | inc h
        endif
        ex de,hl
        ld b,2
        do
            push bc
                push hl | push de
                    ld b,0
                    call LDIRVM
                pop de | pop hl
                ld bc,12*2+1
                add hl,bc
                ex de,hl
                    ld bc,VramWidth
                    add hl,bc
                ex de,hl
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
ret