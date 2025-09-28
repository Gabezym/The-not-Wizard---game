var _colDown = place_meeting(x,y+1, obj_r_collision);

// Cai lento se bater no teto
if(place_meeting(x,y-6, obj_r_collision) && colUp) {
	
	fallingSlow = true;
	grav = 0.01;
}
else if(fallingSlow) {
	
	grav = gravVal;
	vval = vval div 1;
	fallingSlow = false;
	colUp = false;
	scale = scaleMax;
}

#region Colisão XY + (x+=hval e y+=vval) + Grav

// Se n tiver chao em baixo
if(!_colDown) {

	vval += grav;
	colDown = false;
}
else {
	
	// Ativa o efeito do liquido ao cair no chão
	alarm[2] = 0;
}

// Colisão Y + reset jumpVal +  reset isFirstjump
if(place_meeting(x, y + vval, obj_r_collision)) {
	
	var isColGround = sign(vval);
	
	while (!place_meeting(x, y+sign(vval), obj_r_collision)) {
		
		y+=sign(vval);
	}
	
	// Colidiu com o teto
	if(isColGround < 0) colUp = true;
	if(isColGround > 0) colDown = true;
	
	
	vval = 0;
}

y+=vval;

// Colisao X
if(place_meeting(x +hval, y, obj_r_collision)) {

	while(!place_meeting(x+sign(hval), y, obj_r_collision)) {
		
		x+=sign(hval);
	}
	
	hval = 0;
}

x+=hval;

#endregion

// Zera o hval
if(hval != 0) {
	
	if(colDown || colUp) hval = lerp(0, hval, 0.95);
	else hval = lerp(0, hval, 0.99);
}
// Diminui ocupacida e exclui obj 
if(death == 1) {
	
	if(alpha > 0.1) {
		
		alpha = lerp(0, alpha, 0.9);
	}
	else {
		
		instance_destroy();
	}
}

image_alpha = alpha;
