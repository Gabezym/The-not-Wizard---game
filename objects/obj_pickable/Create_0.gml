/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Cooldown antes de poder pegar o item
alarmCooldownPick = 1;
alarm[alarmCooldownPick] = CONSTANTS.SPD_GAME * 0.25;

#region Sprite

// Mesmo objeto, diferentes sprite.
if(_id == ITEMS_ID.BOTTLE) {
					
	var _liquidId = status.liquidId;
			
	_spr = obj_config.liquidsData[_liquidId].spriteBottle;
}
else if(_id == ITEMS_ID.POTION) {
	
	_spr = obj_config.effectsData[status.effectId].spritePotion;
}
else _spr = obj_config.itemsData[_id].sprite;	

sprite_index = _spr;
mask_index = sprite_index;

#endregion

#region Fisica

grav = 0.3;
hval = _valHval;
vval = _valVval;
angl = _angl;

valAngl = _valHval
spdAngl = 0.85*_valHval;
spdMinAngl = 0.2*_valHval;
cooldownAngl = CONSTANTS.SPD_GAME * 0.1;

#endregion

// Sprite do draw
spr = sprite_index;
colH = sprite_get_height(sprite_index);
colW = sprite_get_width(sprite_index);

// Se foi coletado
isInteracted = false;

itemData = {
	
	isFull: 1,
	itemId: _id,
	itemStatus: status,
	itemAmount: amount
}
