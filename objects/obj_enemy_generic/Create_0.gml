// Geral 
lifeVal = 100;
life = lifeVal;

// Quase fixo
spd= 3;
jump = 20;	// Vai ser multiplicado pelo vertMoveVal
slow = 1;

grav = 1; 
hDisView = 12;
vDisView = 8;

#region Tempo

cooldownActions = irandom_range(5, 15) * CONSTANTS.SPD_GAME;
cooldownColisionObj = 2 *  CONSTANTS.SPD_GAME; // Tempo entre as açoes ao colidir com outro inimigo
cooldownViewPlayerNotView = 2 * CONSTANTS.SPD_GAME;// Tempo entre checagens se viu o player
cooldownViewPlayerInView = 1 * CONSTANTS.SPD_GAME;// Tempo entre checagens se viu o player
cooldownDamageLiquid = 0.75 * CONSTANTS.SPD_GAME;

#endregion 

// Armazena valores
hval = 0;
vval = 0;

sideMoveVal = choose(DIR.LEFT, DIR.RIGHT);	// Usado no hval e pra saber oq ta rolando
vertMoveVal = 0;							// Usado no pulo e pra saber oq ta rolando

// Alarms
alarm[0] = cooldownActions
alarm[2] = cooldownViewPlayerNotView;

// Bool
inGround = false;
isPlayerInView = false;
isHit = false;			// Se foi atingido
isDead = false;

// Struct 
hitStruct = {

	hitVal: 0
};