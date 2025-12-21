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
	if(_can)	return fRemoveOneItemSlotInventoryAndDelete(_inventory, _slot);
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
// Retorna o inventario com o slot a menos ou ele zerado e spawna o item
// P: array, int, int, int
function fThrowItem(_inventory, _slot, _x, _y) {
	
	var _strItem = fGetSlotInventory(_inventory, _slot);
	var _id = _strItem.itemId;
	var _grav = 0.4;
	var _spd = 8;
	var _status = _strItem.itemStatus;
	
	var _ang = obj_mouse.mouseAnglePlayer;
	
	var _hval = 0;
	var _vval = 0;
	
	// Hval e Vval adicional
	if(instance_exists(obj_wizard)) {
	
		var _min = _spd/4;
		var _max = _spd/3.5;
	
		if((obj_wizard.hval != 0))	_hval  = random_range(_min, _max);
		if(obj_wizard.vval != 0)	_vval  = random_range(_min, _max);
	}
	
	var hval = lengthdir_x(_spd+_hval, _ang);	// Valor usado
	var vval = lengthdir_y(_spd+_vval, _ang);	// Valor usado
	
	var _can = fSpawnItem(_x, _y, _id, _grav, hval, vval, _status, 1);
	
	// Se conseguiu spawnar o objeto, ele tira o objeto do inventario
	if(_can)	return fRemoveOneItemSlotInventoryAndDelete(_inventory, _slot);
	else		return _inventory;
} 

// -- Aprovado \[T]/
// Aplica efeitos no player
// Retorna o novo inventario com o item a menos
function fUseItem(idItem, whoUseItem) {
	
	with(whoUseItem) {
		
		var _effect = EFFCTS.NOTHING;
		
		if(idItem == ITEMS_ID.POTION) {	
			
			// O efeito das poções está no status do item, não no dataBase
			_effect = itemSelectedStruct.itemStatus.effectId;
		}
		else {
			
			var _infos = obj_config.itemsNoActionData[idItem];
			life+=_infos.heal;
			_effect = _infos.effect;
		}	
		
		fWithEffects(self, _effect);			// Aplica efeito
		
		var _toxicity = obj_config.effectsData[_effect].toxicity;
		fWithToxicityIncrease(self, _toxicity);	// Aumenta a toxicidade	
	}
	
	 return fRemoveOneItemSlotInventory(inventory, selectedSlot);
}

#endregion


#region  Pra encurtar (genérico)

	// Pq??
	function fCoyoteJump(cjTime, vval) {

		// CoyoteJump
		return (alarm[1] > 0 && vval == 0);
	}

	// -- Aprovado \[T]/
	// Retorna se da pra mandar input pro objeto
	function fIsInputItem(input, alarmCooldown, isStop, itemSelected) {
	
		if(input && alarmCooldown <=0 && isStop == false) { 

			var _type = obj_config.itemsData[itemSelected].type;

			// Se for de um tipo que de pra interagir
			if(_type == ITEMS_TYPE.NO_ACTION  || _type == ITEMS_TYPE.TOOLS) {
		
				return true;
			}
		}
	
		return false;

	}

	// -- Aprovado \[T]/	
	// Retorna a Xscale pro player
	function fXscale(hval, xScaleVal, xScale, _ang, _haveItemInHands, stopCondition) {

		if(stopCondition == false) {

			// Com angulo
			if(_haveItemInHands) {
			
				// Retorna a image_xscale
				if ((_ang <= 90 || _ang > 270))		return xScaleVal;
				else if((_ang > 90 && _ang <= 270))	return -xScaleVal;
			}
		
			// Com hval
			else {
		
				if(hval > 0) return xScaleVal;
				else if(hval < 0) return -xScaleVal;
			}
		}
		
		// Fica igual
		return xScale;
	}	

	// -- Aprovado \[T]/
	// Retorna a posiçao da array de sprites 
	function fChangeSprite(hval, jump, xScale, _inGround) {
	
		var _scl = sign(xScale);

		var _sprRight	= [spr_wizard_right, spr_wizard_walk_right, spr_wizard_fall_right, spr_wizard_jump_right];
		var _sprRightNA	= [spr_wizard_right_noArm, spr_wizard_walk_right_noArm, spr_wizard_fall_right_noArm, spr_wizard_jump_right_noArm];	 
		var _sprLeft	= [spr_wizard_left, spr_wizard_walk_left, spr_wizard_fall_left, spr_wizard_jump_left];

	
		var _haveItemInHands = (itemSelectedStruct != clearSlot);
		var _sprites;
	
	
		// Left sprites
		if (_scl == -1)				_sprites = _sprLeft;
		
		// Right sprites No Arm
		else if(_haveItemInHands == false || stopCondition)	_sprites = _sprRight;
		else						_sprites = _sprRightNA;
	
		if((_inGround) && jump == false) {
		
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
						
							#region Pickable Vars
						
							var _id = other.interactionObjects[_z].id;
							var _isPickable = ((object_is_ancestor(_id.object_index, obj_pickable)) || (_id.object_index == obj_pickable));
							var _isAlive = true;
							if(_isPickable) _isAlive = (_id.life > 0);
						
							#endregion
						
							var _isColliding = place_meeting(x, y, other.interactionObjects[_z]);
						
							// N tiver mais colidindo ou n estiver mais vivo
							if(!_isColliding || !_isAlive) { 
					
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


	#region	About Crafting

		// Retorna o status da poção pro crafting
		// -1 == n da pra craftar
		function fGetStatusCraftingPotion(_liquid, _ingredient) {

				var _effect = -1;

				if(_liquid == LIQUIDS_ID.WATER) {
			
					switch(_ingredient) {
				
						case ITEMS_ID.PLANT_BLUE: 		
				
							_effect	= EFFCTS.BIG_JUMP;
						break;
					}
				}
		
				else if(_liquid == LIQUIDS_ID.BLOOD) {
			
					switch(_ingredient) {
				
						case ITEMS_ID.PLANT_RED: 		
				
							_effect	= EFFCTS.MORE_DAMAGE;
						break;
					}
				}
	
			return _effect
		}

		// Coleta a poção e tira ingredientes do inventario
		function fWithCollectPotion(_instance, _effect) {

			with(_instance) {
		
				var _status = {
				
					effectId: _effect
				}
				var _potionStr = {
				
					isFull: true,
					itemId: ITEMS_ID.POTION,
					itemStatus: _status,
					itemAmount: 1
				}
			
				// Remove os items do crafting
				newInventory = fRemoveOneItemSlotInventory(inventory, craftIndexItem1);
				newInventory = fRemoveOneItemSlotInventory(newInventory, craftIndexItem2);
				
				// Checar se algum item chegou a 0 (Bottle)
				isUpdateInvetory = true; 
		
				// Atualiza inventario
				fWithSetNewInventory(self);
		
				// Coleta poção
				array_insert(toPick, array_length(toPick), _potionStr);
			}
		}

	#endregion


	// Reseta o recoil do damage 
	function fWithResetRecoilDmg(instance) {

		with(instance) {
		
			var _recoilX = recoilXDmg;
			var _recoilY = recoilYDmg;
		
			var _reduction = 0
		
			if(_recoilY != 0) {
			
				if(!place_meeting(x, y+1, obj_r_collision)) {
				
					recoilYDmg += grav; 
				}
			}
			if(_recoilX != 0) {
			
				var _sinX = sign(_recoilX) * -1;
				_reduction = 0.1 * _sinX;
			
				// Se é positivo ou negativo
				var _check = false;
				if(_recoilX > 0)	_check = (_recoilX + _reduction > 0);
				else				_check = (_recoilX + _reduction < 0);
			
				// Se ainda da pra reduzir
				if (_check) _recoilX += _reduction;
				else _recoilX = 0;
			
				recoilXDmg = _recoilX; 
			}	
		}
	}

	// Aumenta a toxicidade 
	function fWithToxicityIncrease(_instance, _toxicity) {

		with(_instance) {
		
			toxicityValLevel += _toxicity;
		
			if(toxicityValLevel >=  toxicityMaxValLevel) {
			
				toxicityLevel++;
				toxicityValLevel = 0;
			}
		}
	}

	// Muda qual objeto ta iteragindo e manda o input de interação
	function fWithInputIndexAndInteraction(_instance) {

		with(_instance) {
	
			var _lenIA = array_length(interactionObjects);
			if(_lenIA != 0) {
	
				// Muda qual objeto esta interagindo
				if(changeIndex) {
		
					if(indexAI+1 >= _lenIA) indexAI = 0;
					else					indexAI++;
				}
	
				// Manda input de interação
				if(instance_exists(interactionObjects[indexAI])) {
	
					// Manda input pro objeto
					if(interact) {

						interactionObjects[indexAI].interacted = true;
					}
				}
			}
			else {
	
				indexAI = 0;
			}
		}
	}

#endregion


#region Sistemas
			
		// Sistema de inputs
		function fWithInputs(_instance) {
		
			with(_instance) {

				#region Keybinds

				escape			= keyboard_check_pressed(keyEscape);

				right			= keyboard_check(keyRight);
				left			= keyboard_check(keyLeft);
				jump			= keyboard_check(keyJump);
				inputInventory	= keyboard_check_pressed(keyInventory);
				interact		= keyboard_check_pressed(keyInteract);
				changeIndex		= keyboard_check_pressed(keyChangeIndex);

				leftClick			= mouse_check_button(mouseLeftClick);
				leftClickReleased	= mouse_check_button_released(mouseLeftClick);
				leftClickPressed	= mouse_check_button_pressed(mouseLeftClick);

				rightClick			= mouse_check_button_pressed(mouseRightClick)
				rightClickPressed	= mouse_check_button_pressed(mouseRightClick);

				#endregion

				#region Condição inputs

				// Interação com objetos 
				interact = (stopCondition || alarm[alarmInt] > 0 ? false : interact);
				
				// Mudar index objeto de interação
				changeIndex = (stopCondition? false : changeIndex);
				
				inputInventory = (inText? false: inputInventory);

				// Cooldown entre interações
				alarm[alarmInt] = (interact? cooldownInteraction : alarm[alarmInt]);

				#endregion

				// Input index de interagiveis + interação
				fWithInputIndexAndInteraction(self);

				#region Input Itens equipados
				
				var _id = fGetSlotInventory(inventory, selectedSlot).itemId;
				isInputItem			= fIsInputItem(leftClick, alarm[0], stopCondition, _id);
				isInputPressedItem	= fIsInputItem(leftClickPressed, 0, stopCondition, _id);
				isInputItem2		= fIsInputItem(rightClick, alarm[0], stopCondition, _id);

				#endregion

				// Abre e fecha o inventario
				isInInventory = fInputOnOff(inputInventory, isInInventory);

				// Se ta craftando, abre o inventario
				if(isCrafting) isInInventory = true;

				// Sai de tudo
				if(escape) {

					isInInventory = false;
					isCrafting = false;
					craftIndexItem1 = -1;
					craftIndexItem2 = -1;
				}

				#region Slots Inventario
				
				slot1	= keyboard_check_pressed(keySlot1);
				slot2	= keyboard_check_pressed(keySlot2);
				slot3	= keyboard_check_pressed(keySlot3);
				slot4	= keyboard_check_pressed(keySlot4);
				slot5	= keyboard_check_pressed(keySlot5);
				
				#endregion
			}
		}
		
		// Sistema de movimentação
		function fWithMovementHvalVval(_instance) {
	
			with(_instance){
		
				// Evita de pular infinitamente segurando o botão
				if(keyboard_check_released(keyJump) && canJump == false) canJump = true;
	
				var inGround = place_meeting(x,y+1, obj_r_collision);
		
				// Fica parado se tiver no inventario
				if(stopCondition) {

					right = 0;
					left = 0;
					jump = 0;
				}

				// Hval Andando
				hval = (right - left) * spd * slow;

				// Vars + inJumpAnimation
				if (inGround) {
			
					jumpVal = 0;	// Da pra da o pulo pressionado
					isFirstJump = true;
					isFalling = false;
					alarm[1] = coyoteJumpTimeVal;	// O timer n desce enquanto ta no chao, coyote jump
			
					// Só reseta a animação de pulo se NÃO estiver apertando jump
				    if (!jump) inJumpAnimation = false;
				}

				#region Vars pro Pulo + inJumpAnimation

				// Ta na animacao de pulo
				if(inJumpAnimation) {

						var _lastFrame = floor(image_index) >= image_number - 1;
						if(_lastFrame) inJumpAnimation = false;
				}

				// Cliquei o pulo, e agora?
				if (jump) {
	
					// To no chão
					if ((inGround || isCoyoteJump) && canJump) {
		
						isFalling = false;
						isJumping = true;
						isFirstJump = false;
						inJumpAnimation = true;
						canJump = false;
					}
					// N to no chão e TemMaisPuloPress ou DeuPrimeiroPulo
					else if ((jumpVal < maxJumpVal) && (isFirstJump == false)) {
	
							isJumping = true;
							jumpVal++;
					}
			
					else isJumping = false;
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
		
				var _moveH = hval + recoilXDmg;
				var _moveY = vval + recoilYDmg;
		
				// Y
				// Colisão Y + reset jumpVal +  reset isFirstjump
				if(place_meeting(x, y + _moveY, obj_r_collision)) {
	
					var isColGround = sign(_moveY);
	
					y = y div 1;
	
					while (!place_meeting(x, y+sign(_moveY), obj_r_collision)) {
		
						y+=sign(_moveY);
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
					recoilYDmg = 0;
				}

				// X
				// +vval pq ainda n somou, ele soma só no final
				if(place_meeting(x +_moveH, y+_moveY, obj_r_collision)) {

					x = x div 1;
	
					while(!place_meeting(x+sign(_moveH), y+_moveY, obj_r_collision)) {
		
						x+=sign(_moveH);
					}
	
					hval = 0;
					recoilXDmg = 0;
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
	
					// Velocidade
					if(estamina <= 0 ) {
	
						estamina = 0
						spd = spdVal/2;
						spdJump = spdJumpVal/2;
					}
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
							
									var _dis = other.disToHand;
									var _valX = other.x + other.armX;
									var _valY = other.y + other.armY;
							
									// Angulo
									var _ang = point_direction(_valX, _valY, mouse_x, mouse_y);
							
									var _x = _valX;	 
									var _y = _valY;
				
									var _lenX = lengthdir_x(_dis, _ang);
									var _lenY = lengthdir_y(_dis, _ang);
				
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
				
									#endregion
								
								// Built-in variables
								if(_instance.object_index != obj_attack) {
									
									x = _newX;
									y = _newY;
									image_alpha = _alpha;
									image_angle = _ang;

									var _isWeapon = (_instance.object_index == obj_weapon);									
									// Escala
									if(_isWeapon == false) {
							
										image_yscale = _scl;
									}
									else {
							
										image_xscale = _scl;
										image_yscale = _scl;
									}					
									
								}							
								else {
							
									x += other.hval;
									y += other.vval;
								}
							}
						}
		
						else {
		
								array_delete(followObjects, _i, 1);
							}
					}
				}
			}
		}

		// Sistema dos efeitos
		function fWithEffectsPlayer(_instance) {

			if(fWithHasEffects(_instance)) {
		
				// Fogo
				fWithStepEfFire(_instance)
 
				// Pulo Alto
				fWithStepEfBigJump(_instance);
		
				// Mais dano
				fWithStepEfMoreDamage(_instance);
			}
		}

		// Sistema de crafting
		function fWithCraftingPotions(_instance) {

			with(_instance) {
	
				if(isCrafting) {

					var _mx = display_mouse_get_x();
					var _my = display_mouse_get_y();
	
					#region Colisao das caixas (cordenadas)
	
					var _bcy1 = craftVarDefY - 32;
					var _bcy2 = craftVarDefY + 32;
	
					// Box 1
					var _b1cx1 = craftVarB1 - 32;
					var _b1cx2 = craftVarB1 + 32;
	
					// Box 2
					var _b2cx1 = craftVarB2 - 32;
					var _b2cx2 = craftVarB2 + 32;

					// Done 
					var _dWidHalf = sprite_get_width(spr_craftingUI_done) div 2;
					var _dHeiHalf = sprite_get_height(spr_craftingUI_done) div 2;
	
					var _donecx1 = craftDoneVarDefX - _dWidHalf;
					var _donecx2 = craftDoneVarDefX + _dWidHalf;
	
					var _donecy1 = craftDoneVarDefY - _dHeiHalf;
					var _donecy2 = craftDoneVarDefY + _dHeiHalf;
	
					#endregion
	
					// Colisoes com mouse
					var _colb1 = point_in_rectangle(_mx, _my, _b1cx1, _bcy1, _b1cx2, _bcy2);
					var _colb2 = point_in_rectangle(_mx, _my, _b2cx1, _bcy1, _b2cx2, _bcy2);
					var _coldone = point_in_rectangle(_mx, _my, _donecx1, _donecy1, _donecx2, _donecy2);


					// MOVER ITENS PROS SLOTS
					// Mouse dentro de uma das caixas de colisão
					if(_colb1 || _colb2) {
	
						// Se soltou o botao do mouse e ja armazenou a posiçao de um slot
						if(leftClickReleased && (slotClick != -1)) {
		
							var _notTheSameItem = ((craftIndexItem1 != slotClick) && (craftIndexItem2 != slotClick));
							if(_notTheSameItem) {
				
								var _itemId = slotStrClick.itemId;
				
								var _isLiquidBottle = (_itemId == ITEMS_ID.BOTTLE);
								var _isIngredient	= (obj_config.itemsData[_itemId].type == ITEMS_TYPE.NO_ACTION);
				
								// Liquido
								if(_colb1 && _isLiquidBottle){
					
									craftIndexItem1 = slotClick;
								}
								// Ingredientes
								else if(_colb2 && _isIngredient) {
					
									craftIndexItem2 = slotClick;
								}
							}
						}
		
						// Tirar item do slot
						if(rightClickPressed) {
		
							if(_colb1)	craftIndexItem1 = -1;
							else		craftIndexItem2 = -1;
						}
					}
	
					// CRAFTAR ITENS
					// Mouse no botao pra craftar
					else if(_coldone) {
		
						// Se clicou e tem items nos slots de crafting 
						if(leftClickPressed && (craftIndexItem1 != -1) && (craftIndexItem2 != -1)) {
			
							var _item1 = fGetSlotInventory(inventory, craftIndexItem1);
							var _item2 = fGetSlotInventory(inventory,craftIndexItem2);
		
							var _item2Type = obj_config.itemsData[_item2.itemId].type;
		
		
							var _isBott	= (_item1.itemId == ITEMS_ID.BOTTLE);
							var _isIng	= (_item2Type == ITEMS_TYPE.NO_ACTION);
			
							// Se são os itens pra crafting
							if(_isBott && _isIng) {
		
								var _liquidId	= _item1.itemStatus.liquidId;
								var _itemId		= _item2.itemId;
			
								var _effect		= fGetStatusCraftingPotion(_liquidId, _itemId);
					
								if(_effect != -1) {
					
									// Coleta poção e tira ingredientes (1 de cada)
									fWithCollectPotion(self, _effect);
					
									craftIndexItem1 = -1;
									craftIndexItem2 = -1;
								}
							}
						}
					}
				}
			}
		}

		// Sistema de dano inimigo ao player
		function fWithPlayerDmg(_instance, _dmg, _sideRecoil) {

			with(_instance) {
	
				// Dano
				life -= _dmg;
	
				// Recoil do dano
				recoilXDmg = (other.spd*3 * _sideRecoil);
				recoilYDmg = (-other.jump/2);

				// Cooldown dano
				alarm[alarmDmg] = cooldownDamage;
		
				fShakeScreenPower(2);
			}
		}

#endregion
