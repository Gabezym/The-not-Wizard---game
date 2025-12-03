// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region Efeitos 

// Aplica efeitos (alarme)
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
					slow = fResetSlow(self, true);
				break;
			
				case EFFCTS.BIG_JUMP:
			
					effectsAlarm[EFFECTS_ALARMS.ALARM_BIG_JUMP] = valMyAlarmEfBigJump;
					alarm[11] = CONSTANTS.SPD_GAME * 1;
				break;
				
				case EFFCTS.MORE_DAMAGE:
			
					effectsAlarm[EFFECTS_ALARMS.ALARM_MORE_DAMAGE] = valMyAlarmEfMoreDamage;
					alarm[11] = CONSTANTS.SPD_GAME * 1;
				break;
		}
	}
}

// Retorna se tem algum efeito (boolean) 
function fWithHasEffects(_instance) {

	with(_instance) {
		
		for(var _i = 0; _i < array_length(effectsAlarm); _i++) {
		
			if(effectsAlarm[_i] > 0) return true;
		}
		
		return false;
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

#region Efeito More Damage

// Use no create
function fWithCreateEfMoreDamage(_instance) {

	with(_instance) {
	
		valMyAlarmEfMoreDamage = 15;

		valEfMoreDamage = 3;
		efMoreDamage = 1;
	}
}

// Use no step
function fWithStepEfMoreDamage(_instance) {

	with(_instance) {
		
		// Efeito more damage
		if(effectsAlarm[EFFECTS_ALARMS.ALARM_MORE_DAMAGE] > 0) {

			efMoreDamage = valEfMoreDamage;
		} 
		else {

			efMoreDamage = 1;
		}
	}
}

#endregion

#endregion