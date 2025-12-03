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