// Inherit the parent event
event_inherited();

if(liquidAmount > 0) {
		
	// Se clicou com o botao esquerdo, joga o liquido do item		
	if(input1) fSpawnLiquidObject(liquidId, gravVal, spd, cooldownInput, self);
		
	fWithThrowItem(self);
}
else {
	
	with(obj_wizard) fGetUpdateInventory(inventory, clearSlot);
}
