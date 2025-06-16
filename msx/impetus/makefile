name=impetus

filename=$(name)

all: $(filename) $(name).wav $(name).rom $(name).d88 $(name).dsk

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Vram.h Sprite.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Vram.h Math.h Main.h \
	VVram.h Chars.h Stage.h Bang.h Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Vram.h \
	Math.h 
Fighter.asm: Fighter.c Fighter.h Vram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Barrier.h Sound.h Status.h Main.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h Vram.h \
	SkyEnemy.h GroundEnemy.h Barrier.h Fort.h Sound.h 
Fort.asm: Fort.c Fort.h Sprite.h Vram.h Chars.h VVram.h \
	Stage.h Bang.h Main.h EnemyBullet.h Math.h Sound.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Sprite.h Vram.h Math.h \
	Main.h EnemyBullet.h Bang.h Main.h Sound.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Main.h Sound.h 
Main.asm: Main.c Main.h Init.h Stage.h ScanKeys.h VVram.h \
	Sprite.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h \
	Bang.h Barrier.h GroundEnemy.h Fort.h Sound.h Item.h 
Math.asm: Math.c Math.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h Vram.h Math.h Main.h \
	Fighter.h EnemyBullet.h Stage.h Bang.h Main.h Barrier.h \
	Sound.h Item.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Chars.h \
	CopyMemory.h VVram.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h \
	Bang.h Math.h Status.h Barrier.h GroundEnemy.h Fort.h \
	Sprite.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h VVram.h \
	Chars.h Print.h CopyMemory.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Vram.h Sprite.h Barrier.h Stage.h \
	Fort.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
CopyMemory.obj: CopyMemory.asm 
FortA.obj: FortA.asm BIOS.inc Vram.inc Chars.inc 
Init.obj: Init.asm BIOS.inc 
Loader.obj: Loader.asm BIOS.inc BinSize.inc
PrintA.obj: PrintA.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm BIOS.inc 
Sprite.obj: Sprite.asm BIOS.inc Vram.inc 
StageA.obj: StageA.asm BIOS.inc Vram.inc Chars.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc Chars.inc 
VVramA.obj: VVramA.asm Vram.inc 

objects = Main.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Math.obj SkyEnemy.obj Stage.obj Stages.obj \
	Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj FortA.obj \
	Init.obj PrintA.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).rom: chead.obj $(objects) makefile
	LinkLE.exe $(name).rom 4000 e000 chead.obj $(objects)
	copy $(name).symbols.txt $(name).rom.symbols.txt /y

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex 8900 8000 $(objects)
	copy $(name).symbols.txt $(name).disk.symbols.txt /y

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)

$(name).cas: $(objects) makefile
	LinkLE.exe $(name).cas 8900 8000 $(objects)
	copy $(name).symbols.txt $(name).tape.symbols.txt /y

$(name).wav: $(name).cas
	cas2wav $(name).cas $(name).wav


BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) 8900

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin 8900 8000 $(objects)

Loader.bin: Loader.obj makefile
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
