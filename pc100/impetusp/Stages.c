#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 1
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 15, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
	},
	{ // 2
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 13, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 2, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 3
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 13, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 15, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 2, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
	},
	{ // 4
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 26, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 27, 
			Char_Terrain + 28, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 29, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 6, 
			Char_Terrain + 43, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 42, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 8, 
		},
	},
	{ // 5
		{ // chars0
			Char_Terrain + 15, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 13, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 2, 
			Char_Terrain + 36, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 30, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 6
		{ // chars0
			Char_Terrain + 15, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 17, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 36, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 35, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 7
		{ // chars0
			Char_Terrain + 15, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 36, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 8
		{ // chars0
			Char_Terrain + 15, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 9
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 13, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 19, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 2, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 30, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 40, 
		},
	},
	{ // 10
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 13, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 2, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 30, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 11
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 12
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 36, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 13
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 16, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
	},
	{ // 14
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 15
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 16
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 20, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 12, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 17
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 20, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 12, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 18
		{ // chars0
			Char_Terrain + 24, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 20, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 25, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 12, 
			Char_Terrain + 47, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 37, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 46, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 41, 
		},
	},
	{ // 19
		{ // chars0
			Char_Terrain + 24, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 25, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, 
			Char_Terrain + 47, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 46, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 20
		{ // chars0
			Char_Terrain + 24, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 47, 
			Char_Terrain + 47, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 21
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 20, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 12, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 37, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 41, 
		},
	},
	{ // 22
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 20, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 12, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 37, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 23
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, 
			Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
		},
	},
	{ // 24
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 25
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 47, 
			Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
		},
	},
	{ // 26
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 27, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 47, 
			Char_Terrain + 48, Char_Terrain + 33, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 51, Char_Terrain + 38, 
		},
	},
	{ // 27
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 47, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 28
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 13, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 19, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 2, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 30, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 40, 
		},
	},
	{ // 29
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 13, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 2, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 30, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 30
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 31
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 36, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 32
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 20, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 12, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 37, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 33
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, 
			Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
		},
	},
	{ // 34
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 17, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 35, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 35
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 22, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 36
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 47, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 37
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 38
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 17, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 35, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 4, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 39
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 29, Char_Terrain + 28, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 27, Char_Terrain + 26, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 18, 
			Char_Terrain + 0, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 6, Char_Terrain + 5, Char_Terrain + 0, 
		},
	},
	{ // 40
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 41
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 42
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 17, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 35, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 4, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 43
		{ // chars0
			Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 26, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 34, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
		},
	},
	{ // 44
		{ // chars0
			Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 45
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 10, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 46
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 47
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 25, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 46, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 14, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 48
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 25, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 46, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 14, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 49
		{ // chars0
			Char_Terrain + 19, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 40, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 50
		{ // chars0
			Char_Terrain + 19, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 13, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 40, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 2, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 51
		{ // chars0
			Char_Terrain + 19, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 40, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 3, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 52
		{ // chars0
			Char_Terrain + 21, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 41, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 53
		{ // chars0
			Char_Terrain + 21, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 41, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 10, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 54
		{ // chars0
			Char_Terrain + 21, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 25, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 41, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 46, 
			Char_Terrain + 10, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 14, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 55
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 17, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 31, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 35, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 56
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 31, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 57
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 28, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 39, Char_Terrain + 49, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 32, Char_Terrain + 48, 
		},
	},
	{ // 58
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 44, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 39, Char_Terrain + 49, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 38, Char_Terrain + 52, Char_Terrain + 43, Char_Terrain + 48, 
		},
	},
	{ // 59
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 45, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 39, Char_Terrain + 49, Char_Terrain + 50, Char_Terrain + 39, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
		},
	},
	{ // 60
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
	},
	{ // 61
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 45, 
			Char_Terrain + 48, Char_Terrain + 29, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 50, Char_Terrain + 39, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 31, Char_Terrain + 38, Char_Terrain + 38, 
		},
	},
	{ // 62
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 45, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 50, Char_Terrain + 39, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 51, Char_Terrain + 38, 
		},
	},
	{ // 63
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 29, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 64
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 65
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 27, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 33, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 66
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 26, Char_Terrain + 48, 
			Char_Terrain + 44, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 34, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 38, Char_Terrain + 52, Char_Terrain + 43, Char_Terrain + 48, 
		},
	},
	{ // 67
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
		},
	},
	{ // 68
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 44, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 38, Char_Terrain + 52, Char_Terrain + 51, Char_Terrain + 38, 
		},
	},
	{ // 69
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 27, Char_Terrain + 45, Char_Terrain + 45, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 44, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 33, Char_Terrain + 39, Char_Terrain + 39, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 42, Char_Terrain + 51, Char_Terrain + 38, 
		},
	},
	{ // 70
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 17, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 35, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 71
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 19, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 40, 
		},
	},
	{ // 72
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 41, 
		},
	},
	{ // 73
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 74
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 25, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 46, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 75
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 10, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 76
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 77
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 25, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 46, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 14, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 78
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 25, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 46, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 14, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 79
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 32, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 80
		{ // chars0
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
			Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 48, 
		},
	},
	{ // 81
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 28, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
		},
	},
	{ // 82
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
		},
	},
	{ // 83
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 45, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 28, Char_Terrain + 48, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 43, Char_Terrain + 48, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 50, Char_Terrain + 39, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 51, Char_Terrain + 38, 
		},
	},
	{ // 84
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 85
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
};

static const byte[] mapBytes0 = {
	128 + 55, 73, 53, 128 + 3, 44, 43, 128 + 3, 73, 
	16, 128 + 3, 85, 82, 128 + 3, 73, 35, 128 + 3, 
	84, 83, 128 + 4, 67, 128 + 3, 80, 79, 128 + 4, 
	73, 46, 46, 47, 128 + 3, 73, 72, 53, 
	128 + 3, 14, 73, 73, 53, 45, 128 + 3, 14, 
	15, 73, 73, 14, 14, 19, 24, 24, 
	27, 73, 73, 14, 14, 76, 41, 42, 
	128 + 3, 73, 16, 14, 14, 0, 0, 70, 
	73, 73, 32, 16, 14, 0, 0, 38, 
	73, 65, 43, 32, 16, 128 + 3, 0, 70, 
	63, 81, 73, 35, 128 + 3, 0, 38, 55, 
	79, 73, 73, 128 + 4, 0, 38, 70, 73, 
	53, 128 + 5, 0, 38, 70, 16, 128 + 6, 0, 
	38, 34, 128 + 7, 0, 37, 128 + 3, 0, 6, 
	9, 128 + 6, 0, 37, 40, 128 + 10, 0, 7, 
	128 + 6, 0, 1, 73, 0, 0, 1, 7, 
	11, 11, 12, 65, 10, 3, 8, 73, 
	53, 47, 73, 64, 73, 31, 73, 73, 
	16, 15, 73, 63, 128 + 4, 73, 35, 27, 
	73, 56, 128 + 8, 67, 73, 73, 72, 53, 
	47, 128 + 5, 73, 52, 14, 15, 73, 69, 
	67, 73, 73, 16, 15, 20, 73, 60, 
	128 + 3, 73, 35, 27, 73, 73, 60, 73, 
	128 + 6, 67, 58, 128 + 7, 73, 60, 128 + 3, 73, 
	65, 43, 73, 73, 60, 128 + 3, 73, 64, 
	82, 73, 54, 60, 128 + 3, 73, 63, 81, 
	73, 17, 60, 128 + 3, 73, 56, 79, 73, 
	36, 60, 73, 128 + 6, 67, 58, 128 + 3, 73, 
	53, 46, 47, 73, 60, 128 + 3, 73, 128 + 3, 
	14, 73, 61, 67, 73, 73, 16, 14, 
	15, 128 + 5, 73, 35, 24, 27, 73, 73, 
	73, 
};
static const byte[] mapBytes1 = {
	128 + 56, 73, 128 + 7, 67, 66, 128 + 7, 73, 60, 
	128 + 3, 73, 53, 46, 47, 73, 60, 128 + 3, 
	73, 16, 14, 15, 73, 60, 128 + 3, 73, 
	35, 24, 27, 73, 60, 128 + 7, 67, 57, 
	128 + 11, 73, 71, 51, 128 + 3, 41, 73, 51, 
	41, 40, 128 + 4, 0, 73, 128 + 7, 0, 71, 
	128 + 7, 0, 40, 128 + 17, 0, 7, 10, 128 + 6, 
	0, 70, 71, 0, 0, 1, 7, 0, 
	0, 37, 40, 0, 0, 8, 73, 128 + 6, 
	0, 70, 73, 128 + 6, 0, 37, 41, 128 + 8, 
	0, 11, 10, 2, 128 + 5, 0, 73, 73, 
	29, 2, 128 + 4, 0, 128 + 3, 73, 29, 2, 
	128 + 3, 0, 73, 73, 53, 47, 29, 0, 
	1, 7, 73, 73, 16, 15, 73, 0, 
	8, 128 + 3, 73, 35, 27, 73, 0, 73, 
	73, 69, 128 + 4, 67, 4, 67, 67, 60, 
	73, 53, 47, 73, 0, 53, 46, 60, 
	73, 16, 15, 73, 0, 14, 14, 60, 
	73, 35, 27, 73, 0, 14, 14, 60, 
	128 + 4, 73, 0, 16, 14, 60, 128 + 4, 73, 
	0, 35, 24, 62, 67, 67, 68, 67, 
	4, 67, 67, 60, 73, 73, 60, 71, 
	0, 73, 73, 39, 41, 41, 39, 40, 
	1, 73, 53, 13, 11, 11, 13, 11, 
	12, 73, 16, 60, 53, 47, 60, 53, 
	47, 73, 35, 60, 16, 15, 60, 16, 
	15, 73, 73, 60, 35, 27, 60, 35, 
	27, 73, 73, 61, 67, 67, 59, 128 + 4, 
	67, 128 + 15, 73, 73, 
};
static const byte[] mapBytes2 = {
	128 + 40, 73, 46, 47, 128 + 6, 73, 14, 15, 
	128 + 6, 73, 24, 26, 128 + 6, 67, 73, 60, 
	128 + 7, 73, 60, 128 + 3, 73, 53, 46, 46, 
	73, 60, 128 + 3, 73, 16, 14, 14, 73, 
	60, 128 + 3, 73, 35, 24, 24, 67, 59, 
	128 + 6, 67, 128 + 8, 73, 46, 47, 128 + 3, 73, 
	71, 51, 41, 14, 15, 73, 51, 41, 
	40, 0, 0, 24, 27, 73, 128 + 5, 0, 
	47, 73, 71, 128 + 5, 0, 15, 73, 49, 
	128 + 5, 0, 27, 71, 128 + 6, 0, 73, 50, 
	128 + 6, 0, 73, 28, 128 + 6, 0, 73, 49, 
	128 + 6, 0, 73, 128 + 7, 0, 73, 2, 128 + 6, 
	0, 73, 29, 2, 128 + 5, 0, 46, 47, 
	30, 10, 2, 128 + 3, 0, 14, 15, 73, 
	73, 29, 2, 0, 0, 23, 25, 66, 
	73, 73, 29, 0, 0, 73, 73, 60, 
	73, 53, 47, 0, 7, 73, 73, 60, 
	73, 16, 14, 0, 73, 47, 73, 60, 
	73, 35, 24, 0, 73, 14, 73, 62, 
	128 + 3, 67, 4, 67, 14, 73, 60, 73, 
	53, 47, 0, 73, 14, 73, 60, 73, 
	16, 14, 0, 73, 14, 73, 60, 73, 
	35, 24, 0, 73, 15, 73, 60, 128 + 3, 
	73, 0, 73, 27, 73, 62, 67, 68, 
	67, 4, 67, 73, 73, 60, 73, 60, 
	71, 0, 73, 41, 41, 39, 41, 39, 
	40, 1, 73, 11, 11, 13, 11, 13, 
	11, 12, 128 + 3, 73, 60, 54, 60, 54, 
	74, 73, 67, 67, 58, 14, 60, 14, 
	76, 46, 73, 73, 60, 17, 60, 16, 
	14, 14, 73, 73, 60, 36, 60, 35, 
	24, 24, 46, 47, 61, 67, 59, 128 + 3, 
	67, 14, 15, 128 + 6, 73, 24, 27, 128 + 5, 
	73, 73, 
};
static const byte[] mapBytes3 = {
	128 + 49, 73, 53, 47, 73, 53, 128 + 3, 46, 
	73, 16, 15, 73, 16, 128 + 3, 14, 73, 
	35, 27, 73, 35, 128 + 3, 24, 128 + 6, 67, 
	66, 128 + 7, 73, 60, 73, 72, 53, 46, 
	47, 74, 73, 60, 73, 45, 128 + 3, 14, 
	77, 73, 62, 67, 14, 19, 21, 14, 
	14, 73, 60, 73, 14, 76, 45, 14, 
	14, 73, 60, 73, 128 + 4, 14, 15, 73, 
	62, 67, 128 + 4, 14, 20, 73, 60, 73, 
	22, 16, 14, 15, 73, 73, 60, 73, 
	73, 35, 24, 27, 73, 73, 60, 128 + 7, 
	73, 60, 128 + 3, 73, 53, 47, 74, 73, 
	62, 67, 73, 73, 16, 14, 77, 73, 
	60, 73, 42, 70, 32, 16, 15, 73, 
	60, 73, 0, 38, 70, 35, 27, 73, 
	60, 73, 0, 0, 37, 128 + 3, 41, 39, 
	41, 0, 1, 7, 128 + 3, 11, 13, 11, 
	0, 8, 73, 73, 69, 67, 59, 67, 
	1, 128 + 3, 73, 60, 128 + 3, 73, 12, 65, 
	43, 73, 60, 128 + 4, 73, 64, 82, 73, 
	62, 128 + 3, 67, 73, 63, 81, 73, 60, 
	128 + 4, 73, 56, 79, 73, 60, 73, 53, 
	46, 128 + 4, 67, 58, 73, 16, 14, 128 + 4, 
	73, 60, 73, 35, 24, 73, 69, 67, 
	67, 58, 73, 72, 53, 47, 60, 73, 
	73, 60, 72, 52, 14, 15, 60, 53, 
	47, 60, 52, 14, 14, 27, 60, 16, 
	15, 60, 14, 14, 19, 67, 58, 35, 
	27, 60, 16, 14, 76, 73, 62, 67, 
	67, 58, 32, 16, 14, 47, 60, 73, 
	73, 60, 73, 32, 16, 15, 60, 73, 
	73, 60, 73, 73, 35, 25, 58, 73, 
	73, 60, 53, 47, 73, 73, 60, 73, 
	73, 60, 16, 15, 73, 73, 60, 73, 
	73, 60, 35, 27, 73, 73, 61, 67, 
	67, 59, 128 + 3, 67, 128 + 15, 73, 73, 
};
static const byte[] mapBytes4 = {
	128 + 56, 73, 128 + 4, 67, 68, 128 + 3, 67, 128 + 4, 
	73, 60, 128 + 3, 73, 46, 46, 47, 73, 
	60, 128 + 3, 73, 14, 14, 15, 73, 60, 
	128 + 3, 73, 24, 24, 27, 73, 60, 73, 
	73, 53, 128 + 4, 67, 57, 73, 73, 14, 
	128 + 7, 73, 16, 71, 51, 128 + 3, 41, 42, 
	70, 35, 40, 128 + 5, 0, 37, 41, 128 + 43, 
	0, 1, 5, 2, 128 + 5, 0, 8, 73, 
	29, 128 + 5, 0, 70, 73, 71, 128 + 5, 0, 
	37, 41, 40, 128 + 26, 0, 10, 2, 0, 
	0, 1, 7, 10, 2, 73, 29, 0, 
	1, 8, 73, 73, 30, 73, 73, 0, 
	8, 128 + 6, 73, 0, 128 + 5, 73, 67, 67, 
	4, 128 + 5, 67, 47, 73, 0, 53, 46, 
	46, 47, 73, 15, 73, 0, 128 + 4, 14, 
	73, 27, 73, 0, 128 + 4, 14, 128 + 3, 73, 
	0, 16, 14, 14, 15, 73, 69, 67, 
	4, 33, 23, 23, 25, 67, 60, 71, 
	0, 128 + 5, 73, 39, 40, 1, 73, 73, 
	65, 43, 73, 13, 11, 12, 54, 73, 
	64, 82, 73, 60, 73, 73, 17, 73, 
	63, 81, 73, 60, 54, 74, 36, 73, 
	56, 79, 73, 60, 16, 78, 73, 73, 
	69, 67, 67, 60, 35, 27, 73, 73, 
	60, 73, 73, 61, 128 + 4, 67, 57, 128 + 17, 
	73, 73, 
};
static const byte[] mapBytes5 = {
	128 + 53, 73, 53, 47, 73, 44, 43, 128 + 3, 
	73, 16, 15, 73, 85, 82, 128 + 3, 73, 
	35, 27, 73, 84, 83, 128 + 6, 67, 80, 
	79, 128 + 6, 73, 47, 128 + 3, 73, 72, 53, 
	46, 46, 14, 73, 73, 53, 45, 128 + 3, 
	14, 15, 73, 73, 14, 14, 19, 21, 
	14, 27, 73, 73, 14, 14, 76, 45, 
	14, 128 + 3, 73, 16, 128 + 4, 14, 128 + 3, 73, 
	32, 16, 128 + 3, 14, 42, 73, 65, 43, 
	32, 16, 14, 14, 0, 70, 63, 81, 
	73, 35, 24, 24, 0, 38, 55, 79, 
	128 + 4, 73, 0, 0, 38, 70, 73, 73, 
	53, 46, 128 + 3, 0, 38, 70, 73, 16, 
	14, 128 + 4, 0, 38, 70, 32, 16, 128 + 5, 
	0, 38, 70, 35, 0, 6, 9, 128 + 3, 
	0, 37, 41, 0, 37, 40, 0, 0, 
	1, 7, 11, 128 + 5, 0, 8, 73, 73, 
	128 + 4, 0, 1, 128 + 3, 73, 1, 7, 11, 
	11, 12, 65, 43, 73, 12, 73, 53, 
	47, 73, 64, 82, 128 + 3, 73, 16, 15, 
	73, 63, 81, 128 + 3, 73, 35, 27, 73, 
	56, 79, 73, 128 + 8, 67, 128 + 13, 73, 69, 
	67, 67, 128 + 3, 73, 53, 47, 60, 128 + 5, 
	73, 16, 15, 60, 53, 46, 128 + 3, 67, 
	33, 25, 58, 16, 14, 128 + 5, 73, 60, 
	35, 24, 44, 43, 128 + 3, 73, 62, 67, 
	67, 85, 82, 73, 53, 47, 60, 73, 
	73, 84, 81, 73, 16, 15, 60, 73, 
	73, 80, 79, 73, 35, 27, 60, 73, 
	73, 128 + 5, 67, 58, 73, 73, 46, 46, 
	47, 73, 73, 60, 73, 73, 128 + 3, 14, 
	73, 73, 61, 67, 67, 14, 14, 15, 
	128 + 5, 73, 24, 24, 27, 128 + 4, 73, 73, 

};
static const byte[] mapBytes6 = {
	128 + 41, 73, 72, 53, 47, 128 + 5, 73, 52, 
	14, 14, 128 + 5, 73, 128 + 3, 14, 73, 69, 
	67, 67, 73, 16, 14, 15, 73, 60, 
	128 + 3, 73, 35, 24, 27, 73, 60, 128 + 7, 
	73, 60, 128 + 7, 73, 60, 73, 73, 67, 
	67, 68, 67, 67, 59, 67, 67, 73, 
	73, 60, 128 + 7, 73, 60, 73, 53, 47, 
	128 + 4, 73, 60, 73, 16, 15, 73, 51, 
	73, 73, 60, 73, 35, 27, 73, 0, 
	73, 73, 60, 53, 47, 73, 71, 0, 
	67, 67, 58, 16, 15, 73, 49, 0, 
	73, 73, 60, 35, 27, 71, 0, 0, 
	73, 73, 60, 73, 73, 50, 0, 0, 
	73, 73, 60, 73, 73, 28, 0, 0, 
	73, 73, 60, 73, 73, 49, 0, 0, 
	67, 67, 58, 73, 73, 128 + 3, 0, 73, 
	73, 60, 73, 73, 2, 0, 0, 73, 
	73, 60, 73, 73, 29, 2, 0, 73, 
	73, 60, 73, 53, 47, 30, 11, 73, 
	73, 60, 73, 16, 15, 73, 73, 67, 
	67, 59, 67, 33, 25, 66, 128 + 7, 73, 
	60, 73, 46, 47, 73, 73, 53, 47, 
	60, 73, 14, 14, 74, 73, 14, 14, 
	60, 73, 14, 14, 77, 73, 14, 14, 
	62, 67, 128 + 3, 14, 73, 16, 15, 60, 
	73, 128 + 3, 14, 74, 35, 27, 60, 73, 
	128 + 3, 14, 77, 73, 73, 60, 73, 128 + 3, 
	14, 15, 73, 73, 60, 73, 14, 14, 
	15, 20, 73, 73, 62, 67, 24, 24, 
	27, 128 + 3, 73, 60, 73, 128 + 6, 41, 39, 
	41, 128 + 6, 11, 13, 11, 128 + 6, 73, 60, 
	53, 128 + 6, 67, 58, 14, 128 + 6, 73, 60, 
	16, 73, 53, 47, 128 + 3, 73, 60, 35, 
	73, 16, 15, 73, 53, 47, 61, 67, 
	73, 35, 27, 73, 16, 15, 128 + 6, 73, 
	35, 27, 73, 73, 
};
static const byte[] mapBytes7 = {
	128 + 48, 73, 47, 128 + 7, 73, 15, 128 + 4, 73, 
	65, 43, 73, 27, 128 + 4, 73, 63, 81, 
	73, 128 + 4, 67, 66, 56, 79, 73, 47, 
	74, 73, 73, 62, 128 + 3, 67, 14, 77, 
	74, 73, 60, 128 + 3, 73, 14, 14, 77, 
	73, 62, 128 + 3, 67, 21, 14, 14, 73, 
	60, 128 + 3, 73, 45, 14, 14, 73, 60, 
	128 + 3, 73, 14, 14, 15, 73, 62, 128 + 3, 
	67, 14, 14, 20, 73, 60, 128 + 3, 73, 
	14, 15, 73, 73, 60, 53, 47, 73, 
	15, 20, 73, 73, 60, 16, 15, 73, 
	27, 128 + 3, 73, 60, 35, 27, 73, 47, 
	128 + 3, 73, 61, 128 + 3, 67, 14, 128 + 4, 73, 
	53, 47, 73, 15, 128 + 4, 73, 16, 15, 
	73, 27, 128 + 4, 73, 35, 27, 73, 128 + 8, 
	41, 128 + 8, 11, 73, 73, 69, 128 + 5, 67, 
	73, 73, 60, 128 + 5, 73, 43, 73, 60, 
	128 + 5, 73, 82, 73, 62, 128 + 5, 67, 81, 
	73, 60, 128 + 5, 73, 79, 73, 60, 73, 
	53, 48, 73, 73, 67, 67, 58, 73, 
	17, 20, 128 + 4, 73, 60, 73, 36, 72, 
	53, 46, 67, 67, 58, 73, 72, 52, 
	14, 14, 73, 73, 60, 73, 52, 128 + 3, 
	14, 46, 47, 60, 73, 128 + 5, 14, 15, 
	60, 73, 14, 14, 18, 14, 24, 27, 
	60, 73, 16, 14, 75, 14, 67, 67, 
	58, 73, 32, 16, 14, 14, 73, 73, 
	60, 73, 73, 32, 14, 14, 73, 73, 
	60, 128 + 3, 73, 16, 14, 73, 73, 60, 
	53, 47, 73, 32, 14, 73, 73, 60, 
	16, 15, 73, 73, 16, 73, 73, 60, 
	35, 27, 73, 73, 35, 67, 67, 59, 
	128 + 5, 67, 128 + 15, 73, 73, 
};

static const SkyElement[] SkyElements0 = {
	{ 47, 0x01 },
	{ 36, 0x00 },
	{ 35, 0x02 },
	{ 24, 0x00 },
	{ 23, 0x08 },
	{ 17, 0x00 },
	{ 16, 0x04 },
	{ 5, 0x00 },
	{ 4, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements1 = {
	{ 47, 0x01 },
	{ 35, 0x03 },
	{ 32, 0x02 },
	{ 28, 0x0a },
	{ 20, 0x08 },
	{ 13, 0x00 },
	{ 12, 0x04 },
	{ 7, 0x05 },
	{ 5, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements2 = {
	{ 47, 0x01 },
	{ 37, 0x03 },
	{ 29, 0x02 },
	{ 28, 0x0a },
	{ 17, 0x08 },
	{ 16, 0x0c },
	{ 13, 0x04 },
	{ 7, 0x05 },
	{ 5, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements3 = {
	{ 47, 0x01 },
	{ 41, 0x03 },
	{ 26, 0x02 },
	{ 19, 0x06 },
	{ 14, 0x04 },
	{ 7, 0x0c },
	{ 1, 0x08 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements4 = {
	{ 47, 0x01 },
	{ 44, 0x03 },
	{ 27, 0x0b },
	{ 23, 0x0a },
	{ 22, 0x0e },
	{ 15, 0x06 },
	{ 11, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements5 = {
	{ 47, 0x01 },
	{ 46, 0x03 },
	{ 27, 0x0b },
	{ 25, 0x0f },
	{ 20, 0x0e },
	{ 17, 0x06 },
	{ 8, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements6 = {
	{ 47, 0x01 },
	{ 46, 0x03 },
	{ 28, 0x07 },
	{ 24, 0x0f },
	{ 17, 0x0e },
	{ 16, 0x06 },
	{ 6, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements7 = {
	{ 47, 0x01 },
	{ 46, 0x03 },
	{ 35, 0x07 },
	{ 14, 0x06 },
	{ 8, 0x0e },
	{ 4, 0x06 },
	{ 3, 0x04 },
	{ 0, 0x00 },
};


static const Route[] Route0B1 = {
	{ 1, 0, 24 },
	{ -1, 0, 26 },
};

static const Route[] Route0B2 = {
	{ -1, 0, 4 },
	{ 0, 1, 40 },
};

static const Route[] Route0B3 = {
	{ -1, 0, 30 },
};

static const Route[] Route0B5 = {
	{ -1, 0, 16 },
	{ 1, 0, 19 },
};

static const Route[] Route0B0 = {
	{ 1, 0, 24 },
	{ 0, 1, 8 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements0 = {
	{ // B0
		1, 43,
		3,
		Route0B0
	},
	{ // A16
		13, 41,
		0,
		nullptr
	},
	{ // A15
		9, 39,
		0,
		nullptr
	},
	{ // B1
		1, 37,
		2,
		Route0B1
	},
	{ // A13
		5, 35,
		0,
		nullptr
	},
	{ // B2
		29, 34,
		2,
		Route0B2
	},
	{ // B3
		29, 32,
		1,
		Route0B3
	},
	{ // A9
		9, 30,
		0,
		nullptr
	},
	{ // A10
		29, 30,
		0,
		nullptr
	},
	{ // A8
		29, 28,
		0,
		nullptr
	},
	{ // A7
		17, 24,
		0,
		nullptr
	},
	{ // A6
		21, 18,
		0,
		nullptr
	},
	{ // A5
		17, 17,
		0,
		nullptr
	},
	{ // A4
		9, 14,
		0,
		nullptr
	},
	{ // A3
		29, 13,
		0,
		nullptr
	},
	{ // B5
		29, 9,
		2,
		Route0B5
	},
	{ // A1
		9, 8,
		0,
		nullptr
	},
	{ // A0
		1, 7,
		0,
		nullptr
	},
};

static const Route[] Route1B1 = {
	{ 0, 1, 12 },
	{ 1, 0, 19 },
};

static const Route[] Route1B4 = {
	{ 1, 0, 28 },
	{ 0, -1, 20 },
	{ -1, 0, 30 },
};

static const Route[] Route1B2 = {
	{ -1, 0, 16 },
	{ 0, -1, 28 },
	{ -1, 0, 2 },
};

static const Route[] Route1B3 = {
	{ -1, 0, 16 },
	{ 0, 1, 28 },
};

static const Route[] Route1B5 = {
	{ 1, 0, 24 },
	{ -1, 0, 26 },
};

static const Route[] Route1B0 = {
	{ 0, 1, 16 },
	{ 1, 0, 31 },
};

static const GroundElement[] GroundElements1 = {
	{ // B1
		13, 42,
		2,
		Route1B1
	},
	{ // A16
		25, 42,
		0,
		nullptr
	},
	{ // B0
		1, 41,
		2,
		Route1B0
	},
	{ // B2
		17, 38,
		3,
		Route1B2
	},
	{ // A13
		13, 35,
		0,
		nullptr
	},
	{ // B3
		17, 32,
		2,
		Route1B3
	},
	{ // A11
		29, 30,
		0,
		nullptr
	},
	{ // A9
		5, 28,
		0,
		nullptr
	},
	{ // A8
		25, 22,
		0,
		nullptr
	},
	{ // A7
		13, 20,
		0,
		nullptr
	},
	{ // A6
		5, 13,
		0,
		nullptr
	},
	{ // B4
		1, 12,
		3,
		Route1B4
	},
	{ // A5
		25, 10,
		0,
		nullptr
	},
	{ // A4
		5, 9,
		0,
		nullptr
	},
	{ // A3
		25, 8,
		0,
		nullptr
	},
	{ // B5
		1, 7,
		2,
		Route1B5
	},
	{ // A0
		5, 6,
		0,
		nullptr
	},
};

static const Route[] Route2B1 = {
	{ 0, 1, 20 },
	{ 1, 0, 15 },
};

static const Route[] Route2B4 = {
	{ 1, 0, 31 },
};

static const Route[] Route2B0 = {
	{ -1, 0, 20 },
	{ 0, -1, 12 },
	{ -1, 0, 10 },
};

static const Route[] Route2B2 = {
	{ -1, 0, 12 },
	{ 0, -1, 36 },
	{ -1, 0, 10 },
};

static const Route[] Route2B3 = {
	{ -1, 0, 12 },
	{ 0, 1, 24 },
};

static const Route[] Route2B5 = {
	{ -1, 0, 24 },
	{ 0, 1, 20 },
	{ 1, 0, 27 },
};

static const GroundElement[] GroundElements2 = {
	{ // A24
		13, 46,
		0,
		nullptr
	},
	{ // B0
		29, 45,
		3,
		Route2B0
	},
	{ // A22
		25, 41,
		0,
		nullptr
	},
	{ // B1
		17, 40,
		2,
		Route2B1
	},
	{ // B2
		21, 37,
		3,
		Route2B2
	},
	{ // A20
		13, 35,
		0,
		nullptr
	},
	{ // A19
		5, 34,
		0,
		nullptr
	},
	{ // B3
		21, 32,
		2,
		Route2B3
	},
	{ // A17
		17, 31,
		0,
		nullptr
	},
	{ // A15
		13, 27,
		0,
		nullptr
	},
	{ // A14
		9, 26,
		0,
		nullptr
	},
	{ // A13
		1, 24,
		0,
		nullptr
	},
	{ // A12
		1, 22,
		0,
		nullptr
	},
	{ // A11
		5, 21,
		0,
		nullptr
	},
	{ // A10
		9, 17,
		0,
		nullptr
	},
	{ // B4
		1, 12,
		1,
		Route2B4
	},
	{ // A8
		13, 10,
		0,
		nullptr
	},
	{ // A7
		13, 9,
		0,
		nullptr
	},
	{ // A6
		17, 8,
		0,
		nullptr
	},
	{ // B5
		29, 7,
		3,
		Route2B5
	},
	{ // A4
		21, 5,
		0,
		nullptr
	},
	{ // A3
		29, 4,
		0,
		nullptr
	},
	{ // A2
		1, 3,
		0,
		nullptr
	},
	{ // A1
		29, 2,
		0,
		nullptr
	},
	{ // A0
		1, 1,
		0,
		nullptr
	},
};

static const Route[] Route3B1 = {
	{ 1, 0, 4 },
	{ 0, -1, 32 },
	{ 1, 0, 12 },
	{ 0, 1, 44 },
};

static const Route[] Route3B4 = {
	{ -1, 0, 4 },
	{ 0, -1, 44 },
	{ -1, 0, 26 },
};

static const Route[] Route3B0 = {
	{ -1, 0, 24 },
	{ 0, -1, 28 },
	{ -1, 0, 6 },
};

static const Route[] Route3B2 = {
	{ 0, -1, 72 },
	{ 1, 0, 15 },
};

static const Route[] Route3B3 = {
	{ 1, 0, 16 },
	{ 0, -1, 12 },
	{ 1, 0, 15 },
};

static const Route[] Route3B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements3 = {
	{ // A27
		5, 47,
		0,
		nullptr
	},
	{ // A26
		29, 46,
		0,
		nullptr
	},
	{ // B0
		29, 45,
		3,
		Route3B0
	},
	{ // B2
		17, 44,
		2,
		Route3B2
	},
	{ // A25
		13, 43,
		0,
		nullptr
	},
	{ // B1
		1, 42,
		4,
		Route3B1
	},
	{ // A24
		9, 41,
		0,
		nullptr
	},
	{ // A23
		9, 38,
		0,
		nullptr
	},
	{ // A21
		29, 37,
		0,
		nullptr
	},
	{ // A19
		25, 33,
		0,
		nullptr
	},
	{ // B3
		1, 32,
		3,
		Route3B3
	},
	{ // A18
		9, 30,
		0,
		nullptr
	},
	{ // A16
		5, 29,
		0,
		nullptr
	},
	{ // A15
		9, 28,
		0,
		nullptr
	},
	{ // A13
		9, 26,
		0,
		nullptr
	},
	{ // A12
		21, 21,
		0,
		nullptr
	},
	{ // B4
		29, 20,
		3,
		Route3B4
	},
	{ // A11
		17, 19,
		0,
		nullptr
	},
	{ // A10
		17, 17,
		0,
		nullptr
	},
	{ // B5
		29, 15,
		3,
		Route3B5
	},
	{ // A9
		21, 14,
		0,
		nullptr
	},
	{ // A8
		9, 13,
		0,
		nullptr
	},
	{ // A6
		17, 11,
		0,
		nullptr
	},
	{ // A5
		29, 9,
		0,
		nullptr
	},
	{ // A3
		13, 8,
		0,
		nullptr
	},
	{ // A2
		17, 5,
		0,
		nullptr
	},
	{ // A1
		1, 4,
		0,
		nullptr
	},
	{ // A0
		29, 3,
		0,
		nullptr
	},
};

static const Route[] Route4B1 = {
	{ 0, -1, 4 },
	{ 1, 0, 31 },
};

static const Route[] Route4B0 = {
	{ -1, 0, 8 },
	{ 0, 1, 8 },
	{ -1, 0, 20 },
	{ 0, -1, 20 },
};

static const Route[] Route4B2 = {
	{ 1, 0, 19 },
};

static const Route[] Route4B3 = {
	{ 1, 0, 16 },
	{ 0, -1, 20 },
	{ -1, 0, 18 },
};

static const GroundElement[] GroundElements4 = {
	{ // A25
		9, 47,
		0,
		nullptr
	},
	{ // A24
		25, 46,
		0,
		nullptr
	},
	{ // A23
		17, 44,
		0,
		nullptr
	},
	{ // B0
		29, 43,
		4,
		Route4B0
	},
	{ // A21
		9, 41,
		0,
		nullptr
	},
	{ // A22
		25, 41,
		0,
		nullptr
	},
	{ // A20
		21, 40,
		0,
		nullptr
	},
	{ // A18
		25, 39,
		0,
		nullptr
	},
	{ // B1
		1, 38,
		2,
		Route4B1
	},
	{ // A16
		29, 34,
		0,
		nullptr
	},
	{ // A15
		5, 33,
		0,
		nullptr
	},
	{ // B2
		13, 32,
		1,
		Route4B2
	},
	{ // A13
		25, 31,
		0,
		nullptr
	},
	{ // A12
		21, 29,
		0,
		nullptr
	},
	{ // A11
		21, 23,
		0,
		nullptr
	},
	{ // A10
		13, 22,
		0,
		nullptr
	},
	{ // A9
		17, 21,
		0,
		nullptr
	},
	{ // B3
		1, 12,
		3,
		Route4B3
	},
	{ // A8
		25, 12,
		0,
		nullptr
	},
	{ // A7
		13, 10,
		0,
		nullptr
	},
	{ // A6
		29, 9,
		0,
		nullptr
	},
	{ // A4
		1, 6,
		0,
		nullptr
	},
	{ // A3
		1, 4,
		0,
		nullptr
	},
	{ // A2
		29, 3,
		0,
		nullptr
	},
	{ // A1
		29, 2,
		0,
		nullptr
	},
	{ // A0
		1, 1,
		0,
		nullptr
	},
};

static const Route[] Route5B1 = {
	{ -1, 0, 8 },
	{ 0, -1, 20 },
	{ 1, 0, 11 },
};

static const Route[] Route5B4 = {
	{ 1, 0, 31 },
};

static const Route[] Route5B0 = {
	{ -1, 0, 8 },
	{ 0, -1, 8 },
	{ -1, 0, 22 },
};

static const Route[] Route5B3 = {
	{ 1, 0, 20 },
	{ 0, 1, 28 },
};

static const Route[] Route5B5 = {
	{ 1, 0, 31 },
};

static const GroundElement[] GroundElements5 = {
	{ // A28
		5, 47,
		0,
		nullptr
	},
	{ // A27
		25, 46,
		0,
		nullptr
	},
	{ // B0
		29, 45,
		3,
		Route5B0
	},
	{ // A25
		1, 41,
		0,
		nullptr
	},
	{ // A24
		5, 40,
		0,
		nullptr
	},
	{ // A23
		1, 39,
		0,
		nullptr
	},
	{ // B1
		29, 39,
		3,
		Route5B1
	},
	{ // A22
		25, 38,
		0,
		nullptr
	},
	{ // B3
		1, 37,
		2,
		Route5B3
	},
	{ // A20
		9, 35,
		0,
		nullptr
	},
	{ // A18
		13, 33,
		0,
		nullptr
	},
	{ // B4
		1, 32,
		1,
		Route5B4
	},
	{ // A16
		21, 30,
		0,
		nullptr
	},
	{ // A15
		25, 29,
		0,
		nullptr
	},
	{ // A14
		21, 28,
		0,
		nullptr
	},
	{ // A13
		9, 24,
		0,
		nullptr
	},
	{ // A12
		25, 22,
		0,
		nullptr
	},
	{ // A11
		9, 18,
		0,
		nullptr
	},
	{ // A10
		13, 17,
		0,
		nullptr
	},
	{ // A9
		5, 14,
		0,
		nullptr
	},
	{ // A8
		25, 13,
		0,
		nullptr
	},
	{ // A7
		9, 10,
		0,
		nullptr
	},
	{ // B5
		1, 9,
		1,
		Route5B5
	},
	{ // A5
		1, 8,
		0,
		nullptr
	},
	{ // A4
		5, 7,
		0,
		nullptr
	},
	{ // A2
		1, 4,
		0,
		nullptr
	},
	{ // A3
		29, 4,
		0,
		nullptr
	},
	{ // A0
		1, 0,
		0,
		nullptr
	},
	{ // A1
		29, 0,
		0,
		nullptr
	},
};

static const Route[] Route6B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 20 },
	{ 1, 0, 7 },
};

static const Route[] Route6B4 = {
	{ 1, 0, 8 },
	{ 0, -1, 24 },
	{ -1, 0, 10 },
};

static const Route[] Route6B0 = {
	{ 1, 0, 24 },
	{ 0, 1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route6B2 = {
	{ -1, 0, 26 },
};

static const Route[] Route6B3 = {
	{ 1, 0, 8 },
	{ 0, -1, 20 },
	{ -1, 0, 10 },
};

static const Route[] Route6B5 = {
	{ -1, 0, 8 },
	{ 0, -1, 20 },
	{ 1, 0, 11 },
};

static const GroundElement[] GroundElements6 = {
	{ // A23
		13, 47,
		0,
		nullptr
	},
	{ // A22
		17, 44,
		0,
		nullptr
	},
	{ // B0
		1, 42,
		3,
		Route6B0
	},
	{ // A20
		9, 41,
		0,
		nullptr
	},
	{ // A19
		29, 40,
		0,
		nullptr
	},
	{ // B1
		29, 37,
		3,
		Route6B1
	},
	{ // A18
		17, 36,
		0,
		nullptr
	},
	{ // A16
		13, 32,
		0,
		nullptr
	},
	{ // A15
		5, 29,
		0,
		nullptr
	},
	{ // B3
		1, 28,
		3,
		Route6B3
	},
	{ // B2
		25, 28,
		1,
		Route6B2
	},
	{ // A13
		1, 26,
		0,
		nullptr
	},
	{ // A11
		17, 21,
		0,
		nullptr
	},
	{ // A10
		1, 20,
		0,
		nullptr
	},
	{ // B4
		1, 18,
		3,
		Route6B4
	},
	{ // A9
		21, 16,
		0,
		nullptr
	},
	{ // A8
		5, 14,
		0,
		nullptr
	},
	{ // B5
		29, 12,
		3,
		Route6B5
	},
	{ // A6
		5, 11,
		0,
		nullptr
	},
	{ // A5
		9, 10,
		0,
		nullptr
	},
	{ // A4
		13, 9,
		0,
		nullptr
	},
	{ // A3
		17, 8,
		0,
		nullptr
	},
	{ // A1
		29, 1,
		0,
		nullptr
	},
	{ // A0
		1, 0,
		0,
		nullptr
	},
};

static const Route[] Route7B1 = {
	{ 1, 0, 8 },
	{ 0, -1, 24 },
	{ -1, 0, 10 },
};

static const Route[] Route7B4 = {
	{ -1, 0, 20 },
	{ 0, 1, 52 },
};

static const Route[] Route7B7 = {
	{ -1, 0, 12 },
	{ 0, -1, 8 },
	{ 1, 0, 15 },
};

static const Route[] Route7B0 = {
	{ -1, 0, 30 },
};

static const Route[] Route7B8 = {
	{ 1, 0, 16 },
	{ 0, 1, 40 },
};

static const Route[] Route7B2 = {
	{ 1, 0, 8 },
	{ 0, 1, 40 },
};

static const Route[] Route7B3 = {
	{ 1, 0, 8 },
	{ 0, 1, 44 },
};

static const Route[] Route7B6 = {
	{ -1, 0, 12 },
	{ 0, -1, 20 },
	{ 1, 0, 15 },
};

static const Route[] Route7B5 = {
	{ -1, 0, 20 },
	{ 0, 1, 60 },
};

static const GroundElement[] GroundElements7 = {
	{ // A29
		25, 47,
		0,
		nullptr
	},
	{ // A28
		1, 46,
		0,
		nullptr
	},
	{ // B1
		1, 45,
		3,
		Route7B1
	},
	{ // B0
		29, 45,
		1,
		Route7B0
	},
	{ // A26
		17, 41,
		0,
		nullptr
	},
	{ // A25
		5, 40,
		0,
		nullptr
	},
	{ // A23
		5, 38,
		0,
		nullptr
	},
	{ // A22
		25, 37,
		0,
		nullptr
	},
	{ // B2
		1, 34,
		2,
		Route7B2
	},
	{ // A20
		17, 33,
		0,
		nullptr
	},
	{ // B3
		1, 32,
		2,
		Route7B3
	},
	{ // A17
		1, 30,
		0,
		nullptr
	},
	{ // A18
		25, 30,
		0,
		nullptr
	},
	{ // B4
		29, 29,
		2,
		Route7B4
	},
	{ // A14
		1, 28,
		0,
		nullptr
	},
	{ // A15
		25, 28,
		0,
		nullptr
	},
	{ // A13
		17, 27,
		0,
		nullptr
	},
	{ // B5
		29, 26,
		2,
		Route7B5
	},
	{ // A11
		5, 23,
		0,
		nullptr
	},
	{ // B6
		29, 20,
		3,
		Route7B6
	},
	{ // A10
		29, 16,
		0,
		nullptr
	},
	{ // A8
		13, 14,
		0,
		nullptr
	},
	{ // A7
		1, 13,
		0,
		nullptr
	},
	{ // B7
		29, 12,
		3,
		Route7B7
	},
	{ // A5
		9, 10,
		0,
		nullptr
	},
	{ // B8
		1, 9,
		2,
		Route7B8
	},
	{ // A3
		25, 8,
		0,
		nullptr
	},
	{ // A2
		21, 7,
		0,
		nullptr
	},
	{ // A0
		1, 5,
		0,
		nullptr
	},
	{ // A1
		29, 5,
		0,
		nullptr
	},
};


const Stage[] Stages = {
	{ // 0
		mapBytes0, // pBytes
		10,SkyElements0,
		18,GroundElements0,
	},
	{ // 1
		mapBytes1, // pBytes
		10,SkyElements1,
		17,GroundElements1,
	},
	{ // 2
		mapBytes2, // pBytes
		10,SkyElements2,
		25,GroundElements2,
	},
	{ // 3
		mapBytes3, // pBytes
		8,SkyElements3,
		28,GroundElements3,
	},
	{ // 4
		mapBytes4, // pBytes
		8,SkyElements4,
		26,GroundElements4,
	},
	{ // 5
		mapBytes5, // pBytes
		8,SkyElements5,
		29,GroundElements5,
	},
	{ // 6
		mapBytes6, // pBytes
		8,SkyElements6,
		24,GroundElements6,
	},
	{ // 7
		mapBytes7, // pBytes
		8,SkyElements7,
		30,GroundElements7,
	},
};
