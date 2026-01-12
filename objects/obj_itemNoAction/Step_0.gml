// Inherit the parent event
event_inherited();
	

	
// Se clicou com o botao esquerdo, usa o item
var _canUse = obj_config.itemsNoActionData[other.itemId].canUse;
if(input1Pressed && _canUse)	{
	
	with(obj_wizard) {
		
		isUpdateInvetory = true;
		newInventory = fUseItem(other.itemId, obj_wizard);
		fWithSetNewInventory(self);
	}
}
	
fWithThrowItem(self);