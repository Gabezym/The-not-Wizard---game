hval = valHval
vval = valVval;

death = 0;	// Se o tempo de vida acabou
alarm[0] = 4 * CONSTANTS.SPD_GAME;	// Tempo de vida

colUp = false;
colDown = false;

fallingSlow = false;	// Se colidiu com o teto e ta caidno lent

var _str = obj_config.liquidsData[liquidId];

color		= _str.color;
scaleMax	= 1;
scale		= scaleMax / 5;
scaleVal	= 0.2;

sprite_index = spr_pixel;
mask_index = sprite_index;
alpha = 1;


cooldownScale = 0.1 * CONSTANTS.SPD_GAME;
cooldownEffect = 0.7 * CONSTANTS.SPD_GAME;

alarm[1] = cooldownScale;
alarm[2] = cooldownEffect; 