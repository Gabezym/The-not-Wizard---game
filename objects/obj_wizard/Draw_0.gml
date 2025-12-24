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