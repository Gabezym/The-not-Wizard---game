#region Encurtar codigo

function fWithDrawItems(instance, side) {

	with(instance) {
		
		var _lenArrF = array_length(followObjects); 
		if(_lenArrF > 0) {

			// De tras pra frente
			for(var _i = _lenArrF-1; _i >=0; _i-- ) {
		
				var _instance = followObjects[_i];
		
				if(instance_exists(_instance)) {
					
					var _valSide = side;
					
					if(_instance.object_index != obj_attack) {
					
						draw_sprite_ext(_instance.sprite_index, 1, _instance.x, _instance.y, _instance.image_xscale*side, _instance.image_yscale, _instance.image_angle, c_white, _instance.image_alpha);
					}
					else draw_sprite_ext(_instance.sprite_index, 1, _instance.x, _instance.y, _instance.image_xscale, _instance.image_yscale*side, _instance.image_angle, c_white, _instance.image_alpha);
				}
			}
		}
	}
}

#endregion

function fDrawInventory(_instance) {

	with(_instance)	{
		
		var _viewWid = obj_camera.camWidth;
		var _viewHei = obj_camera.camHeight;
		
		#region Vars inventario
	
		// Sprites usados
		var _sprBa = inventorySprBackground;
		var _sprBo = inventorySprBorder;
		var _sprSe = inventorySprSelected;
		var _sprPl = inventorySprPlate;
	
		// Tamanho dos Sprites usados
		var _sprSize = sprite_get_width(inventorySprBackground);
		var _sprWidPl = sprite_get_width(_sprPl);
		var _sprHeidPl = sprite_get_height(_sprPl);
	
	
		// Posição X Y
		var _yLen = array_length(inventory);
		var _defaultX = _viewWid div 14 * 2;
		var _defaultY = _viewHei div 12;
	
		// Cordenadas Mouse
		var _mouseX = display_mouse_get_x();
		var _mouseY = display_mouse_get_y();
	
	
		// Slot atual no loop
		var _inSLot = 0;
	

		// Determina se é o inventario pequeno ou completo
		if(isInInventory) _yLen = array_length(inventory);
		else _yLen = 1;
	
		#endregion
		
		// Back 
		for(var _y = 0; _y < _yLen; _y++) {
	
			// Linhas
			for(var _x = 0; _x < array_length(inventory[_y]); _x++) {
				
				// Posição de cada sprite no loop
				var _xSpr	= (_defaultX + (_sprSize*_x));
				var _ySpr	= (_defaultY + (_sprSize*_y));

				#region Sprites inventario
			
				// Fundo dos slots
				draw_sprite(_sprBa, 1, _xSpr, _ySpr);
				// Borda dos slots 
				draw_sprite(_sprBo, 1, _xSpr, _ySpr);
				// Seleção do slot
				if(selectedSlot == _inSLot) {
			
					draw_sprite(_sprSe, 1, _xSpr, _ySpr);
				}
			
				#endregion

				_inSLot++;	// Atualiza o slot atual
			}
		}
	
		_inSLot = 0;
	
		// Icons
		for(var _y = 0; _y < _yLen; _y++) {
	
			// Linhas
			for(var _x = 0; _x < array_length(inventory[_y]); _x++) {
				
				// Posição de cada sprite no loop
				var _xSpr	= (_defaultX + (_sprSize*_x));
				var _ySpr	= (_defaultY + (_sprSize*_y));
				
				var _inventoryPos = fGetPositionInventory(inventory, inventory[_y][_x]);
				var _amount =	inventory[_y][_x].itemAmount;
							
				// Se for o mesmo slot usado no craft, tira d mentirinha
				// um item do slot
				if (_inventoryPos == craftIndexItem1) _amount--;
				if (_inventoryPos == craftIndexItem2) _amount--;

				// Icone e plaquina
				if(inventory[_y][_x].isFull && _amount > 0) {
		
					// Var pro Icone
					var _sprIcon = 0;
			
					// Icone no lugar padrão
					if((_inSLot != slotClick)) {
				
						_sprIcon = fGetIconInventory(inventory[_y][_x]);
				
						draw_sprite(_sprIcon, 1, _xSpr, _ySpr);
					}
	
					#region Plaquinha pro texto
			
					var _xpl = _xSpr;
					var _ypl = _ySpr + 5 + _sprHeidPl;
			
					draw_sprite(_sprPl, 1, _xpl, _ypl);
			
					draw_set_font(font_default);
			
					draw_set_halign(fa_center);
			
					draw_set_valign(fa_middle);
			
					var _strScl = 0.2;
			
					var _amoundId = inventory[_y][_x].itemId;
					var _maxAmont = obj_config.itemsData[_amoundId].maxAmount;
					var _strAmount = _amount;	
				
					var _string = "";
				
					// Porcentagem do liquido
					if(_amoundId == ITEMS_ID.BOTTLE) {
				
						var _status = inventory[_y][_x].itemStatus
					
						var _liquidAmount = _status.liquidAmount;
						var _MaxliquidAmount = obj_config.liquidsData[_status.liquidId].maxLiquidAmount;
					
						var _percentage = (_liquidAmount/_MaxliquidAmount) * 100;
				
						_string = string(_percentage) + "%";
					}
					// Qunatos items tem
					else _string = string(_strAmount) + "/" + string(_maxAmont);
			
					draw_text_ext_transformed(_xpl, _ypl-5, _string, 5, _sprWidPl, _strScl, _strScl, 1);
			
					draw_set_valign(-1);
			
					draw_set_halign(-1);
			
					draw_set_font(-1);
			
					#endregion
					
					// Se tiver uma struct pra ele (ta segurando o click)
					// Icone no Mouse
					if(slotStrClick != undefined ) {
				
						_sprIcon = fGetIconInventory(slotStrClick);
						
						draw_sprite(_sprIcon, 1, _mouseX, _mouseY);
					}
				}
				
				_inSLot++;	// Atualiza o slot atual
			}
		}
	}
}

function fDrawCharacterAndItems(_instance) {

	with(_instance) {
	
		var _isLookingToLeft = (sign(xScale) < 0);
		var _aX = x+armX;
		var _aY = y+armY;
		var _ang = point_direction(_aX, _aY, mouse_x, mouse_y) + 90;
		
		var _haveItemInHands = (itemSelectedStruct != clearSlot);
		
		// Na esquerda, atras do sprite
		if((_isLookingToLeft == true) && stopCondition == false && _haveItemInHands) { 
	
			// Desenha Arm
			draw_sprite_ext(spr_wizard_arm, 1, _aX, _aY, -xScaleVal, xScaleVal, _ang, c_white, 1);
			
			fWithDrawItems(_instance, -1);
		}

		draw_self();

		// Na direita, na frente do sprite
		if((_isLookingToLeft == false) && stopCondition == false && _haveItemInHands) {
			
			fWithDrawItems(_instance, 1)
			
			// Desenha Arm
			draw_sprite_ext(spr_wizard_arm, 1, _aX, _aY, xScaleVal, xScaleVal, _ang, c_white, 1);
		}
	}
}