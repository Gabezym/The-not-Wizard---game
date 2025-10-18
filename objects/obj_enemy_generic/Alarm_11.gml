// Effects

// Só os efeitos do inimigo
if(effectsAlarm[EFFECTS_ALARMS.ALARM_FIRE] > 0) {
	
	// Efeito do fogo
	if(effectsAlarm[EFFECTS_ALARMS.ALARM_FIRE] > 0) {
	
		fWithFireDamage(self);
		effectsAlarm[EFFECTS_ALARMS.ALARM_FIRE]--;
	}
}

alarm[11] = CONSTANTS.SPD_GAME * 1;