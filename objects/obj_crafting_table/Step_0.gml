canInteract = colliding;

if(interacted) {
	
	if(canInteract) {
		
		if(instance_exists(obj_wizard)) obj_wizard.isCrafting = true;
	}
	interacted = false;
}