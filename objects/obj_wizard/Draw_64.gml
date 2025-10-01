var _viewWid = obj_camera.camWidth;
var _viewHei = obj_camera.camHeight;

fDrawInventory(self);

#region UI Temporario
{
	
#region Life
	
var _UI_LifeXVal = _viewWid div 14; 
var _UI_LifeYVal = _viewHei div 12;

var _heiSpr = sprite_get_height(spr_UI_Life_Full);
var _widSpr = sprite_get_width(spr_UI_Life_Full);

var _lifePercent = (life / maxLife);
var _px2 = _widSpr;
var _py2 = _heiSpr * _lifePercent; // Altura proporcional à vida

var _py1 = (_heiSpr - _py2);
var _px1 = 0;


// Origem
var _draw_x = _UI_LifeXVal-(_widSpr/2);
var _draw_y = _UI_LifeYVal-(_heiSpr/2) + _py1;


draw_sprite_part(spr_UI_Life_Full, 1, _px1, _py1, _px2, _py2, _draw_x, _draw_y);
draw_sprite_ext(spr_UI_Life, 1, _UI_LifeXVal,  _UI_LifeYVal, 3, 3, 1, c_white, 1);

#endregion

#region Estamina

var _estaminaPercent = (estamina/ maxEstamina);

_widSpr = sprite_get_width(spr_UI_Estamina_Full);
_heiSpr = sprite_get_height(spr_UI_Estamina_Full);

_py1 = 0;
_px2 = _widSpr * _estaminaPercent;
_py2 = _heiSpr;

_draw_x = 2;
_draw_y = _UI_LifeYVal * 2.5;

var _draw_y_full = _draw_y-(_heiSpr/2);

draw_sprite_part(spr_UI_Estamina_Full, 1, _px1, _py1, _px2, _py2, _draw_x, _draw_y_full);
draw_sprite_ext(spr_UI_Estamina, 1, _draw_x,  _draw_y, 3, 3, 0, c_white, 1);

#endregion

#region STATUS
{
var _xSlow = _UI_LifeXVal div 4;
var _ySlow = _UI_LifeYVal * 4;
var _scl = 0.6;

draw_set_font(font_default);

draw_set_color(c_black);

draw_text_ext_transformed(_xSlow, _ySlow, "SLOW: " + string(slow*100) + "%", 15, 1000, _scl, _scl, 1);

draw_set_color(-1);

draw_set_font(-1);
}	
#endregion


}
#endregion
