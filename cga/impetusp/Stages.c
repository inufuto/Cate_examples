#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 1
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 15, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 2, 
		},
	},
	{ // 2
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 14, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 6, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 3
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 14, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 15, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 6, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 2, 
		},
	},
	{ // 4
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 20, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 21, 
		},
	},
	{ // 5
		{ // chars0
			Char_Terrain + 15, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 14, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 2, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 6, 
			Char_Terrain + 30, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 28, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 6
		{ // chars0
			Char_Terrain + 15, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 17, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 2, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 30, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 29, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 7
		{ // chars0
			Char_Terrain + 15, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 2, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 30, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 8
		{ // chars0
			Char_Terrain + 15, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 2, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 30, 
			Char_Terrain + 30, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 9
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 14, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 19, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 6, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 28, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 32, 
		},
	},
	{ // 10
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 14, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 6, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 28, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 11
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 12
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 30, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 13
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 16, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
	},
	{ // 14
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 15
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 27, 
		},
		{ // chars4
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 11, 
		},
	},
	{ // 16
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 22, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 10, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 17
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 22, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 27, 
		},
		{ // chars4
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 10, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 11, 
		},
	},
	{ // 18
		{ // chars0
			Char_Terrain + 27, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 22, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 26, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 10, 
			Char_Terrain + 35, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 31, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 33, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 34, 
		},
	},
	{ // 19
		{ // chars0
			Char_Terrain + 27, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 26, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 35, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 33, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 20
		{ // chars0
			Char_Terrain + 27, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 35, 
			Char_Terrain + 35, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 21
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 22, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 10, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 31, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 34, 
		},
	},
	{ // 22
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 22, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 10, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 31, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 23
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 24
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
		},
	},
	{ // 25
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 35, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 26
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 35, 
			Char_Terrain + 36, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 37, 
		},
	},
	{ // 27
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 35, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
		},
	},
	{ // 28
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 14, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 19, 
		},
		{ // chars4
			Char_Terrain + 28, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 6, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 28, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 32, 
		},
	},
	{ // 29
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 14, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 28, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 6, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 28, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 30
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 28, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 31
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 28, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 30, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 32
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 22, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 10, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 31, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 33
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 17, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 29, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 34
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 35
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 24, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
		},
	},
	{ // 36
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 35, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 37
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 7, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 38
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 17, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 7, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 29, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 39
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 3, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 40
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 41
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 17, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 29, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 42
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 18, 
			Char_Terrain + 1, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 1, 
		},
	},
	{ // 43
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 9, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 44
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 45
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 26, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 33, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 12, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 46
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 26, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 27, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 33, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 12, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 11, 
		},
	},
	{ // 47
		{ // chars0
			Char_Terrain + 19, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 32, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 48
		{ // chars0
			Char_Terrain + 19, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 14, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 32, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 6, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 49
		{ // chars0
			Char_Terrain + 19, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 32, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 3, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 50
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 34, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 51
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 34, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 52
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 26, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 34, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 33, 
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 12, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 53
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 17, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 29, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 54
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 19, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 32, 
		},
	},
	{ // 55
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 34, 
		},
	},
	{ // 56
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 57
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 26, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 33, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
	},
	{ // 58
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 59
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 37, 
		},
	},
	{ // 60
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
		},
	},
	{ // 61
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 62
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 37, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
	},
	{ // 63
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
		},
	},
	{ // 64
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
			Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, Char_Terrain + 38, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 37, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 37, 
		},
	},
	{ // 65
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 66
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
	{ // 67
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
	},
	{ // 68
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 38, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
		},
	},
	{ // 69
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 38, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 37, 
		},
	},
	{ // 70
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 38, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 36, 
		},
	},
	{ // 71
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 38, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 37, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
		},
	},
	{ // 72
		{ // chars0
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 36, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 36, 
			Char_Terrain + 38, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 38, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
		},
	},
	{ // 73
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 9, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 74
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 75
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 26, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 33, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 12, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 76
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 26, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 27, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 33, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 12, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 11, 
		},
	},
	{ // 77
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 36, 
		},
	},
	{ // 78
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
		},
	},
	{ // 79
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 0, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 0, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 36, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 38, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 0, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 37, 
		},
	},
	{ // 80
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, Char_Terrain + 36, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 81
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
		},
	},
};

static const byte[] mapBytes0 = {
	128 + 55, 56, 51, 128 + 3, 61, 60, 128 + 3, 56, 
	16, 128 + 3, 81, 78, 128 + 3, 56, 34, 128 + 3, 
	80, 79, 128 + 4, 63, 128 + 8, 56, 44, 44, 
	45, 128 + 3, 56, 55, 51, 128 + 3, 14, 56, 
	56, 51, 43, 128 + 3, 14, 15, 56, 56, 
	14, 14, 19, 23, 23, 25, 56, 56, 
	14, 14, 74, 40, 41, 128 + 3, 56, 16, 
	14, 14, 0, 0, 53, 56, 56, 32, 
	16, 14, 0, 0, 38, 56, 58, 60, 
	32, 16, 128 + 3, 0, 53, 65, 77, 56, 
	34, 128 + 3, 0, 38, 53, 128 + 3, 56, 128 + 4, 
	0, 38, 53, 56, 51, 128 + 5, 0, 38, 
	53, 16, 128 + 6, 0, 38, 33, 128 + 7, 0, 
	37, 128 + 3, 0, 6, 9, 128 + 6, 0, 37, 
	39, 128 + 10, 0, 7, 128 + 6, 0, 1, 56, 
	0, 0, 1, 7, 11, 11, 12, 58, 
	10, 3, 8, 56, 51, 45, 56, 66, 
	56, 31, 56, 56, 16, 15, 56, 65, 
	128 + 4, 56, 34, 25, 56, 56, 128 + 8, 63, 
	56, 56, 55, 51, 45, 128 + 5, 56, 50, 
	14, 15, 56, 59, 63, 56, 56, 16, 
	15, 20, 56, 67, 128 + 3, 56, 34, 25, 
	56, 56, 67, 56, 128 + 6, 63, 71, 128 + 7, 
	56, 67, 128 + 3, 56, 58, 60, 56, 56, 
	67, 128 + 3, 56, 66, 78, 56, 52, 67, 
	128 + 3, 56, 65, 77, 56, 17, 67, 128 + 6, 
	56, 36, 67, 56, 128 + 6, 63, 71, 128 + 3, 
	56, 51, 44, 45, 56, 67, 128 + 3, 56, 
	128 + 3, 14, 56, 68, 63, 56, 56, 16, 
	14, 15, 128 + 5, 56, 34, 23, 25, 56, 
	56, 56, 
};
static const byte[] mapBytes1 = {
	128 + 56, 56, 128 + 7, 63, 62, 128 + 7, 56, 67, 
	128 + 3, 56, 51, 44, 45, 56, 67, 128 + 3, 
	56, 16, 14, 15, 56, 67, 128 + 3, 56, 
	34, 23, 25, 56, 67, 128 + 7, 63, 70, 
	128 + 11, 56, 54, 49, 128 + 3, 40, 56, 49, 
	40, 39, 128 + 4, 0, 56, 128 + 7, 0, 54, 
	128 + 7, 0, 39, 128 + 17, 0, 7, 10, 128 + 6, 
	0, 53, 54, 0, 0, 1, 7, 0, 
	0, 37, 39, 0, 0, 8, 56, 128 + 6, 
	0, 53, 56, 128 + 6, 0, 37, 40, 128 + 8, 
	0, 11, 10, 2, 128 + 5, 0, 56, 56, 
	29, 2, 128 + 4, 0, 128 + 3, 56, 29, 2, 
	128 + 3, 0, 56, 56, 51, 45, 29, 0, 
	1, 7, 56, 56, 16, 15, 56, 0, 
	8, 128 + 3, 56, 34, 25, 56, 0, 56, 
	56, 59, 128 + 4, 63, 4, 63, 63, 67, 
	56, 51, 45, 56, 0, 51, 44, 67, 
	56, 16, 15, 56, 0, 14, 14, 67, 
	56, 34, 25, 56, 0, 14, 14, 67, 
	128 + 4, 56, 0, 16, 14, 67, 128 + 4, 56, 
	0, 34, 23, 69, 63, 63, 64, 63, 
	4, 63, 63, 67, 56, 56, 67, 54, 
	0, 56, 56, 42, 40, 40, 42, 39, 
	1, 56, 51, 13, 11, 11, 13, 11, 
	12, 56, 16, 67, 51, 45, 67, 51, 
	45, 56, 34, 67, 16, 15, 67, 16, 
	15, 56, 56, 67, 34, 25, 67, 34, 
	25, 56, 56, 68, 63, 63, 72, 128 + 4, 
	63, 128 + 15, 56, 56, 
};
static const byte[] mapBytes2 = {
	128 + 40, 56, 44, 45, 128 + 6, 56, 14, 15, 
	128 + 6, 56, 23, 26, 128 + 6, 63, 56, 67, 
	128 + 7, 56, 67, 128 + 3, 56, 51, 44, 44, 
	56, 67, 128 + 3, 56, 16, 14, 14, 56, 
	67, 128 + 3, 56, 34, 23, 23, 63, 72, 
	128 + 6, 63, 128 + 8, 56, 44, 45, 128 + 3, 56, 
	54, 49, 40, 14, 15, 56, 49, 40, 
	39, 0, 0, 23, 25, 56, 128 + 5, 0, 
	45, 56, 54, 128 + 5, 0, 15, 56, 47, 
	128 + 5, 0, 25, 54, 128 + 6, 0, 56, 48, 
	128 + 6, 0, 56, 28, 128 + 6, 0, 56, 47, 
	128 + 6, 0, 56, 128 + 7, 0, 56, 2, 128 + 6, 
	0, 56, 29, 2, 128 + 5, 0, 44, 45, 
	30, 10, 2, 128 + 3, 0, 14, 15, 56, 
	56, 29, 2, 0, 0, 24, 27, 62, 
	56, 56, 29, 0, 0, 56, 56, 67, 
	56, 51, 45, 0, 7, 56, 56, 67, 
	56, 16, 14, 0, 56, 45, 56, 67, 
	56, 34, 23, 0, 56, 14, 56, 69, 
	128 + 3, 63, 4, 63, 14, 56, 67, 56, 
	51, 45, 0, 56, 14, 56, 67, 56, 
	16, 14, 0, 56, 14, 56, 67, 56, 
	34, 23, 0, 56, 15, 56, 67, 128 + 3, 
	56, 0, 56, 25, 56, 69, 63, 64, 
	63, 4, 63, 56, 56, 67, 56, 67, 
	54, 0, 56, 40, 40, 42, 40, 42, 
	39, 1, 56, 11, 11, 13, 11, 13, 
	11, 12, 128 + 3, 56, 67, 52, 67, 52, 
	57, 56, 63, 63, 71, 14, 67, 14, 
	74, 44, 56, 56, 67, 17, 67, 16, 
	14, 14, 56, 56, 67, 36, 67, 34, 
	23, 23, 44, 45, 68, 63, 72, 128 + 3, 
	63, 14, 15, 128 + 6, 56, 23, 25, 128 + 5, 
	56, 56, 
};
static const byte[] mapBytes3 = {
	128 + 49, 56, 51, 45, 56, 51, 128 + 3, 44, 
	56, 16, 15, 56, 16, 128 + 3, 14, 56, 
	34, 25, 56, 34, 128 + 3, 23, 128 + 6, 63, 
	62, 128 + 7, 56, 67, 56, 55, 51, 44, 
	45, 57, 56, 67, 56, 43, 128 + 3, 14, 
	75, 56, 69, 63, 14, 19, 21, 14, 
	14, 56, 67, 56, 14, 74, 43, 14, 
	14, 56, 67, 56, 128 + 4, 14, 15, 56, 
	69, 63, 128 + 4, 14, 20, 56, 67, 56, 
	22, 16, 14, 15, 56, 56, 67, 56, 
	56, 34, 23, 25, 56, 56, 67, 128 + 7, 
	56, 67, 128 + 3, 56, 51, 45, 57, 56, 
	69, 63, 56, 56, 16, 14, 75, 56, 
	67, 56, 41, 53, 32, 16, 15, 56, 
	67, 56, 0, 38, 53, 34, 25, 56, 
	67, 56, 0, 0, 37, 128 + 3, 40, 42, 
	40, 0, 1, 7, 128 + 3, 11, 13, 11, 
	0, 8, 56, 56, 59, 63, 72, 63, 
	1, 128 + 3, 56, 67, 128 + 3, 56, 12, 58, 
	60, 56, 67, 128 + 4, 56, 66, 78, 56, 
	69, 128 + 3, 63, 56, 65, 77, 56, 67, 
	128 + 7, 56, 67, 56, 51, 44, 128 + 4, 63, 
	71, 56, 16, 14, 128 + 4, 56, 67, 56, 
	34, 23, 56, 59, 63, 63, 71, 56, 
	55, 51, 45, 67, 56, 56, 67, 55, 
	50, 14, 15, 67, 51, 45, 67, 50, 
	14, 14, 25, 67, 16, 15, 67, 14, 
	14, 19, 63, 71, 34, 25, 67, 16, 
	14, 74, 56, 69, 63, 63, 71, 32, 
	16, 14, 45, 67, 56, 56, 67, 56, 
	32, 16, 15, 67, 56, 56, 67, 56, 
	56, 34, 27, 71, 56, 56, 67, 51, 
	45, 56, 56, 67, 56, 56, 67, 16, 
	15, 56, 56, 67, 56, 56, 67, 34, 
	25, 56, 56, 68, 63, 63, 72, 128 + 3, 
	63, 128 + 15, 56, 56, 
};
static const byte[] mapBytes4 = {
	128 + 56, 56, 128 + 4, 63, 64, 128 + 3, 63, 128 + 4, 
	56, 67, 128 + 3, 56, 44, 44, 45, 56, 
	67, 128 + 3, 56, 14, 14, 15, 56, 67, 
	128 + 3, 56, 23, 23, 25, 56, 67, 56, 
	56, 51, 128 + 4, 63, 70, 56, 56, 14, 
	128 + 7, 56, 16, 54, 49, 128 + 3, 40, 41, 
	53, 34, 39, 128 + 5, 0, 37, 40, 128 + 43, 
	0, 1, 5, 2, 128 + 5, 0, 8, 56, 
	29, 128 + 5, 0, 53, 56, 54, 128 + 5, 0, 
	37, 40, 39, 128 + 26, 0, 10, 2, 0, 
	0, 1, 7, 10, 2, 56, 29, 0, 
	1, 8, 56, 56, 30, 56, 56, 0, 
	8, 128 + 6, 56, 0, 128 + 5, 56, 63, 63, 
	4, 128 + 5, 63, 45, 56, 0, 51, 44, 
	44, 45, 56, 15, 56, 0, 128 + 4, 14, 
	56, 25, 56, 0, 128 + 4, 14, 128 + 3, 56, 
	0, 16, 14, 14, 15, 56, 59, 63, 
	4, 35, 24, 24, 27, 63, 67, 54, 
	0, 128 + 5, 56, 42, 39, 1, 56, 56, 
	58, 60, 56, 13, 11, 12, 52, 56, 
	66, 78, 56, 67, 56, 56, 17, 56, 
	65, 77, 56, 67, 52, 57, 36, 128 + 4, 
	56, 67, 16, 76, 56, 56, 59, 63, 
	63, 67, 34, 25, 56, 56, 67, 56, 
	56, 68, 128 + 4, 63, 70, 128 + 17, 56, 56, 

};
static const byte[] mapBytes5 = {
	128 + 53, 56, 51, 45, 56, 61, 60, 128 + 3, 
	56, 16, 15, 56, 81, 78, 128 + 3, 56, 
	34, 25, 56, 80, 79, 128 + 6, 63, 128 + 8, 
	56, 45, 128 + 3, 56, 55, 51, 44, 44, 
	14, 56, 56, 51, 43, 128 + 3, 14, 15, 
	56, 56, 14, 14, 19, 21, 14, 25, 
	56, 56, 14, 14, 74, 43, 14, 128 + 3, 
	56, 16, 128 + 4, 14, 128 + 3, 56, 32, 16, 
	128 + 3, 14, 41, 56, 58, 60, 32, 16, 
	14, 14, 0, 53, 65, 77, 56, 34, 
	23, 23, 0, 38, 53, 128 + 5, 56, 0, 
	0, 38, 53, 56, 56, 51, 44, 128 + 3, 
	0, 38, 53, 56, 16, 14, 128 + 4, 0, 
	38, 53, 32, 16, 128 + 5, 0, 38, 53, 
	34, 0, 6, 9, 128 + 3, 0, 37, 40, 
	0, 37, 39, 0, 0, 1, 7, 11, 
	128 + 5, 0, 8, 56, 56, 128 + 4, 0, 1, 
	128 + 3, 56, 1, 7, 11, 11, 12, 58, 
	60, 56, 12, 56, 51, 45, 56, 66, 
	78, 128 + 3, 56, 16, 15, 56, 65, 77, 
	128 + 3, 56, 34, 25, 128 + 4, 56, 128 + 8, 63, 
	128 + 13, 56, 59, 63, 63, 128 + 3, 56, 51, 
	45, 67, 128 + 5, 56, 16, 15, 67, 51, 
	44, 128 + 3, 63, 35, 27, 71, 16, 14, 
	128 + 5, 56, 67, 34, 23, 61, 60, 128 + 3, 
	56, 69, 63, 63, 81, 78, 56, 51, 
	45, 67, 56, 56, 80, 77, 56, 16, 
	15, 67, 128 + 5, 56, 34, 25, 67, 56, 
	56, 128 + 5, 63, 71, 56, 56, 44, 44, 
	45, 56, 56, 67, 56, 56, 128 + 3, 14, 
	56, 56, 68, 63, 63, 14, 14, 15, 
	128 + 5, 56, 23, 23, 25, 128 + 4, 56, 56, 

};
static const byte[] mapBytes6 = {
	128 + 41, 56, 55, 51, 45, 128 + 5, 56, 50, 
	14, 14, 128 + 5, 56, 128 + 3, 14, 56, 59, 
	63, 63, 56, 16, 14, 15, 56, 67, 
	128 + 3, 56, 34, 23, 25, 56, 67, 128 + 7, 
	56, 67, 128 + 7, 56, 67, 56, 56, 63, 
	63, 64, 63, 63, 72, 63, 63, 56, 
	56, 67, 128 + 7, 56, 67, 56, 51, 45, 
	128 + 4, 56, 67, 56, 16, 15, 56, 49, 
	56, 56, 67, 56, 34, 25, 56, 0, 
	56, 56, 67, 51, 45, 56, 54, 0, 
	63, 63, 71, 16, 15, 56, 47, 0, 
	56, 56, 67, 34, 25, 54, 0, 0, 
	56, 56, 67, 56, 56, 48, 0, 0, 
	56, 56, 67, 56, 56, 28, 0, 0, 
	56, 56, 67, 56, 56, 47, 0, 0, 
	63, 63, 71, 56, 56, 128 + 3, 0, 56, 
	56, 67, 56, 56, 2, 0, 0, 56, 
	56, 67, 56, 56, 29, 2, 0, 56, 
	56, 67, 56, 51, 45, 30, 11, 56, 
	56, 67, 56, 16, 15, 56, 56, 63, 
	63, 72, 63, 35, 27, 62, 128 + 7, 56, 
	67, 56, 44, 45, 56, 56, 51, 45, 
	67, 56, 14, 14, 57, 56, 14, 14, 
	67, 56, 14, 14, 75, 56, 14, 14, 
	69, 63, 128 + 3, 14, 56, 16, 15, 67, 
	56, 128 + 3, 14, 57, 34, 25, 67, 56, 
	128 + 3, 14, 75, 56, 56, 67, 56, 128 + 3, 
	14, 15, 56, 56, 67, 56, 14, 14, 
	15, 20, 56, 56, 69, 63, 23, 23, 
	25, 128 + 3, 56, 67, 56, 128 + 6, 40, 42, 
	40, 128 + 6, 11, 13, 11, 128 + 6, 56, 67, 
	51, 128 + 6, 63, 71, 14, 128 + 6, 56, 67, 
	16, 56, 51, 45, 128 + 3, 56, 67, 34, 
	56, 16, 15, 56, 51, 45, 68, 63, 
	56, 34, 25, 56, 16, 15, 128 + 6, 56, 
	34, 25, 56, 56, 
};
static const byte[] mapBytes7 = {
	128 + 48, 56, 45, 128 + 7, 56, 15, 128 + 4, 56, 
	58, 60, 56, 25, 128 + 4, 56, 65, 77, 
	56, 128 + 4, 63, 62, 128 + 3, 56, 45, 57, 
	56, 56, 69, 128 + 3, 63, 14, 75, 57, 
	56, 67, 128 + 3, 56, 14, 14, 75, 56, 
	69, 128 + 3, 63, 21, 14, 14, 56, 67, 
	128 + 3, 56, 43, 14, 14, 56, 67, 128 + 3, 
	56, 14, 14, 15, 56, 69, 128 + 3, 63, 
	14, 14, 20, 56, 67, 128 + 3, 56, 14, 
	15, 56, 56, 67, 51, 45, 56, 15, 
	20, 56, 56, 67, 16, 15, 56, 25, 
	128 + 3, 56, 67, 34, 25, 56, 45, 128 + 3, 
	56, 68, 128 + 3, 63, 14, 128 + 4, 56, 51, 
	45, 56, 15, 128 + 4, 56, 16, 15, 56, 
	25, 128 + 4, 56, 34, 25, 56, 128 + 8, 40, 
	128 + 8, 11, 56, 56, 59, 128 + 5, 63, 56, 
	56, 67, 128 + 5, 56, 60, 56, 67, 128 + 5, 
	56, 78, 56, 69, 128 + 5, 63, 77, 56, 
	67, 128 + 7, 56, 67, 56, 51, 46, 56, 
	56, 63, 63, 71, 56, 17, 20, 128 + 4, 
	56, 67, 56, 36, 55, 51, 44, 63, 
	63, 71, 56, 55, 50, 14, 14, 56, 
	56, 67, 56, 50, 128 + 3, 14, 44, 45, 
	67, 56, 128 + 5, 14, 15, 67, 56, 14, 
	14, 18, 14, 23, 25, 67, 56, 16, 
	14, 73, 14, 63, 63, 71, 56, 32, 
	16, 14, 14, 56, 56, 67, 56, 56, 
	32, 14, 14, 56, 56, 67, 128 + 3, 56, 
	16, 14, 56, 56, 67, 51, 45, 56, 
	32, 14, 56, 56, 67, 16, 15, 56, 
	56, 16, 56, 56, 67, 34, 25, 56, 
	56, 34, 63, 63, 72, 128 + 5, 63, 128 + 15, 
	56, 56, 
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
