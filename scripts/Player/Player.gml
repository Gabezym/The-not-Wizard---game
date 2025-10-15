#region WIZARD

#region Use/Throw/Drop ITEMS

// -- Aprovado \[T]/
// Retorna o inventario com o slot a menos e spawna o item
// P: array, int, int, int
function fDropItem(_inventory, _slot, _x, _y, _spd) {

	var _strItem = fGetSlotInventory(_inventory, _slot);
	var _id = _strItem.itemId;
	var _grav = 0.4;
	var _status = _strItem.itemStatus;
	
	var hval = choose(1.1, 1.2, 1.3) * _spd;	// Valor usado
	var vval = choose(0, -1, -1.5, -2, -2.5);	// Valor usado
	
	var _can = fSpawnItem(_x, _y, _id, _grav, hval, vval, _status, 1);
	
	// Se conseguiu spawnar o objeto, ele tira o objeto do inventario
	if(_can)	return fRemoveOneItemSlotInventory(_inventory, _slot);
	else		return _inventory;
}

// -- Aprovado \[T]/
function fDropAllItems(_inventory, _slot, _x, _y,  _spd) {

	var _strItem = fGetSlotInventory(_inventory, _slot);
	var _id = _strItem.itemId;
	var _grav = 0.4;
	var _status = _strItem.itemStatus;
	var _amount = _strItem.itemAmount;	
	
	var hval = choose(1.1, 1.2, 1.3) * _spd;	// Valor usado
	var vval = choose(0, -1, -1.5, -2, -2.5);	// Valor usado
	
	var _slotVazio = {
		
		isFull: false,
		itemId: ITEMS_ID.NOTHING,
		itemStatus: {},
		itemAmount: 0
	};			
					
	var _can = fSpawnItem(_x, _y, _id, _grav, hval, vval, _status, _amount);
	
	// Se conseguiu spawnar o objeto, ele tira o objeto do inventario
	if(_can)	return fSetSlotInventory(_inventory, _slot, _slotVazio);
	else		return _inventory;
}

// -- Aprovado \[T]/
// Retorna o inventario com o slot a menos e spawna o item
// P: array, int, int, int
function fThrowItem(_inventory, _slot, _x, _y) {
	
	var _strItem = fGetSlotInventory(_inventory, _slot);
	var _id = _strItem.itemId;
	var _grav = 0.4;
	var _spd = 8;
	var _status = _strItem.itemStatus;
	
	var _ang = obj_mouse.mouseAnglePlayer;
	
	var hval = lengthdir_x(_spd, _ang);	// Valor usado
	var vval = lengthdir_y(_spd, _ang);	// Valor usado
	
	var _can = fSpawnItem(_x, _y, _id, _grav, hval, vval, _status, 1);
	
	// Se conseguiu spawnar o objeto, ele tira o objeto do inventario
	if(_can)	return fRemoveOneItemSlotInventory(_inventory, _slot);
	else		return _inventory;
} 

// -- Aprovado \[T]/
// Aplica efeitos no player
// Retorna o novo inventario com o item a menos
function fUseItem(idItem, inventory, selectedSlot, whoUseItem) {
	
	with(whoUseItem) {
	
		var _infos = obj_config.itemsNoActionData[idItem];
		
		life+=_infos.heal;
		
		fWithEffects(self, _infos.effect);
	}
	
	 return fRemoveOneItemSlotInventory(inventory, selectedSlot);
}

#endregion

// Pq??
function fCoyoteJump(cjTime, vval) {

	// CoyoteJump
	return (alarm[1] > 0 && vval == 0);
}

// -- Aprovado \[T]/
// Retorna se da pra mandar input pro objeto
function fIsInputItem(input, alarmCooldown, isInInventory, itemSelected) {
	
	if(input && alarmCooldown <=0 && isInInventory == false) { 

		var _type = obj_config.itemsData[itemSelected].type;

		// Se for de um tipo que de pra interagir
		if(_type == ITEMS_TYPE.NO_ACTION  || _type == ITEMS_TYPE.TOOLS) {
		
			return true;
		}
	}
	
	return false;

}

// -- Aprovado \[T]/	
// Retorna a Xscale
function fXscale(hval, xScaleVal, xScale) {

	// Retorna a image_xscale
	if (hval > 0) return xScaleVal;
	else if(hval < 0)  return -xScaleVal;
	
	// Se n ta se mexendo fica igual
	return xScale;
}	

// -- Aprovado \[T]/
// Retorna a posiçao da array de sprites 
function fChangeSprite(hval, jump, xScale, _inGround, _inLadder) {
	
	var _scl = sign(xScale);

	var _sprRight = [spr_wizard_right, spr_wizard_walk_right, spr_wizard_fall_right, spr_wizard_jump_right];
	var _sprLeft = [spr_wizard_left, spr_wizard_walk_left, spr_wizard_fall_left, spr_wizard_jump_left];
	
	var _sprites;
	
	// Right sprites
	if (_scl == -1)	_sprites = _sprLeft;
	// Left sprites
	else			_sprites = _sprRight;
	
	if((_inGround || _inLadder) && jump == false) {
		
		// Walk 
		if ((hval != 0)) return _sprites[1];
		// Idle
		else				return _sprites[0];
	}
	// Fall
	else if (jump == false)	return _sprites[2];
	// Jump
	else			return _sprites[3];
}

// Retorna novo valor da estamina
function fGetEstamina(_instance) {
	
	var _newEst = estamina;
	
	with(_instance) {
		
		if(estamina > maxEstamina) _newEst = maxEstamina;	// Pra n ultrapassar
		// Regeneraçao
		else if(estamina < maxEstamina && alarm[4] <= 0) {
		
			var _reg = 0;
			
			if(hval == 0 && vval == 0)	_reg = regeneracaoEstamina;
			else						_reg = regeneracaoEstamina div 2;
		
			// Regenera estamina
			_newEst = estamina + _reg;
		}
	}
	
	return _newEst;
}

// Arruma Array interactedObjects
function fWithInteractedObjects(_instance) {

	with(_instance) {
	
		// Organiza a array dos interactObjects
		var _lenAI = array_length(interactionObjects);
		if(_lenAI != 0) {

			with(objColInteraction) {
			
				for(var _z = _lenAI-1; _z >= 0; _z--) {
				
					if(instance_exists(other.interactionObjects[_z])) {
						
						// N tiver mais colidindo, tira da array
						if(place_empty(x, y, other.interactionObjects[_z])) { 
					
							// N esta mais colidindo nem interagindo
							other.interactionObjects[_z].colliding = false;
							other.interactionObjects[_z].interacted = false;
					
							// Tira da array
							array_delete(other.interactionObjects, _z, 1);	
						}
					}
					else {
					
						// Tira da array
						array_delete(other.interactionObjects, _z, 1);	
					}
				}
			}
		} 
	
		if(_lenAI != array_length(interactionObjects)) indexAI = 0;
	}
}

#region Sistemas

// Sistema de movimentação
function fWithMovementHvalVval(_instance) {
	
	with(_instance){

		var inGround = place_meeting(x,y+1, obj_r_collision);
		
		// Fica parado se tiver no inventario
		if(isInInventory) {

			right = 0;
			left = 0;
			jump = 0;
		}

		// Hval Andando
		hval = (right - left) * spd * slow;

		// Vars + inJumpAnimation
		if (inGround || isInLadder) {

			jumpVal = 0;	// Da pra da o pulo pressionado
			isFirstJump = true;
			isFalling = false;
			alarm[1] = coyoteJumpTimeVal;	// O timer n desce enquanto ta no chao, coyote jump
	
			// Só reseta a animação de pulo se NÃO estiver apertando jump
		    if (!jump) inJumpAnimation = false;
		}
		else isFirstJump = false;

		#region Vars pro Pulo + inJumpAnimation

		// Ta na animacao de pulo
		if(inJumpAnimation) {

				var _lastFrame = floor(image_index) >= image_number - 1;
				if(_lastFrame) inJumpAnimation = false;
		}

		// Cliquei o pulo, e agora?
		if (jump) {
	
			// To no chão
			if (inGround || isCoyoteJump) {
		
				isFalling = false;
				isJumping = true;
				isFirstJump = false;
				inJumpAnimation = true;
			}
			// N to no chão
			else {
		
				// TemMaisPuloPress ou DeuPrimeiroPulo
				if ((jumpVal < maxJumpVal) && (isFirstJump == false)) {
	
					isJumping = true;
					jumpVal++;
				}	
			}
		}
		else {
	
			isJumping = false;
		}
	
		#endregion

		// Vval Jump + estamina
		if (isJumping) { 
	
			vval = (jump * spdJump) * slow * efBigJump;
			estamina -= estJump;
			alarm[4] = cooldownEstamina;
		}

		// CoyoteJump
		isCoyoteJump = fCoyoteJump(alarm[1], vval);

		// Codigo falling
		if (!inGround)  {
	
			// N to pulando no ar,n tem pulo pressionado e n tem coyote jump
			if (((!isJumping) || (jumpVal >= maxJumpVal)) && (isCoyoteJump == false)) {
		
				isFalling = true;
				isJumping = false;
				jumpVal = maxJumpVal; // Sem pulo Pressionado
			}
		}	

		// Vval caindo
		if (isFalling) vval +=grav;


	}
}

// Sistema de colisao do player
function fWithCollisionPlayer(_instance) {
	
	with(_instance) {
	
		// Y
		// Descer escada 
		if (!(place_meeting(x + hval, y, obj_collision_ladder)) && isInLadder && (vval >= 0)) {
	
			y = y div 1;
	
			while !place_meeting(x, y+1, obj_collision_ladder) {
		
				y+=1;		
			}
		}

		// Colisão Y + reset jumpVal +  reset isFirstjump
		if(place_meeting(x, y + vval, obj_r_collision)) {
	
			var isColGround = sign(vval);
	
			y = y div 1;
	
			while (!place_meeting(x, y+sign(vval), obj_r_collision)) {
		
				y+=sign(vval);
			}
	
			// Se for uma colição com o chão
			if(isColGround > 0) {
		
				isFirstJump = true;
			}
			else {
		
				// Num da pra ficar segurando pulo batendo a cabeça
				jumpVal = maxJumpVal;
			}
	
			// Se colidiu de alguma forma, n ta mais na animacao de pular
			inJumpAnimation = false;
			vval = 0;
		}

		// X
		// Subir escada
		if place_meeting(x + hval, y + vval, obj_collision_ladder) {
	
			x = x div 1
			y = y div 1
	
			while !place_meeting(x + sign(hval), y, obj_collision_ladder) {
	
				x += sign(hval);
			}
	
			// Soma o spd pra cima, assim fazendo com que ele suba a escada
			y-=spd;
		}

		// +vval pq ainda n somou, ele soma só no final
		if(place_meeting(x +hval, y+vval, obj_r_collision)) {

			x = x div 1;
	
			while(!place_meeting(x+sign(hval), y+vval, obj_r_collision)) {
		
				x+=sign(hval);
			}
	
			hval = 0;
		}
	}
} 

// Sistema de inventario
function fWithInventory(_instance) {

	with(_instance) {
	
		// Inventario com o mouse(ações) + selectedSlot/last
		fWithInvetoryMouse(self);

		// Coleta Itens
		var _lenToPick = array_length(toPick);
		inventory = fGetInventoryColletToPick(inventory, toPick, _lenToPick);
		toPick = [];

		// Info do item em mãos
		itemSelectedStruct = fGetSlotInventory(inventory, selectedSlot);
		itemInHand = itemSelectedStruct.itemId;

		// Cria e destroi os items
		fWithChangeInstanceHands(self);
	}
}

// Sistema de estamina
function fWithEstamina(_instance) {

	with(_instance) {
	
		if(estamina != maxEstamina) {
	
			// Velocidade lenta
			if(estamina <= 0 ) {

				spd = spdVal/2;
				spdJump = spdJumpVal / 2;
			}
			// Velocidade normal
			else {

				spd = spdVal;
				spdJump = spdJumpVal;
			}
	
			estamina = fGetEstamina(self);	
		}
	}
}

// Sistema dos follow objects
function fWithFollowObjects(_ins) {

	with(_ins) {
	
		var _lenArrF = array_length(followObjects); 
		if(_lenArrF > 0) {

			// De tras pra frente
			for(var _i = _lenArrF-1; _i >=0; _i-- ) {
		
				var _instance = followObjects[_i];
				var _sprWid = sprite_get_width(sprite_index);
		
				if(instance_exists(_instance)) {
		
					with(_instance) {
				
						#region Vars
				
						var _dis = 5 + ((_sprWid div 2 + xPlus)); // xPlus é o espaço adicional d cada objeto
						var _ang = obj_mouse.mouseAnglePlayer;
						var _x = other.x + other.hval;	 
						var _y = other.y + other.vval;
				
						var _lenX = lengthdir_x(_dis, _ang);
						var _lenY = lengthdir_y(_dis, _ang);
								
						#endregion
				
						// Posição XY
						var _newX = _x + _lenX;
						var _newY = _y + _lenY;
				
						// Xscale
						var _scl = sign(other.xScale);
						if(mouse_x > _x)		_scl =  1;
						else if	(mouse_x < _x)	_scl = -1;
				
						// Alpha
						var _alpha = 1;
						// Se ta no inventario o item some
						if(other.isInInventory) _alpha = 0;
				
						x = _newX;
						y = _newY;
						image_alpha = _alpha
						image_xscale = _scl;
					}
				}
		
				else {
		
						array_delete(followObjects, _i, 1);
					}
			}
		}
	}
}

#endregion

#endregion