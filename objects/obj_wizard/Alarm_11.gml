// Effects
var _effectsTime = (myAlarmFire + myAlarmEfBigJump);

if(_effectsTime > 0) {
	
	// Efeito do fogo
	if(myAlarmFire > 0) {
	
		fWithFireDamage(self);
		myAlarmFire--;
	}
	
	// Efeito big jump
	if(myAlarmEfBigJump > 0) {
	
		myAlarmEfBigJump--;
	}

	alarm[11] = CONSTANTS.SPD_GAME * 1;
}