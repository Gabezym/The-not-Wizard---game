draw_self();

#region Barra de vida
 
var _sprLife = spr_enemy_life;
var _sprWid = sprite_get_width(_sprLife);
var _xLife =  x - (_sprWid div 2);
var _yLife = y - ((sprite_get_height(sprite_index)/ 4) * 3);
var _xscaleLife = life/lifeVal;

draw_sprite_ext(_sprLife, 1, _xLife, _yLife, _xscaleLife, 1, 0, -1, 1);

#endregion

var _wid = hDisView*CONSTANTS.GRID;
var _hei = vDisView*CONSTANTS.GRID;

fDrawHitBox(_wid, _hei, self);
