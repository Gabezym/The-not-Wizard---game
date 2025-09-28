var _struct = {

	hitVal: damage
};

var _id = other.id;
var _len = array_length(alreadyAttacked);
var _isAlreadyAttacked = false;

// Checa se ja foi atingido
for (var _i = 0; _i < _len; _i++) {
			
	if (alreadyAttacked[_i] == _id) {
		
		_isAlreadyAttacked = true;
		break;
	}
}

// Hit
if (_isAlreadyAttacked == false) {
	
	array_insert(alreadyAttacked, _len, _id);
	other.isHit = true;
	other.hitStruct = _struct;
}