// Se n ta no cooldown de dano
if(other.alarm[other.alarmDmg] <= 0) {
	
	var _dmg = damage;
	var _sign = 1;
	if(other.x < x) _sign = -1;

	with(other) {
	
		// Dano
		life -= _dmg;
	
		// Recoil do dano
		recoilXDmg = (other.spd*3 * _sign);
		recoilYDmg = (-other.jump/2);

		alarm[alarmDmg] = cooldownDamage;
	}
	}