if(alarm[2] <= 0) {
	
	with(other){
	
		var _status = obj_config.liquidsData[other.liquidId];
		var _dmg = _status.damage;
		var _slow = _status.slow;
		var _outOfCooldown = (alarm[3] <= 0);
		var _areMoving = (hval != 0 || vval != 0);
		var _damegeForMoving = (_areMoving && (alarm[3] <= cooldownDamageLiquid/2));
		
		if(_outOfCooldown || _damegeForMoving ) {
		
			life-= _dmg;
		
			alarm[3] = cooldownDamageLiquid;
		}
		
		var _slowVal = _slow/50;
		var _canSlowMore = (slow - _slowVal > _slow);
		
		// Ta se mechendo no liquido
		if(_areMoving || _outOfCooldown) {
			
			if(_canSlowMore) slow -= _slowVal;
			else slow = _slow;
		}
	}
}	