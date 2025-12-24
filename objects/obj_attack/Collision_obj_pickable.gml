if(inPause) exit;

var _id = other.id;
var _len = array_length(alreadyAttacked);
var _isAlreadyAttacked = false;
var _side = 0;
var _outOfCooldown = (other.alarm[other.alarmCooldownDmg] <= 0);

if(_outOfCooldown) {

	if (instance_exists(obj_wizard)) {

		if(obj_wizard.x < _id.x)	_side = 1;
		else						_side = -1;
	}

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
		other.side = _side;
	}
}