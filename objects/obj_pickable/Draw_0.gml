draw_sprite_ext(spr, 1, x, y, 1, 1, angl, c_white, 1);

fDrawHitBox(colW, colH, self);

// Amount
if(isNextToPlayer) {

	draw_set_font(font_default);

	draw_set_halign(fa_center);

	draw_set_color(c_black);

	var _x = x - 5;
	var _y = y - (sprite_get_height(spr)) - 15;
	var _scl = 0.4;

	draw_text_ext_transformed(_x, _y, itemData.itemAmount, 20, 100, _scl, _scl, 1);

	draw_set_color(-1);

	draw_set_halign(fa_center);

	draw_set_font(-1);
}