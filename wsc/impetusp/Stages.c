#include "Stage.h"
#include "Chars.h"

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
		10,SkyElements0,
		17,GroundElements0,
	},
	{ // 1
		10,SkyElements1,
		16,GroundElements1,
	},
	{ // 2
		10,SkyElements2,
		21,GroundElements2,
	},
	{ // 3
		8,SkyElements3,
		24,GroundElements3,
	},
	{ // 4
		8,SkyElements4,
		23,GroundElements4,
	},
	{ // 5
		8,SkyElements5,
		26,GroundElements5,
	},
	{ // 6
		8,SkyElements6,
		23,GroundElements6,
	},
	{ // 7
		0,SkyElements7,
		30,GroundElements7,
	},
};
