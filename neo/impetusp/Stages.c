#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 1
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 87, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 61, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 29, 
		},
	},
	{ // 2
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 3, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 34, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 58, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 32, 
		},
	},
	{ // 3
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 88, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 25, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 65, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 30, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 4
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 10, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 40, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 76, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 31, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 5
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 78, 
		},
	},
	{ // 6
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 82, Char_Terrain + 82, Char_Terrain + 82, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
	},
	{ // 7
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 43, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 60, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 78, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
		},
	},
	{ // 8
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, 
		},
	},
	{ // 9
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 43, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 60, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 78, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 78, 
		},
	},
	{ // 10
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 82, Char_Terrain + 82, Char_Terrain + 82, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
		},
	},
	{ // 11
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 82, Char_Terrain + 82, Char_Terrain + 82, Char_Terrain + 82, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, Char_Terrain + 53, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
	},
	{ // 12
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
		},
	},
	{ // 13
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 77, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 59, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 42, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, 
		},
	},
	{ // 14
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 77, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 59, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 42, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 78, 
		},
	},
	{ // 15
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 77, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 59, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 42, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 21, 
		},
	},
	{ // 16
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 77, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 43, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 59, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 60, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 42, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 78, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
		},
	},
	{ // 17
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 77, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 77, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 59, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 59, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 42, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 42, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, 
		},
	},
	{ // 18
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 54, Char_Terrain + 54, Char_Terrain + 54, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 83, Char_Terrain + 83, Char_Terrain + 83, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
		},
	},
	{ // 19
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars2
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars4
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars6
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 21, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
	},
	{ // 20
		{ // chars0
			Char_Terrain + 87, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 88, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 24, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 25, 
			Char_Terrain + 50, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 51, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 61, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 65, 
			Char_Terrain + 26, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 19, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 29, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 30, 
			Char_Terrain + 70, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 72, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 21
		{ // chars0
			Char_Terrain + 87, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 24, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 81, 
			Char_Terrain + 50, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 61, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 89, 
			Char_Terrain + 26, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 29, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 70, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 22
		{ // chars0
			Char_Terrain + 87, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 24, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 50, 
			Char_Terrain + 50, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 61, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 26, 
			Char_Terrain + 26, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 29, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 70, 
			Char_Terrain + 70, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 23
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 34, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 74, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 58, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 52, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 32, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 86, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 24
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 33, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 34, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 74, 
			Char_Terrain + 74, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 9, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 58, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 52, 
			Char_Terrain + 52, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 55, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 32, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 86, 
			Char_Terrain + 86, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 85, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 25
		{ // chars0
			Char_Terrain + 3, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 34, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 74, 
			Char_Terrain + 74, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 58, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 52, 
			Char_Terrain + 52, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 32, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 86, 
			Char_Terrain + 86, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 26
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 88, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 91, 
		},
		{ // chars2
			Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 25, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 51, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 67, 
		},
		{ // chars4
			Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 65, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 19, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 18, 
		},
		{ // chars6
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 30, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 72, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 49, 
		},
	},
	{ // 27
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 88, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 25, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 51, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 65, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 19, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 30, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 72, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 28
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 81, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 89, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 29
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 50, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 26, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 70, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 30
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 40, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 75, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 76, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 41, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 31, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 93, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 31
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 32
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 74, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 52, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 86, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 33
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 4, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 4, 
			Char_Terrain + 2, Char_Terrain + 22, Char_Terrain + 22, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 69, Char_Terrain + 69, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 11, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 11, 
			Char_Terrain + 1, Char_Terrain + 47, Char_Terrain + 47, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 48, Char_Terrain + 48, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 15, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 15, 
			Char_Terrain + 2, Char_Terrain + 68, Char_Terrain + 68, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 2, 
		},
	},
	{ // 34
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 88, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 91, 
		},
		{ // chars2
			Char_Terrain + 51, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 25, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 51, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 67, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 65, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 19, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 18, 
		},
		{ // chars6
			Char_Terrain + 72, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 30, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 72, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 49, 
		},
	},
	{ // 35
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 88, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 51, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 25, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 51, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 65, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 19, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 72, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 30, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 72, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 36
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 51, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 81, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 89, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 72, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 37
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 51, Char_Terrain + 81, Char_Terrain + 81, Char_Terrain + 50, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 19, Char_Terrain + 89, Char_Terrain + 89, Char_Terrain + 26, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 72, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 70, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 38
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 75, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 40, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 75, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 41, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 76, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 41, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 93, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 31, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 93, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 39
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 75, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 41, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 93, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 40
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 36, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 37, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 71, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 66, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 35, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 27, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 41
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 36, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 71, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 35, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 42
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 10, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 36, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 40, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 71, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 76, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 35, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 31, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 43
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 36, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 71, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, 
			Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 35, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, 
			Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, 
		},
	},
	{ // 44
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 6, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 36, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 79, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 36, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 71, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 28, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 71, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 35, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 56, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 35, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 45
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 38, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 39, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 84, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 62, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 44, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 45, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 46
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 38, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 84, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 44, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 47
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 33, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 38, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 9, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 38, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 84, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 55, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 84, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 44, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 85, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 44, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 48
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 33, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 3, 
		},
		{ // chars2
			Char_Terrain + 38, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 9, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 38, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 34, 
		},
		{ // chars4
			Char_Terrain + 84, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 55, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 84, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 58, 
		},
		{ // chars6
			Char_Terrain + 44, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 85, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 44, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 32, 
		},
	},
	{ // 49
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 37, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 66, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 27, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 50
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 37, 
			Char_Terrain + 21, Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 66, 
			Char_Terrain + 20, Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 27, 
			Char_Terrain + 21, Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 78, 
		},
	},
	{ // 51
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 37, 
			Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 66, 
			Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 27, 
			Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, 
		},
	},
	{ // 52
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 53
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, Char_Terrain + 77, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, 
			Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, Char_Terrain + 59, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, 
			Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, Char_Terrain + 42, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, Char_Terrain + 78, 
		},
	},
	{ // 54
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 6, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 79, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 36, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 28, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 71, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 56, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 35, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 55
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 6, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 87, 
		},
		{ // chars2
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 79, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 36, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 28, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 71, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 61, 
		},
		{ // chars6
			Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 56, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 35, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 29, 
		},
	},
	{ // 56
		{ // chars0
			Char_Terrain + 91, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 67, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 37, 
			Char_Terrain + 37, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 66, 
			Char_Terrain + 66, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 49, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 27, 
			Char_Terrain + 27, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 57
		{ // chars0
			Char_Terrain + 91, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 88, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 67, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 37, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 25, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 90, 
			Char_Terrain + 66, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 65, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 49, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 80, 
			Char_Terrain + 27, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 30, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 58
		{ // chars0
			Char_Terrain + 91, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 6, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 88, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 87, 
		},
		{ // chars2
			Char_Terrain + 67, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 79, 
			Char_Terrain + 37, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 36, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 25, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 24, 
		},
		{ // chars4
			Char_Terrain + 18, Char_Terrain + 90, Char_Terrain + 90, Char_Terrain + 28, 
			Char_Terrain + 66, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 71, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 65, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 61, 
		},
		{ // chars6
			Char_Terrain + 49, Char_Terrain + 80, Char_Terrain + 80, Char_Terrain + 56, 
			Char_Terrain + 27, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 35, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 30, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 29, 
		},
	},
	{ // 59
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 6, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 91, 
		},
		{ // chars2
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 79, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 67, 
		},
		{ // chars4
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 28, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 18, 
		},
		{ // chars6
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 56, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 49, 
		},
	},
	{ // 60
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 6, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 79, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 28, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 56, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 61
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 91, 
		},
		{ // chars2
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 67, 
		},
		{ // chars4
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 18, 
		},
		{ // chars6
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 49, 
		},
	},
	{ // 62
		{ // chars0
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars2
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
		{ // chars4
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
			Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, Char_Terrain + 63, 
		},
		{ // chars6
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
			Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, Char_Terrain + 64, 
		},
	},
	{ // 63
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 39, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 62, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 45, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 64
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 65
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 33, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 9, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 38, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 55, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 84, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 85, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 44, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 66
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 33, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 3, 
		},
		{ // chars2
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 9, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 38, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 34, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 55, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 84, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 58, 
		},
		{ // chars6
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 85, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 44, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 32, 
		},
	},
	{ // 67
		{ // chars0
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 16, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 16, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 12, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 12, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 5, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 5, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 21, 
		},
	},
	{ // 68
		{ // chars0
			Char_Terrain + 17, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 92, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 39, 
			Char_Terrain + 39, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 57, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 62, 
			Char_Terrain + 62, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 73, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 45, 
			Char_Terrain + 45, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 69
		{ // chars0
			Char_Terrain + 17, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 92, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 39, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 57, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 62, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 73, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 45, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 70
		{ // chars0
			Char_Terrain + 17, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 10, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 92, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 39, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 40, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 57, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 62, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 76, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 73, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 45, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 31, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 71
		{ // chars0
			Char_Terrain + 17, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 33, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 92, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 9, 
			Char_Terrain + 39, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 38, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 57, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 55, 
			Char_Terrain + 62, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 84, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 73, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 85, 
			Char_Terrain + 45, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 44, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, Char_Terrain + 21, 
		},
	},
	{ // 72
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 33, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 17, 
		},
		{ // chars2
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 9, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 92, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 55, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 57, 
		},
		{ // chars6
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 85, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 73, 
		},
	},
	{ // 73
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 33, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 9, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 55, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 85, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 74
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 17, 
		},
		{ // chars2
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 92, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 57, 
		},
		{ // chars6
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 73, 
		},
	},
	{ // 75
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars6
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 76
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars2
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 69, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 69, 
			Char_Terrain + 0, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 0, 
			Char_Terrain + 22, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 22, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 48, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 48, 
			Char_Terrain + 0, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 47, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 47, 
		},
		{ // chars6
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 23, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 23, 
			Char_Terrain + 0, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 0, 
			Char_Terrain + 68, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 68, 
		},
	},
	{ // 77
		{ // chars0
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 54, Char_Terrain + 54, Char_Terrain + 54, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 83, Char_Terrain + 83, Char_Terrain + 83, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 21, 
		},
	},
	{ // 78
		{ // chars0
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
		},
		{ // chars4
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
		},
		{ // chars6
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
		},
	},
	{ // 79
		{ // chars0
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 0, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 0, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 77, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 0, 
			Char_Terrain + 54, Char_Terrain + 54, Char_Terrain + 54, Char_Terrain + 43, 
		},
		{ // chars4
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 20, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 59, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 0, 
			Char_Terrain + 83, Char_Terrain + 83, Char_Terrain + 83, Char_Terrain + 60, 
		},
		{ // chars6
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 21, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 42, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 0, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 78, 
		},
	},
	{ // 80
		{ // chars0
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, Char_Terrain + 20, 
		},
		{ // chars2
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 54, Char_Terrain + 54, Char_Terrain + 54, Char_Terrain + 54, 
		},
		{ // chars4
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 83, Char_Terrain + 83, Char_Terrain + 83, Char_Terrain + 83, 
		},
		{ // chars6
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
		},
	},
	{ // 81
		{ // chars0
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars2
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars4
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
		{ // chars6
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
			Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, Char_Terrain + 46, 
		},
	},
};

static const byte[] mapBytes0 = {
	128 + 55, 0, 21, 128 + 3, 11, 10, 128 + 3, 0, 
	60, 128 + 3, 81, 78, 128 + 3, 0, 41, 128 + 3, 
	80, 79, 128 + 4, 8, 128 + 8, 0, 28, 28, 
	27, 128 + 3, 0, 1, 21, 128 + 3, 62, 0, 
	0, 21, 29, 128 + 3, 62, 61, 0, 0, 
	62, 62, 57, 52, 52, 49, 0, 0, 
	62, 62, 36, 31, 30, 128 + 3, 0, 60, 
	62, 62, 75, 75, 4, 0, 0, 44, 
	60, 62, 75, 75, 38, 0, 6, 10, 
	44, 60, 128 + 3, 75, 4, 18, 77, 0, 
	41, 128 + 3, 75, 38, 4, 128 + 3, 0, 128 + 4, 
	75, 38, 4, 0, 21, 128 + 5, 75, 38, 
	4, 60, 128 + 6, 75, 38, 42, 128 + 7, 75, 
	39, 128 + 3, 75, 70, 66, 128 + 6, 75, 39, 
	32, 128 + 10, 75, 69, 128 + 6, 75, 74, 0, 
	75, 75, 74, 69, 64, 64, 63, 6, 
	65, 72, 68, 0, 21, 27, 0, 19, 
	0, 45, 0, 0, 60, 61, 0, 18, 
	128 + 4, 0, 41, 49, 0, 0, 128 + 8, 8, 
	0, 0, 1, 21, 27, 128 + 5, 0, 22, 
	62, 61, 0, 5, 8, 0, 0, 60, 
	61, 56, 0, 12, 128 + 3, 0, 41, 49, 
	0, 0, 12, 0, 128 + 6, 8, 16, 128 + 7, 
	0, 12, 128 + 3, 0, 6, 10, 0, 0, 
	12, 128 + 3, 0, 19, 78, 0, 20, 12, 
	128 + 3, 0, 18, 77, 0, 59, 12, 128 + 6, 
	0, 40, 12, 0, 128 + 6, 8, 16, 128 + 3, 
	0, 21, 28, 27, 0, 12, 128 + 3, 0, 
	128 + 3, 62, 0, 13, 8, 0, 0, 60, 
	62, 61, 128 + 5, 0, 41, 52, 49, 0, 
	0, 0, 
};
static const byte[] mapBytes1 = {
	128 + 56, 0, 128 + 7, 8, 7, 128 + 7, 0, 12, 
	128 + 3, 0, 21, 28, 27, 0, 12, 128 + 3, 
	0, 60, 62, 61, 0, 12, 128 + 3, 0, 
	41, 52, 49, 0, 12, 128 + 7, 8, 15, 
	128 + 11, 0, 2, 23, 128 + 3, 31, 0, 23, 
	31, 32, 128 + 4, 75, 0, 128 + 7, 75, 2, 
	128 + 7, 75, 32, 128 + 17, 75, 69, 65, 128 + 6, 
	75, 4, 2, 75, 75, 74, 69, 75, 
	75, 39, 32, 75, 75, 68, 0, 128 + 6, 
	75, 4, 0, 128 + 6, 75, 39, 31, 128 + 8, 
	75, 64, 65, 73, 128 + 5, 75, 0, 0, 
	47, 73, 128 + 4, 75, 128 + 3, 0, 47, 73, 
	128 + 3, 75, 0, 0, 21, 27, 47, 75, 
	74, 69, 0, 0, 60, 61, 0, 75, 
	68, 128 + 3, 0, 41, 49, 0, 75, 0, 
	0, 5, 128 + 4, 8, 76, 8, 8, 12, 
	0, 21, 27, 0, 75, 21, 28, 12, 
	0, 60, 61, 0, 75, 62, 62, 12, 
	0, 41, 49, 0, 75, 62, 62, 12, 
	128 + 4, 0, 75, 60, 62, 12, 128 + 4, 0, 
	75, 41, 52, 14, 8, 8, 9, 8, 
	76, 8, 8, 12, 0, 0, 12, 2, 
	75, 0, 0, 33, 31, 31, 33, 32, 
	74, 0, 21, 67, 64, 64, 67, 64, 
	63, 0, 60, 12, 21, 27, 12, 21, 
	27, 0, 41, 12, 60, 61, 12, 60, 
	61, 0, 0, 12, 41, 49, 12, 41, 
	49, 0, 0, 13, 8, 8, 17, 128 + 4, 
	8, 128 + 15, 0, 0, 
};
static const byte[] mapBytes2 = {
	128 + 40, 0, 28, 27, 128 + 6, 0, 62, 61, 
	128 + 6, 0, 52, 50, 128 + 6, 8, 0, 12, 
	128 + 7, 0, 12, 128 + 3, 0, 21, 28, 28, 
	0, 12, 128 + 3, 0, 60, 62, 62, 0, 
	12, 128 + 3, 0, 41, 52, 52, 8, 17, 
	128 + 6, 8, 128 + 8, 0, 28, 27, 128 + 3, 0, 
	2, 23, 31, 62, 61, 0, 23, 31, 
	32, 75, 75, 52, 49, 0, 128 + 5, 75, 
	27, 0, 2, 128 + 5, 75, 61, 0, 25, 
	128 + 5, 75, 49, 2, 128 + 6, 75, 0, 24, 
	128 + 6, 75, 0, 48, 128 + 6, 75, 0, 25, 
	128 + 6, 75, 0, 128 + 7, 75, 0, 73, 128 + 6, 
	75, 0, 47, 73, 128 + 5, 75, 28, 27, 
	46, 65, 73, 128 + 3, 75, 62, 61, 0, 
	0, 47, 73, 75, 75, 53, 51, 7, 
	0, 0, 47, 75, 75, 0, 0, 12, 
	0, 21, 27, 75, 69, 0, 0, 12, 
	0, 60, 62, 75, 0, 27, 0, 12, 
	0, 41, 52, 75, 0, 62, 0, 14, 
	128 + 3, 8, 76, 8, 62, 0, 12, 0, 
	21, 27, 75, 0, 62, 0, 12, 0, 
	60, 62, 75, 0, 62, 0, 12, 0, 
	41, 52, 75, 0, 61, 0, 12, 128 + 3, 
	0, 75, 0, 49, 0, 14, 8, 9, 
	8, 76, 8, 0, 0, 12, 0, 12, 
	2, 75, 0, 31, 31, 33, 31, 33, 
	32, 74, 0, 64, 64, 67, 64, 67, 
	64, 63, 128 + 3, 0, 12, 20, 12, 20, 
	3, 0, 8, 8, 16, 62, 12, 62, 
	36, 28, 0, 0, 12, 59, 12, 60, 
	62, 62, 0, 0, 12, 40, 12, 41, 
	52, 52, 28, 27, 13, 8, 17, 128 + 3, 
	8, 62, 61, 128 + 6, 0, 52, 49, 128 + 5, 
	0, 0, 
};
static const byte[] mapBytes3 = {
	128 + 49, 0, 21, 27, 0, 21, 128 + 3, 28, 
	0, 60, 61, 0, 60, 128 + 3, 62, 0, 
	41, 49, 0, 41, 128 + 3, 52, 128 + 6, 8, 
	7, 128 + 7, 0, 12, 0, 1, 21, 28, 
	27, 3, 0, 12, 0, 29, 128 + 3, 62, 
	35, 0, 14, 8, 62, 57, 55, 62, 
	62, 0, 12, 0, 62, 36, 29, 62, 
	62, 0, 12, 0, 128 + 4, 62, 61, 0, 
	14, 8, 128 + 4, 62, 56, 0, 12, 0, 
	54, 60, 62, 61, 0, 0, 12, 0, 
	0, 41, 52, 49, 0, 0, 12, 128 + 7, 
	0, 12, 128 + 3, 0, 21, 27, 3, 0, 
	14, 8, 0, 0, 60, 62, 35, 0, 
	12, 0, 30, 4, 44, 60, 61, 0, 
	12, 0, 75, 38, 4, 41, 49, 0, 
	12, 0, 75, 75, 39, 128 + 3, 31, 33, 
	31, 75, 74, 69, 128 + 3, 64, 67, 64, 
	75, 68, 0, 0, 5, 8, 17, 8, 
	74, 128 + 3, 0, 12, 128 + 3, 0, 63, 6, 
	10, 0, 12, 128 + 4, 0, 19, 78, 0, 
	14, 128 + 3, 8, 0, 18, 77, 0, 12, 
	128 + 7, 0, 12, 0, 21, 28, 128 + 4, 8, 
	16, 0, 60, 62, 128 + 4, 0, 12, 0, 
	41, 52, 0, 5, 8, 8, 16, 0, 
	1, 21, 27, 12, 0, 0, 12, 1, 
	22, 62, 61, 12, 21, 27, 12, 22, 
	62, 62, 49, 12, 60, 61, 12, 62, 
	62, 57, 8, 16, 41, 49, 12, 60, 
	62, 36, 0, 14, 8, 8, 16, 44, 
	60, 62, 27, 12, 0, 0, 12, 0, 
	44, 60, 61, 12, 0, 0, 12, 0, 
	0, 41, 51, 16, 0, 0, 12, 21, 
	27, 0, 0, 12, 0, 0, 12, 60, 
	61, 0, 0, 12, 0, 0, 12, 41, 
	49, 0, 0, 13, 8, 8, 17, 128 + 3, 
	8, 128 + 15, 0, 0, 
};
static const byte[] mapBytes4 = {
	128 + 56, 0, 128 + 4, 8, 9, 128 + 3, 8, 128 + 4, 
	0, 12, 128 + 3, 0, 28, 28, 27, 0, 
	12, 128 + 3, 0, 62, 62, 61, 0, 12, 
	128 + 3, 0, 52, 52, 49, 0, 12, 0, 
	0, 21, 128 + 4, 8, 15, 0, 0, 62, 
	128 + 7, 0, 60, 2, 23, 128 + 3, 31, 30, 
	4, 41, 32, 128 + 5, 75, 39, 31, 128 + 43, 
	75, 74, 71, 73, 128 + 5, 75, 68, 0, 
	47, 128 + 5, 75, 4, 0, 2, 128 + 5, 75, 
	39, 31, 32, 128 + 26, 75, 65, 73, 75, 
	75, 74, 69, 65, 73, 0, 47, 75, 
	74, 68, 0, 0, 46, 0, 0, 75, 
	68, 128 + 6, 0, 75, 128 + 5, 0, 8, 8, 
	76, 128 + 5, 8, 27, 0, 75, 21, 28, 
	28, 27, 0, 61, 0, 75, 128 + 4, 62, 
	0, 49, 0, 75, 128 + 4, 62, 128 + 3, 0, 
	75, 60, 62, 62, 61, 0, 5, 8, 
	76, 43, 53, 53, 51, 8, 12, 2, 
	75, 128 + 5, 0, 33, 32, 74, 0, 0, 
	6, 10, 0, 67, 64, 63, 20, 0, 
	19, 78, 0, 12, 0, 0, 59, 0, 
	18, 77, 0, 12, 20, 3, 40, 128 + 4, 
	0, 12, 60, 34, 0, 0, 5, 8, 
	8, 12, 41, 49, 0, 0, 12, 0, 
	0, 13, 128 + 4, 8, 15, 128 + 17, 0, 0, 

};
static const byte[] mapBytes5 = {
	128 + 53, 0, 21, 27, 0, 11, 10, 128 + 3, 
	0, 60, 61, 0, 81, 78, 128 + 3, 0, 
	41, 49, 0, 80, 79, 128 + 6, 8, 128 + 8, 
	0, 27, 128 + 3, 0, 1, 21, 28, 28, 
	62, 0, 0, 21, 29, 128 + 3, 62, 61, 
	0, 0, 62, 62, 57, 55, 62, 49, 
	0, 0, 62, 62, 36, 29, 62, 128 + 3, 
	0, 60, 128 + 4, 62, 128 + 3, 0, 44, 60, 
	128 + 3, 62, 30, 0, 6, 10, 44, 60, 
	62, 62, 75, 4, 18, 77, 0, 41, 
	52, 52, 75, 38, 4, 128 + 5, 0, 75, 
	75, 38, 4, 0, 0, 21, 28, 128 + 3, 
	75, 38, 4, 0, 60, 62, 128 + 4, 75, 
	38, 4, 44, 60, 128 + 5, 75, 38, 4, 
	41, 75, 70, 66, 128 + 3, 75, 39, 31, 
	75, 39, 32, 75, 75, 74, 69, 64, 
	128 + 5, 75, 68, 0, 0, 128 + 4, 75, 74, 
	128 + 3, 0, 74, 69, 64, 64, 63, 6, 
	10, 0, 63, 0, 21, 27, 0, 19, 
	78, 128 + 3, 0, 60, 61, 0, 18, 77, 
	128 + 3, 0, 41, 49, 128 + 4, 0, 128 + 8, 8, 
	128 + 13, 0, 5, 8, 8, 128 + 3, 0, 21, 
	27, 12, 128 + 5, 0, 60, 61, 12, 21, 
	28, 128 + 3, 8, 43, 51, 16, 60, 62, 
	128 + 5, 0, 12, 41, 52, 11, 10, 128 + 3, 
	0, 14, 8, 8, 81, 78, 0, 21, 
	27, 12, 0, 0, 80, 77, 0, 60, 
	61, 12, 128 + 5, 0, 41, 49, 12, 0, 
	0, 128 + 5, 8, 16, 0, 0, 28, 28, 
	27, 0, 0, 12, 0, 0, 128 + 3, 62, 
	0, 0, 13, 8, 8, 62, 62, 61, 
	128 + 5, 0, 52, 52, 49, 128 + 4, 0, 0, 

};
static const byte[] mapBytes6 = {
	128 + 41, 0, 1, 21, 27, 128 + 5, 0, 22, 
	62, 62, 128 + 5, 0, 128 + 3, 62, 0, 5, 
	8, 8, 0, 60, 62, 61, 0, 12, 
	128 + 3, 0, 41, 52, 49, 0, 12, 128 + 7, 
	0, 12, 128 + 7, 0, 12, 0, 0, 8, 
	8, 9, 8, 8, 17, 8, 8, 0, 
	0, 12, 128 + 7, 0, 12, 0, 21, 27, 
	128 + 4, 0, 12, 0, 60, 61, 0, 23, 
	0, 0, 12, 0, 41, 49, 0, 75, 
	0, 0, 12, 21, 27, 0, 2, 75, 
	8, 8, 16, 60, 61, 0, 25, 75, 
	0, 0, 12, 41, 49, 2, 75, 75, 
	0, 0, 12, 0, 0, 24, 75, 75, 
	0, 0, 12, 0, 0, 48, 75, 75, 
	0, 0, 12, 0, 0, 25, 75, 75, 
	8, 8, 16, 0, 0, 128 + 3, 75, 0, 
	0, 12, 0, 0, 73, 75, 75, 0, 
	0, 12, 0, 0, 47, 73, 75, 0, 
	0, 12, 0, 21, 27, 46, 64, 0, 
	0, 12, 0, 60, 61, 0, 0, 8, 
	8, 17, 8, 43, 51, 7, 128 + 7, 0, 
	12, 0, 28, 27, 0, 0, 21, 27, 
	12, 0, 62, 62, 3, 0, 62, 62, 
	12, 0, 62, 62, 35, 0, 62, 62, 
	14, 8, 128 + 3, 62, 0, 60, 61, 12, 
	0, 128 + 3, 62, 3, 41, 49, 12, 0, 
	128 + 3, 62, 35, 0, 0, 12, 0, 128 + 3, 
	62, 61, 0, 0, 12, 0, 62, 62, 
	61, 56, 0, 0, 14, 8, 52, 52, 
	49, 128 + 3, 0, 12, 0, 128 + 6, 31, 33, 
	31, 128 + 6, 64, 67, 64, 128 + 6, 0, 12, 
	21, 128 + 6, 8, 16, 62, 128 + 6, 0, 12, 
	60, 0, 21, 27, 128 + 3, 0, 12, 41, 
	0, 60, 61, 0, 21, 27, 13, 8, 
	0, 41, 49, 0, 60, 61, 128 + 6, 0, 
	41, 49, 0, 0, 
};
static const byte[] mapBytes7 = {
	128 + 48, 0, 27, 128 + 7, 0, 61, 128 + 4, 0, 
	6, 10, 0, 49, 128 + 4, 0, 18, 77, 
	0, 128 + 4, 8, 7, 128 + 3, 0, 27, 3, 
	0, 0, 14, 128 + 3, 8, 62, 35, 3, 
	0, 12, 128 + 3, 0, 62, 62, 35, 0, 
	14, 128 + 3, 8, 55, 62, 62, 0, 12, 
	128 + 3, 0, 29, 62, 62, 0, 12, 128 + 3, 
	0, 62, 62, 61, 0, 14, 128 + 3, 8, 
	62, 62, 56, 0, 12, 128 + 3, 0, 62, 
	61, 0, 0, 12, 21, 27, 0, 61, 
	56, 0, 0, 12, 60, 61, 0, 49, 
	128 + 3, 0, 12, 41, 49, 0, 27, 128 + 3, 
	0, 13, 128 + 3, 8, 62, 128 + 4, 0, 21, 
	27, 0, 61, 128 + 4, 0, 60, 61, 0, 
	49, 128 + 4, 0, 41, 49, 0, 128 + 8, 31, 
	128 + 8, 64, 0, 0, 5, 128 + 5, 8, 0, 
	0, 12, 128 + 5, 0, 10, 0, 12, 128 + 5, 
	0, 78, 0, 14, 128 + 5, 8, 77, 0, 
	12, 128 + 7, 0, 12, 0, 21, 26, 0, 
	0, 8, 8, 16, 0, 59, 56, 128 + 4, 
	0, 12, 0, 40, 1, 21, 28, 8, 
	8, 16, 0, 1, 22, 62, 62, 0, 
	0, 12, 0, 22, 128 + 3, 62, 28, 27, 
	12, 0, 128 + 5, 62, 61, 12, 0, 62, 
	62, 58, 62, 52, 49, 12, 0, 60, 
	62, 37, 62, 8, 8, 16, 0, 44, 
	60, 62, 62, 0, 0, 12, 0, 0, 
	44, 62, 62, 0, 0, 12, 128 + 3, 0, 
	60, 62, 0, 0, 12, 21, 27, 0, 
	44, 62, 0, 0, 12, 60, 61, 0, 
	0, 60, 0, 0, 12, 41, 49, 0, 
	0, 41, 8, 8, 17, 128 + 5, 8, 128 + 15, 
	0, 0, 
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
