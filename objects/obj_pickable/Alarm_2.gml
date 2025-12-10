/// @description Dano fogo
if(inFire) {
	
	life--;
	if(life <= 0) deathByFire = true;
	alarm[2] = cooldownFire	
}