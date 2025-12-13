#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 1
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
		},
	},
	{ // 3
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
		},
	},
	{ // 4
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 3, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 4, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 4, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 8
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 9
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 3, 
			Char_Terrain + 3, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 3, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 3, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 4, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 4, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 4, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 4, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 4, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 3, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 4, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 3, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 5, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 6, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 12, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 6, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 5, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 6, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 6, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 5, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, Char_Terrain + 2, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 7, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 8, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 9, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 8, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 9, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 9, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 9, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 9, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 8, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 10, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 10, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 10, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 12, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 12, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 11, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 52
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 53
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 10, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 54
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 11, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 55
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 11, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 10, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 56
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 0, 
		},
	},
	{ // 57
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
		},
	},
};

static const byte[] mapBytes0 = {
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	29, 33, 33, 34, 38, 14, 0, 0, 
	2, 31, 31, 38, 38, 38, 38, 29, 
	27, 28, 38, 26, 4, 4, 4, 38, 
	14, 8, 8, 11, 38, 37, 38, 41, 
	40, 38, 24, 38, 57, 57, 38, 38, 
	38, 57, 57, 45, 40, 38, 57, 57, 
	57, 57, 38, 57, 57, 57, 57, 45, 
	57, 57, 55, 57, 57, 57, 57, 46, 
	57, 57, 57, 57, 57, 57, 54, 57, 
	57, 54, 50, 38, 52, 50, 38, 38, 
	38, 31, 31, 31, 31, 31, 38, 38, 
	30, 38, 38, 38, 26, 4, 35, 31, 
	38, 14, 11, 21, 38, 31, 31, 31, 
	19, 38, 38, 38, 38, 21, 38, 38, 
	38, 38, 21, 38, 31, 31, 31, 19, 
	38, 38, 38, 38, 21, 38, 38, 29, 
	28, 20, 31, 38, 14, 11, 38, 38, 

};
static const byte[] mapBytes1 = {
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 31, 31, 31, 31, 32, 38, 38, 
	29, 28, 21, 38, 38, 4, 4, 21, 
	31, 31, 13, 10, 19, 38, 38, 38, 
	38, 38, 38, 38, 39, 41, 41, 38, 
	42, 57, 57, 57, 43, 57, 57, 57, 
	57, 57, 57, 57, 57, 57, 57, 57, 
	55, 57, 54, 57, 57, 46, 57, 38, 
	57, 57, 57, 57, 45, 57, 57, 57, 
	57, 57, 52, 53, 57, 57, 57, 38, 
	38, 48, 57, 57, 38, 38, 38, 57, 
	54, 35, 31, 31, 56, 31, 21, 29, 
	28, 57, 29, 21, 4, 4, 57, 4, 
	21, 14, 11, 57, 4, 20, 31, 31, 
	56, 13, 21, 38, 38, 57, 38, 22, 
	41, 43, 57, 29, 49, 52, 49, 52, 
	14, 21, 38, 21, 38, 38, 20, 31, 
	18, 31, 31, 38, 38, 38, 38, 38, 

};
static const byte[] mapBytes2 = {
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 35, 31, 31, 31, 38, 21, 
	38, 29, 27, 38, 21, 38, 14, 8, 
	31, 18, 31, 31, 31, 28, 38, 38, 
	38, 38, 4, 38, 38, 39, 41, 11, 
	38, 42, 57, 57, 38, 42, 57, 57, 
	57, 38, 57, 57, 57, 57, 38, 57, 
	57, 57, 57, 38, 57, 57, 57, 57, 
	38, 57, 57, 57, 57, 38, 48, 57, 
	57, 57, 38, 38, 48, 57, 57, 31, 
	32, 38, 57, 57, 38, 21, 38, 57, 
	54, 28, 20, 31, 56, 31, 4, 21, 
	38, 57, 38, 4, 21, 38, 57, 38, 
	4, 20, 31, 56, 31, 11, 21, 38, 
	57, 38, 41, 22, 43, 57, 38, 52, 
	49, 52, 50, 38, 31, 19, 29, 27, 
	27, 38, 21, 4, 4, 4, 28, 20, 
	13, 7, 7, 11, 38, 38, 38, 38, 

};
static const byte[] mapBytes3 = {
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 29, 
	27, 38, 38, 38, 12, 4, 31, 31, 
	31, 32, 14, 38, 29, 28, 21, 38, 
	25, 4, 4, 20, 31, 4, 5, 4, 
	21, 38, 4, 17, 4, 20, 31, 4, 
	4, 4, 21, 38, 8, 8, 11, 21, 
	38, 38, 29, 28, 20, 31, 38, 12, 
	4, 21, 38, 41, 40, 16, 21, 38, 
	57, 57, 45, 22, 41, 57, 57, 54, 
	49, 52, 57, 51, 38, 20, 31, 50, 
	38, 38, 21, 38, 38, 38, 38, 20, 
	31, 31, 31, 31, 19, 29, 38, 38, 
	38, 21, 14, 28, 35, 31, 19, 29, 
	4, 21, 38, 21, 14, 10, 19, 38, 
	21, 29, 38, 20, 31, 19, 4, 28, 
	21, 38, 21, 14, 10, 19, 38, 21, 
	38, 38, 21, 38, 21, 38, 38, 20, 
	31, 18, 31, 38, 38, 38, 38, 38, 

};
static const byte[] mapBytes4 = {
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 31, 31, 31, 31, 31, 27, 28, 
	38, 21, 38, 4, 4, 38, 21, 29, 
	7, 10, 31, 19, 4, 38, 38, 38, 
	38, 14, 38, 39, 41, 40, 38, 43, 
	57, 57, 57, 45, 57, 57, 57, 57, 
	57, 57, 57, 57, 57, 57, 57, 57, 
	57, 57, 57, 57, 57, 55, 57, 57, 
	57, 57, 46, 57, 57, 57, 57, 57, 
	57, 57, 57, 57, 57, 57, 57, 53, 
	57, 57, 55, 57, 38, 57, 51, 38, 
	47, 31, 56, 31, 31, 31, 28, 57, 
	29, 28, 38, 11, 57, 4, 4, 38, 
	31, 56, 13, 10, 31, 38, 57, 38, 
	38, 38, 43, 57, 38, 37, 38, 49, 
	50, 38, 24, 38, 21, 30, 38, 38, 
	38, 21, 4, 38, 35, 31, 20, 15, 
	31, 19, 38, 38, 38, 38, 38, 38, 

};
static const byte[] mapBytes5 = {
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 30, 
	38, 33, 34, 38, 4, 38, 0, 2, 
	31, 15, 31, 38, 38, 38, 29, 27, 
	28, 38, 26, 4, 4, 4, 38, 4, 
	4, 4, 11, 38, 14, 6, 4, 40, 
	38, 36, 34, 14, 57, 38, 23, 3, 
	38, 57, 44, 38, 38, 38, 57, 57, 
	44, 38, 29, 57, 57, 57, 44, 14, 
	57, 55, 57, 57, 45, 57, 46, 57, 
	57, 54, 57, 57, 57, 51, 38, 57, 
	54, 50, 38, 38, 50, 38, 38, 38, 
	38, 31, 31, 31, 31, 31, 38, 38, 
	38, 38, 38, 38, 38, 38, 35, 31, 
	31, 31, 31, 19, 29, 38, 38, 38, 
	21, 4, 33, 34, 38, 20, 13, 0, 
	3, 38, 21, 38, 38, 38, 38, 21, 
	38, 31, 31, 31, 19, 38, 27, 28, 
	38, 20, 31, 8, 11, 38, 38, 38, 

};
static const byte[] mapBytes6 = {
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 29, 28, 38, 
	38, 38, 4, 9, 35, 31, 38, 16, 
	38, 21, 38, 38, 38, 38, 21, 38, 
	31, 31, 31, 18, 31, 38, 21, 30, 
	38, 38, 38, 21, 16, 38, 39, 38, 
	21, 38, 38, 57, 31, 19, 38, 42, 
	57, 38, 21, 38, 57, 57, 38, 21, 
	38, 57, 57, 31, 19, 38, 57, 57, 
	38, 21, 38, 57, 57, 38, 21, 38, 
	57, 57, 38, 21, 38, 47, 52, 31, 
	18, 31, 32, 38, 27, 28, 38, 21, 
	38, 4, 4, 38, 20, 31, 4, 4, 
	38, 21, 38, 4, 4, 38, 21, 38, 
	4, 4, 38, 20, 31, 8, 11, 38, 
	21, 38, 41, 41, 41, 22, 41, 52, 
	52, 52, 49, 52, 31, 31, 31, 19, 
	29, 38, 30, 38, 21, 4, 38, 4, 
	38, 20, 13, 38, 16, 38, 38, 38, 

};
static const byte[] mapBytes7 = {
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 38, 38, 38, 38, 
	38, 38, 38, 38, 28, 38, 38, 36, 
	33, 4, 38, 38, 38, 1, 10, 31, 
	31, 32, 38, 27, 28, 38, 21, 38, 
	4, 4, 38, 20, 31, 6, 4, 38, 
	21, 38, 25, 4, 38, 20, 31, 4, 
	4, 38, 21, 38, 4, 4, 38, 21, 
	38, 4, 9, 38, 20, 31, 4, 38, 
	38, 38, 38, 11, 38, 38, 38, 38, 
	41, 41, 41, 41, 41, 52, 52, 52, 
	52, 52, 38, 35, 31, 31, 31, 38, 
	21, 38, 38, 38, 38, 20, 31, 31, 
	31, 31, 19, 38, 38, 38, 38, 21, 
	38, 29, 27, 31, 19, 38, 4, 4, 
	38, 21, 38, 4, 4, 38, 21, 38, 
	4, 4, 31, 19, 38, 4, 4, 38, 
	21, 26, 4, 4, 38, 21, 4, 5, 
	4, 38, 21, 4, 17, 4, 31, 18, 
	13, 7, 7, 38, 38, 38, 38, 38, 

};

static const SkyElement[] SkyElements0 = {
	{ 31, 0x01 },
	{ 25, 0x00 },
	{ 24, 0x02 },
	{ 16, 0x00 },
	{ 15, 0x08 },
	{ 9, 0x00 },
	{ 8, 0x04 },
	{ 4, 0x00 },
	{ 3, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements1 = {
	{ 31, 0x01 },
	{ 23, 0x03 },
	{ 21, 0x02 },
	{ 19, 0x0a },
	{ 13, 0x08 },
	{ 9, 0x00 },
	{ 8, 0x04 },
	{ 5, 0x05 },
	{ 4, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements2 = {
	{ 31, 0x01 },
	{ 24, 0x03 },
	{ 20, 0x02 },
	{ 19, 0x0a },
	{ 12, 0x08 },
	{ 11, 0x0c },
	{ 9, 0x04 },
	{ 5, 0x05 },
	{ 4, 0x01 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements3 = {
	{ 31, 0x01 },
	{ 27, 0x03 },
	{ 18, 0x02 },
	{ 12, 0x06 },
	{ 9, 0x04 },
	{ 5, 0x0c },
	{ 1, 0x08 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements4 = {
	{ 31, 0x01 },
	{ 29, 0x03 },
	{ 18, 0x0b },
	{ 15, 0x0a },
	{ 14, 0x0e },
	{ 11, 0x06 },
	{ 7, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements5 = {
	{ 31, 0x01 },
	{ 30, 0x03 },
	{ 18, 0x0b },
	{ 17, 0x0f },
	{ 13, 0x0e },
	{ 11, 0x06 },
	{ 5, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements6 = {
	{ 31, 0x01 },
	{ 30, 0x03 },
	{ 19, 0x07 },
	{ 16, 0x0f },
	{ 12, 0x0e },
	{ 11, 0x06 },
	{ 4, 0x04 },
	{ 1, 0x00 },
};

static const SkyElement[] SkyElements7 = {
};


static const Route[] Route0B1 = {
	{ 1, 0, 12 },
	{ -1, 0, 14 },
};

static const Route[] Route0B2 = {
	{ -1, 0, 4 },
	{ 0, 1, 24 },
};

static const Route[] Route0B5 = {
	{ -1, 0, 8 },
	{ 1, 0, 11 },
};

static const Route[] Route0B0 = {
	{ 1, 0, 12 },
	{ 0, 1, 8 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements0 = {
	{ // B0
		1, 28,
		3,
		Route0B0
	},
	{ // A14
		9, 27,
		0,
		nullptr
	},
	{ // A13
		5, 26,
		0,
		nullptr
	},
	{ // B1
		1, 25,
		2,
		Route0B1
	},
	{ // A10
		1, 23,
		0,
		nullptr
	},
	{ // B2
		17, 23,
		2,
		Route0B2
	},
	{ // A9
		17, 20,
		0,
		nullptr
	},
	{ // A8
		9, 19,
		0,
		nullptr
	},
	{ // A7
		17, 18,
		0,
		nullptr
	},
	{ // A6
		9, 16,
		0,
		nullptr
	},
	{ // A5
		13, 11,
		0,
		nullptr
	},
	{ // A3
		5, 10,
		0,
		nullptr
	},
	{ // A4
		13, 10,
		0,
		nullptr
	},
	{ // A1
		5, 6,
		0,
		nullptr
	},
	{ // B5
		17, 6,
		2,
		Route0B5
	},
	{ // A0
		1, 5,
		0,
		nullptr
	},
};

static const Route[] Route1B1 = {
	{ 0, 1, 8 },
	{ 1, 0, 11 },
};

static const Route[] Route1B4 = {
	{ 1, 0, 16 },
	{ 0, -1, 12 },
	{ -1, 0, 18 },
};

static const Route[] Route1B2 = {
	{ -1, 0, 8 },
	{ 0, -1, 20 },
	{ -1, 0, 2 },
};

static const Route[] Route1B3 = {
	{ -1, 0, 8 },
	{ 0, 1, 20 },
};

static const Route[] Route1B5 = {
	{ 1, 0, 12 },
	{ -1, 0, 14 },
};

static const Route[] Route1B0 = {
	{ 0, 1, 8 },
	{ 1, 0, 19 },
};

static const GroundElement[] GroundElements1 = {
	{ // B0
		1, 28,
		2,
		Route1B0
	},
	{ // B1
		9, 28,
		2,
		Route1B1
	},
	{ // A14
		13, 28,
		0,
		nullptr
	},
	{ // B2
		9, 25,
		3,
		Route1B2
	},
	{ // A11
		9, 24,
		0,
		nullptr
	},
	{ // B3
		9, 21,
		2,
		Route1B3
	},
	{ // A9
		17, 20,
		0,
		nullptr
	},
	{ // A7
		5, 19,
		0,
		nullptr
	},
	{ // A6
		17, 15,
		0,
		nullptr
	},
	{ // A5
		9, 14,
		0,
		nullptr
	},
	{ // A4
		5, 9,
		0,
		nullptr
	},
	{ // B4
		1, 8,
		3,
		Route1B4
	},
	{ // A3
		5, 6,
		0,
		nullptr
	},
	{ // B5
		1, 5,
		2,
		Route1B5
	},
	{ // A0
		1, 4,
		0,
		nullptr
	},
};

static const Route[] Route2B4 = {
	{ 1, 0, 19 },
};

static const Route[] Route2B2 = {
	{ -1, 0, 4 },
	{ 0, -1, 20 },
	{ -1, 0, 6 },
};

static const Route[] Route2B5 = {
	{ -1, 0, 12 },
	{ 0, 1, 12 },
	{ 1, 0, 15 },
};

static const Route[] Route2B0 = {
	{ -1, 0, 12 },
	{ 0, -1, 8 },
	{ -1, 0, 6 },
};

static const GroundElement[] GroundElements2 = {
	{ // B0
		17, 30,
		3,
		Route2B0
	},
	{ // A17
		13, 27,
		0,
		nullptr
	},
	{ // B2
		9, 24,
		3,
		Route2B2
	},
	{ // A16
		9, 23,
		0,
		nullptr
	},
	{ // A14
		9, 18,
		0,
		nullptr
	},
	{ // A13
		5, 17,
		0,
		nullptr
	},
	{ // A12
		1, 16,
		0,
		nullptr
	},
	{ // A11
		1, 15,
		0,
		nullptr
	},
	{ // A10
		1, 14,
		0,
		nullptr
	},
	{ // A9
		5, 11,
		0,
		nullptr
	},
	{ // B4
		1, 8,
		1,
		Route2B4
	},
	{ // A7
		9, 7,
		0,
		nullptr
	},
	{ // A6
		9, 6,
		0,
		nullptr
	},
	{ // B5
		17, 5,
		3,
		Route2B5
	},
	{ // A3
		9, 3,
		0,
		nullptr
	},
	{ // A4
		17, 3,
		0,
		nullptr
	},
	{ // A1
		1, 2,
		0,
		nullptr
	},
	{ // A2
		17, 2,
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
	{ 0, -1, 20 },
	{ 1, 0, 8 },
	{ 0, 1, 28 },
	{ 1, 0, 7 },
};

static const Route[] Route3B4 = {
	{ -1, 0, 4 },
	{ 0, -1, 28 },
	{ -1, 0, 14 },
};

static const Route[] Route3B2 = {
	{ 0, -1, 44 },
	{ 1, 0, 7 },
};

static const Route[] Route3B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 4 },
	{ 1, 0, 7 },
};

static const Route[] Route3B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 8 },
	{ 1, 0, 7 },
};

static const Route[] Route3B0 = {
	{ -1, 0, 12 },
	{ 0, -1, 20 },
	{ -1, 0, 6 },
};

static const GroundElement[] GroundElements3 = {
	{ // A21
		5, 31,
		0,
		nullptr
	},
	{ // A22
		17, 31,
		0,
		nullptr
	},
	{ // B0
		17, 30,
		3,
		Route3B0
	},
	{ // B2
		13, 29,
		2,
		Route3B2
	},
	{ // B1
		1, 28,
		5,
		Route3B1
	},
	{ // A20
		9, 28,
		0,
		nullptr
	},
	{ // A19
		9, 25,
		0,
		nullptr
	},
	{ // A17
		17, 24,
		0,
		nullptr
	},
	{ // A15
		17, 22,
		0,
		nullptr
	},
	{ // B3
		1, 21,
		3,
		Route3B3
	},
	{ // A13
		9, 20,
		0,
		nullptr
	},
	{ // A12
		1, 19,
		0,
		nullptr
	},
	{ // A10
		5, 18,
		0,
		nullptr
	},
	{ // B4
		17, 13,
		3,
		Route3B4
	},
	{ // A8
		5, 12,
		0,
		nullptr
	},
	{ // A9
		9, 12,
		0,
		nullptr
	},
	{ // B5
		17, 10,
		3,
		Route3B5
	},
	{ // A7
		5, 9,
		0,
		nullptr
	},
	{ // A5
		17, 7,
		0,
		nullptr
	},
	{ // A3
		9, 5,
		0,
		nullptr
	},
	{ // A2
		13, 3,
		0,
		nullptr
	},
	{ // A0
		1, 2,
		0,
		nullptr
	},
	{ // A1
		17, 2,
		0,
		nullptr
	},
};

static const Route[] Route4B1 = {
	{ 0, -1, 4 },
	{ 1, 0, 19 },
};

static const Route[] Route4B2 = {
	{ 1, 0, 11 },
};

static const Route[] Route4B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 12 },
	{ -1, 0, 14 },
};

static const Route[] Route4B0 = {
	{ -1, 0, 4 },
	{ 0, 1, 4 },
	{ -1, 0, 12 },
	{ 0, -1, 12 },
};

static const GroundElement[] GroundElements4 = {
	{ // A19
		5, 31,
		0,
		nullptr
	},
	{ // A20
		13, 31,
		0,
		nullptr
	},
	{ // A18
		9, 29,
		0,
		nullptr
	},
	{ // B0
		17, 29,
		4,
		Route4B0
	},
	{ // A17
		13, 27,
		0,
		nullptr
	},
	{ // A15
		13, 26,
		0,
		nullptr
	},
	{ // B1
		1, 25,
		2,
		Route4B1
	},
	{ // A13
		17, 22,
		0,
		nullptr
	},
	{ // B2
		9, 21,
		1,
		Route4B2
	},
	{ // A10
		1, 20,
		0,
		nullptr
	},
	{ // A11
		13, 20,
		0,
		nullptr
	},
	{ // A9
		13, 19,
		0,
		nullptr
	},
	{ // A8
		9, 15,
		0,
		nullptr
	},
	{ // A7
		17, 9,
		0,
		nullptr
	},
	{ // B3
		1, 8,
		3,
		Route4B3
	},
	{ // A6
		9, 7,
		0,
		nullptr
	},
	{ // A5
		17, 6,
		0,
		nullptr
	},
	{ // A3
		1, 4,
		0,
		nullptr
	},
	{ // A2
		17, 3,
		0,
		nullptr
	},
	{ // A1
		1, 2,
		0,
		nullptr
	},
	{ // A0
		17, 1,
		0,
		nullptr
	},
};

static const Route[] Route5B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route5B4 = {
	{ 1, 0, 19 },
};

static const Route[] Route5B0 = {
	{ -1, 0, 4 },
	{ 0, -1, 4 },
	{ -1, 0, 14 },
};

static const Route[] Route5B3 = {
	{ 1, 0, 12 },
	{ 0, 1, 28 },
};

static const Route[] Route5B5 = {
	{ 1, 0, 15 },
};

static const GroundElement[] GroundElements5 = {
	{ // A24
		9, 31,
		0,
		nullptr
	},
	{ // A25
		17, 31,
		0,
		nullptr
	},
	{ // B0
		17, 30,
		3,
		Route5B0
	},
	{ // A21
		1, 27,
		0,
		nullptr
	},
	{ // A22
		17, 27,
		0,
		nullptr
	},
	{ // A20
		5, 26,
		0,
		nullptr
	},
	{ // B1
		17, 26,
		3,
		Route5B1
	},
	{ // B3
		1, 24,
		2,
		Route5B3
	},
	{ // A17
		5, 23,
		0,
		nullptr
	},
	{ // A16
		9, 22,
		0,
		nullptr
	},
	{ // B4
		1, 21,
		1,
		Route5B4
	},
	{ // A14
		13, 20,
		0,
		nullptr
	},
	{ // A13
		17, 19,
		0,
		nullptr
	},
	{ // A12
		13, 18,
		0,
		nullptr
	},
	{ // A11
		5, 16,
		0,
		nullptr
	},
	{ // A10
		17, 15,
		0,
		nullptr
	},
	{ // A9
		9, 12,
		0,
		nullptr
	},
	{ // A8
		13, 11,
		0,
		nullptr
	},
	{ // A7
		5, 9,
		0,
		nullptr
	},
	{ // A6
		17, 8,
		0,
		nullptr
	},
	{ // A5
		9, 7,
		0,
		nullptr
	},
	{ // B5
		5, 6,
		1,
		Route5B5
	},
	{ // A2
		1, 3,
		0,
		nullptr
	},
	{ // A3
		17, 3,
		0,
		nullptr
	},
	{ // A0
		1, 0,
		0,
		nullptr
	},
	{ // A1
		17, 0,
		0,
		nullptr
	},
};

static const Route[] Route6B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route6B4 = {
	{ 1, 0, 4 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route6B2 = {
	{ -1, 0, 14 },
};

static const Route[] Route6B3 = {
	{ 1, 0, 4 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route6B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route6B0 = {
	{ 1, 0, 12 },
	{ 0, 1, 8 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements6 = {
	{ // A22
		9, 31,
		0,
		nullptr
	},
	{ // A21
		9, 29,
		0,
		nullptr
	},
	{ // B0
		1, 28,
		3,
		Route6B0
	},
	{ // A18
		5, 27,
		0,
		nullptr
	},
	{ // A19
		17, 27,
		0,
		nullptr
	},
	{ // A17
		9, 24,
		0,
		nullptr
	},
	{ // B1
		17, 24,
		3,
		Route6B1
	},
	{ // A15
		9, 21,
		0,
		nullptr
	},
	{ // B3
		1, 19,
		3,
		Route6B3
	},
	{ // B2
		13, 19,
		1,
		Route6B2
	},
	{ // A13
		1, 18,
		0,
		nullptr
	},
	{ // A11
		9, 14,
		0,
		nullptr
	},
	{ // A10
		1, 13,
		0,
		nullptr
	},
	{ // B4
		1, 12,
		3,
		Route6B4
	},
	{ // A9
		9, 11,
		0,
		nullptr
	},
	{ // A8
		1, 10,
		0,
		nullptr
	},
	{ // B5
		17, 8,
		3,
		Route6B5
	},
	{ // A6
		1, 7,
		0,
		nullptr
	},
	{ // A5
		5, 6,
		0,
		nullptr
	},
	{ // A3
		9, 5,
		0,
		nullptr
	},
	{ // A2
		13, 4,
		0,
		nullptr
	},
	{ // A1
		17, 1,
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
	{ 1, 0, 4 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route7B4 = {
	{ -1, 0, 12 },
	{ 0, 1, 28 },
};

static const Route[] Route7B7 = {
	{ -1, 0, 4 },
	{ 0, 1, 40 },
	{ 1, 0, 7 },
};

static const Route[] Route7B0 = {
	{ -1, 0, 18 },
};

static const Route[] Route7B8 = {
	{ 1, 0, 12 },
	{ 0, 1, 32 },
};

static const Route[] Route7B2 = {
	{ 1, 0, 4 },
	{ 0, 1, 24 },
};

static const Route[] Route7B3 = {
	{ 1, 0, 4 },
	{ 0, 1, 28 },
};

static const Route[] Route7B6 = {
	{ -1, 0, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 7 },
};

static const Route[] Route7B5 = {
	{ -1, 0, 12 },
};

static const GroundElement[] GroundElements7 = {
	{ // A28
		1, 31,
		0,
		nullptr
	},
	{ // A29
		13, 31,
		0,
		nullptr
	},
	{ // B1
		1, 30,
		3,
		Route7B1
	},
	{ // B0
		17, 30,
		1,
		Route7B0
	},
	{ // A26
		13, 28,
		0,
		nullptr
	},
	{ // A25
		1, 27,
		0,
		nullptr
	},
	{ // A22
		1, 25,
		0,
		nullptr
	},
	{ // A23
		17, 25,
		0,
		nullptr
	},
	{ // B2
		1, 23,
		2,
		Route7B2
	},
	{ // A20
		13, 22,
		0,
		nullptr
	},
	{ // B3
		1, 21,
		2,
		Route7B3
	},
	{ // A19
		17, 21,
		0,
		nullptr
	},
	{ // B4
		17, 20,
		2,
		Route7B4
	},
	{ // A14
		1, 19,
		0,
		nullptr
	},
	{ // A15
		9, 19,
		0,
		nullptr
	},
	{ // A16
		17, 19,
		0,
		nullptr
	},
	{ // A12
		1, 18,
		0,
		nullptr
	},
	{ // B5
		17, 18,
		1,
		Route7B5
	},
	{ // A11
		5, 15,
		0,
		nullptr
	},
	{ // B6
		17, 13,
		3,
		Route7B6
	},
	{ // A10
		17, 11,
		0,
		nullptr
	},
	{ // A8
		9, 10,
		0,
		nullptr
	},
	{ // A7
		1, 9,
		0,
		nullptr
	},
	{ // B7
		17, 8,
		3,
		Route7B7
	},
	{ // A5
		9, 7,
		0,
		nullptr
	},
	{ // B8
		1, 6,
		2,
		Route7B8
	},
	{ // A3
		17, 5,
		0,
		nullptr
	},
	{ // A2
		13, 4,
		0,
		nullptr
	},
	{ // A0
		1, 3,
		0,
		nullptr
	},
	{ // A1
		17, 3,
		0,
		nullptr
	},
};


const Stage[] Stages = {
	{ // 0
		mapBytes0, // pBytes
		10,SkyElements0,
		16,GroundElements0,
	},
	{ // 1
		mapBytes1, // pBytes
		10,SkyElements1,
		15,GroundElements1,
	},
	{ // 2
		mapBytes2, // pBytes
		10,SkyElements2,
		19,GroundElements2,
	},
	{ // 3
		mapBytes3, // pBytes
		8,SkyElements3,
		23,GroundElements3,
	},
	{ // 4
		mapBytes4, // pBytes
		8,SkyElements4,
		21,GroundElements4,
	},
	{ // 5
		mapBytes5, // pBytes
		8,SkyElements5,
		26,GroundElements5,
	},
	{ // 6
		mapBytes6, // pBytes
		8,SkyElements6,
		23,GroundElements6,
	},
	{ // 7
		mapBytes7, // pBytes
		0,SkyElements7,
		30,GroundElements7,
	},
};
