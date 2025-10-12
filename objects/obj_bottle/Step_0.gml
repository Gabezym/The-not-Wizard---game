var _isThrowing = obj_wizard.isInputItem;

if(liquidAmount > 0) {
	
	if(_isThrowing) { 
	
		fSpawnLiquidObject(liquidId, gravVal, spd, cooldownInput, self);
	
		
	}
}

else {
	
	with(obj_wizard) {
		
		fGetUpdateInventory(inventory, clearSlot)
	}
}
