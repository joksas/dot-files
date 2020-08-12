//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{" ", "volume-info",					0,		10},
	{"", "battery-info",					3600,		0},
	{"", "temperature-info",				60,		0},
	{"", "disk-info",					600,		0},
	{"", "date-info",					3600,		0},
	{"", "time-info",					1,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = '|';
