if(inPause) exit;

var _viewWid = obj_camera.camWidth;
var _viewHei = obj_camera.camHeight;

if(isCrafting) {
	
	var _halfWid = sprite_get_width(spr_craftingUI_base) div 2;
	var _halfHei = sprite_get_height(spr_craftingUI_base) div 2;
	
	draw_sprite(spr_craftingUI_base, 1, craftVarDefX, craftVarDefY);
	draw_sprite(spr_inventory_border, 1, craftVarB1, craftVarDefY)
	draw_sprite(spr_inventory_border, 1, craftVarB2, craftVarDefY)
	draw_sprite(spr_inventory_border, 1, craftVarB3, craftVarDefY)
	
	draw_sprite(spr_craftingUI_done, 1, craftDoneVarDefX, craftDoneVarDefY);
	
	if(craftIndexItem1 != -1) {
	
		var _itemStr = fGetSlotInventory(inventory, craftIndexItem1);
		var _itemIcon = fGetIconInventory(_itemStr);
		
		draw_sprite(_itemIcon, 1, craftVarB1, craftVarDefY);
	}
	if(craftIndexItem2 != -1) {
	
		var _itemStr = fGetSlotInventory(inventory, craftIndexItem2);
		var _itemIcon = fGetIconInventory(_itemStr);
		
		draw_sprite(_itemIcon, 1, craftVarB2, craftVarDefY);
	}
}

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

if(fWithHasEffects(self) || slow < 1) {

	var _numPerLine = 3;	// Maximo de efeitos por linha	
	var _posLine = 0;		// Pra enumerar os efeitos	por linha
		
	var _xBegin = _UI_LifeXVal div 4;
	var _yBegin = _UI_LifeYVal * 4;
	
	var _heiEffectSpr = sprite_get_height(spr_background_effect);
	var _widEffectSpr = sprite_get_width(spr_background_effect);
	
	var _mx = display_mouse_get_x();
	var _my = display_mouse_get_y();
	
	var _drawTxt = false;
	var _xTxt = 0;
	var _yTxt = 0;
	var _txt = "";
	
	
	// Efeito do slow
	if(slow < 1) {
		
		draw_sprite_ext(spr_background_effect, 1, _xBegin, _yBegin, 1, 1, 0, c_white, 1);
		draw_sprite_ext(spr_effect_big_jump, 1, _xBegin, _yBegin, 1, 1, 0, c_white, 1);
		draw_sprite_ext(spr_border_effect, 1, _xBegin, _yBegin, 1, 1, 0, c_white, 1);
		draw_sprite_ext(spr_plate_effect, 1, _xBegin, _yBegin, 1, 1, 0, c_white, 1);
		
		var _xSlow = _xBegin;
		var _ySlow = _yBegin;

		var _font = font_small;
		
		#region Porcentagem de slow
		
		draw_set_font(_font);
			
		draw_set_halign(fa_center);
			
		draw_set_valign(fa_middle);
	
		var _percent = string(((1 - slow) / (1 - 0.4)) * 100 div 1) + "%";
	
		draw_text_ext_transformed(_xSlow, _ySlow+18, _percent, 15, 1000, 1, 1, 1);

		draw_set_valign(-1);
			
		draw_set_halign(-1);
			
		draw_set_font(-1);
		
		#endregion
		
		var _cx1 = _xBegin - _widEffectSpr/2;
		var _cx2 = _xBegin + _widEffectSpr/2;
		var _cy1 = _yBegin - _heiEffectSpr/2;
		var _cy2 = _yBegin + _heiEffectSpr/2;
		
		if(point_in_rectangle(_mx, _my, _cx1, _cy1, _cx2, _cy2)) {
			
				_drawTxt = true;
				_xTxt = _xBegin + 40;
				_yTxt = _yBegin;
				_txt = "Você esta lento.";
		}
		
		_posLine++;
	}

	// Efeitos
	for(var _i = 0; _i < global.lenAlarmEffects; _i++) {

		if(effectsAlarm[_i] > 0) {
			
			// Novas linhas de efeitos
			if((_posLine != 0) && (_posLine % _numPerLine == 0)) {
				
				_yBegin += _heiSpr*2;
				_posLine = 0;
				_numPerLine = 0;
			}

			var _xxx = _xBegin + (_widEffectSpr* _posLine);
			var _sprEffect = obj_config.infoEffects[_i].sprite;	
				
			draw_sprite_ext(spr_background_effect, 1, _xxx, _yBegin, 1, 1, 0, c_white, 1);
			draw_sprite_ext(_sprEffect, 1, _xxx, _yBegin, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_border_effect, 1, _xxx, _yBegin, 1, 1, 0, c_white, 1);
			
			// Duração
			var _yText = (_yBegin +(_heiEffectSpr/2) + 5);
			draw_text(_xxx-10, _yText, effectsAlarm[_i]);
			
			var _cx1 = _xxx - _widEffectSpr/2;
			var _cx2 = _xxx + _widEffectSpr/2;
			var _cy1 = _yBegin - _heiEffectSpr/2;
			var _cy2 = _yBegin + _heiEffectSpr/2;
		
			if(point_in_rectangle(_mx, _my, _cx1, _cy1, _cx2, _cy2)) {
			
				_drawTxt = true;
				_xTxt = _xxx + 40;
				_yTxt = _yBegin;
				_txt = obj_config.infoEffects[_i].description;
			}
			_posLine++;
		}
	}

	// Descrição
	if(_drawTxt) fDrawBoxText(_xTxt, _yTxt - 40, _txt, font_small);
}
}	
#endregion

// Teste Toxicidade
draw_text(_UI_LifeXVal *4.9, _UI_LifeYVal-15, "Level toxicidade: " + string(toxicityLevel));
draw_text(_UI_LifeXVal *5.1, _UI_LifeYVal, "Porcentagem toxicidade: " + string(toxicityValLevel));
}
#endregion
