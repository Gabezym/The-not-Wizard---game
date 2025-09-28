// Status
// Life
if(life > maxLife) life = maxLife;
else if(life <= 0) { 
	
	life = 0;
	isDead = true;
}

// Muda a variavel da image_xscale
xScale = fXscale(hval, xScaleVal, xScale);

#region Sprites

var _inGround = place_meeting(x,y+1, obj_r_collision);

// O sprite q tem q ta
var _spriteState = fChangeSprite(hval, inJumpAnimation, xScale, _inGround, isInLadder);
// Muda só se for diferente
if(sprite_index != _spriteState) {
	
	sprite_index = _spriteState;
	image_index   = 0;       // começa do frame inicial
    image_speed   = 1;       // garante que vai animar
}

#endregion


// built-in variables
image_xscale = xScale;
y+=vval;
x+=hval;


// Organiza a array dos followObjects
fWithFollowObjects(self);