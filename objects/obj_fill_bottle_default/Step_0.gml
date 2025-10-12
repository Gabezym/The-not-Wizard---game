// Se pode interagir 
canInteract =
    instance_exists(obj_wizard)
    && colliding
    && obj_wizard.itemSelectedStruct.itemId == ITEMS_ID.EMPTY_BOTTLE;

if(interacted) {
	
	fFillBottle(obj_wizard, liquidId, canInteract);
	interacted = false;
}