// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function fDebug(obj, varDebug) {
	
	if(instance_exists(obj)) {
		
		show_debug_message(varDebug);
	}
} 

// Retorna a negaçao da variavel se tiver input ou seu valor atual por padrao
function fInputOnOff(input, varToChange) {

	if(input) return !varToChange;

	return varToChange;
}

// Auto explicativo
function fDrawHitBox(halfWid, halfHei, instance) {


	with(instance) {
		
		var _x1 = x-halfWid;
		var _x2 = x+halfWid;
		var _y1 = y+halfHei;
		var _y2 = y-halfHei;
		
		draw_set_colour(c_red); 
		
		draw_rectangle(_x1, _y1, _x2, _y2, 1);
		
		draw_set_colour(-1); 
	}
}

// Checa se ta colidinodo com uma caixa de colisao
function fIsColliding(_posX, _posY, wid, hei, obj) {
	
	var val	= 5;
		
	var valHY = hei div 2;
	var valHX = wid div 2;
	
	var valIY = _posY-(valHY)-val;
	var valIX = _posX-(wid div 2)-val;

	var valFY = _posY+(valHY)+val;
	var valFX = _posX+(valHX)+val;

	return collision_rectangle(valIX, valIY, valFX, valFY, obj, 0, 1) != noone;
}

function fResetSlow(instance) {

	var _slow

	with(instance) {
		
		_slow = slow;
		
		if((slow != 1) && ((hval != 0) || ( vval != 0))) {

			if (slow + 0.005 < 1) _slow += 0.005;
			else _slow = 1;
		}
	}
	
	return _slow;
}
	
#region Fogo 

// Particula
function fWithCreateParticleFire(_instance) { 

	with(_instance) { 
		
		partSystemFire = part_system_create(); 
		partTypeFire = part_type_create(); 
		
		part_type_sprite(partTypeFire, spr_pixel, false, false, false);
		part_type_size(partTypeFire, 0.5, 1, -0.01, 0);
		
		
		var _col1 = make_colour_hsv(0, 200, 200); 
		var _col2 = make_colour_hsv(30, 200, 220); 
		var _col3 = make_colour_hsv(50, 180, 240);

		
		part_type_scale(partTypeFire, 1, 1.9); 
		
		part_type_direction(partTypeFire, 75, 105, 0, 0);
		part_type_speed(partTypeFire, 1.5, 2.5, 0, 0);
		
		part_type_color3(partTypeFire, _col1, _col2, _col3); 
		part_type_alpha1(partTypeFire, 0.4); 
	
		part_type_life(partTypeFire, 40, 60);
		
		partEmitterFire = part_emitter_create(partSystemFire); 
	} 
}

// No Alarme
function fWithFireDamage(_instance) {

	with(_instance) {
	
		// Fire damage
		if(timesFireDamage > 0) {
	
			life-=fireDamage;
	
	
			timesFireDamage --;
			alarm[alarmFire] = cooldownFireDamage;
		}
	}
}	
	
// No Step
function fWithSpawParticleFire(_instance) { 
	
	with(_instance) { 
		
		var _spr_wid = sprite_get_width(sprite_index);
		var _spr_hei = sprite_get_height(sprite_index);
		var _x1 = x - _spr_wid/2; var _x2 = x + _spr_wid/2; 
		var _y1 = y - _spr_hei/2; var _y2 = y + _spr_hei/2; 
		
		// Posição 
		part_emitter_region(partSystemFire, partEmitterFire, _x1, _x2, _y1, _y2, ps_shape_diamond, ps_distr_gaussian); 
		// Junta tudo 
		part_emitter_stream(partSystemFire, partEmitterFire, partTypeFire, 6*sign(timesFireDamage)); 
	} 
}

// No Create
function fWithCreateFire(_instance, _numAlarm){
	
	with(_instance) {

		cooldownFireDamage = CONSTANTS.SPD_GAME* 0.5;

		alarmFire = _numAlarm;

		valTimesFireDamage = 8;
		timesFireDamage = 0;

		fireDamage = 5;

		partSystemFire = 0;
		partTypeFire = 0;
		partEmitterFire = 0;

		fWithCreateParticleFire(self);
	}
}

#endregion