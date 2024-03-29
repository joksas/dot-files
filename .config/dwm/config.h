/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx = 10;        /* border pixel of windows */
static const unsigned int gappx    = 15;        /* gap pixel between windows */
static const unsigned int snap     = 32;       /* snap pixel */
static const int showbar           = 1;        /* 0 means no bar */
static const int topbar            = 1;        /* 0 means bottom bar */
static const char *fonts[]         = {"IosevkaNerdFont:size=14", "FontAwesome6Brands:size=14:antialias:true", "FontAwesome6Free:size=14:antialias:true", "FontAwesome6Free:style=Solid:size=14:antialias:true"};
static const char dmenufont[]      = "IosevkaNerdFont:size=14";
static const char col_gray1[]      = "#222222";
static const char col_gray2[]      = "#444444";
static const char col_gray3[]      = "#bbbbbb";
static const char col_gray4[]      = "#eeeeee";
static const char col_cyan[]       = "#005577";
static const char col_blue[]       = "#0573e1";
static const char col_white[]      = "#ffffff";
static const char col_gray[]       = "#4d4d4d";
static const char col_dark_gray[]  = "#101010";
static const char *colors[][3]     = {
    /*               fg         bg         border   */
    [SchemeNorm]               = { col_white, col_dark_gray, col_gray },
    [SchemeSel]                = { col_dark_gray, col_white,  col_blue  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class                       instance    title       tags mask     switchtotag isfloating   monitor */
    {  "Gimp",                      NULL,       NULL,       0,           1,   0,          -1 },
    {  "Brave-browser",             NULL,       NULL,       1 << 0,      1,   0,        -1 },
    {  "Alacritty",               NULL,       NULL,       1 << 1,        1, 0,       -1 },
    {  "okular",                    NULL,       NULL,       1 << 2,      1,   0,      -1 },
    {  "zoom",                      NULL,       NULL,       1 << 8,      1,   0,     -1 },
    {  "Skype",                     NULL,       NULL,       1 << 8,      1,   0,    -1 },
    {  NULL,                        NULL,       "Signal",   1 << 4,      1,   0,   -1 },
    {  "Microsoft Teams - Preview", NULL,       NULL,       1 << 8,      1,   0,  -1 },
    {  "WxWabbitemu",               NULL,       NULL,       0,           1,   1, -1 },
};

/* layout(s) */
static const float mfact     = 0.6;  /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[T]",      tile },    /* first entry is default */
    { "[F]",      NULL },    /* no layout function means floating behavior */
    { "[M]",      monocle },
    { "|C|",      centeredmaster },
    { "<C>",      centeredfloatingmaster },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_dark_gray, "-nf", col_white, "-sb", col_white, "-sf", col_dark_gray, NULL };
static const char *termcmd[]  = { "alacritty", NULL };

static Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
    { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
    { MODKEY|ShiftMask,             XK_r,      spawn,          SHCMD("alacritty -e bash -i -c ranger") },
    { MODKEY|ShiftMask,             XK_b,      spawn,          SHCMD("brave") },
    { MODKEY|ShiftMask,             XK_x,      spawn,          SHCMD("dunstctl set-paused true && i3lock --color=ffffff --inside-color=ffffff --line-color=ffffff --separator-color=5F9EDC --ring-color=5F9EDC --keyhl-color=08498A --bshl-color=DB5461 --insidever-color=ffffff --ringver-color=ffffff --insidewrong-color=ffffff --ringwrong-color=DB5461 -n; dunstctl set-paused false") },
    { MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
    { MODKEY|ControlMask,                       XK_i,      incnmaster,     {.i = +1 } },
    { MODKEY|ControlMask,                       XK_d,      incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
    { MODKEY,                       XK_Return, zoom,           {0} },
    { MODKEY,                       XK_Tab,    view,           {0} },
    { MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
    { MODKEY|ControlMask,           XK_t,      setlayout,      {.v = &layouts[0]} },
    { MODKEY|ControlMask,           XK_f,      setlayout,      {.v = &layouts[1]} },
    { MODKEY|ControlMask,           XK_m,      setlayout,      {.v = &layouts[2]} },
    { MODKEY|ControlMask,           XK_u,      setlayout,      {.v = &layouts[3]} },
    { MODKEY|ControlMask,           XK_o,      setlayout,      {.v = &layouts[4]} },
    { MODKEY,                       XK_space,  setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
    { MODKEY,                       XK_s,      togglesticky,   {0} },
    { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
    { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
    { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
    { MODKEY,                       XK_u,      spawn,          SHCMD("udiskie-mount /dev/sdb1 && cd /run/media/dovydas && alacritty -e ranger") },
    { MODKEY|ShiftMask,             XK_u,      spawn,          SHCMD("udiskie-umount /dev/sdb1 && notify-send -t 3000 \"/dev/sdb1 unmounted\"") },
    { MODKEY,                       XK_Print,  spawn,          SHCMD("import png:- | xclip -selection clipboard -t image/png") },
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)
    TAGKEYS(                        XK_9,                      8)
    {
        MODKEY|ControlMask|ShiftMask,             XK_q,      quit,           {0}
    },
    { 0,                            XF86XK_AudioLowerVolume, spawn, SHCMD("amixer set Master 5%- && kill -44 $(pidof dwmblocks)") },
    { 0,                            XF86XK_AudioRaiseVolume, spawn, SHCMD("amixer set Master 5%+ && kill -44 $(pidof dwmblocks)") },
    { 0,                            XF86XK_AudioMute, spawn, SHCMD("amixer set Master toggle && kill -44 $(pidof dwmblocks)") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

