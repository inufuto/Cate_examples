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
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 2
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 24, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 4, Char_Terrain + 14, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, Char_Terrain + 15, 
		},
	},
	{ // 3
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
		},
	},
	{ // 4
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 24, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
		},
	},
	{ // 5
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 6
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 21, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 7
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 28, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 39, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 9, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 39, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 42, 
		},
	},
	{ // 8
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 28, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 39, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 9, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 39, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 9
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 39, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 10
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 39, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 43, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 11
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 28, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 9, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 12
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 13
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 32, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 12, 
		},
	},
	{ // 14
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 34, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 13, 
		},
	},
	{ // 15
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 36, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 18, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 16
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 25, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 19, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 1, Char_Terrain + 15, 
		},
	},
	{ // 17
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 15, Char_Terrain + 2, Char_Terrain + 1, Char_Terrain + 15, 
		},
	},
	{ // 18
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
		},
	},
	{ // 19
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 26, Char_Terrain + 3, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 20, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 15, Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 3, 
		},
	},
	{ // 20
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 25, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 19, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 21
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 22
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 27, Char_Terrain + 10, Char_Terrain + 10, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 23
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 4, Char_Terrain + 14, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 1, Char_Terrain + 15, 
		},
	},
	{ // 24
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 3, Char_Terrain + 27, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 4, Char_Terrain + 14, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 22, Char_Terrain + 15, Char_Terrain + 15, 
		},
	},
	{ // 25
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
	},
	{ // 26
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 14, Char_Terrain + 5, Char_Terrain + 4, Char_Terrain + 14, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
		},
	},
	{ // 27
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 14, Char_Terrain + 5, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 15, Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 3, 
		},
	},
	{ // 28
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 24, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 14, Char_Terrain + 5, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 21, Char_Terrain + 3, 
		},
	},
	{ // 29
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 22, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 30
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 36, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 22, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 18, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 31
		{ // chars0
			Char_Terrain + 32, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 28, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 9, 
			Char_Terrain + 43, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 39, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 32
		{ // chars0
			Char_Terrain + 32, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
			Char_Terrain + 43, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 33
		{ // chars0
			Char_Terrain + 32, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 43, 
			Char_Terrain + 43, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 34
		{ // chars0
			Char_Terrain + 34, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
			Char_Terrain + 50, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 35
		{ // chars0
			Char_Terrain + 34, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 40, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 50, 
			Char_Terrain + 50, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 51, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 36
		{ // chars0
			Char_Terrain + 34, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 50, 
			Char_Terrain + 50, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 37
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 28, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 9, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 39, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 42, 
		},
	},
	{ // 38
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 28, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 9, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 39, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 39
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 40
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 30, Char_Terrain + 43, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 41
		{ // chars0
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 42
		{ // chars0
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 26, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 20, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 3, 
		},
	},
	{ // 43
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 36, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 18, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 49, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 44
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 45
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 50, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 46
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 27, Char_Terrain + 24, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 25, Char_Terrain + 26, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 35, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 35, 
			Char_Terrain + 53, Char_Terrain + 45, Char_Terrain + 46, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 47, Char_Terrain + 48, Char_Terrain + 53, 
		},
	},
	{ // 47
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 36, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 49, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 18, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 49, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 48
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 49, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 49
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 6, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 50
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 51
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 36, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 18, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 52
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
		},
	},
	{ // 53
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 33, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 16, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 41, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 16, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 54
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 17, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 55
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 56
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 40, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 51, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 23, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 57
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 40, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 34, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 51, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 23, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 13, 
		},
	},
	{ // 58
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 6, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 59
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 25, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 6, 
			Char_Terrain + 3, Char_Terrain + 19, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 1, Char_Terrain + 15, 
		},
	},
	{ // 60
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 6, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
		},
	},
	{ // 61
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 62
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
		},
	},
	{ // 63
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 33, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 41, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 16, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 64
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 33, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 32, 
		},
		{ // chars4
			Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 41, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 16, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 12, 
		},
	},
	{ // 65
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 42, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 66
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 28, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 42, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 31, 
			Char_Terrain + 6, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 9, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 67
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 33, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 28, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 32, 
		},
		{ // chars4
			Char_Terrain + 42, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 41, 
			Char_Terrain + 6, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 16, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 9, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 12, 
		},
	},
	{ // 68
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 33, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 41, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 42, 
		},
	},
	{ // 69
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 33, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 41, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 70
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 42, 
		},
	},
	{ // 71
		{ // chars0
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
		{ // chars4
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
			Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, Char_Terrain + 44, 
		},
	},
	{ // 72
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 37, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 3, 
		},
	},
	{ // 73
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 17, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 74
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 75
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 40, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 51, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 23, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 76
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 40, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 34, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 51, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 23, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 13, 
		},
	},
	{ // 77
		{ // chars0
			Char_Terrain + 38, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 52, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 17, 
			Char_Terrain + 17, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 78
		{ // chars0
			Char_Terrain + 38, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 52, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
			Char_Terrain + 17, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 79
		{ // chars0
			Char_Terrain + 38, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 36, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 52, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 37, 
			Char_Terrain + 17, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 18, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 80
		{ // chars0
			Char_Terrain + 38, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 40, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
		{ // chars4
			Char_Terrain + 52, Char_Terrain + 37, Char_Terrain + 37, Char_Terrain + 51, 
			Char_Terrain + 17, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 23, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
		},
	},
	{ // 81
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 26, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 25, 
			Char_Terrain + 24, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 27, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 48, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 47, 
			Char_Terrain + 7, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 8, 
			Char_Terrain + 46, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 45, 
		},
	},
	{ // 82
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 40, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 38, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 51, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 52, 
		},
	},
	{ // 83
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 40, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 51, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
		},
	},
	{ // 84
		{ // chars0
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 38, 
		},
		{ // chars4
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 52, 
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
	128 + 55, 12, 32, 128 + 3, 41, 42, 128 + 3, 12, 
	69, 128 + 3, 0, 3, 128 + 3, 12, 50, 128 + 3, 
	1, 2, 128 + 4, 18, 128 + 3, 5, 6, 128 + 4, 
	12, 39, 39, 38, 128 + 3, 12, 13, 32, 
	128 + 3, 71, 12, 12, 32, 40, 128 + 3, 71, 
	70, 12, 12, 71, 71, 66, 61, 61, 
	58, 12, 12, 71, 71, 9, 44, 43, 
	128 + 3, 12, 69, 71, 71, 85, 85, 15, 
	12, 12, 53, 69, 71, 85, 85, 47, 
	12, 20, 42, 53, 69, 128 + 3, 85, 15, 
	22, 4, 12, 50, 128 + 3, 85, 47, 30, 
	6, 12, 12, 128 + 4, 85, 47, 15, 12, 
	32, 128 + 5, 85, 47, 15, 69, 128 + 6, 85, 
	47, 51, 128 + 7, 85, 48, 128 + 3, 85, 79, 
	76, 128 + 6, 85, 48, 45, 128 + 10, 85, 78, 
	128 + 6, 85, 84, 12, 85, 85, 84, 78, 
	74, 74, 73, 20, 75, 82, 77, 12, 
	32, 38, 12, 21, 12, 54, 12, 12, 
	69, 70, 12, 22, 128 + 4, 12, 50, 58, 
	12, 29, 128 + 8, 18, 12, 12, 13, 32, 
	38, 128 + 5, 12, 33, 71, 70, 12, 16, 
	18, 12, 12, 69, 70, 65, 12, 25, 
	128 + 3, 12, 50, 58, 12, 12, 25, 12, 
	128 + 6, 18, 27, 128 + 7, 12, 25, 128 + 3, 12, 
	20, 42, 12, 12, 25, 128 + 3, 12, 21, 
	3, 12, 31, 25, 128 + 3, 12, 22, 4, 
	12, 68, 25, 128 + 3, 12, 29, 6, 12, 
	49, 25, 12, 128 + 6, 18, 27, 128 + 3, 12, 
	32, 39, 38, 12, 25, 128 + 3, 12, 128 + 3, 
	71, 12, 24, 18, 12, 12, 69, 71, 
	70, 128 + 5, 12, 50, 61, 58, 12, 12, 
	12, 
};
static const byte[] mapBytes1 = {
	128 + 56, 12, 128 + 7, 18, 19, 128 + 7, 12, 25, 
	128 + 3, 12, 32, 39, 38, 12, 25, 128 + 3, 
	12, 69, 71, 70, 12, 25, 128 + 3, 12, 
	50, 61, 58, 12, 25, 128 + 7, 18, 28, 
	128 + 11, 12, 14, 34, 128 + 3, 44, 12, 34, 
	44, 45, 128 + 4, 85, 12, 128 + 7, 85, 14, 
	128 + 7, 85, 45, 128 + 17, 85, 78, 75, 128 + 6, 
	85, 15, 14, 85, 85, 84, 78, 85, 
	85, 48, 45, 85, 85, 77, 12, 128 + 6, 
	85, 15, 12, 128 + 6, 85, 48, 44, 128 + 8, 
	85, 74, 75, 83, 128 + 5, 85, 12, 12, 
	56, 83, 128 + 4, 85, 128 + 3, 12, 56, 83, 
	128 + 3, 85, 12, 12, 32, 38, 56, 85, 
	84, 78, 12, 12, 69, 70, 12, 85, 
	77, 128 + 3, 12, 50, 58, 12, 85, 12, 
	12, 16, 128 + 4, 18, 81, 18, 18, 25, 
	12, 32, 38, 12, 85, 32, 39, 25, 
	12, 69, 70, 12, 85, 71, 71, 25, 
	12, 50, 58, 12, 85, 71, 71, 25, 
	128 + 4, 12, 85, 69, 71, 25, 128 + 4, 12, 
	85, 50, 61, 23, 18, 18, 17, 18, 
	81, 18, 18, 25, 12, 12, 25, 14, 
	85, 12, 12, 46, 44, 44, 46, 45, 
	84, 12, 32, 72, 74, 74, 72, 74, 
	73, 12, 69, 25, 32, 38, 25, 32, 
	38, 12, 50, 25, 69, 70, 25, 69, 
	70, 12, 12, 25, 50, 58, 25, 50, 
	58, 12, 12, 24, 18, 18, 26, 128 + 4, 
	18, 128 + 15, 12, 12, 
};
static const byte[] mapBytes2 = {
	128 + 40, 12, 39, 38, 128 + 6, 12, 71, 70, 
	128 + 6, 12, 61, 59, 128 + 6, 18, 12, 25, 
	128 + 7, 12, 25, 128 + 3, 12, 32, 39, 39, 
	12, 25, 128 + 3, 12, 69, 71, 71, 12, 
	25, 128 + 3, 12, 50, 61, 61, 18, 26, 
	128 + 6, 18, 128 + 8, 12, 39, 38, 128 + 3, 12, 
	14, 34, 44, 71, 70, 12, 34, 44, 
	45, 85, 85, 61, 58, 12, 128 + 5, 85, 
	38, 12, 14, 128 + 5, 85, 70, 12, 36, 
	128 + 5, 85, 58, 14, 128 + 6, 85, 12, 35, 
	128 + 6, 85, 12, 57, 128 + 6, 85, 12, 36, 
	128 + 6, 85, 12, 128 + 7, 85, 12, 83, 128 + 6, 
	85, 12, 56, 83, 128 + 5, 85, 39, 38, 
	55, 75, 83, 128 + 3, 85, 71, 70, 12, 
	12, 56, 83, 85, 85, 62, 60, 19, 
	12, 12, 56, 85, 85, 12, 12, 25, 
	12, 32, 38, 85, 78, 12, 12, 25, 
	12, 69, 71, 85, 12, 38, 12, 25, 
	12, 50, 61, 85, 12, 71, 12, 23, 
	128 + 3, 18, 81, 18, 71, 12, 25, 12, 
	32, 38, 85, 12, 71, 12, 25, 12, 
	69, 71, 85, 12, 71, 12, 25, 12, 
	50, 61, 85, 12, 70, 12, 25, 128 + 3, 
	12, 85, 12, 58, 12, 23, 18, 17, 
	18, 81, 18, 12, 12, 25, 12, 25, 
	14, 85, 12, 44, 44, 46, 44, 46, 
	45, 84, 12, 74, 74, 72, 74, 72, 
	74, 73, 128 + 3, 12, 25, 31, 25, 31, 
	11, 12, 18, 18, 27, 71, 25, 71, 
	9, 39, 12, 12, 25, 68, 25, 69, 
	71, 71, 12, 12, 25, 49, 25, 50, 
	61, 61, 39, 38, 24, 18, 26, 128 + 3, 
	18, 71, 70, 128 + 6, 12, 61, 58, 128 + 5, 
	12, 12, 
};
static const byte[] mapBytes3 = {
	128 + 49, 12, 32, 38, 12, 32, 128 + 3, 39, 
	12, 69, 70, 12, 69, 128 + 3, 71, 12, 
	50, 58, 12, 50, 128 + 3, 61, 128 + 6, 18, 
	19, 128 + 7, 12, 25, 12, 13, 32, 39, 
	38, 11, 12, 25, 12, 40, 128 + 3, 71, 
	8, 12, 23, 18, 71, 66, 64, 71, 
	71, 12, 25, 12, 71, 9, 40, 71, 
	71, 12, 25, 12, 128 + 4, 71, 70, 12, 
	23, 18, 128 + 4, 71, 65, 12, 25, 12, 
	63, 69, 71, 70, 12, 12, 25, 12, 
	12, 50, 61, 58, 12, 12, 25, 128 + 7, 
	12, 25, 128 + 3, 12, 32, 38, 11, 12, 
	23, 18, 12, 12, 69, 71, 8, 12, 
	25, 12, 43, 15, 53, 69, 70, 12, 
	25, 12, 85, 47, 15, 50, 58, 12, 
	25, 12, 85, 85, 48, 128 + 3, 44, 46, 
	44, 85, 84, 78, 128 + 3, 74, 72, 74, 
	85, 77, 12, 12, 16, 18, 26, 18, 
	84, 128 + 3, 12, 25, 128 + 3, 12, 73, 20, 
	42, 12, 25, 128 + 4, 12, 21, 3, 12, 
	23, 128 + 3, 18, 12, 22, 4, 12, 25, 
	128 + 4, 12, 29, 6, 12, 25, 12, 32, 
	39, 128 + 4, 18, 27, 12, 69, 71, 128 + 4, 
	12, 25, 12, 50, 61, 12, 16, 18, 
	18, 27, 12, 13, 32, 38, 25, 12, 
	12, 25, 13, 33, 71, 70, 25, 32, 
	38, 25, 33, 71, 71, 58, 25, 69, 
	70, 25, 71, 71, 66, 18, 27, 50, 
	58, 25, 69, 71, 9, 12, 23, 18, 
	18, 27, 53, 69, 71, 38, 25, 12, 
	12, 25, 12, 53, 69, 70, 25, 12, 
	12, 25, 12, 12, 50, 60, 27, 12, 
	12, 25, 32, 38, 12, 12, 25, 12, 
	12, 25, 69, 70, 12, 12, 25, 12, 
	12, 25, 50, 58, 12, 12, 24, 18, 
	18, 26, 128 + 3, 18, 128 + 15, 12, 12, 
};
static const byte[] mapBytes4 = {
	128 + 56, 12, 128 + 4, 18, 17, 128 + 3, 18, 128 + 4, 
	12, 25, 128 + 3, 12, 39, 39, 38, 12, 
	25, 128 + 3, 12, 71, 71, 70, 12, 25, 
	128 + 3, 12, 61, 61, 58, 12, 25, 12, 
	12, 32, 128 + 4, 18, 28, 12, 12, 71, 
	128 + 7, 12, 69, 14, 34, 128 + 3, 44, 43, 
	15, 50, 45, 128 + 5, 85, 48, 44, 128 + 43, 
	85, 84, 80, 83, 128 + 5, 85, 77, 12, 
	56, 128 + 5, 85, 15, 12, 14, 128 + 5, 85, 
	48, 44, 45, 128 + 26, 85, 75, 83, 85, 
	85, 84, 78, 75, 83, 12, 56, 85, 
	84, 77, 12, 12, 55, 12, 12, 85, 
	77, 128 + 6, 12, 85, 128 + 5, 12, 18, 18, 
	81, 128 + 5, 18, 38, 12, 85, 32, 39, 
	39, 38, 12, 70, 12, 85, 128 + 4, 71, 
	12, 58, 12, 85, 128 + 4, 71, 128 + 3, 12, 
	85, 69, 71, 71, 70, 12, 16, 18, 
	81, 52, 62, 62, 60, 18, 25, 14, 
	85, 128 + 5, 12, 46, 45, 84, 12, 12, 
	20, 42, 12, 72, 74, 73, 31, 12, 
	21, 3, 12, 25, 12, 12, 68, 12, 
	22, 4, 12, 25, 31, 11, 49, 12, 
	29, 6, 12, 25, 69, 7, 12, 12, 
	16, 18, 18, 25, 50, 58, 12, 12, 
	25, 12, 12, 24, 128 + 4, 18, 28, 128 + 17, 
	12, 12, 
};
static const byte[] mapBytes5 = {
	128 + 53, 12, 32, 38, 12, 41, 42, 128 + 3, 
	12, 69, 70, 12, 0, 3, 128 + 3, 12, 
	50, 58, 12, 1, 2, 128 + 6, 18, 5, 
	6, 128 + 6, 12, 38, 128 + 3, 12, 13, 32, 
	39, 39, 71, 12, 12, 32, 40, 128 + 3, 
	71, 70, 12, 12, 71, 71, 66, 64, 
	71, 58, 12, 12, 71, 71, 9, 40, 
	71, 128 + 3, 12, 69, 128 + 4, 71, 128 + 3, 12, 
	53, 69, 128 + 3, 71, 43, 12, 20, 42, 
	53, 69, 71, 71, 85, 15, 22, 4, 
	12, 50, 61, 61, 85, 47, 30, 6, 
	128 + 4, 12, 85, 85, 47, 15, 12, 12, 
	32, 39, 128 + 3, 85, 47, 15, 12, 69, 
	71, 128 + 4, 85, 47, 15, 53, 69, 128 + 5, 
	85, 47, 15, 50, 85, 79, 76, 128 + 3, 
	85, 48, 44, 85, 48, 45, 85, 85, 
	84, 78, 74, 128 + 5, 85, 77, 12, 12, 
	128 + 4, 85, 84, 128 + 3, 12, 84, 78, 74, 
	74, 73, 20, 42, 12, 73, 12, 32, 
	38, 12, 21, 3, 128 + 3, 12, 69, 70, 
	12, 22, 4, 128 + 3, 12, 50, 58, 12, 
	29, 6, 12, 128 + 8, 18, 128 + 13, 12, 16, 
	18, 18, 128 + 3, 12, 32, 38, 25, 128 + 5, 
	12, 69, 70, 25, 32, 39, 128 + 3, 18, 
	52, 60, 27, 69, 71, 128 + 5, 12, 25, 
	50, 61, 41, 42, 128 + 3, 12, 23, 18, 
	18, 0, 3, 12, 32, 38, 25, 12, 
	12, 1, 4, 12, 69, 70, 25, 12, 
	12, 5, 6, 12, 50, 58, 25, 12, 
	12, 128 + 5, 18, 27, 12, 12, 39, 39, 
	38, 12, 12, 25, 12, 12, 128 + 3, 71, 
	12, 12, 24, 18, 18, 71, 71, 70, 
	128 + 5, 12, 61, 61, 58, 128 + 4, 12, 12, 

};
static const byte[] mapBytes6 = {
	128 + 41, 12, 13, 32, 38, 128 + 5, 12, 33, 
	71, 71, 128 + 5, 12, 128 + 3, 71, 12, 16, 
	18, 18, 12, 69, 71, 70, 12, 25, 
	128 + 3, 12, 50, 61, 58, 12, 25, 128 + 7, 
	12, 25, 128 + 7, 12, 25, 12, 12, 18, 
	18, 17, 18, 18, 26, 18, 18, 12, 
	12, 25, 128 + 7, 12, 25, 12, 32, 38, 
	128 + 4, 12, 25, 12, 69, 70, 12, 34, 
	12, 12, 25, 12, 50, 58, 12, 85, 
	12, 12, 25, 32, 38, 12, 14, 85, 
	18, 18, 27, 69, 70, 12, 36, 85, 
	12, 12, 25, 50, 58, 14, 85, 85, 
	12, 12, 25, 12, 12, 35, 85, 85, 
	12, 12, 25, 12, 12, 57, 85, 85, 
	12, 12, 25, 12, 12, 36, 85, 85, 
	18, 18, 27, 12, 12, 128 + 3, 85, 12, 
	12, 25, 12, 12, 83, 85, 85, 12, 
	12, 25, 12, 12, 56, 83, 85, 12, 
	12, 25, 12, 32, 38, 55, 74, 12, 
	12, 25, 12, 69, 70, 12, 12, 18, 
	18, 26, 18, 52, 60, 19, 128 + 7, 12, 
	25, 12, 39, 38, 12, 12, 32, 38, 
	25, 12, 71, 71, 11, 12, 71, 71, 
	25, 12, 71, 71, 8, 12, 71, 71, 
	23, 18, 128 + 3, 71, 12, 69, 70, 25, 
	12, 128 + 3, 71, 11, 50, 58, 25, 12, 
	128 + 3, 71, 8, 12, 12, 25, 12, 128 + 3, 
	71, 70, 12, 12, 25, 12, 71, 71, 
	70, 65, 12, 12, 23, 18, 61, 61, 
	58, 128 + 3, 12, 25, 12, 128 + 6, 44, 46, 
	44, 128 + 6, 74, 72, 74, 128 + 6, 12, 25, 
	32, 128 + 6, 18, 27, 71, 128 + 6, 12, 25, 
	69, 12, 32, 38, 128 + 3, 12, 25, 50, 
	12, 69, 70, 12, 32, 38, 24, 18, 
	12, 50, 58, 12, 69, 70, 128 + 6, 12, 
	50, 58, 12, 12, 
};
static const byte[] mapBytes7 = {
	128 + 48, 12, 38, 128 + 7, 12, 70, 128 + 4, 12, 
	20, 42, 12, 58, 128 + 4, 12, 22, 4, 
	12, 128 + 4, 18, 19, 29, 6, 12, 38, 
	11, 12, 12, 23, 128 + 3, 18, 71, 8, 
	11, 12, 25, 128 + 3, 12, 71, 71, 8, 
	12, 23, 128 + 3, 18, 64, 71, 71, 12, 
	25, 128 + 3, 12, 40, 71, 71, 12, 25, 
	128 + 3, 12, 71, 71, 70, 12, 23, 128 + 3, 
	18, 71, 71, 65, 12, 25, 128 + 3, 12, 
	71, 70, 12, 12, 25, 32, 38, 12, 
	70, 65, 12, 12, 25, 69, 70, 12, 
	58, 128 + 3, 12, 25, 50, 58, 12, 38, 
	128 + 3, 12, 24, 128 + 3, 18, 71, 128 + 4, 12, 
	32, 38, 12, 70, 128 + 4, 12, 69, 70, 
	12, 58, 128 + 4, 12, 50, 58, 12, 128 + 8, 
	44, 128 + 8, 74, 12, 12, 16, 128 + 5, 18, 
	12, 12, 25, 128 + 5, 12, 42, 12, 25, 
	128 + 5, 12, 3, 12, 23, 128 + 5, 18, 4, 
	12, 25, 128 + 5, 12, 6, 12, 25, 12, 
	32, 37, 12, 12, 18, 18, 27, 12, 
	68, 65, 128 + 4, 12, 25, 12, 49, 13, 
	32, 39, 18, 18, 27, 12, 13, 33, 
	71, 71, 12, 12, 25, 12, 33, 128 + 3, 
	71, 39, 38, 25, 12, 128 + 5, 71, 70, 
	25, 12, 71, 71, 67, 71, 61, 58, 
	25, 12, 69, 71, 10, 71, 18, 18, 
	27, 12, 53, 69, 71, 71, 12, 12, 
	25, 12, 12, 53, 71, 71, 12, 12, 
	25, 128 + 3, 12, 69, 71, 12, 12, 25, 
	32, 38, 12, 53, 71, 12, 12, 25, 
	69, 70, 12, 12, 69, 12, 12, 25, 
	50, 58, 12, 12, 50, 18, 18, 26, 
	128 + 5, 18, 128 + 15, 12, 12, 
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
