var _colDown = place_meeting(x,y+1, obj_r_collision);

isNextToPlayer =  fIsColliding(x, y, colW, colH, obj_wizard);

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
}

y+=vval;

// Colisao X
if(place_meeting(x +hval, y, obj_r_collision)) {

	while(!place_meeting(x+sign(hval), y, obj_r_collision)) {
		
		x+=sign(hval);
	}
	
	hval = -hval * 0.75;
	valAngl = -valAngl;
}	

x+=hval;

#endregion

// Zera o hval
if(hval != 0) {
	
	var _val = 0;
	
	if (hval > 1 || hval < -1) {
				
		hval -= sign(hval)/10;
		
		_val = (spdAngl * (valAngl / _valHval));
		
	}
	else {
		
		if(_colDown) {

			hval = lerp(0, hval, 0.50);
		}
		else {
		
			_val = (spdAngl * (valAngl / _valHval));
		}
	}
	
	angl -= _val;
}



with(obj_wizard) {
	
	// Ta na colisão e interagiu
	if(other.isNextToPlayer && interact == 1) {
		
		show_debug_message("Interagiu")
		
		var _spaceInInventory = fHaveSpaceInInvetory(inventory, other._id, other.itemData.itemAmount)[0];
		var _newAmount = fHaveSpaceInInvetory(inventory, other._id, other.itemData.itemAmount)[1];
		var _noItemToPick = (array_length(toPick) == 0);
		
		// Tem espaço pro item
		if(_spaceInInventory == 1 && _noItemToPick) {
		
			// Adiciona as info desse objeto
			array_insert(toPick, array_length(toPick) , other.itemData);
			
			instance_destroy(other);
		}	
		// Tem espaço, mas n vai da pra colocar o amount iteiro
		else if(_spaceInInventory == 2) {
			
			var _itemCopy = {
			    isFull: other.itemData.isFull,
			    itemId: other.itemData.itemId,
			    itemStatus: other.itemData.itemStatus,
			    itemAmount: other.itemData.itemAmount - _newAmount // parte que vai pro inventário
			};
			
			array_insert(toPick, array_length(toPick), _itemCopy);
			
			show_debug_log(_newAmount);
			
			// Atualiza o objeto no chão com o que sobrou
			other.itemData.itemAmount = _newAmount;
			
		}
		else show_debug_message("Inventory full");
	}
}