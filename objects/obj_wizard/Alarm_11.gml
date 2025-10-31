// Diminui alarmes e aplica efeitos por segundo
if(fWithHasEffects(self)) {
	
	// Efeito do fogo
	if(effectsAlarm[EFFECTS_ALARMS.ALARM_FIRE] > 0) {
	
		fWithFireDamage(self);
		effectsAlarm[EFFECTS_ALARMS.ALARM_FIRE]--;
	}
	
	// Efeito big jump
	if(effectsAlarm[EFFECTS_ALARMS.ALARM_BIG_JUMP] > 0) {
	
		effectsAlarm[EFFECTS_ALARMS.ALARM_BIG_JUMP]--;
	}

		// Efeito more damage
	if(effectsAlarm[EFFECTS_ALARMS.ALARM_MORE_DAMAGE] > 0) {
	
		effectsAlarm[EFFECTS_ALARMS.ALARM_MORE_DAMAGE]--;
	}

	alarm[11] = CONSTANTS.SPD_GAME * 1;
}