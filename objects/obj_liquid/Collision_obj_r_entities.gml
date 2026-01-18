if(inPause) exit;

if(death == 0 && alarm[2] <= 0) {
	
	fCollisionLiquid(2, self, other, 0, other.alarmLiquid);
	
	// Diminui tempo de vida
	var _decrease = decreaseLifeCooldown;
	if(other.object_index != obj_wizard) _decrease/=10;	// Diminui menos se for um inimigo
	
	var _time = alarm[0] - decreaseLifeCooldown;
	alarm[0] = (1 < _time ? _time :  1);
}