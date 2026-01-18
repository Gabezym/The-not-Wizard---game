/// @description Scale
if(scaleMax > scale) { 
	
	var _valScale = scaleVal;
	
	if(colDown || colUp) _valScale = 1;
	
	scale = lerp(scale, scaleMax, _valScale);
	alarm[1] = cooldownScale;
}