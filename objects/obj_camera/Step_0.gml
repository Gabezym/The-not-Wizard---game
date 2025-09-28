if (keyboard_check(ord(keyZoomIn)) && zoomVal < maxZoomVal)  {
	
	zoomVal += zoomSpd;
	
}
if (keyboard_check(ord(keyZoomOut)) && zoomVal > minZoomVal)  {
	
	zoomVal -= zoomSpd;
	
}

// Se tiver seguindo algo
if(follow != noone) {

	var _x = follow.x;
	var _y = follow.y;

	xTo = _x;
	yTo = _y;
	
	// Muda o angulo
	if((_x - x) > 0) image_xscale = 1;
	else if((_x - x) < 0) image_xscale = -1;
}

// Aonde eu quero ir - oq eu ja percorri
//x+= (xTo-x)/25;
//y+= (yTo-y)/25;

x = lerp(x, xTo, 0.05);
y = lerp(y, yTo, 0.05);

// Pega tamanho atual
viewWidth	= camera_get_view_width(view_camera[0]);
viewHeight	= camera_get_view_height(view_camera[0]);

// Calcula tamanho desejado pela escala
var desired_width = camWidth / zoomVal;
var desired_height = camHeight / zoomVal;

// Interpola para suavizar
viewWidth = lerp(viewWidth, desired_width, zoomSpd);
viewHeight = lerp(viewHeight, desired_height, zoomSpd);


// Aplica na câmera
camera_set_view_size(view_camera[0], viewWidth, viewHeight);

// Centraliza na camera
camera_set_view_pos(view_camera[0], x - (viewWidth*0.5), y -(viewHeight*0.5));