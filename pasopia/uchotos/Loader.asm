include "BinSize.inc"

FDCST equ 0e4h ; FDC(uPD765) Status Register
FDCRW equ 0e5h ; FDC Read/Write Register
FDCNT equ 0e6h ; FDC Control
FDCTO equ 0e2h ; FDC TC Signal ON
FDCTF equ 0e0h ; FDC TC Signal OFF

SendByte equ 1775h
SendByteDrive equ 176fh
EndSeek equ 1746h
RecieveByte equ 1785h

SectorSize equ 256
SectorCount equ (BinSize+SectorSize-1)/SectorSize
SectorPerTrack equ 16
TrackCount equ (SectorCount+SectorPerTrack-1)/SectorPerTrack

dseg
Drive equ 0cfffh
    defb 0
Address:
    defw 0
Sector:
    defb 0
Track:
    defb 0
RemainSectorCount:
    defb 0
ThisTimeSectorCount:
    defb 0

cseg
    di

    ld hl,BinTop | ld (Address),hl
    ld de,0102h | ld (Sector),de
    ld bc,SectorCount+(SectorPerTrack-1)*100h | ld (RemainSectorCount),bc
    do
        ld a,0fh            ; Seek
        call SendByteDrive        ; コマンド + Drive/Head
        ld a,d              ; 目標シリンダ
        call SendByte        ; パラメータ送信
        call EndSeek        ; Seek完了待ち

        out (FDCTF),a       ; TC OFF
        ld a,46h            ; Read Data(MFM)
        call SendByte        ; コマンド送信
        ld a,(Drive)
        call SendByte        ; Drive/Head
        ld a,d
        call SendByte        ; C(シリンダ)
        ld a,(Drive)
        and 04h
        if z
            xor a
        else
            ld a,1
        endif
        call SendByte        ; H(ヘッド)
        ld a,e
        call SendByte        ; R(セクタ)
        ld a,01h
        call SendByte        ; N=1(256B)
        ld a,e
        ld hl,ThisTimeSectorCount
        add a,(hl)
        dec a
        call SendByte        ; EOT
        ld a,0eh
        call SendByte        ; GPL
        ld a,0ffh
        call SendByte        ; DTL

        ; 受信
        ld hl,(Address)
        ld bc,(RemainSectorCount)
        do
            push bc
                ld bc,00e5h         ; C=FDCRW, B=0(INI 256回)
                do
                    do
                        in a,(FDCST)
                        rlca
                    while nc | wend
                    and 40h
                    jr z,ReadSectorDataEnd
                    ini
                while nz | wend
            pop bc
        dwnz
        ReadSectorDataEnd:
        out (FDCTO),a       ; TC ON
                        _deb: public _deb
        ld b,7
        do
            call RecieveByte
        dwnz

        ld (Address),hl
        ld a,(Drive)
        xor 04h
        ld (Drive),a
        and 04h
        if z
            inc d
        endif
        ld e,1
        
        ld bc,(RemainSectorCount)
        ld a,c | sub b | ld c,a
        ld b,SectorPerTrack
        ld (RemainSectorCount),bc
    while nc | wend
jp BinTop
