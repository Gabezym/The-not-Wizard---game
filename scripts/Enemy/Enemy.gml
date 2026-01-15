// Tem que refazer tudo depois //
// --------------------------- //

// Oque acontece quando isHit == true 
function fEnemyGetDamage(instance) {
	
	with(instance) {
	
		life -=hitStruct.hitVal;
		isHit = false;
		
		fShakeScreenPower(0);
	}
}

// Colisao XY do imigo + X+=hval, Y+=vval
function fEnemyColisionVH(instance) {

	with(instance) {
	
		// Colisão Y + reset jumpVal +  reset isFirstjump
		if(place_meeting(x, y + vval, obj_r_collision)) {
	
			var isColGround = sign(vval);
			
			if(isColGround > 0) y = round(y);
			
			while (!place_meeting(x, y+sign(vval), obj_r_collision)) {
		
				y+=sign(vval);
			}
	
			vertMoveVal = directions.none;	
			vval = 0;
		}
		y +=vval;
	
		// Colisao X
		if(place_meeting(x + hval, y, obj_r_collision)) {
	
			x = x div 1;
				
			while(!place_meeting(x+sign(hval), y, obj_r_collision)) {
		
				x+=sign(hval);
			}
	
			// Se n tiver visto o player, inverte o lado
			if(!isPlayerInView) {
		
				sideMoveVal = -sideMoveVal;	// Inverte o lado
			}
			hval = 0;
		}
		x +=hval;
	}
}

// Ação ao colidir com outro inimigo
function fEnemyColisionEnemy(instance) {

	with(instance) {
		
		// Colisso Self
		if(place_meeting(x, y, obj_enemy_generic) && (alarm[1] < 0)){
	
			// Decide se o obj vai continuar ou mudar de lado se ver for colidir com outro ele
			var _choice = irandom(1);
	
			if(_choice) sideMoveVal = -sideMoveVal;
			alarm[1] = cooldownColisionObj;
		}
	}
}

// Faz uma varredura pra ver se acha o player 
function fEnemySearchTarget(instance) {

	with(instance) {
	
		var _grid = CONSTANTS.GRID;	// Grid
		var _dis = hDisView*_grid;	// Distancia da view
		var _leftDis = x-_dis;
		var _rightDis = x+_dis;
		var _ydis = y - (vDisView*_grid);
		// View Y
		for(var _y = _ydis; _y <= y; _y+=_grid) {
			
			// View X
			for(var _i=_leftDis; _i < _rightDis; _i+=_grid) {

				if(instance_exists(obj_wizard) && (!place_empty(_i, _y, obj_wizard))) {
			
					isPlayerInView = true
			
					// Ta na direira
					if(_i > x)	sideMoveVal = directions.right;
					else		sideMoveVal = directions.left;
				
					var _jumpTime = irandom_range(1, 2) * CONSTANTS.SPD_GAME;
					
					// Tem que refazer tudo depois
					if(obj_wizard.y+(sprite_get_height(obj_wizard.sprite_index)) < y) alarm[0] = _jumpTime; // Seta um pulo			
					
					show_debug_message("T vi");
					alarm[2] = cooldownViewPlayerInView;
			
					exit;
				}
			}
		}

		isPlayerInView = false;					// Nao foi visto
		alarm[2] = cooldownViewPlayerNotView;	// Reseta Timer
	}
}

// Retorna oq ta acontecendo com o vval -> pro enemy. Nsei se valeu a pena =/
function fEnemyActionVval(vval) {
	
	if (vval < 0) return directions.jump;
	else if (vval > 0) return directions.fall; 
	else return directions.none;
}