var _isAttacking = obj_wizard.isInputItem;
var _haveStamina = (obj_wizard.estamina >= estaminaDrain);
var _isThrowing = obj_wizard.isInputItem2;

// Se clicou com o botao esquerdo, ataca com o item
if (_isAttacking ) {
	
	if(_haveStamina) {
		
		fSpawnAttackObject(xPlusAttack, cooldownInput, damage * obj_wizard.efMoreDamage);
		obj_wizard.estamina-=estaminaDrain;
	}
	else {
	
		fSpawnAttackObject(xPlusAttack, cooldownInput, damage / 2);
		obj_wizard.estamina=0;
	}
	obj_wizard.alarm[4] = obj_wizard.cooldownEstamina;
}
	
// Se clicou com o botao direito, joga o item
/*if(_isThrowing) {
		
		with(obj_wizard) {
			
			isUpdateInvetory = true;
			newInventory = fThrowItem(inventory, selectedSlot, other.x, other.y);
			fWithSetNewInventory(self)
		}
	}	