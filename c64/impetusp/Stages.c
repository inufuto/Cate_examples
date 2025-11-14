#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 1
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 3
		{ // chars
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 1, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
		},
	},
	{ // 4
		{ // chars
			Char_Terrain + 2, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 1, 
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 4, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 9, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 2, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 2, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 1, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 4, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 9, 
		},
	},
	{ // 8
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 1, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 4, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 9
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 25, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 4, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 1, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 4, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 4, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 4, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 14, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 4, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 3, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 4, Char_Terrain + 3, Char_Terrain + 3, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 7, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 7, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 7, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 7, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 6, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 10, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 2, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 6, 
			Char_Terrain + 6, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 6, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 10, 
			Char_Terrain + 6, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 7, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, Char_Terrain + 0, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 10, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 9, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 13, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 14, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 25, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 25, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 25, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 23, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 23, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 25, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 11, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 25, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 23, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 14, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 22, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 52
		{ // chars
			Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 21, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 53
		{ // chars
			Char_Terrain + 12, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 12, 
			Char_Terrain + 16, Char_Terrain + 26, Char_Terrain + 26, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 24, Char_Terrain + 24, Char_Terrain + 16, 
		},
	},
	{ // 54
		{ // chars
			Char_Terrain + 13, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 21, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 55
		{ // chars
			Char_Terrain + 13, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 56
		{ // chars
			Char_Terrain + 13, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 21, 
			Char_Terrain + 21, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 17, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 57
		{ // chars
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 58
		{ // chars
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 17, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 19, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 59
		{ // chars
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 17, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 19, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 13, 
		},
	},
	{ // 60
		{ // chars
			Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 20, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 61
		{ // chars
			Char_Terrain + 15, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 15, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
		},
	},
	{ // 62
		{ // chars
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 63
		{ // chars
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 18, 
		},
	},
	{ // 64
		{ // chars
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 17, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 65
		{ // chars
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 17, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 18, 
		},
	},
	{ // 66
		{ // chars
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 24, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 24, 
			Char_Terrain + 27, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 27, 
			Char_Terrain + 26, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 26, 
		},
	},
	{ // 67
		{ // chars
			Char_Terrain + 18, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 20, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 68
		{ // chars
			Char_Terrain + 18, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 20, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 14, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 69
		{ // chars
			Char_Terrain + 18, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 17, 
			Char_Terrain + 20, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 19, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 70
		{ // chars
			Char_Terrain + 18, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 20, 
			Char_Terrain + 20, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 71
		{ // chars
			Char_Terrain + 19, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 15, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 72
		{ // chars
			Char_Terrain + 19, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 17, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 19, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 73
		{ // chars
			Char_Terrain + 19, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 17, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 19, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 13, 
		},
	},
	{ // 74
		{ // chars
			Char_Terrain + 19, Char_Terrain + 15, Char_Terrain + 15, Char_Terrain + 20, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 75
		{ // chars
			Char_Terrain + 22, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 12, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 76
		{ // chars
			Char_Terrain + 22, Char_Terrain + 12, Char_Terrain + 12, Char_Terrain + 14, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 22, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
			Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, Char_Terrain + 16, 
		},
	},
	{ // 77
		{ // chars
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 11, 
		},
	},
	{ // 78
		{ // chars
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
		},
	},
	{ // 79
		{ // chars
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 11, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 23, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 80
		{ // chars
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, Char_Terrain + 25, 
		},
	},
	{ // 81
		{ // chars
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
			Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, Char_Terrain + 27, 
		},
	},
};

static const byte[] mapBytes0 = {
	128 + 55, 32, 28, 128 + 3, 41, 38, 128 + 3, 32, 
	2, 128 + 3, 81, 78, 128 + 3, 32, 15, 128 + 3, 
	80, 79, 128 + 4, 39, 128 + 8, 32, 24, 24, 
	25, 128 + 3, 32, 31, 28, 128 + 3, 0, 32, 
	32, 28, 23, 128 + 3, 0, 1, 32, 32, 
	0, 0, 5, 9, 9, 11, 32, 32, 
	0, 0, 20, 50, 51, 128 + 3, 32, 2, 
	0, 0, 62, 62, 34, 32, 32, 14, 
	2, 0, 62, 62, 76, 32, 36, 38, 
	14, 2, 128 + 3, 62, 34, 48, 77, 32, 
	15, 128 + 3, 62, 76, 34, 128 + 3, 32, 128 + 4, 
	62, 76, 34, 32, 28, 128 + 5, 62, 76, 
	34, 2, 128 + 6, 62, 76, 16, 128 + 7, 62, 
	75, 128 + 3, 62, 68, 59, 128 + 6, 62, 75, 
	52, 128 + 10, 62, 67, 128 + 6, 62, 63, 32, 
	62, 62, 63, 67, 57, 57, 60, 36, 
	58, 65, 70, 32, 28, 25, 32, 49, 
	32, 74, 32, 32, 2, 1, 32, 48, 
	128 + 4, 32, 15, 11, 32, 32, 128 + 8, 39, 
	32, 32, 31, 28, 25, 128 + 5, 32, 27, 
	0, 1, 32, 35, 39, 32, 32, 2, 
	1, 6, 32, 42, 128 + 3, 32, 15, 11, 
	32, 32, 42, 32, 128 + 6, 39, 46, 128 + 7, 
	32, 42, 128 + 3, 32, 36, 38, 32, 32, 
	42, 128 + 3, 32, 49, 78, 32, 29, 42, 
	128 + 3, 32, 48, 77, 32, 3, 42, 128 + 6, 
	32, 18, 42, 32, 128 + 6, 39, 46, 128 + 3, 
	32, 28, 24, 25, 32, 42, 128 + 3, 32, 
	128 + 3, 0, 32, 43, 39, 32, 32, 2, 
	0, 1, 128 + 5, 32, 15, 9, 11, 32, 
	32, 32, 
};
static const byte[] mapBytes1 = {
	128 + 56, 32, 128 + 7, 39, 37, 128 + 7, 32, 42, 
	128 + 3, 32, 28, 24, 25, 32, 42, 128 + 3, 
	32, 2, 0, 1, 32, 42, 128 + 3, 32, 
	15, 9, 11, 32, 42, 128 + 7, 39, 45, 
	128 + 11, 32, 33, 54, 128 + 3, 50, 32, 54, 
	50, 52, 128 + 4, 62, 32, 128 + 7, 62, 33, 
	128 + 7, 62, 52, 128 + 17, 62, 67, 58, 128 + 6, 
	62, 34, 33, 62, 62, 63, 67, 62, 
	62, 75, 52, 62, 62, 70, 32, 128 + 6, 
	62, 34, 32, 128 + 6, 62, 75, 50, 128 + 8, 
	62, 57, 58, 64, 128 + 5, 62, 32, 32, 
	72, 64, 128 + 4, 62, 128 + 3, 32, 72, 64, 
	128 + 3, 62, 32, 32, 28, 25, 72, 62, 
	63, 67, 32, 32, 2, 1, 32, 62, 
	70, 128 + 3, 32, 15, 11, 32, 62, 32, 
	32, 35, 128 + 4, 39, 66, 39, 39, 42, 
	32, 28, 25, 32, 62, 28, 24, 42, 
	32, 2, 1, 32, 62, 0, 0, 42, 
	32, 15, 11, 32, 62, 0, 0, 42, 
	128 + 4, 32, 62, 2, 0, 42, 128 + 4, 32, 
	62, 15, 9, 44, 39, 39, 40, 39, 
	66, 39, 39, 42, 32, 32, 42, 33, 
	62, 32, 32, 53, 50, 50, 53, 52, 
	63, 32, 28, 61, 57, 57, 61, 57, 
	60, 32, 2, 42, 28, 25, 42, 28, 
	25, 32, 15, 42, 2, 1, 42, 2, 
	1, 32, 32, 42, 15, 11, 42, 15, 
	11, 32, 32, 43, 39, 39, 47, 128 + 4, 
	39, 128 + 15, 32, 32, 
};
static const byte[] mapBytes2 = {
	128 + 40, 32, 24, 25, 128 + 6, 32, 0, 1, 
	128 + 6, 32, 9, 12, 128 + 6, 39, 32, 42, 
	128 + 7, 32, 42, 128 + 3, 32, 28, 24, 24, 
	32, 42, 128 + 3, 32, 2, 0, 0, 32, 
	42, 128 + 3, 32, 15, 9, 9, 39, 47, 
	128 + 6, 39, 128 + 8, 32, 24, 25, 128 + 3, 32, 
	33, 54, 50, 0, 1, 32, 54, 50, 
	52, 62, 62, 9, 11, 32, 128 + 5, 62, 
	25, 32, 33, 128 + 5, 62, 1, 32, 55, 
	128 + 5, 62, 11, 33, 128 + 6, 62, 32, 56, 
	128 + 6, 62, 32, 73, 128 + 6, 62, 32, 55, 
	128 + 6, 62, 32, 128 + 7, 62, 32, 64, 128 + 6, 
	62, 32, 72, 64, 128 + 5, 62, 24, 25, 
	71, 58, 64, 128 + 3, 62, 0, 1, 32, 
	32, 72, 64, 62, 62, 10, 13, 37, 
	32, 32, 72, 62, 62, 32, 32, 42, 
	32, 28, 25, 62, 67, 32, 32, 42, 
	32, 2, 0, 62, 32, 25, 32, 42, 
	32, 15, 9, 62, 32, 0, 32, 44, 
	128 + 3, 39, 66, 39, 0, 32, 42, 32, 
	28, 25, 62, 32, 0, 32, 42, 32, 
	2, 0, 62, 32, 0, 32, 42, 32, 
	15, 9, 62, 32, 1, 32, 42, 128 + 3, 
	32, 62, 32, 11, 32, 44, 39, 40, 
	39, 66, 39, 32, 32, 42, 32, 42, 
	33, 62, 32, 50, 50, 53, 50, 53, 
	52, 63, 32, 57, 57, 61, 57, 61, 
	57, 60, 128 + 3, 32, 42, 29, 42, 29, 
	30, 32, 39, 39, 46, 0, 42, 0, 
	20, 24, 32, 32, 42, 3, 42, 2, 
	0, 0, 32, 32, 42, 18, 42, 15, 
	9, 9, 24, 25, 43, 39, 47, 128 + 3, 
	39, 0, 1, 128 + 6, 32, 9, 11, 128 + 5, 
	32, 32, 
};
static const byte[] mapBytes3 = {
	128 + 49, 32, 28, 25, 32, 28, 128 + 3, 24, 
	32, 2, 1, 32, 2, 128 + 3, 0, 32, 
	15, 11, 32, 15, 128 + 3, 9, 128 + 6, 39, 
	37, 128 + 7, 32, 42, 32, 31, 28, 24, 
	25, 30, 32, 42, 32, 23, 128 + 3, 0, 
	21, 32, 44, 39, 0, 5, 7, 0, 
	0, 32, 42, 32, 0, 20, 23, 0, 
	0, 32, 42, 32, 128 + 4, 0, 1, 32, 
	44, 39, 128 + 4, 0, 6, 32, 42, 32, 
	8, 2, 0, 1, 32, 32, 42, 32, 
	32, 15, 9, 11, 32, 32, 42, 128 + 7, 
	32, 42, 128 + 3, 32, 28, 25, 30, 32, 
	44, 39, 32, 32, 2, 0, 21, 32, 
	42, 32, 51, 34, 14, 2, 1, 32, 
	42, 32, 62, 76, 34, 15, 11, 32, 
	42, 32, 62, 62, 75, 128 + 3, 50, 53, 
	50, 62, 63, 67, 128 + 3, 57, 61, 57, 
	62, 70, 32, 32, 35, 39, 47, 39, 
	63, 128 + 3, 32, 42, 128 + 3, 32, 60, 36, 
	38, 32, 42, 128 + 4, 32, 49, 78, 32, 
	44, 128 + 3, 39, 32, 48, 77, 32, 42, 
	128 + 7, 32, 42, 32, 28, 24, 128 + 4, 39, 
	46, 32, 2, 0, 128 + 4, 32, 42, 32, 
	15, 9, 32, 35, 39, 39, 46, 32, 
	31, 28, 25, 42, 32, 32, 42, 31, 
	27, 0, 1, 42, 28, 25, 42, 27, 
	0, 0, 11, 42, 2, 1, 42, 0, 
	0, 5, 39, 46, 15, 11, 42, 2, 
	0, 20, 32, 44, 39, 39, 46, 14, 
	2, 0, 25, 42, 32, 32, 42, 32, 
	14, 2, 1, 42, 32, 32, 42, 32, 
	32, 15, 13, 46, 32, 32, 42, 28, 
	25, 32, 32, 42, 32, 32, 42, 2, 
	1, 32, 32, 42, 32, 32, 42, 15, 
	11, 32, 32, 43, 39, 39, 47, 128 + 3, 
	39, 128 + 15, 32, 32, 
};
static const byte[] mapBytes4 = {
	128 + 56, 32, 128 + 4, 39, 40, 128 + 3, 39, 128 + 4, 
	32, 42, 128 + 3, 32, 24, 24, 25, 32, 
	42, 128 + 3, 32, 0, 0, 1, 32, 42, 
	128 + 3, 32, 9, 9, 11, 32, 42, 32, 
	32, 28, 128 + 4, 39, 45, 32, 32, 0, 
	128 + 7, 32, 2, 33, 54, 128 + 3, 50, 51, 
	34, 15, 52, 128 + 5, 62, 75, 50, 128 + 43, 
	62, 63, 69, 64, 128 + 5, 62, 70, 32, 
	72, 128 + 5, 62, 34, 32, 33, 128 + 5, 62, 
	75, 50, 52, 128 + 26, 62, 58, 64, 62, 
	62, 63, 67, 58, 64, 32, 72, 62, 
	63, 70, 32, 32, 71, 32, 32, 62, 
	70, 128 + 6, 32, 62, 128 + 5, 32, 39, 39, 
	66, 128 + 5, 39, 25, 32, 62, 28, 24, 
	24, 25, 32, 1, 32, 62, 128 + 4, 0, 
	32, 11, 32, 62, 128 + 4, 0, 128 + 3, 32, 
	62, 2, 0, 0, 1, 32, 35, 39, 
	66, 17, 10, 10, 13, 39, 42, 33, 
	62, 128 + 5, 32, 53, 52, 63, 32, 32, 
	36, 38, 32, 61, 57, 60, 29, 32, 
	49, 78, 32, 42, 32, 32, 3, 32, 
	48, 77, 32, 42, 29, 30, 18, 128 + 4, 
	32, 42, 2, 22, 32, 32, 35, 39, 
	39, 42, 15, 11, 32, 32, 42, 32, 
	32, 43, 128 + 4, 39, 45, 128 + 17, 32, 32, 

};
static const byte[] mapBytes5 = {
	128 + 53, 32, 28, 25, 32, 41, 38, 128 + 3, 
	32, 2, 1, 32, 81, 78, 128 + 3, 32, 
	15, 11, 32, 80, 79, 128 + 6, 39, 128 + 8, 
	32, 25, 128 + 3, 32, 31, 28, 24, 24, 
	0, 32, 32, 28, 23, 128 + 3, 0, 1, 
	32, 32, 0, 0, 5, 7, 0, 11, 
	32, 32, 0, 0, 20, 23, 0, 128 + 3, 
	32, 2, 128 + 4, 0, 128 + 3, 32, 14, 2, 
	128 + 3, 0, 51, 32, 36, 38, 14, 2, 
	0, 0, 62, 34, 48, 77, 32, 15, 
	9, 9, 62, 76, 34, 128 + 5, 32, 62, 
	62, 76, 34, 32, 32, 28, 24, 128 + 3, 
	62, 76, 34, 32, 2, 0, 128 + 4, 62, 
	76, 34, 14, 2, 128 + 5, 62, 76, 34, 
	15, 62, 68, 59, 128 + 3, 62, 75, 50, 
	62, 75, 52, 62, 62, 63, 67, 57, 
	128 + 5, 62, 70, 32, 32, 128 + 4, 62, 63, 
	128 + 3, 32, 63, 67, 57, 57, 60, 36, 
	38, 32, 60, 32, 28, 25, 32, 49, 
	78, 128 + 3, 32, 2, 1, 32, 48, 77, 
	128 + 3, 32, 15, 11, 128 + 4, 32, 128 + 8, 39, 
	128 + 13, 32, 35, 39, 39, 128 + 3, 32, 28, 
	25, 42, 128 + 5, 32, 2, 1, 42, 28, 
	24, 128 + 3, 39, 17, 13, 46, 2, 0, 
	128 + 5, 32, 42, 15, 9, 41, 38, 128 + 3, 
	32, 44, 39, 39, 81, 78, 32, 28, 
	25, 42, 32, 32, 80, 77, 32, 2, 
	1, 42, 128 + 5, 32, 15, 11, 42, 32, 
	32, 128 + 5, 39, 46, 32, 32, 24, 24, 
	25, 32, 32, 42, 32, 32, 128 + 3, 0, 
	32, 32, 43, 39, 39, 0, 0, 1, 
	128 + 5, 32, 9, 9, 11, 128 + 4, 32, 32, 

};
static const byte[] mapBytes6 = {
	128 + 41, 32, 31, 28, 25, 128 + 5, 32, 27, 
	0, 0, 128 + 5, 32, 128 + 3, 0, 32, 35, 
	39, 39, 32, 2, 0, 1, 32, 42, 
	128 + 3, 32, 15, 9, 11, 32, 42, 128 + 7, 
	32, 42, 128 + 7, 32, 42, 32, 32, 39, 
	39, 40, 39, 39, 47, 39, 39, 32, 
	32, 42, 128 + 7, 32, 42, 32, 28, 25, 
	128 + 4, 32, 42, 32, 2, 1, 32, 54, 
	32, 32, 42, 32, 15, 11, 32, 62, 
	32, 32, 42, 28, 25, 32, 33, 62, 
	39, 39, 46, 2, 1, 32, 55, 62, 
	32, 32, 42, 15, 11, 33, 62, 62, 
	32, 32, 42, 32, 32, 56, 62, 62, 
	32, 32, 42, 32, 32, 73, 62, 62, 
	32, 32, 42, 32, 32, 55, 62, 62, 
	39, 39, 46, 32, 32, 128 + 3, 62, 32, 
	32, 42, 32, 32, 64, 62, 62, 32, 
	32, 42, 32, 32, 72, 64, 62, 32, 
	32, 42, 32, 28, 25, 71, 57, 32, 
	32, 42, 32, 2, 1, 32, 32, 39, 
	39, 47, 39, 17, 13, 37, 128 + 7, 32, 
	42, 32, 24, 25, 32, 32, 28, 25, 
	42, 32, 0, 0, 30, 32, 0, 0, 
	42, 32, 0, 0, 21, 32, 0, 0, 
	44, 39, 128 + 3, 0, 32, 2, 1, 42, 
	32, 128 + 3, 0, 30, 15, 11, 42, 32, 
	128 + 3, 0, 21, 32, 32, 42, 32, 128 + 3, 
	0, 1, 32, 32, 42, 32, 0, 0, 
	1, 6, 32, 32, 44, 39, 9, 9, 
	11, 128 + 3, 32, 42, 32, 128 + 6, 50, 53, 
	50, 128 + 6, 57, 61, 57, 128 + 6, 32, 42, 
	28, 128 + 6, 39, 46, 0, 128 + 6, 32, 42, 
	2, 32, 28, 25, 128 + 3, 32, 42, 15, 
	32, 2, 1, 32, 28, 25, 43, 39, 
	32, 15, 11, 32, 2, 1, 128 + 6, 32, 
	15, 11, 32, 32, 
};
static const byte[] mapBytes7 = {
	128 + 48, 32, 25, 128 + 7, 32, 1, 128 + 4, 32, 
	36, 38, 32, 11, 128 + 4, 32, 48, 77, 
	32, 128 + 4, 39, 37, 128 + 3, 32, 25, 30, 
	32, 32, 44, 128 + 3, 39, 0, 21, 30, 
	32, 42, 128 + 3, 32, 0, 0, 21, 32, 
	44, 128 + 3, 39, 7, 0, 0, 32, 42, 
	128 + 3, 32, 23, 0, 0, 32, 42, 128 + 3, 
	32, 0, 0, 1, 32, 44, 128 + 3, 39, 
	0, 0, 6, 32, 42, 128 + 3, 32, 0, 
	1, 32, 32, 42, 28, 25, 32, 1, 
	6, 32, 32, 42, 2, 1, 32, 11, 
	128 + 3, 32, 42, 15, 11, 32, 25, 128 + 3, 
	32, 43, 128 + 3, 39, 0, 128 + 4, 32, 28, 
	25, 32, 1, 128 + 4, 32, 2, 1, 32, 
	11, 128 + 4, 32, 15, 11, 32, 128 + 8, 50, 
	128 + 8, 57, 32, 32, 35, 128 + 5, 39, 32, 
	32, 42, 128 + 5, 32, 38, 32, 42, 128 + 5, 
	32, 78, 32, 44, 128 + 5, 39, 77, 32, 
	42, 128 + 7, 32, 42, 32, 28, 26, 32, 
	32, 39, 39, 46, 32, 3, 6, 128 + 4, 
	32, 42, 32, 18, 31, 28, 24, 39, 
	39, 46, 32, 31, 27, 0, 0, 32, 
	32, 42, 32, 27, 128 + 3, 0, 24, 25, 
	42, 32, 128 + 5, 0, 1, 42, 32, 0, 
	0, 4, 0, 9, 11, 42, 32, 2, 
	0, 19, 0, 39, 39, 46, 32, 14, 
	2, 0, 0, 32, 32, 42, 32, 32, 
	14, 0, 0, 32, 32, 42, 128 + 3, 32, 
	2, 0, 32, 32, 42, 28, 25, 32, 
	14, 0, 32, 32, 42, 2, 1, 32, 
	32, 2, 32, 32, 42, 15, 11, 32, 
	32, 15, 39, 39, 47, 128 + 5, 39, 128 + 15, 
	32, 32, 
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
