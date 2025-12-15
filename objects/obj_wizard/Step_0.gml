stopCondition = (isInInventory || inText);

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

interact = (stopCondition || alarm[alarmInt] > 0 ? false : interact);
changeIndex = (stopCondition? false : changeIndex);
inputInventory = (inText? false: inputInventory);

// Cooldown entre interações
alarm[alarmInt] = (interact? cooldownInteraction : alarm[alarmInt]);

#region Inputs com condições

#region Input + index (interagiveis scenario)

var _lenIA = array_length(interactionObjects);
if(_lenIA != 0) {
	
	// Muda qual objeto esta interagindo
	if(changeIndex) {
		
		if(indexAI+1 >= _lenIA) indexAI = 0;
		else					indexAI++;
	}
	
	if(instance_exists(interactionObjects[indexAI])) {
		
		var _objInter = interactionObjects[indexAI];
	
		// Manda input pro objeto
		if(interact) {

			interactionObjects[indexAI].interacted = true;
		}
	}
}
else {
	
	indexAI = 0;
}

#endregion

#region Input pro objeto na mão

var _id = fGetSlotInventory(inventory, selectedSlot).itemId;

isInputItem			= fIsInputItem(leftClick, alarm[0], stopCondition, _id);
isInputPressedItem	= fIsInputItem(leftClickPressed, 0, stopCondition, _id);
isInputItem2		= fIsInputItem(rightClick, alarm[0], stopCondition, _id);

#endregion

#endregion

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

// Se ficar preso
fStuck(self);

// Se n tomou dano -> movimentação
if(recoilXDmg == 0 && recoilYDmg == 0) {
	
	// Movimentação
	fWithMovementHvalVval(self);
}
// Reseta vars
else {

	isInInventory = false;
	isCrafting = false;
	craftIndexItem1 = -1;
	craftIndexItem2 = -1;
	hval = 0;
	vval = 0;
}

// Estamina
fWithEstamina(self);

// Slow padrão 
slow = fResetSlow(self, false);

// Efeitos
fWithEffectsPlayer(self);

// Crafting
fWithCraftingPotions(self);

// Inventario
fWithInventory(self);
