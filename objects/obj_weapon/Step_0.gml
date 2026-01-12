// Inherit the parent event
event_inherited();

// Se clicou com o botao esquerdo, ataca com o item
if (input1Pressed) {
	
	var _haveStamina = (obj_wizard.estamina > 0);
	var _dmg = damage;
	
	if(_haveStamina == false) _dmg = damage/2;
	
	fSpawnAttackObject(xPlusAttack, _dmg);
}
