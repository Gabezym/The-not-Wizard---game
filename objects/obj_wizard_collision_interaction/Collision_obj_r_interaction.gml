var _id = other.id;

with(character) {

	var _alreadyStored = false;
	var	_arrLen = array_length(interactionObjects);
	
	#region FILL BOTLE 
	
	var _is_fill_bottle = (_id.object_index == obj_fill_bottle_default);
	var _have_bottle_in_hand = (itemSelectedStruct.itemId == ITEMS_ID.EMPTY_BOTTLE);
	var _can_fill = (_is_fill_bottle && _have_bottle_in_hand);
	var _fill_bottle_check = (_can_fill || !_is_fill_bottle);
	
	#endregion
	
	// Se der pra interagir	
	if(_fill_bottle_check) {
		
		// Checa se ja armazenou esse objeto
		for(var _i = 0; _i < _arrLen; _i++) {
	
			if(interactionObjects[_i] == _id) _alreadyStored = true;
		}
	
	
		// Armazena ID de interação
		if(_alreadyStored = false)  {
		
			array_insert(interactionObjects, _arrLen, _id);
			indexAI = _arrLen;
		}
	}
}