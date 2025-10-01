#region Keybinds

right			= keyboard_check(keyRight);
left			= keyboard_check(keyLeft);
jump			= keyboard_check(keyJump);
inputInventory	= keyboard_check_pressed(keyInventory);
interact		= keyboard_check_pressed(keyInteract);

leftClick			= mouse_check_button(mouseLeftClick);
leftClickReleased	= mouse_check_button_released(mouseLeftClick);
leftClickPressed	= mouse_check_button_pressed(mouseLeftClick);

rightClick			= mouse_check_button_pressed(mouseRightClick)
rightClickPressed	= mouse_check_button_pressed(mouseRightClick);

#region Inventario Keys

// Abre e fecha o inventario
isInInventory = fInputOnOff(inputInventory, isInInventory);

slot1	= keyboard_check_pressed(keySlot1);
slot2	= keyboard_check_pressed(keySlot2);
slot3	= keyboard_check_pressed(keySlot3);
slot4	= keyboard_check_pressed(keySlot4);
slot5	= keyboard_check_pressed(keySlot5);

#endregion

#endregion

isInLadder = place_meeting(x, y+spd+15, obj_collision_ladder);

fWithMovementHvalVval(self);

// Estamina
fWithEstamina(self);

#region Effects

slow = fResetSlow(self);

fWithSpawParticleFire(self);

#endregion

// Colisão XY 
fWithCollisionPlayer(self);

// Inventario
fWithInventory(self);

// Ta enviando input pro objeto?
var _id = fGetSlotInventory(inventory, selectedSlot).itemId;

isInputItem			= fIsInputItem(leftClick, alarm[0], isInInventory, _id);
isInputPressedItem	= fIsInputItem(leftClickPressed, 0, isInInventory, _id);
isInputItem2		= fIsInputItem(rightClick, alarm[0], isInInventory, _id);