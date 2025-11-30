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
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 2
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 34, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 35, 
		},
	},
	{ // 3
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
		},
	},
	{ // 4
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 23, 
		},
	},
	{ // 5
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 6
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 3, 
		},
	},
	{ // 7
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 22, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 2, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 8
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 22, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 2, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 3, 
		},
	},
	{ // 9
		{ // chars0
			Char_Terrain + 21, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 22, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 2, 
			Char_Terrain + 36, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 37, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 38, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 33, 
		},
	},
	{ // 10
		{ // chars0
			Char_Terrain + 21, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 36, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 38, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 11
		{ // chars0
			Char_Terrain + 21, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 36, 
			Char_Terrain + 36, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 12
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 22, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 2, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 37, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 33, 
		},
	},
	{ // 13
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 22, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 2, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 37, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 14
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
		},
	},
	{ // 15
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 16
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 36, 
			Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
		},
	},
	{ // 17
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 36, 
			Char_Terrain + 23, Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 35, 
		},
	},
	{ // 18
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 36, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 19
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 1, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 1, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 31, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 31, 
			Char_Terrain + 1, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 1, 
			Char_Terrain + 32, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 32, 
		},
	},
	{ // 20
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
	{ // 21
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 13, 
		},
		{ // chars4
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
		},
	},
	{ // 22
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 6, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 8, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 23
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 6, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 13, 
		},
		{ // chars4
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 8, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
		},
	},
	{ // 24
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 6, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 5, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 8, 
			Char_Terrain + 28, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 14, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 25
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 15, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 5, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 28, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 16, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 26
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 5, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 28, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 27
		{ // chars0
			Char_Terrain + 13, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 5, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 28, 
			Char_Terrain + 28, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 28
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 19, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
	},
	{ // 29
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 6, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 20, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 8, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 14, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 30, 
		},
	},
	{ // 30
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 6, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 8, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 14, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 31
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 32
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 28, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 33
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 22, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 2, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 37, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 34
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
		},
	},
	{ // 35
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 15, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 16, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 36
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 37
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 37, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 36, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 38
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 6, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 20, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 8, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 14, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 30, 
		},
	},
	{ // 39
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 6, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 8, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 14, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 40
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 19, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 41
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 19, Char_Terrain + 19, Char_Terrain + 28, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 42
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 12, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 43
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 44
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 27, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 38, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 4, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 45
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 27, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 38, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 4, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 3, 
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
			Char_Terrain + 17, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 47
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 15, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 17, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 16, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 17, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 48
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 12, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 49
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 50
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 27, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 38, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 4, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 51
		{ // chars0
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 27, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 38, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 4, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 3, 
		},
	},
	{ // 52
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 18, 
			Char_Terrain + 9, Char_Terrain + 32, Char_Terrain + 32, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 31, Char_Terrain + 31, Char_Terrain + 9, 
		},
	},
	{ // 53
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 7, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 54
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 55
		{ // chars0
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 15, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 16, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 17, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 56
		{ // chars0
			Char_Terrain + 24, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 33, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 57
		{ // chars0
			Char_Terrain + 24, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 33, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 26, 
			Char_Terrain + 12, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 58
		{ // chars0
			Char_Terrain + 24, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 27, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
		{ // chars4
			Char_Terrain + 33, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 38, 
			Char_Terrain + 12, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 4, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
			Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, Char_Terrain + 29, 
		},
	},
	{ // 59
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 60
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 6, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 8, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 61
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
		{ // chars4
			Char_Terrain + 30, Char_Terrain + 18, Char_Terrain + 18, Char_Terrain + 18, 
			Char_Terrain + 7, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 62
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 34, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 34, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
		},
	},
	{ // 63
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 34, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 35, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
	},
	{ // 64
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 34, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 23, 
		},
	},
	{ // 65
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 34, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 35, 
		},
	},
	{ // 66
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 34, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
		},
	},
	{ // 67
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
	},
	{ // 68
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 69
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 70
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 35, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 35, 
		},
	},
	{ // 71
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, Char_Terrain + 35, 
		},
	},
	{ // 72
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 23, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
			Char_Terrain + 35, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
	},
	{ // 73
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 74
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 23, 
		},
	},
	{ // 75
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 34, Char_Terrain + 34, Char_Terrain + 34, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 23, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 35, 
		},
	},
	{ // 76
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 23, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 77
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 38, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 78
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 15, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 16, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
	{ // 79
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 33, 
		},
	},
	{ // 80
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 20, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 30, 
		},
	},
	{ // 81
		{ // chars0
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
		{ // chars4
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
		},
	},
};

static const byte[] mapBytes0 = {
	128 + 55, 81, 57, 128 + 3, 73, 74, 128 + 3, 81, 
	7, 128 + 3, 0, 3, 128 + 3, 81, 36, 128 + 3, 
	1, 2, 128 + 4, 71, 128 + 8, 81, 49, 49, 
	50, 128 + 3, 81, 79, 57, 128 + 3, 5, 81, 
	81, 57, 48, 128 + 3, 5, 6, 81, 81, 
	5, 5, 10, 15, 15, 18, 81, 81, 
	5, 5, 43, 54, 55, 128 + 3, 81, 7, 
	5, 5, 20, 20, 78, 81, 81, 33, 
	7, 5, 20, 20, 47, 81, 76, 74, 
	33, 7, 128 + 3, 20, 78, 69, 4, 81, 
	36, 128 + 3, 20, 47, 78, 128 + 3, 81, 128 + 4, 
	20, 47, 78, 81, 57, 128 + 5, 20, 47, 
	78, 7, 128 + 6, 20, 47, 35, 128 + 7, 20, 
	46, 128 + 3, 20, 25, 29, 128 + 6, 20, 46, 
	53, 128 + 10, 20, 26, 128 + 6, 20, 21, 81, 
	20, 20, 21, 26, 31, 31, 32, 76, 
	30, 23, 27, 81, 57, 50, 81, 68, 
	81, 41, 81, 81, 7, 6, 81, 69, 
	128 + 4, 81, 36, 18, 81, 81, 128 + 8, 71, 
	81, 81, 79, 57, 50, 128 + 5, 81, 56, 
	5, 6, 81, 75, 71, 81, 81, 7, 
	6, 11, 81, 67, 128 + 3, 81, 36, 18, 
	81, 81, 67, 81, 128 + 6, 71, 63, 128 + 7, 
	81, 67, 128 + 3, 81, 76, 74, 81, 81, 
	67, 128 + 3, 81, 68, 3, 81, 58, 67, 
	128 + 3, 81, 69, 4, 81, 8, 67, 128 + 6, 
	81, 37, 67, 81, 128 + 6, 71, 63, 128 + 3, 
	81, 57, 49, 50, 81, 67, 128 + 3, 81, 
	128 + 3, 5, 81, 66, 71, 81, 81, 7, 
	5, 6, 128 + 5, 81, 36, 15, 18, 81, 
	81, 81, 
};
static const byte[] mapBytes1 = {
	128 + 56, 81, 128 + 7, 71, 72, 128 + 7, 81, 67, 
	128 + 3, 81, 57, 49, 50, 81, 67, 128 + 3, 
	81, 7, 5, 6, 81, 67, 128 + 3, 81, 
	36, 15, 18, 81, 67, 128 + 7, 71, 64, 
	128 + 11, 81, 80, 61, 128 + 3, 54, 81, 61, 
	54, 53, 128 + 4, 20, 81, 128 + 7, 20, 80, 
	128 + 7, 20, 53, 128 + 17, 20, 26, 30, 128 + 6, 
	20, 78, 80, 20, 20, 21, 26, 20, 
	20, 46, 53, 20, 20, 27, 81, 128 + 6, 
	20, 78, 81, 128 + 6, 20, 46, 54, 128 + 8, 
	20, 31, 30, 22, 128 + 5, 20, 81, 81, 
	39, 22, 128 + 4, 20, 128 + 3, 81, 39, 22, 
	128 + 3, 20, 81, 81, 57, 50, 39, 20, 
	21, 26, 81, 81, 7, 6, 81, 20, 
	27, 128 + 3, 81, 36, 18, 81, 20, 81, 
	81, 75, 128 + 4, 71, 19, 71, 71, 67, 
	81, 57, 50, 81, 20, 57, 49, 67, 
	81, 7, 6, 81, 20, 5, 5, 67, 
	81, 36, 18, 81, 20, 5, 5, 67, 
	128 + 4, 81, 20, 7, 5, 67, 128 + 4, 81, 
	20, 36, 15, 65, 71, 71, 70, 71, 
	19, 71, 71, 67, 81, 81, 67, 80, 
	20, 81, 81, 52, 54, 54, 52, 53, 
	21, 81, 57, 28, 31, 31, 28, 31, 
	32, 81, 7, 67, 57, 50, 67, 57, 
	50, 81, 36, 67, 7, 6, 67, 7, 
	6, 81, 81, 67, 36, 18, 67, 36, 
	18, 81, 81, 66, 71, 71, 62, 128 + 4, 
	71, 128 + 15, 81, 81, 
};
static const byte[] mapBytes2 = {
	128 + 40, 81, 49, 50, 128 + 6, 81, 5, 6, 
	128 + 6, 81, 15, 17, 128 + 6, 71, 81, 67, 
	128 + 7, 81, 67, 128 + 3, 81, 57, 49, 49, 
	81, 67, 128 + 3, 81, 7, 5, 5, 81, 
	67, 128 + 3, 81, 36, 15, 15, 71, 62, 
	128 + 6, 71, 128 + 8, 81, 49, 50, 128 + 3, 81, 
	80, 61, 54, 5, 6, 81, 61, 54, 
	53, 20, 20, 15, 18, 81, 128 + 5, 20, 
	50, 81, 80, 128 + 5, 20, 6, 81, 59, 
	128 + 5, 20, 18, 80, 128 + 6, 20, 81, 60, 
	128 + 6, 20, 81, 38, 128 + 6, 20, 81, 59, 
	128 + 6, 20, 81, 128 + 7, 20, 81, 22, 128 + 6, 
	20, 81, 39, 22, 128 + 5, 20, 49, 50, 
	40, 30, 22, 128 + 3, 20, 5, 6, 81, 
	81, 39, 22, 20, 20, 14, 16, 72, 
	81, 81, 39, 20, 20, 81, 81, 67, 
	81, 57, 50, 20, 26, 81, 81, 67, 
	81, 7, 5, 20, 81, 50, 81, 67, 
	81, 36, 15, 20, 81, 5, 81, 65, 
	128 + 3, 71, 19, 71, 5, 81, 67, 81, 
	57, 50, 20, 81, 5, 81, 67, 81, 
	7, 5, 20, 81, 5, 81, 67, 81, 
	36, 15, 20, 81, 6, 81, 67, 128 + 3, 
	81, 20, 81, 18, 81, 65, 71, 70, 
	71, 19, 71, 81, 81, 67, 81, 67, 
	80, 20, 81, 54, 54, 52, 54, 52, 
	53, 21, 81, 31, 31, 28, 31, 28, 
	31, 32, 128 + 3, 81, 67, 58, 67, 58, 
	77, 81, 71, 71, 63, 5, 67, 5, 
	43, 49, 81, 81, 67, 8, 67, 7, 
	5, 5, 81, 81, 67, 37, 67, 36, 
	15, 15, 49, 50, 66, 71, 62, 128 + 3, 
	71, 5, 6, 128 + 6, 81, 15, 18, 128 + 5, 
	81, 81, 
};
static const byte[] mapBytes3 = {
	128 + 49, 81, 57, 50, 81, 57, 128 + 3, 49, 
	81, 7, 6, 81, 7, 128 + 3, 5, 81, 
	36, 18, 81, 36, 128 + 3, 15, 128 + 6, 71, 
	72, 128 + 7, 81, 67, 81, 79, 57, 49, 
	50, 77, 81, 67, 81, 48, 128 + 3, 5, 
	44, 81, 65, 71, 5, 10, 12, 5, 
	5, 81, 67, 81, 5, 43, 48, 5, 
	5, 81, 67, 81, 128 + 4, 5, 6, 81, 
	65, 71, 128 + 4, 5, 11, 81, 67, 81, 
	13, 7, 5, 6, 81, 81, 67, 81, 
	81, 36, 15, 18, 81, 81, 67, 128 + 7, 
	81, 67, 128 + 3, 81, 57, 50, 77, 81, 
	65, 71, 81, 81, 7, 5, 44, 81, 
	67, 81, 55, 78, 33, 7, 6, 81, 
	67, 81, 20, 47, 78, 36, 18, 81, 
	67, 81, 20, 20, 46, 128 + 3, 54, 52, 
	54, 20, 21, 26, 128 + 3, 31, 28, 31, 
	20, 27, 81, 81, 75, 71, 62, 71, 
	21, 128 + 3, 81, 67, 128 + 3, 81, 32, 76, 
	74, 81, 67, 128 + 4, 81, 68, 3, 81, 
	65, 128 + 3, 71, 81, 69, 4, 81, 67, 
	128 + 7, 81, 67, 81, 57, 49, 128 + 4, 71, 
	63, 81, 7, 5, 128 + 4, 81, 67, 81, 
	36, 15, 81, 75, 71, 71, 63, 81, 
	79, 57, 50, 67, 81, 81, 67, 79, 
	56, 5, 6, 67, 57, 50, 67, 56, 
	5, 5, 18, 67, 7, 6, 67, 5, 
	5, 10, 71, 63, 36, 18, 67, 7, 
	5, 43, 81, 65, 71, 71, 63, 33, 
	7, 5, 50, 67, 81, 81, 67, 81, 
	33, 7, 6, 67, 81, 81, 67, 81, 
	81, 36, 16, 63, 81, 81, 67, 57, 
	50, 81, 81, 67, 81, 81, 67, 7, 
	6, 81, 81, 67, 81, 81, 67, 36, 
	18, 81, 81, 66, 71, 71, 62, 128 + 3, 
	71, 128 + 15, 81, 81, 
};
static const byte[] mapBytes4 = {
	128 + 56, 81, 128 + 4, 71, 70, 128 + 3, 71, 128 + 4, 
	81, 67, 128 + 3, 81, 49, 49, 50, 81, 
	67, 128 + 3, 81, 5, 5, 6, 81, 67, 
	128 + 3, 81, 15, 15, 18, 81, 67, 81, 
	81, 57, 128 + 4, 71, 64, 81, 81, 5, 
	128 + 7, 81, 7, 80, 61, 128 + 3, 54, 55, 
	78, 36, 53, 128 + 5, 20, 46, 54, 128 + 43, 
	20, 21, 24, 22, 128 + 5, 20, 27, 81, 
	39, 128 + 5, 20, 78, 81, 80, 128 + 5, 20, 
	46, 54, 53, 128 + 26, 20, 30, 22, 20, 
	20, 21, 26, 30, 22, 81, 39, 20, 
	21, 27, 81, 81, 40, 81, 81, 20, 
	27, 128 + 6, 81, 20, 128 + 5, 81, 71, 71, 
	19, 128 + 5, 71, 50, 81, 20, 57, 49, 
	49, 50, 81, 6, 81, 20, 128 + 4, 5, 
	81, 18, 81, 20, 128 + 4, 5, 128 + 3, 81, 
	20, 7, 5, 5, 6, 81, 75, 71, 
	19, 34, 14, 14, 16, 71, 67, 80, 
	20, 128 + 5, 81, 52, 53, 21, 81, 81, 
	76, 74, 81, 28, 31, 32, 58, 81, 
	68, 3, 81, 67, 81, 81, 8, 81, 
	69, 4, 81, 67, 58, 77, 37, 128 + 4, 
	81, 67, 7, 45, 81, 81, 75, 71, 
	71, 67, 36, 18, 81, 81, 67, 81, 
	81, 66, 128 + 4, 71, 64, 128 + 17, 81, 81, 

};
static const byte[] mapBytes5 = {
	128 + 53, 81, 57, 50, 81, 73, 74, 128 + 3, 
	81, 7, 6, 81, 0, 3, 128 + 3, 81, 
	36, 18, 81, 1, 2, 128 + 6, 71, 128 + 8, 
	81, 50, 128 + 3, 81, 79, 57, 49, 49, 
	5, 81, 81, 57, 48, 128 + 3, 5, 6, 
	81, 81, 5, 5, 10, 12, 5, 18, 
	81, 81, 5, 5, 43, 48, 5, 128 + 3, 
	81, 7, 128 + 4, 5, 128 + 3, 81, 33, 7, 
	128 + 3, 5, 55, 81, 76, 74, 33, 7, 
	5, 5, 20, 78, 69, 4, 81, 36, 
	15, 15, 20, 47, 78, 128 + 5, 81, 20, 
	20, 47, 78, 81, 81, 57, 49, 128 + 3, 
	20, 47, 78, 81, 7, 5, 128 + 4, 20, 
	47, 78, 33, 7, 128 + 5, 20, 47, 78, 
	36, 20, 25, 29, 128 + 3, 20, 46, 54, 
	20, 46, 53, 20, 20, 21, 26, 31, 
	128 + 5, 20, 27, 81, 81, 128 + 4, 20, 21, 
	128 + 3, 81, 21, 26, 31, 31, 32, 76, 
	74, 81, 32, 81, 57, 50, 81, 68, 
	3, 128 + 3, 81, 7, 6, 81, 69, 4, 
	128 + 3, 81, 36, 18, 128 + 4, 81, 128 + 8, 71, 
	128 + 13, 81, 75, 71, 71, 128 + 3, 81, 57, 
	50, 67, 128 + 5, 81, 7, 6, 67, 57, 
	49, 128 + 3, 71, 34, 16, 63, 7, 5, 
	128 + 5, 81, 67, 36, 15, 73, 74, 128 + 3, 
	81, 65, 71, 71, 0, 3, 81, 57, 
	50, 67, 81, 81, 1, 4, 81, 7, 
	6, 67, 128 + 5, 81, 36, 18, 67, 81, 
	81, 128 + 5, 71, 63, 81, 81, 49, 49, 
	50, 81, 81, 67, 81, 81, 128 + 3, 5, 
	81, 81, 66, 71, 71, 5, 5, 6, 
	128 + 5, 81, 15, 15, 18, 128 + 4, 81, 81, 

};
static const byte[] mapBytes6 = {
	128 + 41, 81, 79, 57, 50, 128 + 5, 81, 56, 
	5, 5, 128 + 5, 81, 128 + 3, 5, 81, 75, 
	71, 71, 81, 7, 5, 6, 81, 67, 
	128 + 3, 81, 36, 15, 18, 81, 67, 128 + 7, 
	81, 67, 128 + 7, 81, 67, 81, 81, 71, 
	71, 70, 71, 71, 62, 71, 71, 81, 
	81, 67, 128 + 7, 81, 67, 81, 57, 50, 
	128 + 4, 81, 67, 81, 7, 6, 81, 61, 
	81, 81, 67, 81, 36, 18, 81, 20, 
	81, 81, 67, 57, 50, 81, 80, 20, 
	71, 71, 63, 7, 6, 81, 59, 20, 
	81, 81, 67, 36, 18, 80, 20, 20, 
	81, 81, 67, 81, 81, 60, 20, 20, 
	81, 81, 67, 81, 81, 38, 20, 20, 
	81, 81, 67, 81, 81, 59, 20, 20, 
	71, 71, 63, 81, 81, 128 + 3, 20, 81, 
	81, 67, 81, 81, 22, 20, 20, 81, 
	81, 67, 81, 81, 39, 22, 20, 81, 
	81, 67, 81, 57, 50, 40, 31, 81, 
	81, 67, 81, 7, 6, 81, 81, 71, 
	71, 62, 71, 34, 16, 72, 128 + 7, 81, 
	67, 81, 49, 50, 81, 81, 57, 50, 
	67, 81, 5, 5, 77, 81, 5, 5, 
	67, 81, 5, 5, 44, 81, 5, 5, 
	65, 71, 128 + 3, 5, 81, 7, 6, 67, 
	81, 128 + 3, 5, 77, 36, 18, 67, 81, 
	128 + 3, 5, 44, 81, 81, 67, 81, 128 + 3, 
	5, 6, 81, 81, 67, 81, 5, 5, 
	6, 11, 81, 81, 65, 71, 15, 15, 
	18, 128 + 3, 81, 67, 81, 128 + 6, 54, 52, 
	54, 128 + 6, 31, 28, 31, 128 + 6, 81, 67, 
	57, 128 + 6, 71, 63, 5, 128 + 6, 81, 67, 
	7, 81, 57, 50, 128 + 3, 81, 67, 36, 
	81, 7, 6, 81, 57, 50, 66, 71, 
	81, 36, 18, 81, 7, 6, 128 + 6, 81, 
	36, 18, 81, 81, 
};
static const byte[] mapBytes7 = {
	128 + 48, 81, 50, 128 + 7, 81, 6, 128 + 4, 81, 
	76, 74, 81, 18, 128 + 4, 81, 69, 4, 
	81, 128 + 4, 71, 72, 128 + 3, 81, 50, 77, 
	81, 81, 65, 128 + 3, 71, 5, 44, 77, 
	81, 67, 128 + 3, 81, 5, 5, 44, 81, 
	65, 128 + 3, 71, 12, 5, 5, 81, 67, 
	128 + 3, 81, 48, 5, 5, 81, 67, 128 + 3, 
	81, 5, 5, 6, 81, 65, 128 + 3, 71, 
	5, 5, 11, 81, 67, 128 + 3, 81, 5, 
	6, 81, 81, 67, 57, 50, 81, 6, 
	11, 81, 81, 67, 7, 6, 81, 18, 
	128 + 3, 81, 67, 36, 18, 81, 50, 128 + 3, 
	81, 66, 128 + 3, 71, 5, 128 + 4, 81, 57, 
	50, 81, 6, 128 + 4, 81, 7, 6, 81, 
	18, 128 + 4, 81, 36, 18, 81, 128 + 8, 54, 
	128 + 8, 31, 81, 81, 75, 128 + 5, 71, 81, 
	81, 67, 128 + 5, 81, 74, 81, 67, 128 + 5, 
	81, 3, 81, 65, 128 + 5, 71, 4, 81, 
	67, 128 + 7, 81, 67, 81, 57, 51, 81, 
	81, 71, 71, 63, 81, 8, 11, 128 + 4, 
	81, 67, 81, 37, 79, 57, 49, 71, 
	71, 63, 81, 79, 56, 5, 5, 81, 
	81, 67, 81, 56, 128 + 3, 5, 49, 50, 
	67, 81, 128 + 5, 5, 6, 67, 81, 5, 
	5, 9, 5, 15, 18, 67, 81, 7, 
	5, 42, 5, 71, 71, 63, 81, 33, 
	7, 5, 5, 81, 81, 67, 81, 81, 
	33, 5, 5, 81, 81, 67, 128 + 3, 81, 
	7, 5, 81, 81, 67, 57, 50, 81, 
	33, 5, 81, 81, 67, 7, 6, 81, 
	81, 7, 81, 81, 67, 36, 18, 81, 
	81, 36, 71, 71, 62, 128 + 5, 71, 128 + 15, 
	81, 81, 
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
