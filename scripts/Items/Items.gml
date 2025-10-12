#region Spawn

// Spawna o objeto do ataque se tiver o input
function fSpawnAttackObject(xPlusAttack, cooldown, valDamage) {

	with(obj_wizard) {

			var _scl = instanceInHands.image_xscale; 
			var _x = instanceInHands.x;
			var _y = instanceInHands.y;

			var _struct = {
	
				xScale: _scl,
				xPlus: xPlusAttack,
				damage: valDamage
			}

			var _id = instance_create_layer(_x, _y, layer, obj_attack, _struct);
	
			array_insert(followObjects, array_length(followObjects), _id);
	
			alarm[0] = cooldown;
		}
}

// Pro player lançar do bottle
function fSpawnLiquidObject(varLiquidId, varGravVal, varSpd, cooldown, instance) {
	
	with(instance) {
		
		var _xVal = x;
		var _yVal = y;
		var _anglVal = 5;
		var _amount = obj_config.liquidsData[varLiquidId].amount;
		
		var _spdVal = varSpd;
		var _widColSpr = 3;
	
		for(var _i = 0; _i < _amount; _i++) {
			
			var _x = _xVal + random_range(-5, 5);
			var _y = _yVal + random_range(-5, 5);
			
			var _ang = obj_mouse.mouseAnglePlayer - (_anglVal*(_amount-1)) +_anglVal*_i;
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
		
				instance_create_layer(_spawnX, _spawnY, layer, obj_liquid, _structLiquid)
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
		
			instance_create_layer(_spawnX, _spawnY, "Objects", obj_liquid, _structLiquid)
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
		_angl: choose(-15, -10, -5, 0, 5, 10, 15),
		_valHval	: hval,
		_valVval	: vval,
		status: _status,
		amount: _amount
	}
	
	var _widColSpr = sprite_get_width(_sprr)+5;
	var _heiColSpr = sprite_get_height(_sprr)+5;
		
	if(!fIsColliding(_x, _y, _widColSpr, _heiColSpr, obj_r_collision)) {
		
		instance_create_layer(_x, _y, "Scenario", obj_pickable, _struct);
		return true;
	}
		
	return false
}


#endregion

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