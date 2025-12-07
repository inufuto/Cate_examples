#include "Stage.h"
#include "Chars.h"

const Tile[] Tiles = {
	{ // 0
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 1
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 2
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 3
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 4
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 5
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 6
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 7
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
		},
	},
	{ // 8
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 9
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 10
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
		},
	},
	{ // 11
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 12
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
		},
	},
	{ // 13
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 14
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 15
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 16
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
		},
	},
	{ // 17
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
		},
	},
	{ // 18
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 19
		{ // chars
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 5, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
	{ // 20
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 21
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 22
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 23
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 0, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 24
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 25
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 0, 
			Char_Terrain + 0, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 26
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 2, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 27
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 2, 
			Char_Terrain + 2, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 28
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 29
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 30
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 31
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 32
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 7, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 33
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 34
		{ // chars
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 2, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 35
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 8, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 36
		{ // chars
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 2, 
			Char_Terrain + 8, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 37
		{ // chars
			Char_Terrain + 12, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 38
		{ // chars
			Char_Terrain + 12, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 12, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 39
		{ // chars
			Char_Terrain + 12, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 40
		{ // chars
			Char_Terrain + 12, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 0, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 41
		{ // chars
			Char_Terrain + 7, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 7, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 42
		{ // chars
			Char_Terrain + 7, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 43
		{ // chars
			Char_Terrain + 7, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 2, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 44
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 45
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 46
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 47
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 48
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 49
		{ // chars
			Char_Terrain + 3, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 3, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 50
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 51
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 52
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 53
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 9, 
		},
	},
	{ // 54
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 3, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 55
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 3, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 56
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 4, 
			Char_Terrain + 4, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 57
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 4, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 58
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 4, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 3, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 59
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 60
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 61
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 62
		{ // chars
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
			Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, Char_Terrain + 10, 
		},
	},
	{ // 63
		{ // chars
			Char_Terrain + 6, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 64
		{ // chars
			Char_Terrain + 6, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 6, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 65
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 1, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 66
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 67
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 6, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 68
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 6, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 69
		{ // chars
			Char_Terrain + 8, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 8, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 9, Char_Terrain + 9, Char_Terrain + 5, 
		},
	},
	{ // 70
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 71
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 1, 
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 72
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 73
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 74
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 1, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 6, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
			Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, Char_Terrain + 5, 
		},
	},
	{ // 75
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 76
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 77
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 78
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
		},
	},
	{ // 79
		{ // chars
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 8, 
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 9, 
			Char_Terrain + 9, Char_Terrain + 8, Char_Terrain + 8, Char_Terrain + 9, 
		},
	},
	{ // 80
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
		},
	},
	{ // 81
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 5, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 9, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 9, 
		},
	},
	{ // 82
		{ // chars
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
			Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, Char_Terrain + 11, 
		},
	},
};

static const byte[] mapBytes0 = {
	128 + 29, 0, 22, 11, 11, 10, 0, 0, 
	46, 82, 82, 81, 128 + 3, 8, 128 + 4, 0, 
	1, 23, 30, 29, 0, 22, 31, 62, 
	62, 61, 0, 46, 128 + 3, 52, 50, 0, 
	6, 10, 0, 33, 32, 0, 19, 80, 
	0, 77, 77, 4, 128 + 3, 0, 77, 77, 
	42, 32, 0, 22, 128 + 4, 77, 4, 46, 
	128 + 4, 77, 42, 33, 77, 77, 74, 128 + 5, 
	77, 43, 128 + 7, 77, 76, 72, 77, 76, 
	72, 66, 65, 0, 66, 65, 128 + 4, 0, 
	128 + 6, 8, 0, 1, 23, 29, 128 + 3, 0, 
	24, 62, 61, 5, 8, 0, 46, 52, 
	50, 12, 0, 128 + 4, 8, 17, 128 + 5, 0, 
	12, 128 + 5, 0, 12, 0, 128 + 4, 8, 17, 
	128 + 5, 0, 12, 0, 0, 22, 30, 28, 
	13, 8, 0, 46, 52, 50, 0, 0, 

};
static const byte[] mapBytes1 = {
	128 + 30, 0, 128 + 5, 8, 7, 0, 0, 23, 
	29, 0, 12, 0, 0, 60, 61, 0, 
	12, 8, 8, 48, 51, 8, 16, 128 + 7, 
	0, 2, 26, 128 + 3, 33, 2, 27, 128 + 4, 
	77, 34, 128 + 13, 77, 74, 77, 76, 72, 
	77, 77, 43, 77, 71, 0, 128 + 4, 77, 
	42, 33, 128 + 6, 77, 66, 67, 75, 128 + 3, 
	77, 0, 0, 64, 128 + 3, 77, 128 + 3, 0, 
	77, 72, 66, 5, 8, 8, 79, 8, 
	8, 12, 23, 29, 77, 23, 30, 12, 
	60, 61, 77, 62, 62, 12, 46, 50, 
	77, 60, 62, 14, 8, 9, 79, 48, 
	53, 12, 0, 15, 78, 0, 0, 35, 
	33, 36, 76, 0, 22, 69, 66, 69, 
	65, 0, 46, 12, 0, 12, 128 + 3, 0, 
	13, 8, 18, 128 + 3, 8, 128 + 5, 0, 0, 

};
static const byte[] mapBytes2 = {
	128 + 31, 0, 5, 128 + 4, 8, 0, 12, 0, 
	22, 30, 30, 0, 12, 0, 46, 52, 
	52, 8, 18, 128 + 4, 8, 29, 128 + 5, 0, 
	61, 0, 2, 26, 33, 33, 50, 2, 
	27, 128 + 3, 77, 0, 27, 128 + 4, 77, 0, 
	128 + 5, 77, 0, 128 + 5, 77, 0, 128 + 5, 77, 
	0, 75, 128 + 4, 77, 0, 64, 75, 128 + 3, 
	77, 0, 0, 64, 75, 77, 77, 8, 
	7, 0, 64, 77, 77, 0, 12, 0, 
	0, 77, 72, 29, 14, 8, 8, 79, 
	8, 62, 12, 0, 0, 77, 0, 62, 
	12, 0, 0, 77, 0, 61, 14, 8, 
	8, 79, 8, 50, 12, 0, 2, 77, 
	0, 33, 35, 33, 34, 76, 0, 66, 
	69, 66, 66, 65, 0, 8, 17, 23, 
	128 + 3, 30, 0, 12, 60, 128 + 3, 62, 28, 
	13, 48, 128 + 3, 53, 50, 128 + 4, 0, 0, 

};
static const byte[] mapBytes3 = {
	128 + 27, 0, 22, 30, 30, 128 + 3, 0, 46, 
	54, 60, 128 + 4, 8, 7, 46, 1, 23, 
	29, 3, 12, 0, 31, 62, 62, 38, 
	14, 8, 62, 58, 62, 62, 12, 0, 
	62, 40, 62, 61, 14, 8, 62, 62, 
	61, 56, 12, 0, 52, 52, 50, 0, 
	12, 0, 0, 22, 29, 3, 14, 8, 
	0, 49, 60, 37, 12, 0, 33, 32, 
	47, 50, 12, 0, 77, 77, 42, 33, 
	35, 33, 77, 76, 72, 66, 69, 66, 
	76, 70, 0, 5, 18, 8, 65, 0, 
	0, 12, 128 + 5, 0, 14, 128 + 5, 8, 17, 
	22, 30, 128 + 3, 0, 12, 46, 52, 29, 
	5, 8, 17, 23, 30, 61, 12, 0, 
	12, 62, 57, 51, 17, 0, 12, 62, 
	39, 0, 14, 8, 17, 60, 62, 28, 
	12, 0, 12, 46, 52, 51, 17, 0, 
	12, 21, 0, 0, 12, 0, 12, 59, 
	0, 0, 13, 8, 18, 45, 8, 128 + 5, 
	0, 0, 
};
static const byte[] mapBytes4 = {
	128 + 30, 0, 128 + 3, 8, 9, 8, 8, 30, 
	29, 0, 12, 0, 0, 62, 61, 0, 
	12, 0, 23, 53, 51, 8, 16, 0, 
	60, 128 + 5, 0, 46, 2, 26, 33, 32, 
	4, 0, 34, 128 + 3, 77, 42, 33, 128 + 20, 
	77, 73, 68, 128 + 4, 77, 42, 34, 128 + 14, 
	77, 67, 77, 76, 72, 67, 75, 0, 
	77, 70, 0, 0, 63, 8, 79, 128 + 4, 
	8, 28, 77, 23, 30, 29, 0, 50, 
	77, 60, 62, 61, 0, 5, 79, 48, 
	53, 51, 8, 15, 78, 128 + 4, 0, 36, 
	76, 0, 6, 10, 0, 69, 65, 0, 
	19, 80, 0, 12, 21, 128 + 4, 0, 12, 
	59, 0, 5, 8, 8, 13, 45, 8, 
	16, 128 + 7, 0, 0, 
};
static const byte[] mapBytes5 = {
	128 + 27, 0, 23, 29, 0, 11, 10, 0, 
	60, 61, 0, 82, 81, 8, 48, 51, 
	8, 0, 0, 1, 23, 30, 30, 29, 
	0, 25, 62, 58, 62, 61, 0, 60, 
	62, 40, 62, 50, 0, 46, 54, 60, 
	62, 32, 0, 6, 10, 49, 60, 77, 
	4, 19, 80, 0, 46, 77, 41, 4, 
	0, 1, 23, 77, 77, 41, 4, 24, 
	62, 128 + 3, 77, 41, 47, 52, 77, 74, 
	77, 77, 42, 33, 77, 43, 77, 76, 
	72, 66, 77, 77, 76, 70, 0, 0, 
	76, 72, 65, 128 + 3, 0, 65, 128 + 5, 0, 
	128 + 6, 8, 128 + 9, 0, 5, 128 + 5, 8, 17, 
	23, 30, 128 + 3, 0, 12, 60, 62, 11, 
	10, 0, 14, 48, 53, 82, 80, 0, 
	12, 128 + 5, 0, 12, 0, 0, 128 + 3, 8, 
	17, 0, 0, 30, 28, 0, 13, 8, 
	8, 52, 50, 128 + 3, 0, 0, 
};
static const byte[] mapBytes6 = {
	128 + 25, 0, 23, 28, 128 + 4, 0, 59, 56, 
	5, 8, 8, 0, 44, 0, 12, 128 + 5, 
	0, 12, 0, 0, 8, 9, 8, 18, 
	8, 8, 0, 12, 0, 21, 128 + 3, 0, 
	12, 0, 59, 0, 26, 0, 12, 0, 
	44, 2, 77, 8, 17, 21, 0, 27, 
	77, 0, 12, 59, 0, 77, 77, 0, 
	12, 44, 2, 77, 77, 8, 17, 0, 
	27, 77, 77, 0, 12, 0, 75, 77, 
	77, 0, 12, 0, 64, 75, 77, 0, 
	12, 0, 0, 63, 66, 8, 18, 8, 
	8, 7, 0, 30, 29, 0, 21, 12, 
	0, 62, 62, 0, 62, 14, 8, 62, 
	62, 0, 59, 12, 0, 62, 62, 0, 
	44, 12, 0, 62, 61, 0, 0, 14, 
	8, 52, 50, 0, 0, 12, 0, 128 + 4, 
	33, 35, 33, 128 + 4, 66, 69, 66, 128 + 4, 
	8, 17, 23, 0, 21, 0, 0, 12, 
	60, 0, 59, 0, 20, 13, 48, 0, 
	44, 0, 44, 0, 0, 
};
static const byte[] mapBytes7 = {
	128 + 24, 0, 29, 128 + 3, 0, 6, 11, 61, 
	128 + 3, 0, 19, 82, 51, 8, 8, 7, 
	0, 0, 30, 29, 0, 12, 0, 0, 
	62, 62, 0, 14, 8, 8, 55, 62, 
	0, 12, 0, 0, 31, 62, 0, 14, 
	8, 8, 62, 62, 0, 12, 21, 0, 
	62, 61, 0, 12, 59, 0, 62, 56, 
	0, 13, 45, 8, 61, 128 + 5, 0, 50, 
	128 + 5, 0, 128 + 6, 33, 128 + 6, 66, 0, 5, 
	128 + 4, 8, 0, 12, 128 + 5, 0, 14, 128 + 5, 
	8, 17, 128 + 5, 0, 12, 0, 1, 23, 
	30, 8, 17, 0, 25, 62, 62, 0, 
	12, 0, 128 + 3, 62, 0, 12, 0, 62, 
	58, 62, 8, 17, 0, 60, 40, 62, 
	0, 12, 0, 49, 60, 62, 0, 12, 
	21, 3, 49, 62, 0, 12, 60, 37, 
	0, 60, 8, 18, 48, 51, 8, 48, 
	128 + 5, 0, 0, 
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
	{ 1, 0, 16 },
	{ -1, 0, 18 },
};

static const Route[] Route0B2 = {
	{ -1, 0, 4 },
	{ 0, 1, 24 },
};

static const Route[] Route0B3 = {
	{ -1, 0, 22 },
};

static const Route[] Route0B5 = {
	{ -1, 0, 12 },
	{ 1, 0, 15 },
};

static const Route[] Route0B0 = {
	{ 1, 0, 16 },
	{ 0, 1, 8 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements0 = {
	{ // B0
		1, 28,
		3,
		Route0B0
	},
	{ // A15
		9, 27,
		0,
		nullptr
	},
	{ // A14
		5, 26,
		0,
		nullptr
	},
	{ // B1
		1, 25,
		2,
		Route0B1
	},
	{ // A11
		1, 23,
		0,
		nullptr
	},
	{ // B2
		21, 23,
		2,
		Route0B2
	},
	{ // B3
		21, 21,
		1,
		Route0B3
	},
	{ // A9
		21, 20,
		0,
		nullptr
	},
	{ // A8
		9, 19,
		0,
		nullptr
	},
	{ // A7
		21, 18,
		0,
		nullptr
	},
	{ // A6
		9, 16,
		0,
		nullptr
	},
	{ // A5
		17, 11,
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
		21, 6,
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
	{ 1, 0, 15 },
};

static const Route[] Route1B4 = {
	{ 1, 0, 20 },
	{ 0, -1, 12 },
	{ -1, 0, 22 },
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
	{ 1, 0, 16 },
	{ -1, 0, 18 },
};

static const Route[] Route1B0 = {
	{ 0, 1, 8 },
	{ 1, 0, 23 },
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
	{ // A15
		17, 28,
		0,
		nullptr
	},
	{ // B2
		9, 25,
		3,
		Route1B2
	},
	{ // A12
		9, 24,
		0,
		nullptr
	},
	{ // B3
		9, 21,
		2,
		Route1B3
	},
	{ // A10
		21, 20,
		0,
		nullptr
	},
	{ // A8
		5, 19,
		0,
		nullptr
	},
	{ // A7
		17, 15,
		0,
		nullptr
	},
	{ // A6
		9, 14,
		0,
		nullptr
	},
	{ // A5
		5, 9,
		0,
		nullptr
	},
	{ // B4
		1, 8,
		3,
		Route1B4
	},
	{ // A4
		17, 7,
		0,
		nullptr
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
	{ 1, 0, 23 },
};

static const Route[] Route2B2 = {
	{ -1, 0, 8 },
	{ 0, -1, 20 },
	{ -1, 0, 6 },
};

static const Route[] Route2B3 = {
	{ -1, 0, 8 },
	{ 0, 1, 16 },
};

static const Route[] Route2B5 = {
	{ -1, 0, 16 },
	{ 0, 1, 12 },
	{ 1, 0, 19 },
};

static const Route[] Route2B0 = {
	{ -1, 0, 16 },
	{ 0, -1, 8 },
	{ -1, 0, 6 },
};

static const GroundElement[] GroundElements2 = {
	{ // B0
		21, 30,
		3,
		Route2B0
	},
	{ // A19
		17, 27,
		0,
		nullptr
	},
	{ // B2
		13, 24,
		3,
		Route2B2
	},
	{ // A18
		9, 23,
		0,
		nullptr
	},
	{ // B3
		13, 21,
		2,
		Route2B3
	},
	{ // A16
		13, 20,
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
		21, 5,
		3,
		Route2B5
	},
	{ // A3
		13, 3,
		0,
		nullptr
	},
	{ // A4
		21, 3,
		0,
		nullptr
	},
	{ // A1
		1, 2,
		0,
		nullptr
	},
	{ // A2
		21, 2,
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
};

static const Route[] Route3B4 = {
	{ -1, 0, 4 },
	{ 0, -1, 28 },
	{ -1, 0, 18 },
};

static const Route[] Route3B0 = {
	{ -1, 0, 16 },
	{ 0, -1, 20 },
	{ -1, 0, 6 },
};

static const Route[] Route3B2 = {
	{ 0, -1, 44 },
	{ 1, 0, 11 },
};

static const Route[] Route3B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 4 },
	{ 1, 0, 11 },
};

static const Route[] Route3B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 8 },
	{ 1, 0, 7 },
};

static const GroundElement[] GroundElements3 = {
	{ // A22
		5, 31,
		0,
		nullptr
	},
	{ // A23
		21, 31,
		0,
		nullptr
	},
	{ // B0
		21, 30,
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
		4,
		Route3B1
	},
	{ // A21
		9, 28,
		0,
		nullptr
	},
	{ // A20
		9, 25,
		0,
		nullptr
	},
	{ // A18
		21, 24,
		0,
		nullptr
	},
	{ // A16
		17, 22,
		0,
		nullptr
	},
	{ // B3
		1, 21,
		3,
		Route3B3
	},
	{ // A14
		9, 20,
		0,
		nullptr
	},
	{ // A13
		1, 19,
		0,
		nullptr
	},
	{ // A11
		5, 18,
		0,
		nullptr
	},
	{ // A10
		13, 14,
		0,
		nullptr
	},
	{ // B4
		21, 13,
		3,
		Route3B4
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
	{ // B5
		21, 10,
		3,
		Route3B5
	},
	{ // A7
		5, 9,
		0,
		nullptr
	},
	{ // A5
		13, 7,
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
		21, 2,
		0,
		nullptr
	},
};

static const Route[] Route4B1 = {
	{ 0, -1, 4 },
	{ 1, 0, 23 },
};

static const Route[] Route4B2 = {
	{ 1, 0, 15 },
};

static const Route[] Route4B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 12 },
	{ -1, 0, 14 },
};

static const Route[] Route4B0 = {
	{ -1, 0, 8 },
	{ 0, 1, 4 },
	{ -1, 0, 12 },
	{ 0, -1, 12 },
};

static const GroundElement[] GroundElements4 = {
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
	{ // A20
		9, 29,
		0,
		nullptr
	},
	{ // B0
		21, 29,
		4,
		Route4B0
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
	{ // A16
		13, 26,
		0,
		nullptr
	},
	{ // B1
		1, 25,
		2,
		Route4B1
	},
	{ // A14
		21, 22,
		0,
		nullptr
	},
	{ // B2
		9, 21,
		1,
		Route4B2
	},
	{ // A11
		1, 20,
		0,
		nullptr
	},
	{ // A12
		17, 20,
		0,
		nullptr
	},
	{ // A10
		13, 19,
		0,
		nullptr
	},
	{ // A8
		9, 15,
		0,
		nullptr
	},
	{ // A9
		13, 15,
		0,
		nullptr
	},
	{ // B3
		1, 8,
		3,
		Route4B3
	},
	{ // A7
		17, 8,
		0,
		nullptr
	},
	{ // A6
		9, 7,
		0,
		nullptr
	},
	{ // A5
		21, 6,
		0,
		nullptr
	},
	{ // A3
		1, 4,
		0,
		nullptr
	},
	{ // A2
		21, 3,
		0,
		nullptr
	},
	{ // A1
		1, 2,
		0,
		nullptr
	},
	{ // A0
		21, 1,
		0,
		nullptr
	},
};

static const Route[] Route5B1 = {
	{ -1, 0, 8 },
	{ 0, -1, 12 },
	{ 1, 0, 11 },
};

static const Route[] Route5B4 = {
	{ 1, 0, 23 },
};

static const Route[] Route5B0 = {
	{ -1, 0, 8 },
	{ 0, -1, 4 },
	{ -1, 0, 14 },
};

static const Route[] Route5B3 = {
	{ 1, 0, 12 },
	{ 0, 1, 28 },
};

static const Route[] Route5B5 = {
	{ 1, 0, 19 },
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
		21, 30,
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
		21, 26,
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
		17, 20,
		0,
		nullptr
	},
	{ // A13
		21, 19,
		0,
		nullptr
	},
	{ // A12
		17, 18,
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
		21, 3,
		0,
		nullptr
	},
	{ // A0
		1, 0,
		0,
		nullptr
	},
	{ // A1
		21, 0,
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
	{ -1, 0, 18 },
};

static const Route[] Route6B3 = {
	{ 1, 0, 4 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route6B5 = {
	{ -1, 0, 8 },
	{ 0, -1, 12 },
	{ 1, 0, 11 },
};

static const Route[] Route6B0 = {
	{ 1, 0, 16 },
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
		13, 29,
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
		21, 27,
		0,
		nullptr
	},
	{ // A17
		9, 24,
		0,
		nullptr
	},
	{ // B1
		21, 24,
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
		17, 19,
		1,
		Route6B2
	},
	{ // A13
		1, 18,
		0,
		nullptr
	},
	{ // A11
		13, 14,
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
		13, 11,
		0,
		nullptr
	},
	{ // A8
		1, 10,
		0,
		nullptr
	},
	{ // B5
		21, 8,
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
		21, 1,
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
	{ -1, 0, 16 },
	{ 0, 1, 28 },
};

static const Route[] Route7B7 = {
	{ -1, 0, 8 },
	{ 0, 1, 40 },
	{ 1, 0, 11 },
};

static const Route[] Route7B0 = {
	{ -1, 0, 22 },
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
	{ -1, 0, 8 },
	{ 0, -1, 12 },
	{ 1, 0, 11 },
};

static const Route[] Route7B5 = {
	{ -1, 0, 16 },
	{ 0, 1, 52 },
};

static const GroundElement[] GroundElements7 = {
	{ // A28
		1, 31,
		0,
		nullptr
	},
	{ // A29
		17, 31,
		0,
		nullptr
	},
	{ // B1
		1, 30,
		3,
		Route7B1
	},
	{ // B0
		21, 30,
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
		21, 20,
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
		21, 18,
		2,
		Route7B5
	},
	{ // A11
		5, 15,
		0,
		nullptr
	},
	{ // B6
		21, 13,
		3,
		Route7B6
	},
	{ // A10
		21, 11,
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
		21, 8,
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
		21, 5,
		0,
		nullptr
	},
	{ // A2
		17, 4,
		0,
		nullptr
	},
	{ // A0
		1, 3,
		0,
		nullptr
	},
	{ // A1
		21, 3,
		0,
		nullptr
	},
};


const Stage[] Stages = {
	{ // 0
		mapBytes0, // pBytes
		10,SkyElements0,
		17,GroundElements0,
	},
	{ // 1
		mapBytes1, // pBytes
		10,SkyElements1,
		16,GroundElements1,
	},
	{ // 2
		mapBytes2, // pBytes
		10,SkyElements2,
		21,GroundElements2,
	},
	{ // 3
		mapBytes3, // pBytes
		8,SkyElements3,
		24,GroundElements3,
	},
	{ // 4
		mapBytes4, // pBytes
		8,SkyElements4,
		23,GroundElements4,
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
