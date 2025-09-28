var _viewWid = obj_camera.camWidth;
var _viewHei = obj_camera.camHeight;

#region Inventario
{
	#region Vars inventario
	
	// Sprites usados
	var _sprBa = inventorySprBackground;
	var _sprBo = inventorySprBorder;
	var _sprSe = inventorySprSelected;
	var _sprPl = inventorySprPlate;
	
	// Tamanho dos Sprites usados
	var _sprSize = sprite_get_width(inventorySprBackground);
	var _sprWidPl = sprite_get_width(_sprPl);
	var _sprHeidPl = sprite_get_height(_sprPl);
	
	
	// Posição X Y
	var _yLen = array_length(inventory);
	var _defaultX = _viewWid div 14 * 2;
	var _defaultY = _viewHei div 12;
	
	// Cordenadas Mouse
	var _mouseX = display_mouse_get_x();
	var _mouseY = display_mouse_get_y();
	
	
	// Slot atual no loop
	var _inSLot = 0;
	

	// Determina se é o inventario pequeno ou completo
	if(isInInventory) _yLen = array_length(inventory);
	else _yLen = 1;
	
	#endregion

	// Colunas 
	for(var _y = 0; _y < _yLen; _y++) {
	
		// Linhas
		for(var _x = 0; _x < array_length(inventory[_y]); _x++) {
			
			// Posição de cada sprite no loop
			var _xSpr	= (_defaultX + (_sprSize*_x));
			var _ySpr	= (_defaultY + (_sprSize*_y));
			
			#region Sprites inventario
			
			// Fundo dos slots
			draw_sprite(_sprBa, 1, _xSpr, _ySpr);
			// Borda dos slots 
			draw_sprite(_sprBo, 1, _xSpr, _ySpr);
			// Seleção do slot
			if(selectedSlot == _inSLot) {
			
				draw_sprite(_sprSe, 1, _xSpr, _ySpr);
			}
			
			#endregion
			
			#region Icone
			
			// Var pro Icone
			var _sprIcon = 0;
			
			// Icone no lugar padrão
			if((inventory[_y][_x].isFull) && (_inSLot != slotClick)) {
				
				 _sprIcon = fGetIconInventory(inventory[_y][_x]);
				
				draw_sprite(_sprIcon, 1, _xSpr, _ySpr);
			}
	
			// Se tiver uma struct pra ele (ta segurando o click)
			// Icone no Mouse
			if(slotStrClick != undefined) {
				
				_sprIcon = fGetIconInventory(slotStrClick);
				
				draw_sprite(_sprIcon, 1, _mouseX, _mouseY);
			}
			
			
			#endregion
			
			#region Plaquinha pro texto
			
			var _xpl = _xSpr;
			var _ypl = _ySpr + 5 + _sprHeidPl;
			
			draw_sprite(_sprPl, 1, _xpl, _ypl);
			
			draw_set_font(font_default);
			
			draw_set_halign(fa_center);
			
			draw_set_valign(fa_middle);
			
			var _strScl = 0.2;
			
			var _amoundId = inventory[_y][_x].itemId;
			var _maxAmont = obj_config.itemsData[_amoundId].maxAmount;
			var _strAmount = inventory[_y][_x].itemAmount;	
			var _string = string(_strAmount) + "/" + string(_maxAmont);
			
			draw_text_ext_transformed(_xpl, _ypl-5, _string, 5, _sprWidPl, _strScl, _strScl, 1);
			
			draw_set_valign(-1);
			
			draw_set_halign(-1);
			
			draw_set_font(-1);
			
			#endregion
			

			_inSLot++;	// Atualiza o slot atual
		}
	}
}
#endregion

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