// Shaders Dano
if(shadersDmgCheck) shader_set(shd_damage);

fDrawCharacterAndItems(self);

shader_reset();

if(inPause) exit;

#region Icone Interação

var _lenIA = array_length(interactionObjects);
if(_lenIA != 0) {
	
	if(instance_exists(interactionObjects[indexAI])) {
				
		var _intObj = interactionObjects[indexAI];
		
		// Só exibe icone se puder interagir
		if(_intObj.canInteract) {
		
			var _hei = sprite_get_height(_intObj.sprite_index);
			var _yy = _intObj.y;
		
			var _x = _intObj.x;
			var _y = _yy - (_hei div 2) - 35;
				
			var _spr = spr_key_E;
			
			
			draw_sprite_ext(_spr, 1, _x, _y, 0.5, 0.5, 0, c_white, 1);
		}
	}
}
	
#endregion

#region Throwing Bar

if(itemInHand != ITEMS_ID.NOTHING) {

	if(instanceInHands.isThrowing) {
	
		var _ins = instanceInHands;
		var _forceValMin = _ins.forceValMin;
		var _forceVal = _ins.forceVal - _forceValMin;
		var _forceValMax = _ins.forceValMax - _forceValMin;
	
		var _forcePercent = (_forceVal/ _forceValMax);
	
		var _spr = spr_throw_bar;
		var _widSpr = sprite_get_width(_spr);
		var _heiSpr = sprite_get_height(_spr);

		var _px2 = _widSpr * _forcePercent;
		var _py2 = _heiSpr;

		var _xx = x;
		var _yy = (y -_heiSpr);
		var _xxP = _xx - _widSpr/2;
		var _yyP = _yy - _heiSpr/2;
	
		draw_sprite_part(_spr, 1, 0, 0, _px2, _heiSpr, _xxP, _yyP);
		draw_sprite_ext(_spr, 1, _xx,  _yy, 1, 1, 0, c_white, 0.3);
	}
}



#endregion