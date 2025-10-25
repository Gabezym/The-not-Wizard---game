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

	
	// Colisoes com mouse
	var _colb1 = point_in_rectangle(_mx, _my, _b1cx1, _bcy1, _b1cx2, _bcy2);
	var _colb2 = point_in_rectangle(_mx, _my, _b2cx1, _bcy1, _b2cx2, _bcy2);
	

	// Mouse dentro de uma das caixas de colisão
	if(_colb1 || _colb2) {
	
		// Se soltou o botao do mouse e ja armazenou a posiçao de um slot
		if(leftClickReleased && (slotClick != -1)) {
		
			
			if(_colb1)	craftIndexItem1 = slotClick;
			else		craftIndexItem2 = slotClick;
		}
		
		// Tirar item do slot
		if(rightClickPressed) {
		
			if(_colb1)	craftIndexItem1 = -1;
			else		craftIndexItem2 = -1;
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