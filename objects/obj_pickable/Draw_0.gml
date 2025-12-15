//fDrawHitBox(colW/2, colH/2, self);

if(life > 0) {
	
	draw_sprite_ext(spr, 1, x, y, scale, 1, angl, c_white, 1);

	// Amount
	if(colliding) {

		draw_set_font(font_small);

		draw_set_halign(fa_center);

		var _x = x - 5;
		var _y = y - (sprite_get_height(spr)/2) - 15;

		draw_text_ext_transformed(_x, _y, itemData.itemAmount, 20, 100, 1, 1, 1);

		draw_set_halign(-1);

		draw_set_font(-1);
	}
}