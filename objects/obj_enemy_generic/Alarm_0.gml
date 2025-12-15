/// @description Intervalo pulos

// Se tiver no chao
if (inGround) {
	
	vertMoveVal = directions.jump;	// Ta pulando
	cooldownActions = irandom_range(3, 15) * CONSTANTS.SPD_GAME;	// Novo intervalo
}	

alarm[0] = cooldownActions	// Reseta o timer