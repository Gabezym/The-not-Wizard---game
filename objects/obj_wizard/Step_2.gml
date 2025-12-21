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

// O sprite q tem q ta
var _spriteState = fChangeSprite(hval, inJumpAnimation, xScale, _inGround);
// Muda só se for diferente
if(sprite_index != _spriteState) {
	
	sprite_index = _spriteState;
	image_index   = 0;       // começa do frame inicial
    image_speed   = 1;       // garante que vai animar
}

#endregion

#region Shaders Damage 

// Se vai aplicar ou não
var _alarm = alarm[alarmDmg];	
if(_alarm <= 0) shadersDmgCheck = false; 
else {
		
	var _checkRest = (_alarm % shadersDmgCheckVal);
	var _durationHit = 5;
	var _isInRange = ((_checkRest == 0) || (_checkRest < _durationHit));
	
	if(_isInRange)	shadersDmgCheck = true;
	else			shadersDmgCheck = false;
} 

#endregion

// Colisão XY 
fWithCollisionPlayer(self);

// Built-in variables
image_xscale = xScale;
y+= vval + recoilYDmg;
x+= hval + recoilXDmg;

// Reseta recoil do dano 
if(recoilXDmg != 0 || recoilYDmg != 0 ) fWithResetRecoilDmg(self);

// Organiza a array dos followObjects e suas posições
fWithFollowObjects(self);

// Organiza a array dos interactObjects
fWithInteractedObjects(self);

