#region Inventario

#region Reutilizados	
	
// -- Aprovado \[T]/
// Retorna Struct da posição
// P: Array + posição do item(int)
// Retorna struct da posição q eu pedi
function fGetSlotInventory(inventory, slotToFind) {

	var _slotToCheck = 0;

	// Percorre o inventario até achar "slotToFind" posição do inventario
	for(var _y = 0; _y < array_length(inventory); _y++) {
	
		for(var _x = 0; _x < array_length(inventory[_y]); _x++) {

			if(slotToFind == _slotToCheck) {
				
				// Retorna struct da posição q eu pedi
				return inventory[_y][_x];
			}
			
			_slotToCheck++;
		}
	}
}

// -- Aprovado \[T]/
// Retorna a posição do inventario como numero
// P: array, array[y][x]
// Retorna a posição do slot como int
function fGetPositionInventory(inventory, slotToFind) {

	var _slotToCheck = 0;

	// Percorre o inventario até achar "slotToFind" posição do inventario
	for(var _y = 0; _y < array_length(inventory); _y++) {
	
		for(var _x = 0; _x < array_length(inventory[_y]); _x++) {

			if(slotToFind == inventory[_y][_x]) {
				
				// Retorna a posição do slot
				return _slotToCheck;
			}
			
			_slotToCheck++;
		}
	}
}

// -- Aprovado \[T]/
// Retorna o Inventario com o novo valor no status
// P: array, posiçao(int), struct
function fSetSlotInventory(inventory, slotToFind, newVal) {

	var _slotToCheck = 0;

	// Percorre o inventario até achar "slotToFind" posição do inventario
	for(var _y = 0; _y < array_length(inventory); _y++) {
	
		for(var _x = 0; _x < array_length(inventory[_y]); _x++) {

			if(slotToFind == _slotToCheck) {
							
				// Define novo valor
				inventory[_y][_x] = newVal;
				return inventory;
			}
			
			_slotToCheck++;
		}
	}
	
	// Coloquei dps pra caso n ache o slot pra mudar
	return inventory;
}

// -- Aprovado \[T]/
// Retorna o inventario com o um item a menos naquele slot
// Deixa o slot zerado caso n tenha mais itens 
function fRemoveOneItemSlotInventoryAndDelete(inventory, slotToChange) {

	var _slotStruct = fGetSlotInventory(inventory, slotToChange);
	
	var _newStruct = {};
	// Se ainda tem item depois de jo
	if(_slotStruct.itemAmount-1 > 0) {
	
		_newStruct = {
			
			isFull: _slotStruct.isFull,
			itemId: _slotStruct.itemId,
			itemStatus: _slotStruct.itemStatus,
			itemAmount: _slotStruct.itemAmount-1
		}
	}
	else {
	
		_newStruct = {
			
			isFull: false,
			itemId: ITEMS_ID.NOTHING,
			itemStatus: {},
			itemAmount: 0
		}
	}

	return fSetSlotInventory(inventory, slotToChange, _newStruct);	// Define como vazio o slot
}

// -- Aprovado \[T]/
// Retorna o inventario com o um item a menos naquele slot
// P: posiçao(int)
function fRemoveOneItemSlotInventory(inventory, slotToChange) {

	var _slotStruct = fGetSlotInventory(inventory, slotToChange);
	
	var _newStruct = {
			
			isFull: _slotStruct.isFull,
			itemId: _slotStruct.itemId,
			itemStatus: _slotStruct.itemStatus,
			itemAmount: _slotStruct.itemAmount-1
		}

	return fSetSlotInventory(inventory, slotToChange, _newStruct);	// Define como vazio o slot
}

// -- Aprovado \[T]/
// Pro fWithSetNewInventory
function fGetUpdateInventory(inventory, clearSlot) {

	// Atualiza o inventario
	for(var _y = 0; _y < array_length(inventory); _y++) {

		for(var _x = 0; _x < array_length(inventory[_y]); _x++) {
			
			var _emptyBottle = {

				isFull: true,
				itemId: ITEMS_ID.EMPTY_BOTTLE,
				itemStatus: undefined,
				itemAmount: 1
			}
			
			var _slotCheck = inventory[_y][_x];
			var _notExist = (_slotCheck.isFull == false) && (_slotCheck != clearSlot);
			var _noAmount = (_slotCheck.itemAmount <= 0) && (_slotCheck != clearSlot);
			
			var _isBottle = (_slotCheck.itemId == ITEMS_ID.BOTTLE);
			var _isPotion = (_slotCheck.itemId == ITEMS_ID.POTION);
			
			
			if(_notExist) inventory[_y][_x] = clearSlot;
			
			// Acabou o item
			else if(_noAmount) {
			
				if(_isPotion)	inventory[_y][_x] = _emptyBottle;
				else			inventory[_y][_x] = clearSlot;
			}

			// Acabou liquido do bottle
			else if(_isBottle) {
				
				var _noLiquid = (_slotCheck.itemStatus.liquidAmount <= 0);
				
				if(_noLiquid) inventory[_y][_x] = _emptyBottle;
			}
		}	
	}
	
	return inventory;
}

// -- Aprovado \[T]/
// Caso use new inventory, inventory = newInventory
// Se isUpdateInvetory for true, chama fGetUpdateInventory
function fWithSetNewInventory(_instance) {
	
	with(_instance) {
	
		// Atualiza o inventario caso haja um novo na var newInventario
		if(newInventory != undefined) {

			inventory = newInventory;
			newInventory = undefined;
		}
		// Checa se o amount dos itens chegou a 0, se chegou, limapa o slot.
		if(isUpdateInvetory) {
	
			inventory = fGetUpdateInventory(inventory, clearSlot);
			isUpdateInvetory = false;
		}

	}
}

#endregion

#region Pra encurtar

// -- Aprovado \[T]/
// Define selectedSlot e lastSelectedSlot
function fWithSelectedSlot(instance) {
	
	with(instance) {
		
		var _newSelectedSlot		= selectedSlot;
		var _newLastSelectedSlot	= lastSelectedSlot;

		var _slotIputButton = slot1 + slot2 + slot3 + slot4 + slot5;
	
		if(_slotIputButton != 0) {

			if		(slot1)	_newSelectedSlot =	0;
			else if (slot2)	_newSelectedSlot =  1;
			else if (slot3)	_newSelectedSlot =	2;
			else if (slot4)	_newSelectedSlot =  3;
			else if (slot5)	_newSelectedSlot =  4;
		}
	
		// Se trocou de slot
		if(_newSelectedSlot != selectedSlot) _newLastSelectedSlot = selectedSlot;
	
	
		selectedSlot		= _newSelectedSlot;
		lastSelectedSlot	= _newLastSelectedSlot;
	}
}

// -- Aprovado \[T]/
// P: array, id do item, tantoDeItem
// Retorna array[tipo de cheio, amount]
// 1 = colocar tudo, 2 = um pouco, 0 = n tem espaço
function fHaveSpaceInInvetory(inventory, item, amount){

	var _newAmount = amount;
	var _canPutSome = 0;
	
	// Percorre o inventario
	for(var _y = 0; _y < array_length(inventory); _y ++) {
		
		for(var _x = 0; _x < array_length(inventory[_y]); _x++) {
						
			var _noItemInSlot = (inventory[_y][_x].isFull == false);
			
			var _sameItem = (inventory[_y][_x].itemId == item);
			
			var _maxAmount = obj_config.itemsData[item].maxAmount;	// Maximo de itens
			var _haveSpace = (inventory[_y][_x].itemAmount + _newAmount <= _maxAmount);
			
			// Se tem espaço no slot
			if(_noItemInSlot) return [1, 0];
					
			else if(_sameItem) {
					
				if(_haveSpace) return [1, 0];

				else if(inventory[_y][_x].itemAmount < _maxAmount) { 
					
					_newAmount = inventory[_y][_x].itemAmount + _newAmount - _maxAmount;
					_canPutSome = 2;
					}
			}
		}
	}
	
	return [_canPutSome, _newAmount]
}


// -- Aprovado \[T]/
// Retorna o inventario com os itens coletados
// P: Array, Array, int
// AVISO: Deseve-se definir a array toPick do obj_wizard pra = [];
function fGetInventoryColletToPick(inventory, toPick, _lenArrToPick) {
	
	for(var _i = _lenArrToPick-1; _i >= 0; _i--) {
	
		var _done = false;
		
		// Percorre o inventario
		for(var _y = 0; _y < array_length(inventory); _y ++) {
			
			// N acho um slot ainda
			if(_done == false){
			
				for(var _x = 0; _x < array_length(inventory[_y]); _x++) {
						
					var _str = inventory[_y][_x];
					var _slotMaxAmount = obj_config.itemsData[_str.itemId].maxAmount;
					var _itemAmount = toPick[_i].itemAmount;
					
					var _oldPlusNewAmount = (_str.itemAmount + _itemAmount);
					
					var _isNoItem = (_str.isFull == false);
					var _isSameItem = (_str.itemId == toPick[_i].itemId);
					var _haveAmountSpace = (_oldPlusNewAmount <= _slotMaxAmount);
				
					
					// Se tem espaço mp slot
					if(_isNoItem || (_isSameItem && _haveAmountSpace)) {
							
						var _structSlot = {
							
							isFull: toPick[_i].isFull,
							itemId: toPick[_i].itemId,
							itemStatus: toPick[_i].itemStatus,
							itemAmount: _oldPlusNewAmount
						}
							
							
						inventory[_y][_x] = _structSlot;
						
						// Tira o item da fila pra pegar
						array_delete(toPick, _i, 1);
						_done = true;
						break;
					}
					else if(_isSameItem && (_str.itemAmount < _slotMaxAmount)) {
						
						// Item menos oq ja stacou
						var _thiStructSlot = {
							
							isFull: toPick[_i].isFull,
							itemId: toPick[_i].itemId,
							itemStatus: toPick[_i].itemStatus,
							itemAmount: _oldPlusNewAmount-_slotMaxAmount
						}
						// Slot cheio
						var _newToPick = {
							
							isFull: toPick[_i].isFull,
							itemId: toPick[_i].itemId,
							itemStatus: toPick[_i].itemStatus,
							itemAmount: _slotMaxAmount
						}
						
						inventory[_y][_x] = _newToPick;
						toPick[_i] = _thiStructSlot;
						
					}
				}
			}
				
			else break;
		}
	}

	return inventory;
}


// Destroi antigo, cria novo, bota na lista FollowObjects
function fWithCreateInstanceInHands(instance) {
 	
	with(instance) {
		
		var _strObjHand = obj_config.itemsData[itemInHand];
		var _haveInstance = (instanceInHands != noone);
		
		// O Tool n usa o itemId, mas precisa pra n dar erro de run time
		var _struct = {status: itemSelectedStruct.itemStatus, itemId: itemInHand};

		// Destroi Objeto antigo
		if(_haveInstance) instance_destroy(instanceInHands);
		
		// Cria objeto novo
		instanceInHands = instance_create_layer(x , y, "Objects", _strObjHand.typeData, _struct);
		
		// Coloca nos objeto q segue o player
		array_insert(followObjects, 0, instanceInHands);
	}
}

// Checagem de quando criar ou destruir Objetos (quando usa a funçao: fWithCreateInstanceInHands(instance))
function fWithChangeInstanceHands(instance) {

	with(instance) {
		
		var _strObjHand = obj_config.itemsData[itemInHand];
		var _isTypeTrue = ((_strObjHand.type == ITEMS_TYPE.TOOLS) || (_strObjHand.type == ITEMS_TYPE.NO_ACTION));
		var _haveInstance = (instanceInHands != noone);
	
		if(_isTypeTrue) {
	
			var _InstExist = instance_exists(instanceInHands);
			
			var _isNewObject = (_InstExist) ? (instanceInHands.itemId != itemSelectedStruct.itemId) : false;
			
			// No action muda só o id
			var _NASameId = (_strObjHand.type == ITEMS_TYPE.NO_ACTION && _InstExist) ? (itemInHand == instanceInHands.itemId) : true;

			var _lastStruct = fGetSlotInventory(inventory, lastSelectedSlot);
			var _newStatus = (itemSelectedStruct.itemStatus != _lastStruct.itemStatus);
			
			if((_haveInstance == false) || _isNewObject ||  _newStatus) fWithCreateInstanceInHands(instance);
			
		}
		
		// Destroi a Instancia 
		else if(_haveInstance){
			
			instance_destroy(instanceInHands);
			
			instanceInHands = noone;
		}
	}
}

// Retorna o inventario depois de arrastar um item pra outro slot(ou n) do inventario
function fGetInventoryChangeSlotMouse(slotClick, slotStrClick, _inSLot, inventory, inventoryYX, _moveJustOne) {
		
	var _newInventory = undefined;	
		
	// Se n soltou no mesmo slot
	if(_inSLot != slotClick) {
						
		var _amoundId = inventoryYX.itemId;
		var _maxAmont = obj_config.itemsData[_amoundId].maxAmount;
						
		var _type1 = obj_config.itemsData[_amoundId];
		var _type2 = obj_config.itemsData[slotStrClick.itemId];
							
		var _sameType = (_type1 == _type2);
							
		var _sameStatus = (slotStrClick.itemStatus == inventoryYX.itemStatus);
				
		var _str01;
		var _str02;		
				
		// Se n é o mesmo tipo de item ou mesmo status
		if(!_sameType || !_sameStatus || _moveJustOne) {
							
			// Muda de lugar o item (inverte) ou muda só um item de lugar
			_str01 = inventoryYX;
			_str02 = slotStrClick;
		}
		// É o msm tipo de item, da pra juntar os dois
		else {
								
			// Structs
			_str01 = slotStrClick;		// Do clique
			_str02 = inventoryYX;	// Pra onde arrastou
								
			// Quantidade dos itens
			var _a01 = _str01.itemAmount;
			var _a02 = _str02.itemAmount;
								
			// Se somando as quantias da mais do q o maximo
			if(_a01 + _a02 > _maxAmont) {
								
				// Um fica como a soma menos o maximo do outro
				_str01.itemAmount = (_a01 + _a02 - _maxAmont);
				// E o outro fica com o maximo
				_str02.itemAmount = _maxAmont;
			}
			// Da pra colocar tudo em um
			else{
								
				// Un fica vazio
				_str01 = clearSlot;
				// O outro cheio
				_str02.itemAmount = (_a01 + _a02);
			}							
		}
		
		// Muda de lugar o item(ou nao)
		_newInventory = fSetSlotInventory(inventory, slotClick, _str01);
		_newInventory = fSetSlotInventory(_newInventory, _inSLot, _str02);
	}
	
	return _newInventory;
}

// Retorna sprite da struct do slot
function fGetIconInventory(_slotStruct) {

		var _itemId = _slotStruct.itemId;

		// Mesmo objeto, diferentes sprite.
		if(_itemId == ITEMS_ID.BOTTLE) {
					
			var _liquidId = _slotStruct.itemStatus.liquidId;
			
			return  obj_config.liquidsData[_liquidId].spriteBottle;
		}
		else if(_itemId == ITEMS_ID.POTION) {
		
			var _effectId = _slotStruct.itemStatus.effectId;
			
			return obj_config.effectsData[_effectId].spritePotion;
		}
		else return obj_config.itemsData[_itemId].sprite;	
}

// Dropa os items quando arrastados ou com input pra dropar com o inventario aberto
function fWithDropItemInventoryOpen(_instance, _slotDrop,  _dropAll) {

	with(_instance){

		var _x, _y, _scl;
		
		if(selectedSlot != _slotDrop) {
						
			var _xplus = choose(5,6,7,8,9,10);
			var _yplus = choose(-5, -2, 0, 2, 5);
			
			_x = (x + (_xplus * xScale));
			_y = (y + _yplus);
			_scl = xScale;
		}
		else {
			
			_x = instanceInHands.x;	
			_y = instanceInHands.y;
			_scl = instanceInHands.image_xscale;
		}
						
		isUpdateInvetory = true;
		if(_dropAll)	newInventory = fDropAllItems(inventory, _slotDrop, _x, _y, xScale);
		else			newInventory = fDropItem(inventory, _slotDrop, _x, _y, xScale);	
		fWithSetNewInventory(self);
						
		// Reseta as vars do click no slot do mouse
		slotClick = -1;
		slotStrClick = undefined;
	}
}

// Todo o codigo pra mudar slots de lugar com o mouse
function fWithInvetoryMouse(_instance) {

	with(_instance) {
	
		// Mexer itens com o mouse
		if(isInInventory) {

			#region Vars 
	
			var _viewWid = obj_camera.camWidth;
			var _viewHei = obj_camera.camHeight;
	
			// Cordenadas Mouse
			var _mouseX = display_mouse_get_x() div 1;
			var _mouseY = display_mouse_get_y() div 1;
	
			// Posição X Y
			var _yLen = array_length(inventory);
			var _defaultX = _viewWid div 14 * 2;
			var _defaultY = _viewHei div 12;
	
			// Tamanho usado
			var _sprSize = 64;
	
			// Slot atual no loop
			var _inSLot = 0;
	
			#endregion 
	
			for(var _y = 0; _y <_yLen; _y++) {
	
				for(var _x = 0; _x < array_length(inventory[_y]); _x++) {
		
					// Posição de cada sprite no loop
					var _xSpr	= (_defaultX + (_sprSize*_x));
					var _ySpr	= (_defaultY + (_sprSize*_y));
			
					#region Vars Colisao
				
					// Metade do tamanho do sprite de um sprite
					var _halfSprSize = _sprSize div 2;
			
					// Colisão X cada Slot
					var _slotColMaX		= _xSpr + _halfSprSize;
					var _slotColMinX	= _xSpr - _halfSprSize;
					// Colisão Y cada Slot
					var _slotColMaxY	= _ySpr + _halfSprSize;
					var _slotColMinY	= _ySpr - _halfSprSize;
				
					// Colisão X do Total do inventario
					var _maxXCol = _halfSprSize +(_defaultX + (_sprSize * (array_length(inventory[0])-1)));
					var _minXcol = _halfSprSize +(_defaultX - _sprSize);
					// Colisão Y do Total do inventario
					var _maxYcol = (_defaultY + (_sprSize * (_yLen)))	- _halfSprSize;
					var _minYcol = _defaultY							- _halfSprSize;
					
					
					#endregion
			
					// Se é sem relaçao com o item do crafting
					var _same1 = (slotClick == -1 || ((slotClick != craftIndexItem1) && (slotClick != craftIndexItem2)));
					var _same2 = ((_inSLot != craftIndexItem1) && (_inSLot != craftIndexItem2));

					var _canIteract = (_same1 && _same2);

					// Na caixa de colisao do slot
					if ((_mouseX >= _slotColMinX && _mouseX <= _slotColMaX) &&
						(_mouseY >= _slotColMinY && _mouseY <= _slotColMaxY)) {
						
						// Arrasta os items pra outro lugar quando solta
						// Se soltou o botao do mouse e ja armazenou a posiçao de um slot
						if(leftClickReleased && (slotClick != -1)) {
							
							// Slot n é pra crafting
							if(_canIteract) {
								
								var _sameStatus = (inventory[_y][_x].itemStatus == slotStrClick.itemStatus);
								var _sameItem = (inventory[_y][_x].itemId == slotStrClick.itemId);
								var _sameItemOrNoItem = ((inventory[_y][_x] == clearSlot) || _sameItem);
								var _moveJustOneItem = (moveOneItem && _sameItemOrNoItem && (slotStrClick.itemAmount > 1));
		
								if(_moveJustOneItem) {
							
									var _strOne = {

										isFull: true,
										itemId: slotStrClick.itemId,
										itemStatus: slotStrClick.itemStatus,
										itemAmount:	inventory[_y][_x].itemAmount+1
									}
									var _strMinusOne = {

										isFull: true,
										itemId: slotStrClick.itemId,
										itemStatus: slotStrClick.itemStatus,
										itemAmount:	slotStrClick.itemAmount-1
									}
								
									newInventory = fGetInventoryChangeSlotMouse(slotClick, _strOne, _inSLot, inventory, _strMinusOne, true);
								}
								else {
								
									newInventory = fGetInventoryChangeSlotMouse(slotClick, slotStrClick, _inSLot, inventory, inventory[_y][_x], false);
								}
							
								fWithSetNewInventory(self);
							}
							
							slotClick = -1;				// Reseta o slot do click
							slotStrClick = undefined;	// Reseta a var da struct do slot do click
						}

						// Armazena Slot Clicado se tem algo no slot
						if((leftClickPressed) && (slotClick == -1) && (inventory[_y][_x].isFull)) {
										
							slotClick = _inSLot;
					
							// Guarda struct do slot selecionado
							slotStrClick = fGetSlotInventory(inventory, slotClick);
						}
					
						// Dropa os itens
						// ARRUMAR
						else if (rightClickPressed && _canIteract) {
						
							var _strSlot = fGetSlotInventory(inventory, _inSLot);
							var _isFull = (_strSlot.isFull == 1);				
						
							// Se tiver item, da pra dropar
							// Da pra vc dropar o NADA kkkkk
							if(_isFull) { 
						
								fWithDropItemInventoryOpen(self, _inSLot, false);
							}
						}	
					}
		
					// Fora da col do inventario
					else if !((_mouseX > _minXcol && _mouseX < _maxXCol) &&
							(_mouseY > _minYcol && _mouseY < _maxYcol)) {
				
							// Se soltou um item fora do inventario
							if (leftClickReleased && (slotClick != -1)) {
								
								// Nao ta craftando algo
								if(isCrafting == false) {
									
									// Dropa o item
									fWithDropItemInventoryOpen(self, slotClick, true);
								}
								// N dropa
								else {
						
									slotClick = -1;				// Reseta o slot do click
									slotStrClick = undefined;	// Reseta a var da struct do slot do click
							}
						}
					}
			
					_inSLot++;	// Atualiza o slot atual
				}
			}
		}
		// Reseta as var do item q o mouse pode arrastar 
		// + Selecionar item por teclado
		else {
			
			slotClick = -1;
			slotStrClick = undefined;
	
			fWithSelectedSlot(_instance);
		}
	}
}
	
function fColletPickableItem(_self, _instance) {

	with(_instance) {
	
		// Ta na colisão e interagiu
		if(_self.colliding && _self.interacted) {
		
			show_debug_message("Interagiu")
		
			var _spaceInInventory = fHaveSpaceInInvetory(inventory, _self._id, _self.itemData.itemAmount)[0];
			var _newAmount = fHaveSpaceInInvetory(inventory, _self._id, _self.itemData.itemAmount)[1];
			var _noItemToPick = (array_length(toPick) == 0);
		
			// Tem espaço pro item
			if(_spaceInInventory == 1 && _noItemToPick) {
		
				// Adiciona as info desse objeto
				array_insert(toPick, array_length(toPick) , _self.itemData);
			
				instance_destroy(_self);
			}	
			// Tem espaço, mas n vai da pra colocar o amount iteiro
			else if(_spaceInInventory == 2) {
			
				var _itemCopy = {
				    isFull: _self.itemData.isFull,
				    itemId: _self.itemData.itemId,
				    itemStatus: _self.itemData.itemStatus,
				    itemAmount: _self.itemData.itemAmount - _newAmount // parte que vai pro inventário
				};
			
				array_insert(toPick, array_length(toPick), _itemCopy);
			
				show_debug_log(_newAmount);
			
				// Atualiza o objeto no chão com o que sobrou
				_self.itemData.itemAmount = _newAmount;
			
			}
			else show_debug_message("Inventory full");
		}
		
		_self.interacted = false;
	}
}
#endregion

#endregion
