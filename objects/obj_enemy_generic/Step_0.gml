// Ta no chao? Alarm[0]
inGround = place_meeting(x, y +1, obj_r_collision);

 // Checa se morreu 
if(isDead) { 
	
	fWithDeleteFire(self);
	instance_destroy();
}
else {

	// TEMPORARIO ---------------------//----
	if(isHit) {
	
		fEnemyGetDamage(self);
	
		var _idBlood = LIQUIDS_ID.BLOOD;
		var _angle = random_range(65, 125);
		fSpawnLiquid(x, y, _idBlood, 0.2, 4, _angle, 15);
	}

	// Morte TEMPORARIA ---------------------//----
	if (life<=0) isDead = true;
	// Morte TEMPORARIA ---------------------//----

	#region VVAL e HVAL

	// VVAL
	if (inGround) vval = vertMoveVal * jump*slow;	// Ve se ele ta pulando ou nao
	else vval += grav;								// Aplica a gravidade -> cai

	// HVAL
	hval = spd *sideMoveVal*slow;

	#endregion

	#region Colisão XY


	// Escada
	if (vertMoveVal != DIR.JUMP) {
	
		// Descer a escada
		if(place_meeting(x, y+spd*2, obj_collision_ladder)) {
			
			y = y div 1;
			
			while (!place_meeting(x, y+sign(spd), obj_collision_ladder)) {
		
				y+=sign(spd);
			}
		}
		// Subir escada
		if(place_meeting(x +hval, y+vval, obj_collision_ladder)) {
			
			y = y div 1;
			
			y-=spd;
		}
	}

	fEnemyColisionVH(self);

	fEnemyColisionEnemy(self);


	#endregion

	// ATUALIZA oq ta acontecendo com vval -> -1 pula.
	vertMoveVal = fEnemyActionVval(vval);

	fResetSlow(self);

	fWithSpawParticleFire(self);
}