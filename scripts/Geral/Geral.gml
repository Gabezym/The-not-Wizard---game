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
		var _y1 = y-halfHei;
		var _y2 = y+halfHei;
		
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
		
		if((slow != 1) && !(place_meeting(x, y, obj_r_liquid)) && ((hval != 0) || ( vval != 0))) {
			
			var _reductionSlow = 0.002;
			
			if (slow + _reductionSlow < 0.99) _slow += _reductionSlow;
			else _slow = 1;
		}
	}
	
	return _slow;
}

function fStuck(_instance) {

	with(_instance) {
		
		if(place_meeting(x,y, obj_r_collision)) {
	
			if(place_empty(x+spd, y, obj_r_collision)) x+= spd;
			else if (place_empty(x-spd, y, obj_r_collision)) x-= spd;
		}
	}
}

#region Efeitos 

// Aplica efeitos 
function fWithEffects(_instance, _effect) {

	with(_instance) {
	
		switch(_effect) {
		
				case EFFCTS.NOTHING: break;
				case EFFCTS.FIRE:
			
					effectsAlarm[EFFECTS_ALARMS.ALARM_FIRE] = valMyAlarmFire;
					alarm[11] = CONSTANTS.SPD_GAME * 1;
				
				break;
				case EFFCTS.WATER: 
				
					effectsAlarm[EFFECTS_ALARMS.ALARM_FIRE] = 0;
				break;
			
				case EFFCTS.BIG_JUMP:
			
					effectsAlarm[EFFECTS_ALARMS.ALARM_BIG_JUMP] = valMyAlarmEfBigJump;
					alarm[11] = CONSTANTS.SPD_GAME * 1;
				break;
		}
	}
}

// Retorna se tem algum efeito 
function fWithHasEffects(_instance) {

	with(_instance) {
		
		var _total = 0;
	
		for(var _i = 0; _i < array_length(effectsAlarm); _i++) {
		
			_total += effectsAlarm[_i] 
		}
		
		return _total;
	}
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

// No Alarme 11
function fWithFireDamage(_instance) {

	with(_instance) {
	
	
		life-=fireDamage;
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
		part_emitter_stream(partSystemFire, partEmitterFire, partTypeFire, 6*sign(effectsAlarm[EFFECTS_ALARMS.ALARM_FIRE])); 
	} 
}

// No Create
function fWithCreateFire(_instance){
	
	with(_instance) {

		cooldownFireDamage = CONSTANTS.SPD_GAME* 0.5;
		valMyAlarmFire = 5;

		fireDamage = 5;

		partSystemFire = 0;
		partTypeFire = 0;
		partEmitterFire = 0;

		fWithCreateParticleFire(self);
	}
}

function fWithDeleteFire(_instance) {

	with(_instance) {
	
		if (partSystemFire != noone) {
    
		    // Destroi o emissor
		    part_emitter_destroy(partSystemFire, partEmitterFire);
		    partEmitterFire = noone;
    
		    // Destroi o tipo
		    part_type_destroy(partTypeFire);
		    partTypeFire = noone;
    
		    // Destroi o sistema
		    part_system_destroy(partSystemFire);
		    partSystemFire = noone;
		}
	}
}

#endregion

#region Efeito Big Jump

// Use no create
function fWithCreateEfBigJump(_instance) {

	with(_instance) {
	
		valMyAlarmEfBigJump = 15;

		valEfBigJump = 1.3;
		efBigJump = 1;
	}
}
// Use no step
function fWithStepEfBigJump(_instance) {

	with(_instance) {
		
		// Efeito big jump
		if(effectsAlarm[EFFECTS_ALARMS.ALARM_BIG_JUMP] > 0) {

			efBigJump = valEfBigJump;
		} 
		else {

			efBigJump = 1;
		}
	}
}

#endregion

#endregion

// Intensidade 0: bottle liquid
// Intensidade 1: static liquid

function fCollisionLiquid(_alarmCooldown, _instanceCall, _instanceCol, _instensity) {

	with(_instanceCall) {
	
		if(alarm[_alarmCooldown] <= 0) {
	
			with(_instanceCol) {
				
				var cooldownDamageLiquid = CONSTANTS.SPD_GAME*0.15;
				
				var _status = obj_config.liquidsData[other.liquidId];
				var _dmg = _status.damage;
				var _slow = _status.slow;
				var _effect = _status.effect;
		
				var _outOfCooldown;
				if(_instensity == 0)	_outOfCooldown = (alarm[3] <= 0);
				else					_outOfCooldown = (alarm[3] <= CONSTANTS.SPD_GAME * 0.1);
				
				var _areMoving = (hval != 0 || vval != 0);
				var _damegeForMoving = (_areMoving && (alarm[3] <= cooldownDamageLiquid/2));
			
				// Damage + cooldown 
				if(_outOfCooldown || _damegeForMoving ) {
		
					life-= _dmg;

					alarm[3] = cooldownDamageLiquid;
				}
				
				var _slowVal = 0.02;	
				if(_instensity =! 0) _slowVal = 0.1;
		
				// Slow
				if(_areMoving || _outOfCooldown) {
			
					slow = lerp(slow, _slow, _slowVal);
			
					// Se chegou perto o suficiente, trava no valor exato
					if(abs(slow - _slow) < 0.01)  slow = _slow;
				}
			
				fWithEffects(self, _effect)
			}
		}	
	}
}

function fDrawBoxText(_x, _y, _text, _font) {
		
	var _sprWid = sprite_get_width(spr_plate_info);
	var _sprHei = sprite_get_height(spr_plate_info);			

				
	draw_set_font(_font);
	var _linesSize = font_get_size(_font) + 5;
				
	// mede o texto de verdade
	var _txt_w = string_width_ext(_text, _linesSize, 100) + 20;
	var _txt_h = string_height_ext(_text, _linesSize, 100)

	// define escala do sprite pra caber o texto
	var _valScl = 1.3;
	var _xScl = (_txt_w/ _sprWid) * _valScl;
	var _yScl = (_txt_h/ _sprHei);

	draw_sprite_ext(spr_plate_info, 1, _x-15, _y, _xScl, _yScl, 0, c_white, 0.8);

	draw_set_halign(fa_left);
				
	draw_set_valign(fa_top)
				
	draw_text_ext_transformed(_x, _y - (_txt_h/2), _text, _linesSize, 100, 1, 1, 0);

	draw_set_valign(-1);
			
	draw_set_halign(-1);
			
	draw_set_font(-1);
}