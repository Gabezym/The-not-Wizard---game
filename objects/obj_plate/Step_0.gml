var _inGround = true;
// Se o player esta no chao
if(instance_exists(obj_wizard)) with(obj_wizard) _inGround = place_meeting(x, y +1, obj_r_collision);


canInteract = colliding && _inGround;

if(interacted) {
	
	instance_create_layer(x, y, layer, obj_text, str);
	interacted = false;
}