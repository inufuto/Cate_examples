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
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 2
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 11, 
		},
	},
	{ // 3
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
	},
	{ // 4
		{ // chars0
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 1, 
		},
	},
	{ // 5
		{ // chars0
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
		{ // chars4
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 6
		{ // chars0
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 3, 
		},
	},
	{ // 7
		{ // chars0
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
		{ // chars4
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 3, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 8
		{ // chars0
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 3, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 3, 
		},
	},
	{ // 9
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 10
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 11
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 12
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 11, 
		},
	},
	{ // 13
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 14
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 2, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 2, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 6, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 6, 
			Char_Terrain + 2, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 2, 
			Char_Terrain + 7, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 7, 
		},
	},
	{ // 15
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
	{ // 16
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 14, 
		},
	},
	{ // 17
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 1, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 14, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 18
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 1, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 14, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 14, 
		},
	},
	{ // 19
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 14, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
	},
	{ // 20
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 21
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 22
		{ // chars0
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 23
		{ // chars0
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 1, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 1, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 24
		{ // chars0
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 1, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 1, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 3, 
		},
	},
	{ // 25
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 13, 
			Char_Terrain + 8, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 8, 
		},
	},
	{ // 26
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 27
		{ // chars0
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 1, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 1, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 13, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 28
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 10, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 29
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 11, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
	},
	{ // 30
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 1, 
		},
	},
	{ // 31
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 11, 
		},
	},
	{ // 32
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 33
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
	},
	{ // 34
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 35
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 36
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
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
			Char_Terrain + 1, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 38
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
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
			Char_Terrain + 1, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 14, 
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
			Char_Terrain + 1, Char_Terrain + 14, Char_Terrain + 14, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 41
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 42
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 1, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 4, Char_Terrain + 4, Char_Terrain + 1, 
			Char_Terrain + 4, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 43
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 44
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 1, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 13, Char_Terrain + 13, Char_Terrain + 13, 
			Char_Terrain + 13, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 14, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 45
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 11, 
		},
	},
	{ // 46
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 47
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 1, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
			Char_Terrain + 11, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
	},
	{ // 48
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 49
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 1, 
		},
	},
	{ // 50
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 1, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 1, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 11, 
		},
	},
	{ // 51
		{ // chars0
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
		{ // chars4
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 52
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
};

static const byte[] mapBytes0 = {
	128 + 55, 52, 41, 128 + 3, 48, 49, 128 + 3, 52, 
	7, 128 + 3, 0, 3, 128 + 3, 52, 37, 128 + 3, 
	1, 2, 128 + 4, 46, 128 + 8, 52, 22, 22, 
	23, 128 + 4, 52, 41, 128 + 3, 5, 52, 52, 
	41, 22, 128 + 3, 5, 6, 52, 52, 5, 
	5, 128 + 3, 10, 13, 52, 52, 5, 5, 
	22, 26, 27, 128 + 3, 52, 7, 5, 5, 
	15, 15, 128 + 3, 52, 37, 7, 5, 15, 
	15, 27, 52, 51, 49, 37, 7, 128 + 3, 
	15, 52, 35, 4, 52, 37, 128 + 3, 15, 
	27, 128 + 4, 52, 128 + 4, 15, 27, 52, 52, 
	41, 128 + 5, 15, 27, 52, 7, 128 + 6, 15, 
	27, 37, 128 + 7, 15, 26, 128 + 3, 15, 20, 
	20, 128 + 6, 15, 26, 26, 128 + 10, 15, 20, 
	128 + 6, 15, 16, 52, 15, 15, 16, 128 + 3, 
	20, 21, 51, 20, 18, 21, 52, 41, 
	23, 52, 34, 52, 40, 52, 52, 7, 
	6, 52, 35, 128 + 4, 52, 37, 13, 52, 
	52, 128 + 8, 46, 128 + 3, 52, 41, 23, 128 + 5, 
	52, 41, 5, 6, 52, 50, 46, 52, 
	52, 7, 6, 13, 52, 33, 128 + 3, 52, 
	37, 13, 52, 52, 33, 52, 128 + 6, 46, 
	29, 128 + 7, 52, 33, 128 + 3, 52, 51, 49, 
	52, 52, 33, 128 + 3, 52, 34, 3, 52, 
	42, 33, 128 + 3, 52, 35, 4, 52, 8, 
	33, 128 + 6, 52, 38, 33, 52, 128 + 6, 46, 
	29, 128 + 3, 52, 41, 22, 23, 52, 33, 
	128 + 3, 52, 128 + 3, 5, 52, 32, 46, 52, 
	52, 7, 5, 6, 128 + 5, 52, 37, 10, 
	13, 52, 52, 52, 
};
static const byte[] mapBytes1 = {
	128 + 56, 52, 128 + 7, 46, 47, 128 + 7, 52, 33, 
	128 + 3, 52, 41, 22, 23, 52, 33, 128 + 3, 
	52, 7, 5, 6, 52, 33, 128 + 3, 52, 
	37, 10, 13, 52, 33, 128 + 7, 46, 30, 
	128 + 12, 52, 43, 128 + 3, 26, 52, 43, 26, 
	26, 128 + 4, 15, 52, 128 + 7, 15, 52, 128 + 7, 
	15, 26, 128 + 17, 15, 20, 20, 128 + 6, 15, 
	52, 52, 15, 15, 16, 20, 15, 15, 
	26, 26, 15, 15, 21, 52, 128 + 6, 15, 
	52, 52, 128 + 6, 15, 26, 26, 128 + 8, 15, 
	20, 20, 17, 128 + 5, 15, 52, 52, 39, 
	17, 128 + 4, 15, 128 + 3, 52, 39, 17, 128 + 3, 
	15, 52, 52, 41, 23, 39, 15, 16, 
	20, 52, 52, 7, 6, 52, 15, 21, 
	128 + 3, 52, 37, 13, 52, 15, 52, 52, 
	50, 128 + 4, 46, 14, 46, 46, 33, 52, 
	41, 23, 52, 15, 41, 22, 33, 52, 
	7, 6, 52, 15, 5, 5, 33, 52, 
	37, 13, 52, 15, 5, 5, 33, 128 + 4, 
	52, 15, 7, 5, 33, 128 + 4, 52, 15, 
	37, 10, 31, 46, 46, 45, 46, 14, 
	46, 46, 33, 52, 52, 33, 52, 15, 
	52, 52, 25, 26, 26, 25, 26, 16, 
	52, 41, 19, 20, 20, 19, 20, 21, 
	52, 7, 33, 41, 23, 33, 41, 23, 
	52, 37, 33, 7, 6, 33, 7, 6, 
	52, 52, 33, 37, 13, 33, 37, 13, 
	52, 52, 32, 46, 46, 28, 128 + 4, 46, 
	128 + 15, 52, 52, 
};
static const byte[] mapBytes2 = {
	128 + 40, 52, 22, 23, 128 + 6, 52, 5, 6, 
	128 + 6, 52, 10, 12, 128 + 6, 46, 52, 33, 
	128 + 7, 52, 33, 128 + 3, 52, 41, 22, 22, 
	52, 33, 128 + 3, 52, 7, 5, 5, 52, 
	33, 128 + 3, 52, 37, 10, 10, 46, 28, 
	128 + 6, 46, 128 + 8, 52, 22, 23, 128 + 4, 52, 
	43, 26, 5, 6, 52, 43, 26, 26, 
	15, 15, 10, 13, 52, 128 + 5, 15, 23, 
	52, 52, 128 + 5, 15, 6, 52, 43, 128 + 5, 
	15, 13, 52, 128 + 6, 15, 52, 44, 128 + 6, 
	15, 52, 39, 128 + 6, 15, 52, 43, 128 + 6, 
	15, 52, 128 + 7, 15, 52, 17, 128 + 6, 15, 
	52, 39, 17, 128 + 5, 15, 22, 23, 39, 
	20, 17, 128 + 3, 15, 5, 6, 52, 52, 
	39, 17, 15, 15, 9, 11, 47, 52, 
	52, 39, 15, 15, 52, 52, 33, 52, 
	41, 23, 15, 20, 52, 52, 33, 52, 
	7, 5, 15, 52, 23, 52, 33, 52, 
	37, 10, 15, 52, 5, 52, 31, 128 + 3, 
	46, 14, 46, 5, 52, 33, 52, 41, 
	23, 15, 52, 5, 52, 33, 52, 7, 
	5, 15, 52, 5, 52, 33, 52, 37, 
	10, 15, 52, 6, 52, 33, 128 + 3, 52, 
	15, 52, 13, 52, 31, 46, 45, 46, 
	14, 46, 52, 52, 33, 52, 33, 52, 
	15, 52, 26, 26, 25, 26, 25, 26, 
	16, 52, 20, 20, 19, 20, 19, 20, 
	21, 128 + 3, 52, 33, 42, 33, 42, 52, 
	52, 46, 46, 29, 5, 33, 5, 22, 
	22, 52, 52, 33, 8, 33, 7, 5, 
	5, 52, 52, 33, 38, 33, 37, 10, 
	10, 22, 23, 32, 46, 28, 128 + 3, 46, 
	5, 6, 128 + 6, 52, 10, 13, 128 + 5, 52, 
	52, 
};
static const byte[] mapBytes3 = {
	128 + 49, 52, 41, 23, 52, 41, 128 + 3, 22, 
	52, 7, 6, 52, 7, 128 + 3, 5, 52, 
	37, 13, 52, 37, 128 + 3, 10, 128 + 6, 46, 
	47, 128 + 7, 52, 33, 52, 52, 41, 22, 
	23, 52, 52, 33, 52, 22, 128 + 3, 5, 
	23, 52, 31, 46, 5, 10, 10, 5, 
	5, 52, 33, 52, 5, 22, 22, 5, 
	5, 52, 33, 52, 128 + 4, 5, 6, 52, 
	31, 46, 128 + 4, 5, 13, 52, 33, 52, 
	10, 7, 5, 6, 52, 52, 33, 52, 
	52, 37, 10, 13, 52, 52, 33, 128 + 7, 
	52, 33, 128 + 3, 52, 41, 23, 52, 52, 
	31, 46, 52, 52, 7, 5, 23, 52, 
	33, 52, 27, 52, 37, 7, 6, 52, 
	33, 52, 15, 27, 52, 37, 13, 52, 
	33, 52, 15, 15, 128 + 4, 26, 25, 26, 
	15, 16, 128 + 4, 20, 19, 20, 15, 21, 
	52, 52, 50, 46, 28, 46, 16, 128 + 3, 
	52, 33, 128 + 3, 52, 21, 51, 49, 52, 
	33, 128 + 4, 52, 34, 3, 52, 31, 128 + 3, 
	46, 52, 35, 4, 52, 33, 128 + 7, 52, 
	33, 52, 41, 22, 128 + 4, 46, 29, 52, 
	7, 5, 128 + 4, 52, 33, 52, 37, 10, 
	52, 50, 46, 46, 29, 52, 52, 41, 
	23, 33, 52, 52, 33, 52, 41, 5, 
	6, 33, 41, 23, 33, 41, 5, 5, 
	13, 33, 7, 6, 33, 5, 5, 10, 
	46, 29, 37, 13, 33, 7, 5, 22, 
	52, 31, 46, 46, 29, 37, 7, 5, 
	23, 33, 52, 52, 33, 52, 37, 7, 
	6, 33, 52, 52, 33, 52, 52, 37, 
	11, 29, 52, 52, 33, 41, 23, 52, 
	52, 33, 52, 52, 33, 7, 6, 52, 
	52, 33, 52, 52, 33, 37, 13, 52, 
	52, 32, 46, 46, 28, 128 + 3, 46, 128 + 15, 
	52, 52, 
};
static const byte[] mapBytes4 = {
	128 + 56, 52, 128 + 4, 46, 45, 128 + 3, 46, 128 + 4, 
	52, 33, 128 + 3, 52, 22, 22, 23, 52, 
	33, 128 + 3, 52, 5, 5, 6, 52, 33, 
	128 + 3, 52, 10, 10, 13, 52, 33, 52, 
	52, 41, 128 + 4, 46, 30, 52, 52, 5, 
	128 + 7, 52, 7, 52, 43, 128 + 3, 26, 27, 
	52, 37, 26, 128 + 5, 15, 26, 26, 128 + 43, 
	15, 16, 20, 17, 128 + 5, 15, 21, 52, 
	39, 128 + 5, 15, 128 + 3, 52, 128 + 5, 15, 128 + 3, 
	26, 128 + 26, 15, 20, 17, 15, 15, 16, 
	20, 20, 17, 52, 39, 15, 16, 21, 
	52, 52, 39, 52, 52, 15, 21, 128 + 6, 
	52, 15, 128 + 5, 52, 46, 46, 14, 128 + 5, 
	46, 23, 52, 15, 41, 22, 22, 23, 
	52, 6, 52, 15, 128 + 4, 5, 52, 13, 
	52, 15, 128 + 4, 5, 128 + 3, 52, 15, 7, 
	5, 5, 6, 52, 50, 46, 14, 36, 
	9, 9, 11, 46, 33, 52, 15, 128 + 5, 
	52, 25, 26, 16, 52, 52, 51, 49, 
	52, 19, 20, 21, 42, 52, 34, 3, 
	52, 33, 52, 52, 8, 52, 35, 4, 
	52, 33, 42, 52, 38, 128 + 4, 52, 33, 
	7, 24, 52, 52, 50, 46, 46, 33, 
	37, 13, 52, 52, 33, 52, 52, 32, 
	128 + 4, 46, 30, 128 + 17, 52, 52, 
};
static const byte[] mapBytes5 = {
	128 + 53, 52, 41, 23, 52, 48, 49, 128 + 3, 
	52, 7, 6, 52, 0, 3, 128 + 3, 52, 
	37, 13, 52, 1, 2, 128 + 6, 46, 128 + 8, 
	52, 23, 128 + 4, 52, 41, 22, 22, 5, 
	52, 52, 41, 22, 128 + 3, 5, 6, 52, 
	52, 5, 5, 10, 10, 5, 13, 52, 
	52, 5, 5, 22, 22, 5, 128 + 3, 52, 
	7, 128 + 4, 5, 128 + 3, 52, 37, 7, 128 + 3, 
	5, 27, 52, 51, 49, 37, 7, 5, 
	5, 15, 52, 35, 4, 52, 37, 10, 
	10, 15, 27, 128 + 6, 52, 15, 15, 27, 
	128 + 3, 52, 41, 22, 128 + 3, 15, 27, 52, 
	52, 7, 5, 128 + 4, 15, 27, 52, 37, 
	7, 128 + 5, 15, 27, 52, 37, 15, 20, 
	20, 128 + 3, 15, 26, 26, 15, 26, 26, 
	15, 15, 16, 20, 20, 128 + 5, 15, 21, 
	52, 52, 128 + 4, 15, 16, 128 + 3, 52, 16, 
	128 + 3, 20, 21, 51, 49, 52, 21, 52, 
	41, 23, 52, 34, 3, 128 + 3, 52, 7, 
	6, 52, 35, 4, 128 + 3, 52, 37, 13, 
	128 + 4, 52, 128 + 8, 46, 128 + 13, 52, 50, 46, 
	46, 128 + 3, 52, 41, 23, 33, 128 + 5, 52, 
	7, 6, 33, 41, 22, 128 + 3, 46, 36, 
	11, 29, 7, 5, 128 + 5, 52, 33, 37, 
	10, 48, 49, 128 + 3, 52, 31, 46, 46, 
	0, 3, 52, 41, 23, 33, 52, 52, 
	1, 4, 52, 7, 6, 33, 128 + 5, 52, 
	37, 13, 33, 52, 52, 128 + 5, 46, 29, 
	52, 52, 22, 22, 23, 52, 52, 33, 
	52, 52, 128 + 3, 5, 52, 52, 32, 46, 
	46, 5, 5, 6, 128 + 5, 52, 10, 10, 
	13, 128 + 4, 52, 52, 
};
static const byte[] mapBytes6 = {
	128 + 42, 52, 41, 23, 128 + 5, 52, 41, 5, 
	5, 128 + 5, 52, 128 + 3, 5, 52, 50, 46, 
	46, 52, 7, 5, 6, 52, 33, 128 + 3, 
	52, 37, 10, 13, 52, 33, 128 + 7, 52, 
	33, 128 + 7, 52, 33, 52, 52, 46, 46, 
	45, 46, 46, 28, 46, 46, 52, 52, 
	33, 128 + 7, 52, 33, 52, 41, 23, 128 + 4, 
	52, 33, 52, 7, 6, 52, 43, 52, 
	52, 33, 52, 37, 13, 52, 15, 52, 
	52, 33, 41, 23, 52, 52, 15, 46, 
	46, 29, 7, 6, 52, 43, 15, 52, 
	52, 33, 37, 13, 52, 15, 15, 52, 
	52, 33, 52, 52, 44, 15, 15, 52, 
	52, 33, 52, 52, 39, 15, 15, 52, 
	52, 33, 52, 52, 43, 15, 15, 46, 
	46, 29, 52, 52, 128 + 3, 15, 52, 52, 
	33, 52, 52, 17, 15, 15, 52, 52, 
	33, 52, 52, 39, 17, 15, 52, 52, 
	33, 52, 41, 23, 39, 20, 52, 52, 
	33, 52, 7, 6, 52, 52, 46, 46, 
	28, 46, 36, 11, 47, 128 + 7, 52, 33, 
	52, 22, 23, 52, 52, 41, 23, 33, 
	52, 5, 5, 52, 52, 5, 5, 33, 
	52, 5, 5, 23, 52, 5, 5, 31, 
	46, 128 + 3, 5, 52, 7, 6, 33, 52, 
	128 + 3, 5, 52, 37, 13, 33, 52, 128 + 3, 
	5, 23, 52, 52, 33, 52, 128 + 3, 5, 
	6, 52, 52, 33, 52, 5, 5, 6, 
	13, 52, 52, 31, 46, 10, 10, 13, 
	128 + 3, 52, 33, 52, 128 + 6, 26, 25, 26, 
	128 + 6, 20, 19, 20, 128 + 6, 52, 33, 41, 
	128 + 6, 46, 29, 5, 128 + 6, 52, 33, 7, 
	52, 41, 23, 128 + 3, 52, 33, 37, 52, 
	7, 6, 52, 41, 23, 32, 46, 52, 
	37, 13, 52, 7, 6, 128 + 6, 52, 37, 
	13, 52, 52, 
};
static const byte[] mapBytes7 = {
	128 + 48, 52, 23, 128 + 7, 52, 6, 128 + 4, 52, 
	51, 49, 52, 13, 128 + 4, 52, 35, 4, 
	52, 128 + 4, 46, 47, 128 + 3, 52, 23, 128 + 3, 
	52, 31, 128 + 3, 46, 5, 23, 52, 52, 
	33, 128 + 3, 52, 5, 5, 23, 52, 31, 
	128 + 3, 46, 10, 5, 5, 52, 33, 128 + 3, 
	52, 22, 5, 5, 52, 33, 128 + 3, 52, 
	5, 5, 6, 52, 31, 128 + 3, 46, 5, 
	5, 13, 52, 33, 128 + 3, 52, 5, 6, 
	52, 52, 33, 41, 23, 52, 6, 13, 
	52, 52, 33, 7, 6, 52, 13, 128 + 3, 
	52, 33, 37, 13, 52, 23, 128 + 3, 52, 
	32, 128 + 3, 46, 5, 128 + 4, 52, 41, 23, 
	52, 6, 128 + 4, 52, 7, 6, 52, 13, 
	128 + 4, 52, 37, 13, 52, 128 + 8, 26, 128 + 8, 
	20, 52, 52, 50, 128 + 5, 46, 52, 52, 
	33, 128 + 5, 52, 49, 52, 33, 128 + 5, 52, 
	3, 52, 31, 128 + 5, 46, 4, 52, 33, 
	128 + 7, 52, 33, 52, 41, 24, 52, 52, 
	46, 46, 29, 52, 8, 13, 128 + 4, 52, 
	33, 52, 38, 52, 41, 22, 46, 46, 
	29, 52, 52, 41, 5, 5, 52, 52, 
	33, 52, 41, 128 + 3, 5, 22, 23, 33, 
	52, 128 + 5, 5, 6, 33, 52, 5, 5, 
	10, 5, 10, 13, 33, 52, 7, 5, 
	22, 5, 46, 46, 29, 52, 37, 7, 
	5, 5, 52, 52, 33, 52, 52, 37, 
	5, 5, 52, 52, 33, 128 + 3, 52, 7, 
	5, 52, 52, 33, 41, 23, 52, 37, 
	5, 52, 52, 33, 7, 6, 52, 52, 
	7, 52, 52, 33, 37, 13, 52, 52, 
	37, 46, 46, 28, 128 + 5, 46, 128 + 15, 52, 
	52, 
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
