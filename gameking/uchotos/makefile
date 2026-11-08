.SUFFIXES: .c .asm .obj .wav .adp

name=uchotos

all: $(name).bin

cseg=8000-8201,4000
dseg=1000
zseg=00cc

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 -v2 $*.asm

Debri.asm: Debri.c Debri.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Movable.h 
Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Man.h \
	Movable.h Chars.h Monster.h Movable.h Stage.h Movable.h \
	Main.h Sound.h ScanKeys.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Movable.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Debri.h Movable.h Sound.h Vram.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Chars.h Sprite.h \
	Movable.h Stage.h Movable.h Fire.h Movable.h Sound.h \
	Main.h Status.h OneUp.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Sprite.h Movable.h Stage.h \
	Movable.h Chars.h Math.h Man.h Movable.h Debri.h \
	Movable.h OneUp.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
OneUp.asm: OneUp.c OneUp.h Movable.h Sprite.h Movable.h Chars.h \
	Math.h Main.h Stage.h Movable.h Sound.h Status.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Math.h Chars.h Vram.h Status.h Man.h \
	Movable.h Monster.h Movable.h Fire.h Movable.h Debri.h \
	Movable.h Sprite.h Movable.h OneUp.h Movable.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Man.h Movable.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameKing.inc 
Sound.obj: Sound.asm GameKing.inc ZeroPage.inc 
Sprite.obj: Sprite.asm GameKing.inc ZeroPage.inc Vram.inc 
StageA.obj: StageA.asm ZeroPage.inc Vram.inc 
Startup.obj: Startup.asm GameKing.inc 
VramA.obj: VramA.asm GameKing.inc ZeroPage.inc Vram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = RomHead.obj Startup.obj \
	Debri.obj Fire.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Stage.obj Stages.obj Status.obj Vram.obj Chars.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

fire.adp: fire.wav
loose.adp: loose.wav
hit.adp: hit.wav
beep.adp: beep.wav
up.adp: up.wav
start.adp: start.wav
clear.adp: clear.wav
over.adp: over.wav
bgm.adp: bgm.wav

adps = \
	fire.adp loose.adp hit.adp beep.adp up.adp start.adp clear.adp over.adp bgm.adp

_raw.bin: $(objects) makefile
	LinkLE.exe _raw.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _raw.symbols.txt $(name).symbols.txt /y

$(name).bin: _raw.bin MakeRom.csx $(adps)
	dotnet script MakeRom.csx _raw2
	dotnet script MakeSoundRom.csx _raw2.bin $(name).bin $(adps) -r 5
