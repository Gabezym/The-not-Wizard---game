if(inPause) exit;

// Se n ta no cooldown de dano
if(other.alarm[other.alarmDmg] <= 0) {
	
	var _dmg = damage;
	var _sign = 1;
	if(other.x < x) _sign = -1;

	fWithPlayerDmg(other, _dmg, _sign);
}