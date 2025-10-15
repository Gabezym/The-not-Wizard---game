// Effects
var _effectsTime = (myAlarmFire);

if(_effectsTime > 0) {
	
	// Efeito do fogo
	if(myAlarmFire > 0) {
	
		fWithFireDamage(self);
		myAlarmFire--;
	}
}

alarm[11] = CONSTANTS.SPD_GAME * 1;