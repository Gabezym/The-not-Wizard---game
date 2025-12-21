// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

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
		var _y1 = y-halfHei;
		var _y2 = y+halfHei;
		
		draw_set_colour(c_red); 
		
		draw_rectangle(_x1, _y1, _x2, _y2, 1);
		
		draw_set_colour(-1); 
	}
}

function fResetSlow(instance, inWater) {

	var _slow

	with(instance) {
		
		_slow = slow;
		
		var _inWaterOrNoLiquid = (!(place_meeting(x, y, obj_r_liquid) || inWater));
		
		if((slow != 1) && (_inWaterOrNoLiquid) && ((hval != 0) || ( vval != 0))) {
			
			var _reductionSlow = 0.002;
			
			if (slow + _reductionSlow < 0.99) _slow += _reductionSlow;
			else _slow = 1;
		}
	}
	
	return _slow;
}
	
function fStuck(_instance) {

	with(_instance) {
		
		if(place_meeting(x,y, obj_r_collision)) {
	
			if(place_empty(x+spd, y, obj_r_collision)) x+= spd;
			else if (place_empty(x-spd, y, obj_r_collision)) x-= spd;
		}
	}
}

function fDrawBoxText(_x, _y, _text, _font) {
		
	var _sprWid = sprite_get_width(spr_plate_info);
	var _sprHei = sprite_get_height(spr_plate_info);			

				
	draw_set_font(_font);
	var _linesSize = font_get_size(_font) + 5;
				
	// mede o texto de verdade
	var _txt_w = string_width_ext(_text, _linesSize, 100) + 20;
	var _txt_h = string_height_ext(_text, _linesSize, 100)

	// define escala do sprite pra caber o texto
	var _valScl = 1.3;
	var _xScl = (_txt_w/ _sprWid) * _valScl;
	var _yScl = (_txt_h/ _sprHei);

	draw_sprite_ext(spr_plate_info, 1, _x-15, _y, _xScl, _yScl, 0, c_white, 0.8);

	draw_set_halign(fa_left);
				
	draw_set_valign(fa_top)
				
	draw_text_ext_transformed(_x, _y - (_txt_h/2), _text, _linesSize, 100, 1, 1, 0);

	draw_set_valign(-1);
			
	draw_set_halign(-1);
			
	draw_set_font(-1);
}

#region Camera

#region Encurtar

// Aplica o zoom na camera
function fWithCameraZoom(_instance) {

	with(_instance) {
	
		// Pega tamanho atual
		viewWidth	= camera_get_view_width(view_camera[view]);
		viewHeight	= camera_get_view_height(view_camera[view]);

		// Calcula tamanho desejado pela escala
		var desired_width = camWidth / zoomVal;
		var desired_height = camHeight / zoomVal;

		// Interpola para suavizar
		var _valWid = (lerp(viewWidth, desired_width, zoomSpd));
		var _valHei = (lerp(viewHeight, desired_height, zoomSpd));
			
		// Check se o tamanho da view não é maior que a room
		// View X
		if(_valWid < room_width)	viewWidth	= _valWid;
		else						viewWidth = room_width;
		
		// View Y
		if(_valHei < room_height)	viewHeight	= _valHei;
		else						viewHeight = room_height;
		viewHeight	= _valHei;
	}
}

// Define novo valor pra mover a camera
function fWithCameraMove(_instance) {

	with(_instance) {
	
		// O que a camera deve seguir
		if(follow != noone) {

			xTo = follow.x;
			yTo = follow.y;
		}
	
		newX = (lerp(x, xTo, 0.15));
		newY = (lerp(y, yTo, 0.15));

		var _xGreater = (room_width < newX + viewWidth*0.5);
		var _xLess = (0 > newX - viewWidth*0.5);

		var _yGreater = (room_height < newY + viewHeight*0.5);
		var _yLess = (0 > newY - viewHeight * 0.5);

		// Limites camera X
		if(_xGreater ||_xLess) {
	
			var _xGreaterVal = (room_width - (viewWidth*0.5));
			var _xLessVal = (viewWidth*0.5);
	
			if(_xGreater)	newX = _xGreaterVal;
			else			newX = _xLessVal;
		}
		// Limites camera Y
		if(_yGreater || _yLess) {
	
	
			var _yGreaterVal	= (room_height - (viewHeight * 0.5));
			var _yLessVal		= (0 + viewHeight * 0.5);	
	
			if(_yGreater)	newY = _yGreaterVal;
			else			newY = _yLessVal;
		}
	}
}

// Executa shake Screen 
function fWithShakeScreen(_instance) {

	with(_instance) {
	
		// Shake Screen
		if(shakeVal != 0) {
	
			xView = irandom_range(-shakeVal, shakeVal);
			yView = irandom_range(-shakeVal, shakeVal);
	
			shakeVal = lerp(shakeVal, 0, 0.05);
		}
		else if(xView != 0 || yView != 0) {

			xView = 0;
			yView = 0;
		}
	}
}

#endregion

// Power Shake Screen -> Aplica na camera
// 0 = shakeRealySmall
// 1 = Small
// 2 = Medium
// 3 = Heavy
function fShakeScreenPower(_power) {

	with(obj_camera) {
	
		var aPower = [shakeRealySmall, shakeSmall, shakeMedium, shakeHeavy];
		
		shakeVal = aPower[_power];
	}
}

#endregion