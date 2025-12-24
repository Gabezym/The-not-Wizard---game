if(inPause) exit;

#region Input Zoom

if (keyboard_check(keyZoomIn) && (zoomVal < maxZoomVal))  {
	
	if((zoomVal + zoomSpd) <  maxZoomVal)	zoomVal += zoomSpd;	
	else									zoomVal = maxZoomVal;
}

if (keyboard_check(keyZoomOut) && zoomVal > minZoomVal)  {
	
		if((zoomVal - zoomSpd) >  minZoomVal)	zoomVal -= zoomSpd;	
		else									zoomVal = minZoomVal;
}

#endregion
