
ext TimerCount

OplPort equ 388h

Tempo equ 180

ToneChannelCount equ 6
AllChannelCount equ ToneChannelCount+1
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
UnitSize equ Channel_Len+1

dseg
ShortCount:
    defb 0
LongCount:
    defb 0
ChannelsOpl: public ChannelsOpl
    defs UnitSize*AllChannelCount
Time: defw 0


cseg
Inst_Melody:
	defb 23h,01h,9ah,00h,0a3h,0f4h,0f0h,23h
	defb 00h,00h,08h
Inst_Bass:
	defb 13h,41h,17h,00h,0ffh,0ffh,23h,13h
	defb 01h,00h,0ch
Inst_Chord:
	defb 13h,41h,17h,00h,0ffh,0ffh,23h,13h
	defb 01h,00h,0ch
Inst_BD:
	defb 01h,01h,18h,00h,0dfh,0f8h,6ah,6dh
	defb 01h,00h,0eh
Inst_SD:
	defb 05h,01h,00h,00h,0f8h,0aah,59h,55h
	defb 00h,00h,01h
Inst_HH:
    defb 01h,01h,00h+3fh,00h+3fh,0c8h,0d8h,0a7h,68h
	defb 00h,00h,01h
RhythmTune:
    defb 150,0 ; BD
    defb 200,0 ; SD
    defb 64,14 ; HH

WriteOpl: public WriteOpl ; (ah,al)
    push cx | push dx
        mov cx,[ShortCount]
        mov dx,OplPort
        xchg ah,al
        out dx,al
        do
            dec cl
        while nz | wend
        inc dx
        xchg ah,al
        out dx,al
        do
            dec ch
        while nz | wend
    pop dx | pop cx
ret

InitInst: ;(ahal,bx)
    push ax | push bx | push cx
        mov cl,al

        mov al,[bx] | inc bx | call WriteOpl ; Op1 AVEKM
        add ah,3
        mov al,[bx] | inc bx | call WriteOpl ; Op2 AVEKM
        add ah,20h-3
        mov al,[bx] | inc bx | call WriteOpl ; Op1 KL
        add ah,3
        mov al,[bx] | inc bx | call WriteOpl ; Op2 KL
        add ah,20h-3
        mov al,[bx] | inc bx | call WriteOpl ; Op1 AD
        add ah,3
        mov al,[bx] | inc bx | call WriteOpl ; Op2 AD
        add ah,20h-3
        mov al,[bx] | inc bx | call WriteOpl ; Op1 SR
        add ah,3
        mov al,[bx] | inc bx | call WriteOpl ; Op2 SR
        add ah,60h-3
        mov al,[bx] | inc bx | call WriteOpl ; Op1 WF
        add ah,3
        mov al,[bx] | inc bx | call WriteOpl ; Op2 WF
        
        mov ah,cl
        mov al,[bx]
        call WriteOpl ; FB
    pop cx | pop bx | pop ax
ret


cseg
InitSound1Opl: public InitSound1Opl
    mov ax,0ffffh | mov [ShortCount],ax
ret

InitSound2Opl: public InitSound2Opl
    xor cx,cx | mov [TimerCount],cl
    do
        mov al,[TimerCount]
        or al,al
    while z | wend
    xor cx,cx | mov [TimerCount],cl
    do
        inc cx
        mov al,[TimerCount]
        or al,al
    while z | wend
    mov [ShortCount],ch
    mov al,6 | mul ch
    mov [LongCount],al

    xor ax,ax
    do
        call WriteOpl
        inc ah
    while nz | wend

    mov ax,0bd20h | call WriteOpl
    
    mov bx,Inst_Melody
    mov ax,20c0h
    call InitInst
    mov ax,21c1h
    call InitInst

    mov bx,Inst_Bass
    mov ax,22c2h
    call InitInst

    mov bx,Inst_Chord
    mov ax,28c3h
    call InitInst
    mov ax,29c4h
    call InitInst
    mov ax,2ac5h
    call InitInst

    mov bx,Inst_BD
    mov ax,30c6h
    call InitInst
    mov bx,Inst_SD
    mov ax,31c7h
    call InitInst
    mov bx,Inst_HH
    mov ax,32c8h
    call InitInst

    mov bx,RhythmTune
    mov ah,0a0h+6
    mov cl,3
    do
        mov al,[bx] | inc bx
        call WriteOpl
        add ah,10h
        mov al,[bx] | inc bx
        call WriteOpl
        add ah,1-10h
        dec cl
    while nz | wend

    mov bx,ChannelsOpl
    do
        mov word ptr[bx+Channel_Ptr],0
        mov byte ptr[bx+Channel_Len],1
        add bx,UnitSize
        dec cl
    while nz | wend
    mov word ptr[di+Channel_Ptr],0
    mov byte ptr[di+Channel_Len],1
    mov word ptr[Time],0
ret


SoundHandlerOpl: public SoundHandlerOpl
    push ax | push dx | push bx
        mov ax,[time]
        sub ax,tempo
        if b
            push ax | push cx | push si
                mov si,ChannelsOpl
                mov ah,0a0h
                mov cl,ToneChannelCount
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr [si+Channel_Len]
                        if z
                            continue:
                            xor al,al ; KeyOff
                            add ah,10h
                            call WriteOpl
                            sub ah,10h
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                jmp next
                            endif
                            inc al
                            if z 
                                ; repeat
                                mov bx,[si+Channel_Start]
                                jmp continue
                            endif
                            dec al
                            mov [si+Channel_Len],al
                            inc bx
                            mov al,[bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            if nz
                                dec al
                                mov bl,al
                                xor bh,bh
                                shl bx,1
                                add bx,Scales
                                mov al,[bx] | inc bx
                                call WriteOpl
                                mov al,[bx]
                                add ah,10h
                                or al,20h ; KeyOn
                                call WriteOpl
                                sub ah,10h
                            endif
                        endif
                    endif
                    next:
                    inc ah
                    add si,UnitSize
                    dec cl
                while nz | wend

                mov bx,[si+Channel_Ptr]
                or bx,bx
                if nz
                    dec byte ptr [si+Channel_Len]
                    if z
                        continueR:
                        mov ax,0bd20h
                        call WriteOpl
                        mov al,[bx]
                        or al,al
                        if z
                            ; end
                            mov word ptr [si+Channel_Ptr],0
                            jmp nextR
                        endif
                        inc al
                        if z 
                            ; repeat
                            mov bx,[si+Channel_Start]
                            jmp continueR
                        endif
                        dec al
                        mov [si+Channel_Len],al
                        inc bx
                        mov al,[bx]
                        inc bx
                        mov [si+Channel_Ptr],bx
                        or al,al
                        if nz
                            mov ah,0bdh
                            or al,20h ; KeyOn
                            call WriteOpl
                        endif
                    endif
                endif
                nextR:
            pop si | pop cx | pop ax
            add ax,600/2
        endif
        mov [time],ax
    pop bx | pop dx | pop ax
ret

Melody:
    cli
        mov [ChannelsOpl+unitSize*0+Channel_Ptr],bx
        mov byte ptr [ChannelsOpl+unitSize*0+Channel_Len],1
    sti
ret

MelodyWait:
    call Melody
    do
        cmp word ptr [ChannelsOpl+unitSize*0+Channel_Ptr],0
    while nz | wend
ret 


loose_notes:
    defb 1,A3, 0
Sound_LooseOpl: public Sound_LooseOpl
    push bx
        mov bx,loose_notes
        call MelodyWait
    pop bx
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_HitOpl: public Sound_HitOpl
    push bx
        mov bx,hit_notes
        call Melody
    pop bx
ret


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_StoleOpl: public Sound_StoleOpl
    push bx
        mov bx,stole_notes
        call Melody
    pop bx
ret


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_FireOpl: public Sound_FireOpl
    push bx
        mov bx,fire_notes
        call Melody
    pop bx
ret


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_BonusOpl: public Sound_BonusOpl
    push bx
        mov bx,bonus_notes
        call Melody
    pop bx
ret


start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_StartOpl: public Sound_StartOpl
    push bx
        mov bx,start_notes
        call MelodyWait
    pop bx
ret

clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_ClearOpl: public Sound_ClearOpl
    push bx
        mov bx,clear_notes
        call MelodyWait
    pop bx
ret

over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOverOpl: public Sound_GameOverOpl
    push bx
        mov bx,over_notes
        call MelodyWait
    pop bx
ret


BGM_B:
    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,D4, N4,D4, N8,D4, N4,E4, N4P,D4
    defb N2P,0

    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,F4, N4,F4, N8,F4, N4,A4, N4P,G4
    defb N2P,0

    defb N8,E4, N8,E4, N8,E4, N4,E4, N8,E4, N4,A4
    defb N8,D4, N8,D4, N8,D4, N4,D4, N8,D4, N4,G4
    defb N8,0, N8,A4, N8,0, N8,G4, N8,0, N8,F4, N8,0, N8,E4
    defb N4,D4, N4,E4, N2,C4

    defb 0ffh
BGM_C:
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 3
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0; 5
    defb N8,G2, N4,0, N4P,B2, N8,D3, N8,0; 6

    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 8
    defb N8,F3, N4,0, N8,F3, N8,G2, N4,0, N8,G2; 9
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 10

    defb N8,C3, N4,0, N8,C3, N8,A2, N4,0, N8,A2; 11
    defb N8,D3, N4,0, N8,D3, N8,G2, N4,0, N8,G2; 12
    defb N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,G2, N8,0, N8,G2
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 14

    defb 0ffh

BGM_D1:
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;3  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;4  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;5  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;6  G

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;7  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;8  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4 , N8,0, N8,G4  ;9  F G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;10 C

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;11 C Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4 , N8,0, N8,G4  ;12 Dm G
    defb N8,0, N8,F4, N8,0, N8,F4, N8,0, N8,G4, N8,0, N8,G4 ;13 F G
    defb N8,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0 ;14 C

    defb 0ffh

BGM_D2:
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;3  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;4  Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;5  Dm
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;6  G

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;7  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;8  Am
    defb N4,C4, N8,0, N8,C4, N8,0, N8,D4 , N8,0, N8,D4  ;9  F G
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;10 C

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;11 C Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;12 Dm G
    defb N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,D4, N8,0, N8,D4 ;13 F G
    defb N8,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0 ;14 C

    defb 0ffh

BGM_D3:
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;3  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;4  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;5  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;6  G

    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;7  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;8  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,B3 , N8,0, N8,B3  ;9  F G
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;10 C

    defb N4,G3, N8,0, N8,G3, N8,0, N8,A3 , N8,0, N8,A3  ;11 C Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,B3 , N8,0, N8,B3  ;12 Dm G
    defb N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,B3, N8,0, N8,B3 ;13 F G
    defb N8,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0 ;14 C

    defb 0ffh

BGM_R:
    defb N8,SD+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,SD

    defb N8,SD+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,SD

    defb N8,SD+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH

    defb N8,BD, N8,SD, N8,BD, N8,SD, N8,BD, N8,SD, N8,BD, N8,SD
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,SD, N8,SD, N8,SD

    defb 0ffh

BGM:
    defw 0,BGM_B,BGM_C,BGM_D1,BGM_D2,BGM_D3
    defw BGM_R


StartBGMOpl: public StartBGMOpl
    push ax | push bx | push cx | push si
        cli
            mov si,BGM
            mov bx,ChannelsOpl
            mov cl,AllChannelCount
            do
                mov ax,[si]
                inc si | inc si
                mov [bx+Channel_Ptr],ax
                mov [bx+Channel_Start],ax
                mov byte ptr[bx+Channel_Len],1
                add bx,UnitSize
                dec cl
            while nz | wend
        sti
    pop si | pop cx | pop bx | pop ax
ret


StopBGMOpl: public StopBGMOpl
    push ax | push bx | push cx
        cli
            mov bx,ChannelsOpl
            mov ax,0b000h
            mov cl,AllChannelCount
            do
                call WriteOpl
                inc ah
                mov word ptr[bx+Channel_Ptr],0
                add bx,UnitSize
                dec cl
            while nz | wend
        sti
    pop cx | pop bx | pop ax
ret

HH equ 01h
CY equ 02h
SD equ 08h
BD equ 10h

N8 equ 6
N8L equ 8
N8R equ 4
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

E2 equ 1
F2 equ 2
F2S equ 3
G2 equ 4
G2S equ 5
A2 equ 6
A2S equ 7
B2 equ 8
C3 equ 9
C3S equ 10
D3 equ 11
D3S equ 12
E3 equ 13
F3 equ 14
F3S equ 15
G3 equ 16
G3S equ 17
A3 equ 18
A3S equ 19
B3 equ 20
C4 equ 21
C4S equ 22
D4 equ 23
D4S equ 24
E4 equ 25
F4 equ 26
F4S equ 27
G4 equ 28
G4S equ 29
A4 equ 30
A4S equ 31
B4 equ 32
C5 equ 33
C5S equ 34
D5 equ 35
D5S equ 36
E5 equ 37
F5 equ 38
F5S equ 39
G5 equ 40

Scales:
defb 96,7 ; E2
defb 147,7 ; F2
defb 201,7 ; F2S
defb 1,10 ; G2
defb 32,10 ; G2S
defb 64,10 ; A2
defb 99,10 ; A2S
defb 135,10 ; B2
defb 173,10 ; C3
defb 214,10 ; C3S
defb 1,11 ; D3
defb 47,11 ; D3S
defb 95,11 ; E3
defb 147,11 ; F3
defb 201,11 ; F3S
defb 1,14 ; G3
defb 32,14 ; G3S
defb 64,14 ; A3
defb 99,14 ; A3S
defb 135,14 ; B3
defb 173,14 ; C4
defb 214,14 ; C4S
defb 1,15 ; D4
defb 47,15 ; D4S
defb 95,15 ; E4
defb 147,15 ; F4
defb 201,15 ; F4S
defb 1,18 ; G4
defb 32,18 ; G4S
defb 64,18 ; A4
defb 99,18 ; A4S
defb 135,18 ; B4
defb 173,18 ; C5
defb 214,18 ; C5S
defb 1,19 ; D5
defb 47,19 ; D5S
defb 95,19 ; E5
defb 147,19 ; F5
defb 201,19 ; F5S
defb 1,22 ; G5
