if(inPause) exit;

#region Life

if(life > maxLife) life = maxLife;
else if(life <= 0) { 
	
	life = 0;
	isDead = true;
}

#endregion

#region xScale

var _haveItemInHands = (itemSelectedStruct != clearSlot);
xScale = fXscale(hval, xScaleVal, xScale, obj_mouse.mouseAnglePlayer, _haveItemInHands, stopCondition);



#endregion

#region Sprites

var _inGround = place_meeting(x,y+1, obj_r_collision);

// Sprites
var _strSprites = fChangeSprite(hval, inJumpAnimation, xScale, _inGround);

// Muda só se for diferente
var _sameSprites = ((sprite_body == _strSprites.body) && (sprite_index == _strSprites.leg) && (sprite_body == _strSprites.body));
if(_sameSprites == false) {
	
	sprite_index	= _strSprites.leg;
	sprite_body		= _strSprites.body;
	
	// começa do frame inicial
	image_index = 0;
	image_speed = 1;
}

#endregion

#region Shaders Damage 

// Se vai aplicar ou não
var _alarm = alarm[alarmDmg];	
if(_alarm <= 0) shadersDmgCheck = false; 
else {
		
	var _checkRest = (_alarm % shadersDmgCheckVal);	// Quantas vezes acontece
	var _durationHit = 5;	// Duração por frames
	
	var _isInRange = ((_checkRest == 0) || (_checkRest < _durationHit));
	if(_isInRange)	shadersDmgCheck = true;
	else			shadersDmgCheck = false;
} 

#endregion

// Colisão XY 
fWithCollisionPlayer(self);

// Built-in variables
image_xscale = xScale;
y+= vval;
x+= hval;

#region Arm draw


armX = x+armXVal;
armY = y+armYVal;

fWithArmAngle(self);

#endregion

// Reseta recoil do dano 
if(recoilXDmg != 0 || recoilYDmg != 0 ) fWithResetRecoilDmg(self);

// Organiza a array dos followObjects e suas posições
fWithFollowObjects(self);

// Organiza a array dos interactObjects
fWithInteractedObjects(self);
