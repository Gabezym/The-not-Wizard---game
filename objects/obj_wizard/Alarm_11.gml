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

	alarm[11] = CONSTANTS.SPD_GAME * 1;
}