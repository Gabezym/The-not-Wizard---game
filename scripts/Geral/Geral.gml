// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function fDebug(obj, varDebug) {
	
	if(instance_exists(obj)) {
		
		show_debug_message(varDebug);
	}
} 

// Retorna a negaçao da variavel se tiver input ou seu valor atual por padrao
function fInputOnOff(input, varToChange) {

	if(input) return !varToChange;

	return varToChange;
}

// Auto explicativo
function fDrawHitBox(halfWid, halfHei, instance) {


	with(instance) {
		
		var _x1 = x-halfWid;
		var _x2 = x+halfWid;
		var _y1 = y+halfHei;
		var _y2 = y-halfHei;
		
		draw_set_colour(c_red); 
		
		draw_rectangle(_x1, _y1, _x2, _y2, 1);
		
		draw_set_colour(-1); 
	}
}

// Checa se ta colidinodo com uma caixa de colisao
function fIsColliding(_posX, _posY, wid, hei, obj) {
	
	var val	= 5;
		
	var valHY = hei div 2;
	var valHX = wid div 2;
	
	var valIY = _posY-(valHY)-val;
	var valIX = _posX-(wid div 2)-val;

	var valFY = _posY+(valHY)+val;
	var valFX = _posX+(valHX)+val;

	return collision_rectangle(valIX, valIY, valFX, valFY, obj, 0, 1) != noone;
}

function fResetSlow(instance) {

	var _slow

	with(instance) {
		
		_slow = slow;
		
		if((slow != 1) && ((hval != 0) || ( vval != 0))) {

			if (slow + 0.005 < 1) _slow += 0.005;
			else _slow = 1;
		}
	}
	
	return _slow;
}