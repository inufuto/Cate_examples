name=mieyen

all: $(name)_crt.zip

cseg=fffa-ffff,f000-f2bf,f2c0-fff9,e000-efff,8000
dseg=0200
zseg=00d8

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe $*.asm

Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Sound.h \
	Chars.h Man.h Movable.h Monster.h Movable.h Point.h \
	Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sprite.h \
	Movable.h Sound.h Man.h Movable.h Monster.h Movable.h \
	Fire.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Fire.h Movable.h Main.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Status.h Main.h \
	Sound.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Sprite.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Math.h \
	Sprite.h Movable.h Status.h Chars.h Vram.h CopyMemory.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
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

objects = Vectors.obj RomChars.obj RomSprites.obj Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj CopyMemory.obj Math.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

$(name).crt: $(name).bin MaxRom.csx
	dotnet script MaxRom.csx $(name).bin

$(name)_crt.zip: $(name).crt
	7z a $(name)_crt.zip $(name).crt $(name)-8000.bin $(name)-e000.bin
