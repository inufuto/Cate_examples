name=battlot
filename=$(name)

all: $(filename) $(name).wav $(name).rom $(name).d88 $(name).dsk

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Stage.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h Direction.h Stage.h \
	Robo.h Bullet.h Fort.h 
Direction.asm: Direction.c Direction.h 
EnemyRobo.asm: EnemyRobo.c Robo.h Bullet.h Sprite.h Main.h Fort.h \
	Stage.h Direction.h Bullet.h Bang.h Sound.h 
Fort.asm: Fort.c Fort.h Vram.h Chars.h Stage.h Robo.h \
	Bullet.h Bang.h Sprite.h Sound.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Status.h Sprite.h \
	Vram.h Robo.h Bullet.h Bullet.h Bang.h Fort.h \
	Sound.h 
MyRobo.asm: MyRobo.c Robo.h Bullet.h Sprite.h Direction.h Stage.h \
	ScanKeys.h Fort.h Bang.h Main.h Sound.h 
Robo.asm: Robo.c Robo.h Bullet.h Direction.h Sprite.h Stage.h \
	Fort.h Bullet.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Vram.h \
	Chars.h Fort.h Robo.h Bullet.h Bullet.h Bang.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
Init.obj: Init.asm BIOS.inc 
Loader.obj: Loader.asm BIOS.inc BinSize.inc
PrintA.obj: PrintA.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm BIOS.inc 
SpriteA.obj: SpriteA.asm BIOS.inc Vram.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc 

objects = Main.obj \
	Bang.obj Bullet.obj Direction.obj EnemyRobo.obj Fort.obj MyRobo.obj \
	Robo.obj Stage.obj Stages.obj Status.obj Vram.obj Chars.obj \
	Init.obj PrintA.obj ScanKeys.obj Sound.obj SpriteA.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).rom: chead.obj $(objects) makefile
	LinkLE.exe $(name).rom 4000 e000 chead.obj $(objects)
	copy $(name).symbols.txt $(name).rom.symbols.txt /y

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex 8300 8000 $(objects)
	copy $(name).symbols.txt $(name).disk.symbols.txt /y

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)

$(name).cas: $(objects) makefile
	LinkLE.exe $(name).cas C300 C000 $(objects)
	copy $(name).symbols.txt $(name).tape.symbols.txt /y

$(name).wav: $(name).cas
	cas2wav $(name).cas $(name).wav


BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) 8300

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin 8300 8000 $(objects)

Loader.bin: Loader.obj makefile
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
