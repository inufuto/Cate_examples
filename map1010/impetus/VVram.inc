TileSize equ 4
VVramWidth equ 32
VVramHeight equ 24-2

GroundWidth equ VVramWidth / TileSize
GroundHeight equ (VVramHeight + TileSize * 2 - 1) / TileSize
