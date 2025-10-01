if(alarm[2] <= 0) {
	
	with(other){
	
		var _status = obj_config.liquidsData[other.liquidId];
		var _dmg = _status.damage;
		var _slow = _status.slow;
		var _effect = _status.effect;
		
		var _outOfCooldown = (alarm[3] <= 0);
		var _areMoving = (hval != 0 || vval != 0);
		var _damegeForMoving = (_areMoving && (alarm[3] <= cooldownDamageLiquid/2));
		
		// Damage
		if(_outOfCooldown || _damegeForMoving ) {
		
			life-= _dmg;
		
			alarm[3] = cooldownDamageLiquid;
		}
		
		var _slowVal = 0.02;
		
		// Slow
		if(_areMoving || _outOfCooldown) {
			
			slow = lerp(slow, _slow, _slowVal);
			
			// Se chegou perto o suficiente, trava no valor exato
			if(abs(slow - _slow) < 0.01)  slow = _slow;
		    
		}
		
		
		switch(_effect) {
		
			case EFFCTS.NOTHING: break;
			case EFFCTS.FIRE:
			
				alarm[alarmFire] = cooldownFireDamage;
				timesFireDamage = valTimesFireDamage;
				
			break;
			case EFFCTS.WATER: 
				
				timesFireDamage = 0;
			break;
		}
	}
}	