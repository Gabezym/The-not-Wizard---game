var _colDown = place_meeting(x,y+1, obj_r_collision);
canInteract = colliding;	// A condição pra interagir é estar colidindo

#region Colisão XY + (x+=hval e y+=vval) + Grav

// Se n tiver chao em baixo
if(!_colDown) {

	vval += grav;
	
}

// Colisão Y + reset jumpVal +  reset isFirstjump
if(place_meeting(x, y + vval, obj_r_collision)) {
	
	while (!place_meeting(x, y+sign(vval), obj_r_collision)) {
		
		y+=sign(vval);
	}
	
	if(vval > 2 || vval < -2) {
		
		vval = -vval * 0.55;
		hval *= 0.85;
	}
	
	else vval = 0;
}

y+=vval;

// Colisao X
if(place_meeting(x +hval, y, obj_r_collision)) {

	while(!place_meeting(x+sign(hval), y, obj_r_collision)) {
		
		x+=sign(hval);
	}
	
	hval = -hval * 0.75;
	valAngl = -valAngl;
}	

x+=hval;

#endregion

// Zera o hval
if(hval != 0) {
	
	var _val = 0;
	
	if (hval > 1 || hval < -1) {
				
		hval -= sign(hval)/10;
		
		_val = (spdAngl * (valAngl / _valHval));
		
	}
	else {
		
		if(_colDown) {

			hval = lerp(0, hval, 0.50);
		}
		else {
		
			_val = (spdAngl * (valAngl / _valHval));
		}
	}
	
	angl -= _val;
}


fColletPickableItem(self, obj_wizard);