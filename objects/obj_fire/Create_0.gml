life = 1;
grav = -1.3;
dir = choose(-1, 1);
spd = (random_range(0, 0.4) * dir);
cooldownLife = CONSTANTS.SPD_GAME * 1;
alarm[0] = cooldownLife;

var _red = make_colour_rgb(127, 22, 0);
var _yellow = make_colour_rgb(240, 234, 0);

image_blend = merge_colour(_yellow, _red, random_range(0, 1));

image_alpha = random_range(0.3, 0.6);