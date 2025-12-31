if(inPause) exit;

// Vivo
if(life > 0) {
		
	var _colDown = place_meeting(x,y+1, obj_r_collision);

	var _isAlive = (life > 0);
	var _outOfCooldown = (alarm[alarmCooldownPick] <= 0);
	
	canInteract = (_isAlive && _outOfCooldown);

	#region Colisão XY + (x+=hval e y+=vval) + Grav

	// Se n tiver chao em baixo
	if(!_colDown) {

		vval += grav;
	
	}

	// Colisão Y + reset jumpVal +  reset isFirstjump
	if(place_meeting(x, y + vval, obj_r_collision)) {
	
		while (!place_meeting(x, y+sign(vval), obj_r_collision)) {
		
			y+=sign(vval);
		}
	
		if(vval > 2 || vval < -2) {
		
			vval = -vval * 0.55;
			hval *= 0.85;
		}
	
		else vval = 0;
	
		alarm[alarmCooldownPick] = 0;
	}

	y+=vval;

	// Colisao X
	if(place_meeting(x +hval, y, obj_r_collision)) {

		while(!place_meeting(x+sign(hval), y, obj_r_collision)) {
		
			x+=sign(hval);
		}
	
		hval = -hval * 0.75;
		sideAngl = -sideAngl;	// Inverte lado do giro
	
		alarm[alarmCooldownPick] = 0;
	}	

	x+=hval;

	#endregion

	// Alarme dano Fogo
	if(inFire) {
		
		if(alarm[2] <= 0) alarm[2] = cooldownFire;
		
		fWithSpawParticleFire(self, 1);
	}

	// Zera o hval
	if(hval != 0) {
	
		var _val = 0;
	
		if (hval > 1 || hval < -1) {
				
			hval -= sign(hval)/10;
		
			_val = (spdAngl * sideAngl); 
		
		}
		else {
		
			if(_colDown) {

				hval = lerp(0, hval, 0.50);
			}
			else {
		
				_val = (spdAngl * sideAngl * 0.7); 
			}
		}
	
		angl -= _val;
	}
	
	// Dano no item
	if(isHit) {
	
		// Fisica pra arremessar pra um lado
		_valHval = 5*side;
		_valVval = -3;
	
		hval = _valHval;
		vval = _valVval;
		sideAngl = sign(_valHval);	// Lado do giro
		spdAngl = 0.85 * abs(hval);	// Velocidade do giro
 
 
		// Dano
		life--;
		isHit = false;	
		side = 0;
	}
	
	fColletPickableItem(self, obj_wizard);
}

// Morte
else {

	var _isIngredient = (obj_config.itemsData[_id].type == ITEMS_TYPE.NO_ACTION);

	// Drop death por hit
	if(_isIngredient && !dropDeath) {
		
		var _noItem = ITEMS_ID.NOTHING;
		
		var _item = 0;
		var _amount = 0;
	
		// Morte por hit
		if(deathByFire == false) {
			
			_item = obj_config.itemsNoActionData[_id].spawnDeath.item;
			_amount = obj_config.itemsNoActionData[_id].spawnDeath.itemAmount;
		}		
		// Morte por fogo	
		else {
			
			_item = obj_config.itemsNoActionData[_id].spawnFireDeath.item;
			_amount = obj_config.itemsNoActionData[_id].spawnFireDeath.itemAmount;
		}
		
		if(_item != _noItem) {
	
			var _xSide = choose(-1, 1);
		
			for(var _i = 0; _i < _amount; _i++) {
			
				var _hval = random_range(3,5)*_xSide;
				var _vval = random_range(-3,-1);
			
				fSpawnItem(x, y-5, _item, 0.4, _hval, _vval, undefined, 1);
			
				_xSide*=-1;
			}
		}
	
		dropDeath = true;
	}
	
	canInteract = false;
	inFire = false;
	
	instance_destroy();
}