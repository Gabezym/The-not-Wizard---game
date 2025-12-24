if(inPause) exit;

if(inText) {
	
	var _viewWid = obj_camera.camWidth;
	var _viewHei = obj_camera.camHeight;

	var	_bx =_viewWid/2;
	var _by = _viewHei/5*4;

	draw_sprite_ext(spr_box_text, 1, _bx, _by, 9, 3, 0, c_white, 1);
	
	draw_set_font(font_small);
	
	draw_set_halign(fa_center);
	
	var _sep = font_get_size(font_small) + 10;
	var _w = sprite_get_width(spr_box_text) * 9 - 10;
	
	draw_text_ext_transformed(_bx, _by, text[indexText], _sep, _w, 1.2, 1.2, 0);
	
	draw_set_halign(-1);
	
	draw_set_font(-1);
}