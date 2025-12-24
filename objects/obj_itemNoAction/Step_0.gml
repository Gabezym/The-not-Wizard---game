if(inPause) exit;

with(obj_wizard) {
	
	
	var _canUse = obj_config.itemsNoActionData[other.itemId].canUse;
	
	// Se clicou com o botao esquerdo, usa o item
	if(isInputPressedItem && _canUse)	{
		
		isUpdateInvetory = true;
		newInventory = fUseItem(other.itemId, obj_wizard);
		fWithSetNewInventory(self)
	}
	// Se clicou com o botao direito, joga o item
	if(isInputItem2) {
		
		isUpdateInvetory = true;
		newInventory = fThrowItem(inventory, selectedSlot, other.x, other.y);
		fWithSetNewInventory(self)
	}
}