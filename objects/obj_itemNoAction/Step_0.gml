with(obj_wizard) {
	
	// Se clicou com o botao esquerdo, usa o item
	if(isInputPressedItem)	{
		
		isUpdateInvetory = true;
		newInventory = fUseItem(other.itemId, inventory, selectedSlot, obj_wizard);
		fWithSetNewInventory(self)
	}
	// Se clicou com o botao direito, joga o item
	if(isInputItem2) {
		
		isUpdateInvetory = true;
		newInventory = fThrowItem(inventory, selectedSlot, other.x, other.y);
		fWithSetNewInventory(self)
	}
}