hval = valHval
vval = valVval;

death = 0;	// Se o tempo de vida acabou

colUp = false;
colDown = false;

fallingSlow = false;	// Se colidiu com o teto e ta caidno lent

var _str = obj_config.liquidsData[liquidId];

color		= _str.color;
scaleMax	= 1;
scale		= scaleMax / 3;
scaleVal	= 0.4;

sprite_index = spr_pixel;
mask_index = sprite_index;
alpha = 0.7;


cooldownScale = 0.1 * CONSTANTS.SPD_GAME;
cooldownEffect = 0.7 * CONSTANTS.SPD_GAME;
cooldownLife = 4 * CONSTANTS.SPD_GAME;
decreaseLifeCooldown = cooldownLife/10;

alarm[0] = cooldownLife;
alarm[1] = cooldownScale;
alarm[2] = cooldownEffect; 