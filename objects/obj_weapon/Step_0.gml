var _isAttacking = obj_wizard.isInputItem;
var _haveStamina = (obj_wizard.estamina >= estaminaDrain);

if (_isAttacking ) {
	
	if(_haveStamina) {
		
		fSpawnAttackObject(xPlusAttack, cooldownInput, damage);
		obj_wizard.estamina-=estaminaDrain;
	}
	else {
	
		fSpawnAttackObject(xPlusAttack, cooldownInput, damage / 2);
		obj_wizard.estamina=0;
	}
	obj_wizard.alarm[4] = obj_wizard.cooldownEstamina;
}