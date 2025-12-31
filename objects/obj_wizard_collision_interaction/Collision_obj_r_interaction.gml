if(inPause) exit;

var _id = other.id;
var _isPickable = ((object_is_ancestor(_id.object_index, obj_pickable)) || (_id.object_index == obj_pickable));
var _isAlive = true;
var _outOfCooldown = true;

if(_id.canInteract == false) exit;

with(character) {
	
	// Esta colidindo com o player
	_id.colliding = true; 
		
	var _alreadyStored = false;
	var	_arrLen = array_length(interactionObjects);
	var _indexAi = indexAI;
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
	var _haveNewIndex = (_indexCol != -1 && (_indexAi < _indexCol || _indexNotColliding == true && _indexCol != -1) && _indexAi != _indexCol);
	var _playerNotStop = (hval != 0 || vval != 0);
		
	if(_haveNewIndex && _playerNotStop) indexAI = _indexCol;

}	
	