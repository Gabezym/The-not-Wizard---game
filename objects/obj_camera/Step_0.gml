// Input Zoom
if (keyboard_check(keyZoomIn) && zoomVal < maxZoomVal)  {
	
	zoomVal += zoomSpd;	
}
if (keyboard_check(keyZoomOut) && zoomVal > minZoomVal)  {
	
	zoomVal -= zoomSpd;
}

// Se tiver seguindo algo
if(follow != noone) {

	xTo = follow.x;
	yTo = follow.y;
}

x = lerp(x, xTo, 0.05);
y = lerp(y, yTo, 0.05);

fWithCameraZoom(self);

// Shake Screen
if(shakeVal != 0) {
	
	view_xport[0] = irandom_range(-shakeVal, shakeVal);
	view_yport[0] = irandom_range(-shakeVal, shakeVal);
	
	shakeVal = lerp(shakeVal, 0, 0.05);
}