var _isThrowing = obj_wizard.isInputItem;

if(liquidAmount > 0) {
	
	if(_isThrowing) { 
	
		fSpawnLiquidObject(liquidId, gravVal, spd, cooldownInput, self);
	
		liquidAmount -= 1;
		status.liquidAmount = liquidAmount;
		show_debug_message(liquidAmount);
	}
}

else {
	
	with(obj_wizard) {
		
		fGetUpdateInventory(inventory, clearSlot)
	}
}
