#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 1
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 11, 
		},
	},
	{ // 3
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 4, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 4
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
		},
	},
	{ // 8
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 9
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 9, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 9, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 2, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 2, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 11, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 10, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 12, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 4, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 12, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 11, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 11, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 5, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 5, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 4, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 5, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 9, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 4, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 4, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 5, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 4, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 9, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 5, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 9, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 5, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, Char_Terrain + 6, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 8, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 8, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 8, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 2, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 3, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 0, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 8, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 2, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 8, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
			Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, Char_Terrain + 7, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 10, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, Char_Terrain + 1, 
		},
	},
};

static const byte[] mapBytes0 = {
	128 + 55, 0, 25, 128 + 3, 11, 10, 128 + 3, 0, 
	34, 128 + 3, 51, 48, 128 + 4, 0, 128 + 3, 50, 
	49, 128 + 4, 8, 128 + 8, 0, 36, 36, 32, 
	128 + 3, 0, 1, 25, 128 + 3, 36, 0, 0, 
	25, 128 + 4, 36, 35, 0, 0, 36, 36, 
	29, 128 + 5, 0, 128 + 3, 36, 46, 41, 128 + 3, 
	0, 34, 36, 36, 46, 46, 4, 0, 
	0, 12, 34, 36, 46, 46, 41, 0, 
	6, 10, 12, 34, 128 + 3, 46, 4, 22, 
	47, 0, 0, 128 + 3, 46, 41, 4, 128 + 3, 
	0, 128 + 4, 46, 41, 4, 0, 25, 128 + 5, 
	46, 41, 4, 34, 128 + 6, 46, 41, 4, 
	128 + 11, 46, 38, 15, 128 + 18, 46, 37, 128 + 6, 
	46, 45, 0, 46, 46, 45, 37, 128 + 3, 
	0, 6, 14, 43, 37, 0, 25, 32, 
	0, 23, 128 + 4, 0, 34, 35, 0, 22, 
	128 + 8, 0, 128 + 8, 8, 0, 0, 1, 25, 
	32, 128 + 5, 0, 25, 36, 35, 0, 5, 
	8, 0, 0, 34, 35, 28, 0, 16, 
	128 + 7, 0, 16, 0, 128 + 6, 8, 20, 128 + 7, 
	0, 16, 128 + 3, 0, 6, 10, 0, 0, 
	16, 128 + 3, 0, 23, 48, 0, 24, 16, 
	128 + 3, 0, 22, 47, 0, 33, 16, 128 + 7, 
	0, 16, 0, 128 + 6, 8, 20, 128 + 3, 0, 
	25, 36, 32, 0, 16, 128 + 3, 0, 128 + 3, 
	36, 0, 17, 8, 0, 0, 34, 36, 
	35, 128 + 10, 0, 0, 
};
static const byte[] mapBytes1 = {
	128 + 56, 0, 128 + 7, 8, 7, 128 + 7, 0, 16, 
	128 + 3, 0, 25, 36, 32, 0, 16, 128 + 3, 
	0, 34, 36, 35, 0, 16, 128 + 7, 0, 
	16, 128 + 7, 8, 19, 128 + 11, 0, 2, 27, 
	128 + 3, 46, 0, 27, 128 + 6, 46, 0, 128 + 7, 
	46, 2, 128 + 25, 46, 37, 14, 128 + 6, 46, 
	4, 2, 46, 46, 45, 37, 128 + 6, 46, 
	37, 0, 128 + 6, 46, 4, 0, 128 + 16, 46, 
	0, 14, 44, 128 + 5, 46, 0, 0, 14, 
	44, 128 + 4, 46, 128 + 3, 0, 14, 44, 128 + 3, 
	46, 0, 0, 25, 32, 14, 46, 45, 
	37, 0, 0, 34, 35, 0, 46, 37, 
	128 + 6, 0, 46, 0, 0, 5, 128 + 4, 8, 
	42, 8, 8, 16, 0, 25, 32, 0, 
	46, 25, 36, 16, 0, 34, 35, 0, 
	46, 36, 36, 16, 128 + 4, 0, 46, 36, 
	36, 16, 128 + 4, 0, 46, 34, 36, 16, 
	128 + 4, 0, 46, 0, 0, 18, 8, 8, 
	9, 8, 42, 8, 8, 16, 0, 0, 
	16, 2, 46, 0, 0, 40, 46, 46, 
	40, 46, 45, 0, 25, 16, 0, 0, 
	16, 128 + 3, 0, 34, 16, 25, 32, 16, 
	25, 32, 0, 0, 16, 34, 35, 16, 
	34, 35, 0, 0, 16, 0, 0, 16, 
	128 + 4, 0, 17, 8, 8, 21, 128 + 4, 8, 
	128 + 15, 0, 0, 
};
static const byte[] mapBytes2 = {
	128 + 40, 0, 36, 32, 128 + 6, 0, 36, 35, 
	128 + 7, 0, 5, 128 + 6, 8, 0, 16, 128 + 7, 
	0, 16, 128 + 3, 0, 25, 36, 36, 0, 
	16, 128 + 3, 0, 34, 36, 36, 0, 16, 
	128 + 6, 0, 8, 21, 128 + 6, 8, 128 + 8, 0, 
	36, 32, 128 + 3, 0, 2, 27, 46, 36, 
	35, 0, 27, 128 + 4, 46, 128 + 3, 0, 128 + 5, 
	46, 32, 0, 2, 128 + 5, 46, 35, 0, 
	27, 128 + 5, 46, 0, 2, 128 + 6, 46, 0, 
	26, 128 + 6, 46, 0, 15, 128 + 6, 46, 0, 
	27, 128 + 6, 46, 0, 128 + 7, 46, 0, 44, 
	128 + 6, 46, 0, 14, 44, 128 + 5, 46, 36, 
	32, 0, 14, 44, 128 + 3, 46, 36, 35, 
	0, 0, 14, 44, 46, 46, 8, 8, 
	7, 0, 0, 14, 46, 46, 0, 0, 
	16, 0, 25, 32, 46, 37, 0, 0, 
	16, 0, 34, 36, 46, 0, 32, 0, 
	16, 128 + 3, 0, 46, 0, 36, 0, 18, 
	128 + 3, 8, 42, 8, 36, 0, 16, 0, 
	25, 32, 46, 0, 36, 0, 16, 0, 
	34, 36, 46, 0, 36, 0, 16, 128 + 3, 
	0, 46, 0, 35, 0, 16, 128 + 3, 0, 
	46, 128 + 3, 0, 18, 8, 9, 8, 42, 
	8, 0, 0, 16, 0, 16, 2, 46, 
	0, 46, 46, 40, 46, 40, 46, 45, 
	128 + 3, 0, 16, 0, 16, 128 + 5, 0, 16, 
	24, 16, 24, 3, 0, 8, 8, 20, 
	36, 16, 128 + 3, 36, 0, 0, 16, 33, 
	16, 34, 36, 36, 0, 0, 16, 0, 
	16, 128 + 3, 0, 36, 32, 17, 8, 21, 
	128 + 3, 8, 36, 35, 128 + 13, 0, 0, 
};
static const byte[] mapBytes3 = {
	128 + 49, 0, 25, 32, 0, 25, 128 + 3, 36, 
	0, 34, 35, 0, 34, 128 + 3, 36, 128 + 8, 
	0, 128 + 6, 8, 7, 128 + 7, 0, 16, 0, 
	1, 25, 36, 32, 3, 0, 16, 0, 
	128 + 4, 36, 32, 0, 18, 8, 36, 29, 
	13, 36, 36, 0, 16, 0, 128 + 5, 36, 
	0, 16, 0, 128 + 4, 36, 35, 0, 18, 
	8, 128 + 4, 36, 28, 0, 16, 0, 12, 
	34, 36, 35, 0, 0, 16, 128 + 7, 0, 
	16, 128 + 7, 0, 16, 128 + 3, 0, 25, 32, 
	3, 0, 18, 8, 0, 0, 34, 36, 
	32, 0, 16, 0, 41, 4, 12, 34, 
	35, 0, 16, 0, 46, 41, 4, 128 + 3, 
	0, 16, 0, 128 + 6, 46, 40, 46, 46, 
	45, 37, 128 + 3, 0, 16, 0, 46, 37, 
	0, 0, 5, 8, 21, 8, 45, 128 + 3, 
	0, 16, 128 + 4, 0, 6, 10, 0, 16, 
	128 + 4, 0, 23, 48, 0, 18, 128 + 3, 8, 
	0, 22, 47, 0, 16, 128 + 7, 0, 16, 
	0, 25, 36, 128 + 4, 8, 20, 0, 34, 
	36, 128 + 4, 0, 16, 128 + 4, 0, 5, 8, 
	8, 20, 0, 1, 25, 32, 16, 0, 
	0, 16, 1, 25, 36, 35, 16, 25, 
	32, 16, 25, 36, 36, 0, 16, 34, 
	35, 16, 36, 36, 29, 8, 20, 0, 
	0, 16, 34, 36, 36, 0, 18, 8, 
	8, 20, 12, 34, 36, 32, 16, 0, 
	0, 16, 0, 12, 34, 35, 16, 0, 
	0, 16, 128 + 3, 0, 8, 20, 0, 0, 
	16, 25, 32, 0, 0, 16, 0, 0, 
	16, 34, 35, 0, 0, 16, 0, 0, 
	16, 128 + 4, 0, 17, 8, 8, 21, 128 + 3, 
	8, 128 + 15, 0, 0, 
};
static const byte[] mapBytes4 = {
	128 + 56, 0, 128 + 4, 8, 9, 128 + 3, 8, 128 + 4, 
	0, 16, 128 + 3, 0, 36, 36, 32, 0, 
	16, 128 + 3, 0, 36, 36, 35, 0, 16, 
	128 + 7, 0, 16, 0, 0, 25, 128 + 4, 8, 
	19, 0, 0, 36, 128 + 7, 0, 34, 2, 
	27, 128 + 3, 46, 41, 4, 0, 128 + 51, 46, 
	45, 39, 44, 128 + 5, 46, 37, 0, 14, 
	128 + 5, 46, 4, 0, 2, 128 + 34, 46, 14, 
	44, 46, 46, 45, 37, 14, 44, 0, 
	14, 46, 45, 37, 128 + 5, 0, 46, 37, 
	128 + 6, 0, 46, 128 + 5, 0, 8, 8, 42, 
	128 + 5, 8, 32, 0, 46, 25, 36, 36, 
	32, 0, 35, 0, 46, 128 + 4, 36, 128 + 3, 
	0, 46, 128 + 4, 36, 128 + 3, 0, 46, 34, 
	36, 36, 35, 0, 5, 8, 42, 128 + 5, 
	8, 16, 2, 46, 128 + 5, 0, 40, 46, 
	45, 0, 0, 6, 10, 0, 16, 0, 
	0, 24, 0, 23, 48, 0, 16, 0, 
	0, 33, 0, 22, 47, 0, 16, 24, 
	3, 128 + 5, 0, 16, 34, 31, 0, 0, 
	5, 8, 8, 16, 128 + 4, 0, 16, 0, 
	0, 17, 128 + 4, 8, 19, 128 + 17, 0, 0, 

};
static const byte[] mapBytes5 = {
	128 + 53, 0, 25, 32, 0, 11, 10, 128 + 3, 
	0, 34, 35, 0, 51, 48, 128 + 6, 0, 
	50, 49, 128 + 6, 8, 128 + 8, 0, 32, 128 + 3, 
	0, 1, 25, 128 + 3, 36, 0, 0, 25, 
	128 + 4, 36, 35, 0, 0, 36, 36, 29, 
	13, 36, 128 + 3, 0, 128 + 5, 36, 128 + 3, 0, 
	34, 128 + 4, 36, 128 + 3, 0, 12, 34, 128 + 3, 
	36, 41, 0, 6, 10, 12, 34, 36, 
	36, 46, 4, 22, 47, 128 + 4, 0, 46, 
	41, 4, 128 + 5, 0, 46, 46, 41, 4, 
	0, 0, 25, 36, 128 + 3, 46, 41, 4, 
	0, 34, 36, 128 + 4, 46, 41, 4, 12, 
	34, 128 + 5, 46, 41, 4, 0, 46, 38, 
	15, 128 + 10, 46, 45, 37, 0, 128 + 5, 46, 
	37, 0, 0, 128 + 4, 46, 45, 128 + 3, 0, 
	45, 37, 128 + 3, 0, 6, 10, 128 + 3, 0, 
	25, 32, 0, 23, 48, 128 + 3, 0, 34, 
	35, 0, 22, 47, 128 + 9, 0, 128 + 8, 8, 
	128 + 13, 0, 5, 8, 8, 128 + 3, 0, 25, 
	32, 16, 128 + 5, 0, 34, 35, 16, 25, 
	36, 128 + 5, 8, 20, 34, 36, 128 + 5, 0, 
	16, 0, 0, 11, 10, 128 + 3, 0, 18, 
	8, 8, 51, 48, 0, 25, 32, 16, 
	0, 0, 50, 47, 0, 34, 35, 16, 
	128 + 7, 0, 16, 0, 0, 128 + 5, 8, 20, 
	0, 0, 36, 36, 32, 0, 0, 16, 
	0, 0, 128 + 3, 36, 0, 0, 17, 8, 
	8, 36, 36, 35, 128 + 12, 0, 0, 
};
static const byte[] mapBytes6 = {
	128 + 41, 0, 1, 25, 32, 128 + 5, 0, 25, 
	36, 36, 128 + 5, 0, 128 + 3, 36, 0, 5, 
	8, 8, 0, 34, 36, 35, 0, 16, 
	128 + 7, 0, 16, 128 + 7, 0, 16, 128 + 7, 0, 
	16, 0, 0, 8, 8, 9, 8, 8, 
	21, 8, 8, 0, 0, 16, 128 + 7, 0, 
	16, 0, 25, 32, 128 + 4, 0, 16, 0, 
	34, 35, 0, 27, 0, 0, 16, 128 + 4, 
	0, 46, 0, 0, 16, 25, 32, 0, 
	2, 46, 8, 8, 20, 34, 35, 0, 
	27, 46, 0, 0, 16, 0, 0, 2, 
	46, 46, 0, 0, 16, 0, 0, 26, 
	46, 46, 0, 0, 16, 0, 0, 15, 
	46, 46, 0, 0, 16, 0, 0, 27, 
	46, 46, 8, 8, 20, 0, 0, 128 + 3, 
	46, 0, 0, 16, 0, 0, 44, 46, 
	46, 0, 0, 16, 0, 0, 14, 44, 
	46, 0, 0, 16, 0, 25, 32, 128 + 4, 
	0, 16, 0, 34, 35, 0, 0, 8, 
	8, 21, 128 + 3, 8, 7, 128 + 7, 0, 16, 
	0, 36, 32, 0, 0, 25, 32, 16, 
	0, 36, 36, 3, 0, 36, 36, 16, 
	0, 36, 36, 32, 0, 36, 36, 18, 
	8, 128 + 3, 36, 0, 34, 35, 16, 0, 
	128 + 3, 36, 3, 0, 0, 16, 0, 128 + 3, 
	36, 32, 0, 0, 16, 0, 128 + 3, 36, 
	35, 0, 0, 16, 0, 36, 36, 35, 
	28, 0, 0, 18, 8, 128 + 6, 0, 16, 
	0, 128 + 6, 46, 40, 46, 128 + 6, 0, 16, 
	128 + 7, 0, 16, 25, 128 + 6, 8, 20, 36, 
	128 + 6, 0, 16, 34, 0, 25, 32, 128 + 3, 
	0, 16, 0, 0, 34, 35, 0, 25, 
	32, 17, 8, 128 + 4, 0, 34, 35, 128 + 9, 
	0, 0, 
};
static const byte[] mapBytes7 = {
	128 + 48, 0, 32, 128 + 7, 0, 35, 128 + 4, 0, 
	6, 10, 128 + 6, 0, 22, 47, 0, 128 + 4, 
	8, 7, 128 + 3, 0, 32, 3, 0, 0, 
	18, 128 + 3, 8, 36, 32, 3, 0, 16, 
	128 + 3, 0, 36, 36, 32, 0, 18, 128 + 3, 
	8, 13, 36, 36, 0, 16, 128 + 3, 0, 
	128 + 3, 36, 0, 16, 128 + 3, 0, 36, 36, 
	35, 0, 18, 128 + 3, 8, 36, 36, 28, 
	0, 16, 128 + 3, 0, 36, 35, 0, 0, 
	16, 25, 32, 0, 35, 28, 0, 0, 
	16, 34, 35, 128 + 5, 0, 16, 128 + 3, 0, 
	32, 128 + 3, 0, 17, 128 + 3, 8, 36, 128 + 4, 
	0, 25, 32, 0, 35, 128 + 4, 0, 34, 
	35, 128 + 9, 0, 128 + 8, 46, 128 + 10, 0, 5, 
	128 + 5, 8, 0, 0, 16, 128 + 5, 0, 10, 
	0, 16, 128 + 5, 0, 48, 0, 18, 128 + 5, 
	8, 47, 0, 16, 128 + 7, 0, 16, 0, 
	25, 31, 0, 0, 8, 8, 20, 0, 
	33, 28, 128 + 4, 0, 16, 0, 0, 1, 
	25, 36, 8, 8, 20, 0, 1, 25, 
	36, 36, 0, 0, 16, 0, 25, 128 + 4, 
	36, 32, 16, 0, 128 + 5, 36, 35, 16, 
	0, 36, 36, 30, 36, 0, 0, 16, 
	0, 34, 128 + 3, 36, 8, 8, 20, 0, 
	12, 34, 36, 36, 0, 0, 16, 0, 
	0, 12, 36, 36, 0, 0, 16, 128 + 3, 
	0, 34, 36, 0, 0, 16, 25, 32, 
	0, 12, 36, 0, 0, 16, 34, 35, 
	0, 0, 34, 0, 0, 16, 128 + 5, 0, 
	8, 8, 21, 128 + 5, 8, 128 + 15, 0, 0, 

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
