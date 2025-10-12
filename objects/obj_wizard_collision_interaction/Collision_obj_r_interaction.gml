var _id = other.id;

with(character) {

	var _alreadyStored = false;
	var	_arrLen = array_length(interactionObjects);
	
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