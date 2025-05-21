name=mazy2

all: $(name)_crt.zip

cseg=fffa-ffff,f000-f1ef,f200-fff9,e000-efff,8000
dseg=0200
zseg=00d8

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h Vram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomSprites.obj: RomSprites.asm 
ScanKeys.obj: ScanKeys.asm ZeroPage.inc 
Sound.obj: Sound.asm Zeropage.inc 
Sprite.obj: Sprite.asm Zeropage.inc Vram.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm Vram.inc ZeroPage.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm Zeropage.inc Vram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj RomChars.obj RomSprites.obj Startup.obj Sound.obj Sprite.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Math.obj Print.obj \
	ScanKeys.obj StageA.obj VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

$(name).crt: $(name).bin MaxRom.csx
	dotnet script MaxRom.csx $(name).bin

$(name)_crt.zip: $(name).crt
	7z a $(name)_crt.zip $(name).crt $(name)-8000.bin $(name)-e000.bin
