name=antiair

all: $(name).rom

cseg=0400
dseg=3000

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Block.asm: Block.c Block.h Movable.h Sprite.h Movable.h Chars.h \
	VVram.h CopyMemory.h Chars.h Bang.h Movable.h Sound.h \
	Cannon.h Movable.h Status.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Movable.h Chars.h VVram.h \
	Sound.h Cannon.h Movable.h Ufo.h Stage.h Block.h \
	Movable.h 
Cannon.asm: Cannon.c Cannon.h Movable.h VVram.h Sprite.h Movable.h \
	Chars.h ScanKeys.h Bullet.h Block.h Movable.h Bang.h \
	Movable.h Sound.h 
Main.asm: Main.c Status.h ScanKeys.h Sound.h Stage.h Cannon.h \
	Movable.h Sprite.h Movable.h Bullet.h Vram.h VVram.h \
	Ufo.h Stage.h Bang.h Movable.h Block.h Movable.h \
	Status.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h 
Stage.asm: Stage.c Stages.h Stage.h Vram.h VVram.h Math.h \
	Status.h Sprite.h Movable.h Cannon.h Movable.h Bullet.h \
	Ufo.h Stage.h Bang.h Movable.h Block.h Movable.h 
Stages.asm: Stages.c Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h VVram.h Print.h Chars.h \
	Sprite.h Movable.h 
Ufo.asm: Ufo.c Ufo.h Stage.h VVram.h Movable.h CopyMemory.h \
	Chars.h Bang.h Movable.h Sound.h Block.h Movable.h \
	Math.h Status.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Ufo.h Stage.h \
	Block.h Movable.h Sprite.h Movable.h Sound.h 
VVram.asm: VVram.c Vram.h VVram.h Chars.h Sprite.h Movable.h \
	Sound.h Stage.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm Pasogo.inc BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
Reset.obj: Reset.asm 
ScanKeys.obj: ScanKeys.asm Pasogo.inc 
Sound.obj: Sound.asm Pasogo.inc 
Startup.obj: Startup.asm Pasogo.inc 
VramA.obj: VramA.asm Pasogo.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Block.obj Bullet.obj Cannon.obj Main.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Ufo.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx makefile
	dotnet script BinSize.csx $(name)

Reset.bin: Reset.obj makefile
	LinkLE.exe Reset.bin fff0 0000 Reset.obj

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 0000 0000 Loader.obj

$(name).rom: $(name).bin  Loader.bin Reset.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
