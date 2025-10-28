var _isUsing = obj_wizard.isInputItem;
var _isThrowing = obj_wizard.isInputItem2;

if(liquidAmount > 0) {
		
	// Se clicou com o botao esquerdo, joga o liquido do item		
	if(_isUsing) { 
	
		fSpawnLiquidObject(liquidId, gravVal, spd, cooldownInput, self);
	}
		
	// Se clicou com o botao direito, joga o item
	if(_isThrowing) {
		
		with(obj_wizard) {
			
			isUpdateInvetory = true;
			newInventory = fThrowItem(inventory, selectedSlot, other.x, other.y);
			fWithSetNewInventory(self)
		}
	}
}

else {
	
	with(obj_wizard) {
		
		fGetUpdateInventory(inventory, clearSlot)
	}
}
