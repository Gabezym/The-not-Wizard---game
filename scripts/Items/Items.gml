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
		
		var _xVal = x;
		var _yVal = y - 3;
		var _anglVal = 5;
		var _amount = obj_config.liquidsData[varLiquidId].amount;
		
		var _spdVal = varSpd;
		var _widColSpr = 3;
	
		for(var _i = 0; _i < _amount; _i++) {
			
			var _x = _xVal + random_range(-5, 5);
			var _y = _yVal + random_range(-5, 5);
			
			var _ang = obj_mouse.mouseAnglePlayer + _anglVal * (_i - (_amount - 1) / 2) + random_range(-_anglVal * 0.3, _anglVal * 0.3);

			var _spawnX = _x + lengthdir_x(5, _ang);
			var _spawnY = _y + lengthdir_y(5, _ang);
			
			var _structLiquid = {
	
				liquidId: varLiquidId,
				gravVal : varGravVal,
				grav : varGravVal,
	
				spd : varSpd,

				valHval	: cos(degtorad(_ang)) * varSpd,		// Valor usado
				valVval	: -sin(degtorad(_ang)) * varSpd		// Valor usado
	
		}
			
			if(!fIsColliding(x, y, _widColSpr, _widColSpr, obj_r_collision)) {
		
				instance_create_layer(_spawnX, _spawnY, "ScenarioFront", obj_liquid, _structLiquid)
				// Coldown entre Inputs
				obj_wizard.alarm[0] = cooldown;
				
				// Reduz o liquido na garrafa
				liquidAmount -= 1;
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
			
		if(!fIsColliding(x, y, _widColSpr, _widColSpr, obj_r_collision)) {
		
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
				
				// Cooldow e slow diferente por intensidade
				if(_instensity == 0) { 
					
					_outOfCooldown = (alarm[_alarmLiquid] <= 0);	// Cooldow maior
					_slowVal = 0.01;									// Mais lento o efeito se aplica
					_slow =  (1  - ((1 - _slow) / 1.4));			// Slow maximo menor 
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
			
				fWithEffects(self, _effect)
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
		}
	}
}

#endregion