// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region Efeitos 

// Aplica duração do efeito
function fWithSetEffect(_instance, _ef) {

	with(_instance) {
		
		var _alarm = obj_config.effectsData[_ef].effectAlarm;
		var _duration = obj_config.effectsData[_ef].duration;
		
		effectsBoolean[_alarm] = true;
		effectsAlarm[_alarm] = _duration;
	}
}

// Aplica efeitos (alarme)
function fWithEffects(_instance, _effect) {

	with(_instance) {
		
		
		#macro PLAY_ALARM if(alarm[11] <= 0) alarm[11] = CONSTANTS.SPD_GAME * 1
				
		switch(_effect) {
		
				case EFFCTS.NOTHING: break;
				
				case EFFCTS.WATER: 
					
					fWithSetEffect(self, _effect);
					slow = fResetSlow(self, true);
				break;
				
				case EFFCTS.FIRE:
								
					fWithSetEffect(self, _effect);
					PLAY_ALARM;
				
				break;

				case EFFCTS.BIG_JUMP:
					
					fWithSetEffect(self, _effect);
					PLAY_ALARM;
				break;
				
				case EFFCTS.MORE_DAMAGE:
				
					fWithSetEffect(self, _effect);
					PLAY_ALARM;
				break;
		}
	}
}

// Retorna se tem algum efeito (boolean) 
function fWithHasEffects(_instance) {

	with(_instance) {
		
		for(var _i = 0; _i < array_length(effectsBoolean); _i++) {
		
			if(effectsBoolean[_i] == true) return true;
		}
		
		return false;
	}
}

#region Fogo 

// No Alarme 11
function fWithFireDamage(_instance) {

	with(_instance) {
	
		life-=fireDamage;
		
		// Shake no player
		if(_instance.object_index == obj_wizard) fShakeScreenPower(1);
	}
}	
	
// Particula
function fWithSpawParticleFire(_instance, _amount) { 
	
	with(_instance) { 
		
		var _spr_wid = sprite_get_width(sprite_index);
		var _spr_hei = sprite_get_height(sprite_index);
		var _x1 = x - _spr_wid/2; var _x2 = x + _spr_wid/2; 
		var _y1 = y - _spr_hei/2; var _y2 = y + _spr_hei/2; 
		
		for(var _i = 0; _i < _amount; _i++) {
		
			var _x = random_range(_x1, _x2);
			var _y = random_range(_y1, _y2);
			
			instance_create_layer(_x, _y, "Objects", obj_fire);
		}
	} 
}

// Use no Step 
function fWithStepEfFire(_intance) {

	with(_intance) {
	
		var _effect = EFFECTS_ALARMS.ALARM_FIRE;
		
		if(effectsAlarm[_effect] > 0) {

			// Particulas de fogo
			fWithSpawParticleFire(self, 4);
		} 
		else if(effectsBoolean[_effect] = true) {

			effectsBoolean[_effect] = false;
		}
	}
}

// No Create
function fWithCreateFire(_instance){
	
	with(_instance) {

		cooldownFireDamage = CONSTANTS.SPD_GAME* 0.5;

		fireDamage = 5;
	}
}

#endregion

#region Efeito Big Jump

// Use no create
function fWithCreateEfBigJump(_instance) {

	with(_instance) {
	
		valEfBigJump = 1.3;
		efBigJump = 1;
	}
}
// Use no step
function fWithStepEfBigJump(_instance) {

	with(_instance) {
		
		var _effect = EFFECTS_ALARMS.ALARM_BIG_JUMP;
		
		// Efeito big jump
		if(effectsAlarm[_effect] > 0) {

			efBigJump = valEfBigJump;
		} 
		else if(effectsBoolean[_effect] = true) {

			efBigJump = 1;
			effectsBoolean[_effect] = false;
		}
	}
}

#endregion

#region Efeito More Damage

// Use no create
function fWithCreateEfMoreDamage(_instance) {

	with(_instance) {
	
		valEfMoreDamage = 3;
		efMoreDamage = 1;
	}
}

// Use no step
function fWithStepEfMoreDamage(_instance) {

	with(_instance) {
		
		var _effect = EFFECTS_ALARMS.ALARM_MORE_DAMAGE;
		
		// Efeito more damage
		if(effectsAlarm[_effect] > 0) {

			efMoreDamage = valEfMoreDamage;
		} 
		else if(effectsBoolean[_effect] = true) {

			efMoreDamage = 1;
			effectsBoolean[_effect] = false;
		}
	}
}

#endregion

#endregion