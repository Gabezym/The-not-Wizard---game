var _id = other.id;

with(character) {

	var _alreadyStored = false;
	var	_arrLen = array_length(interactionObjects);
	var _indexAi = indexAI;
	
	#region Cooldown Pickable
	
	var _noCooldown = true;
	var _isPickable = ((object_is_ancestor(_id.object_index, obj_pickable)) || (_id.object_index == obj_pickable));
	
	if(_isPickable) {
	
		var _noCooldownCheck = (_id.alarm[_id.alarmCooldownPick] <= 0);
		
		_noCooldown = _noCooldownCheck
	}
	
	#endregion
	
	#region FILL BOTLE 
	
	var _is_fill_bottle = (_id.object_index == obj_fill_bottle_default);
	var _have_bottle_in_hand = (itemSelectedStruct.itemId == ITEMS_ID.EMPTY_BOTTLE);
	var _can_fill = (_is_fill_bottle && _have_bottle_in_hand);
	var _fill_bottle_check = (_can_fill || !_is_fill_bottle);	
	
	#endregion
	
	// Se der pra interagir	
	if(_fill_bottle_check && _noCooldown) {
		
		var _indexCol = -1;
		var _indexNotColliding = false;
		
		// Checa se ja armazenou esse objeto
		for(var _i = 0; _i < _arrLen; _i++) {
		
			// Checa qual a ultima instancia que ta colidindo
			if(!place_empty(x, y, interactionObjects[_i])) {
				
				_indexCol = _i;
			}
			// Index n ta colidindo
			else if(_indexAi == _i) {
				
				_indexNotColliding = true;
			}

			if(interactionObjects[_i] == _id) {
				
				_alreadyStored = true;				
			}
		}
	
		// Armazena ID de interação
		if(_alreadyStored = false)  {
		
			array_insert(interactionObjects, _arrLen, _id);	
		}

		// Ta colidindo com o player, colidiu depois que os outros, ainda n é o index
		var _haveNewIndex = (_indexCol != -1 && (_indexAi < _indexCol || _indexNotColliding == true) && _indexAi != _indexCol);
		var _playerNotStop = (hval != 0 || vval != 0);
		
		if(_haveNewIndex && _playerNotStop) indexAI = _indexCol;
	}
}