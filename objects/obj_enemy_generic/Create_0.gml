// Geral 
lifeVal = 100;
life = lifeVal;
spd= 3;
jump = 15;
damage = 20;


slow = 1;

grav = 0.6; 
hDisView = 12;
vDisView = 8;

#region Tempo

cooldownActions = irandom_range(5, 15) * CONSTANTS.SPD_GAME;
cooldownColisionObj = 2 *  CONSTANTS.SPD_GAME;		// Tempo entre as açoes ao colidir com outro inimigo
cooldownViewPlayerNotView = 2 * CONSTANTS.SPD_GAME;	// Tempo entre checagens se viu o player
cooldownViewPlayerInView = 1 * CONSTANTS.SPD_GAME;	// Tempo entre checagens se viu o player

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

// Effects Vars
effectsAlarm = array_create(global.lenAlarmEffects, 0); // N usara todos os efeitos
	
fWithCreateFire(self);