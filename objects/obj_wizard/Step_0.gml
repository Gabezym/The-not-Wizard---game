#region Keybinds

escape			= keyboard_check_pressed(keyEscape);

right			= keyboard_check(keyRight);
left			= keyboard_check(keyLeft);
jump			= keyboard_check(keyJump);
inputInventory	= keyboard_check_pressed(keyInventory);
interact		= keyboard_check_pressed(keyInteract);
changeIndex		= keyboard_check_pressed(keyChangeIndex);
moveOneItem		= keyboard_check(keyMoveOneItem);

leftClick			= mouse_check_button(mouseLeftClick);
leftClickReleased	= mouse_check_button_released(mouseLeftClick);
leftClickPressed	= mouse_check_button_pressed(mouseLeftClick);

rightClick			= mouse_check_button_pressed(mouseRightClick)
rightClickPressed	= mouse_check_button_pressed(mouseRightClick);

#region Inventario Keys + CraftingKeys + escape

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


slot1	= keyboard_check_pressed(keySlot1);
slot2	= keyboard_check_pressed(keySlot2);
slot3	= keyboard_check_pressed(keySlot3);
slot4	= keyboard_check_pressed(keySlot4);
slot5	= keyboard_check_pressed(keySlot5);

#endregion

#endregion

isInLadder = place_meeting(x, y+spd+15, obj_collision_ladder);

// Se ficar preso
fStuck(self);

// Movimentação
fWithMovementHvalVval(self);

// Estamina
fWithEstamina(self);

// Slow padrão 
slow = fResetSlow(self);

#region Effects

if(fWithHasEffects(self)) {

}


// Efeito Big jump
fWithStepEfBigJump(self);

// Particulas fogo
fWithSpawParticleFire(self);

#endregion

// Colisão XY 
fWithCollisionPlayer(self);

// Crafting
if(isCrafting) {

	var _mx = display_mouse_get_x();
	var _my = display_mouse_get_y();
	
	// Colisao das caixas
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
	
	
	// Colisoes com mouse
	var _colb1 = point_in_rectangle(_mx, _my, _b1cx1, _bcy1, _b1cx2, _bcy2);
	var _colb2 = point_in_rectangle(_mx, _my, _b2cx1, _bcy1, _b2cx2, _bcy2);
	var _coldone = point_in_rectangle(_mx, _my, _donecx1, _donecy1, _donecx2, _donecy2);

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
	
	// Mouse no botao pra craftar
	if(_coldone) {
		
		// Se clicou e tem items nos slots de crafting 
		if(leftClickPressed && craftIndexItem1 != -1 && craftIndexItem2 != -1) {
			
			var _item1 = fGetSlotInventory(inventory, craftIndexItem1);
			var _item2 = fGetSlotInventory(inventory,craftIndexItem2);
		
			var _item2Type = obj_config.itemsData[_item2.itemId].type;
		
		
			var _isBott	= (_item1.itemId == ITEMS_ID.BOTTLE);
			var _isIng	= (_item2Type == ITEMS_TYPE.NO_ACTION);
			
			if(_isBott && _isIng) {
		
				var _liquidId	= _item1.itemStatus.liquidId;
				var _itemId		= _item2.itemId;
			
				var _canCraft	= false;
				var _effect		= 0;
			
				if(_liquidId == LIQUIDS_ID.WATER) {
			
					switch(_itemId) {
				
						case ITEMS_ID.PLANT_BLUE: 
					
							_effect		= EFFCTS.BIG_JUMP;
							_canCraft	= true;
						break;
					}
				}
						
				if(_canCraft) {
			
					var _status = {
				
						effectId: _effect, 
						effectType: EFFCTS_TYPE.STATUS
					}
					var _potionStr = {
				
						isFull: true,
						itemId: ITEMS_ID.POTION,
						itemStatus: _status,
						itemAmount: 1
					}
			
					// Adiciona as info desse objeto
					array_insert(toPick, array_length(toPick), _potionStr);
				
					// Remove os items do crafting
					newInventory = fRemoveOneItemSlotInventory(inventory, craftIndexItem1);
					newInventory = fRemoveOneItemSlotInventory(newInventory, craftIndexItem2);
				
					// Pra checar se algum item chegou a 0
					isUpdateInvetory = true; 
				
					fWithSetNewInventory(self);
					
					craftIndexItem1 = -1;
					craftIndexItem2 = -1;
				}
			}
		}
	}
}


// Inventario
fWithInventory(self);


// Input Interaçao + index interação
var _lenIA = array_length(interactionObjects);
if(_lenIA != 0) {
	
	// Muda qual objeto esta interagindo
	if(changeIndex) {
		
		if(indexAI+1 >= _lenIA) indexAI = 0;
		else					indexAI++;
	}
	
	if(instance_exists(interactionObjects[indexAI])) {
		
		var _objInter = interactionObjects[indexAI];
			
		interactionObjects[indexAI].colliding = true;
	
		// Manda input pro objeto
		if(interact) {

			interactionObjects[indexAI].interacted = true;
		}
	}
}
else {
	
	indexAI = 0;
}

// Input pro objeto inventario
var _id = fGetSlotInventory(inventory, selectedSlot).itemId;

isInputItem			= fIsInputItem(leftClick, alarm[0], isInInventory, _id);
isInputPressedItem	= fIsInputItem(leftClickPressed, 0, isInInventory, _id);
isInputItem2		= fIsInputItem(rightClick, alarm[0], isInInventory, _id);