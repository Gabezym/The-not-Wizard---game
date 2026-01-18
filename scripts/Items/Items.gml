#region Spawn things

// Checa se ta colidinodo com uma caixa de colisao(uso no spawn)
function fIsColliding(_posX, _posY, wid, hei, obj) {
	
	var valHY = hei div 2;
	var valHX = wid div 2;
	
	var valIY = _posY-(valHY);
	var valIX = _posX-(wid div 2);

	var valFY = _posY+(valHY);
	var valFX = _posX+(valHX);

	return collision_rectangle(valIX, valIY, valFX, valFY, obj, 0, 1) != noone;
}

// Spawna o objeto do ataque se tiver o input
function fSpawnAttackObject(xPlusAttack, valDamage) {

	with(obj_wizard) {

			var _valX = x+armXVal;
			var _valY = y+armYVal;
			var _angl = point_direction(_valX, _valY, mouse_x, mouse_y);
			
			var _x = _valX + lengthdir_x(disToHand + xPlusAttack, _angl);
			var _y = _valY + lengthdir_y(disToHand + xPlusAttack, _angl);
			
			var _side = (sign(xScale));
			
			var _struct = {

				damage: valDamage,
				angle: _angl,
				yscale: _side
			}

			var _id = instance_create_layer(_x, _y, "ScenarioFront", obj_attack, _struct);
	
			array_insert(followObjects, array_length(followObjects), _id);
	
			fWithChangeEstamina(self, estAttack);
			
			inAtackAnimation = true;
			
			alarm[0] = cooldownAtack;
		}
}

// Pro player lançar do bottle
function fSpawnLiquidObject(varLiquidId, varGravVal, varSpd, cooldown, instance) {
	
	with(instance) {
		
		var _angle = (obj_wizard.armAngle);
		var _side = (obj_wizard.xScale);
		var _distance = 6 * _side;
		var _xVal = (x+(2*_side) + lengthdir_x(_distance, _angle));
		var _yVal = (y + lengthdir_y(_distance, _angle));
		
		var _anglVal = 15;
		var _amount = obj_config.liquidsData[varLiquidId].amount;
		
		var _spdVal = varSpd;
		var _widColSpr = sprite_get_width(spr_pixel);
	
		for(var _i = 0; _i < _amount; _i++) {
			
			var _x = _xVal + random_range(-2, 4);
			var _y = _yVal+ random_range(-2, 2);
			
			var _incAngle = (_anglVal/_amount) * _i;
			var _randomInc = (random_range(-1.8, 1.8));
			
			var _ang = (obj_mouse.mouseAnglePlayer - _anglVal/2) + _incAngle + _randomInc;

			var _spawnX = _x;// + lengthdir_x(5, _ang);
			var _spawnY = _y;// + lengthdir_y(5, _ang);
			
			var _structLiquid = {
	
				liquidId: varLiquidId,
				gravVal : varGravVal,
				grav : varGravVal,
	
				spd : varSpd,

				valHval	: cos(degtorad(_ang)) * varSpd,		// Valor usado
				valVval	: -sin(degtorad(_ang)) * varSpd		// Valor usado
	
		}
			
			if(!fIsColliding(_spawnX, _spawnY, _widColSpr, _widColSpr, obj_r_collision)) {
		
				instance_create_layer(_spawnX, _spawnY, "ScenarioFront", obj_liquid, _structLiquid)
				// Coldown entre Inputs
				obj_wizard.alarm[0] = cooldown;
				
				// Reduz o liquido na garrafa
				liquidAmount -= _amount;
				status.liquidAmount = liquidAmount;
			}
		}
	}
}

// Generico
function fSpawnLiquid(_xVal, _yVal, varLiquidId, varGravVal, varSpd, varAngleTo, varAmount) {
			
	var _anglVal = 5;	
	var _amount = varAmount;
	var _spdVal = varSpd;
	var _widColSpr = 3;
	
	for(var _i = 0; _i < _amount; _i++) {
			
		var _x = _xVal + random_range(-5, 5);
		var _y = _yVal + random_range(-5, 5);
			
		var _ang = varAngleTo - (_anglVal*(_amount-1)) +_anglVal*_i;
		var _spd = lerp(_spdVal, _spdVal*2, abs(cos(degtorad(_ang))));	// N entendo de fisica.
		var _spawnX = _x + lengthdir_x(5, _ang);
		var _spawnY = _y + lengthdir_y(5, _ang);
			
		var _structLiquid = {
	
			liquidId: varLiquidId,
			gravVal : varGravVal,
			grav : varGravVal,
	
			spd : _spd,

			valHval	: cos(degtorad(_ang)) * _spd,		// Valor usado
			valVval	: -sin(degtorad(_ang)) * _spd * 1.4	// Valor usado
	
	}
			
		if(!fIsColliding(_spawnX, _spawnY, _widColSpr, _widColSpr, obj_r_collision)) {
		
			instance_create_layer(_spawnX, _spawnY, "ScenarioFront", obj_liquid, _structLiquid)
		}
	}
}

// -- Aprovado \[T]/
function fSpawnItem(_x, _y, idd, varGravVal, hval, vval, _status, _amount) {
	
	var _itemData = obj_config.itemsData[idd];
	var _sprr = _itemData.sprite;
	
	var _struct = {
	
		_id: idd,
		_gravVal : varGravVal,
		_grav : varGravVal,
		_spr: _sprr,
		_valHval	: hval,
		_valVval	: vval,
		status: _status,
		amount: _amount
	}
	
	var _widColSpr = sprite_get_width(_sprr);
	var _heiColSpr = sprite_get_height(_sprr);
		
	if(!fIsColliding(_x, _y, _widColSpr, _heiColSpr, obj_r_collision)) {
		
		instance_create_layer(_x, _y, "Objects", obj_pickable, _struct);
		return true;
	}
		
	return false
}


#endregion


#region Liquid

#region Generico

function fWithLiquidPhysicsAndCollisons(_instance) {

	with(_instance) {
	
		var _colDown = place_meeting(x,y+1, obj_r_collision);

		// Cai lento se bater no teto
		if(place_meeting(x,y-2, obj_r_collision) && colUp) {
	
			fallingSlow = true;
			grav = 0.01;
		}
		else if(fallingSlow) {
	
			grav = gravVal;
			vval = vval div 1;
			fallingSlow = false;
			colUp = false;
			scale = scaleMax;
		}

		#region Colisão + Grav

		// Se n tiver chao em baixo
		if(!_colDown) {

			vval += grav;
			colDown = false;
		}
		else {
	
			// Ativa o efeito do liquido ao cair no chão
			alarm[2] = 0;
		}

		// Colisão Y + reset jumpVal +  reset isFirstjump
		if(place_meeting(x, y + vval, obj_r_collision)) {
	
			var isColGround = sign(vval);
	
			if(isColGround > 0) y = round(y);
	
			while (!place_meeting(x, y+sign(vval), obj_r_collision)) {
		
				y+=sign(vval);
			}
	
			// Colidiu com o teto
			if(isColGround < 0) colUp = true;
			if(isColGround > 0) colDown = true;

			vval = 0;
		}

		y+=vval;

		// Colisao X
		if(place_meeting(x +hval, y, obj_r_collision)) {

			while(!place_meeting(x+sign(hval), y, obj_r_collision)) {
		
				x+=sign(hval);
			}
	
			hval = 0;
		}

		x+=hval;

		#region Colisão com liquido 

		var _other = instance_place(x, y, obj_liquid);
		var _isBlood = (_other != noone && _other.liquidId == LIQUIDS_ID.BLOOD)
		if (liquidId == LIQUIDS_ID.WATER && _isBlood) {
	
			var _id = _other.id;
			with(_id) death = true;
		}

		#endregion

		#endregion

		// Zera o hval
		if(hval != 0) {
	
			var _howFastStop = 0.99;	// O quao rapido ele chega para
			if(colDown || colUp) _howFastStop = 0.94;

			 hval = (hval <= 0.2 && hval >= -0.2 ? 0 : lerp(0, hval, _howFastStop));
		}
	
	
	}
}


#endregion

// Colisão de liquidos com characters
// Intensidade 0: bottle liquid
// Intensidade 1: static liquid
function fCollisionLiquid(_alarmCooldown, _instanceCall, _instanceCol, _instensity, _alarmLiquid) {

	with(_instanceCall) {
	
		if(alarm[_alarmCooldown] <= 0) {
	
			with(_instanceCol) {
				
				#region Vars

				var cooldownDamageLiquid = CONSTANTS.SPD_GAME*0.15;
				
				var _status = obj_config.liquidsData[other.liquidId];
				var _dmg = _status.damage;
				var _effect = _status.effect;
				
				var _slowVal = 0.3;			// O quao rapido fica lento
				var _outOfCooldown = false;
				var _slow = _status.slow;	// Slow padrão -> Maximo
				
				// Cooldow diferente por intensidade
				if(_instensity == 0) { 
					
					_outOfCooldown = (alarm[_alarmLiquid] <= 0);	// Cooldow maior
					_slowVal = 0.01;								// Mais lento o efeito se aplica
				}				
				else {
					
					_outOfCooldown = (alarm[_alarmLiquid] <= CONSTANTS.SPD_GAME * 0.1);	// Cooldown menor
				}
				
				var _areMoving = (hval != 0 || vval != 0);
				var _damegeForMoving = (_areMoving && (alarm[_alarmLiquid] <= cooldownDamageLiquid/2));
				var _slowForMovinh = (_areMoving && (alarm[_alarmLiquid] <= cooldownDamageLiquid/2));
				
				#endregion
				
				// Damage + cooldown 
				if(_outOfCooldown || _damegeForMoving ) {
		
					life-= _dmg;
					alarm[_alarmLiquid] = cooldownDamageLiquid;
					
					// Shake Screen
					if(_instanceCol.object_index == obj_wizard && _dmg > 0) {
						
						fShakeScreenPower(_instensity);
					}
				}
		
				// Slow
				if(_areMoving || _outOfCooldown) {
			
					slow = lerp(slow, _slow, _slowVal);
			
					// Se chegou perto o suficiente, trava no valor exato
					if(abs(slow - _slow) < 0.01)  slow = _slow;
				}
			
				fWithEffects(self, _effect);
			}
		}	
	}
}

function fFillBottle(_instance, _liquidId, _canInteract) {

		with(_instance) {
	
		if(_canInteract) {
			
			// Item
			var _status = {
				liquidId: _liquidId, 
				liquidAmount: obj_config.liquidsData[_liquidId].maxLiquidAmount
			};
			var _id = ITEMS_ID.BOTTLE;
			var _str = {

				isFull: true,
				itemId: _id,
				itemStatus: _status,
				itemAmount: 1
			}
			
			var _spaceInInventory = fHaveSpaceInInvetory(inventory, _id, 1)[0];
			var _newAmount = fHaveSpaceInInvetory(inventory, _id, 1)[1];
			
			var _noItemToPick = (array_length(toPick) == 0);
		
			// Tem espaço pro item ou tirando o bottle vai ter espaço
			if((_spaceInInventory == 1 && _noItemToPick) || (itemSelectedStruct.itemAmount == 1)) {
		
				// Remove bottle e adiciona objeto do bottle com liquido
				fRemoveOneItemSlotInventory(inventory, selectedSlot);
				array_insert(toPick, array_length(toPick), _str);
				
				isUpdateInvetory = true;
				fWithSetNewInventory(self);
			}	

			else show_debug_message("Inventory full");
		}
	
	}
} 

#endregion

#region Systems

// Sistema completo de jogar items
function fWithThrowItem(_instance) {

	with(_instance) {
	
		if(isThrowing) {
						
			// Force
			if(input2 && (forceVal < forceValMax)) {
				
				if(forceVal+incForceVal < forceValMax) {
		
					forceVal += incForceVal;
				}
				else forceVal = forceValMax
			}
			// Throw
			else {


				with(obj_wizard) {

					isUpdateInvetory = true;
					
					var _forceVal = other.forceVal;
					
					if(estamina <= 0) _forceVal /= 2;
					
					newInventory = fThrowItem(inventory, selectedSlot, other.x, other.y, _forceVal);
					
					fWithSetNewInventory(self);
				}
				
				forceVal = forceValMin;
				isThrowing = false;
			}
		}
		
		if(input2Pressed) {
			
			isThrowing = true;
			
			with(obj_wizard) inThrowingAnimation = true;
		}
	}
}

#endregion