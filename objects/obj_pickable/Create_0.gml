/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Cooldown antes de poder pegar o item
alarmCooldownPick = 1;
alarm[alarmCooldownPick] = CONSTANTS.SPD_GAME * 0.25;

// Cooldown ante de poder dar dano no item
alarmCooldownDmg = 0;
alarm[alarmCooldownDmg] = CONSTANTS.SPD_GAME * 0.25;

// Se foi coletado
isInteracted = false;

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

// Sprite do draw
spr = sprite_index;
colH = sprite_get_height(sprite_index);
colW = sprite_get_width(sprite_index);

#endregion

#region Fisica + hit

grav = 0.3;
hval = _valHval;
vval = _valVval;
angl = (_id != ITEMS_ID.WEAPON)? 0 : obj_mouse.mouseAnglePlayer;

scale = 1;	// Xscale
if(hval < 0) scale = -1;

sideAngl = sign(_valHval);	// Lado do giro
spdAngl = 0.85 * abs(hval);	// Velocidade do giro
 
// Dano
life = 3;
isHit = false;	// Se recebeu dano
side = 0;		// Lado que recebeu dano

#endregion

itemData = {
	
	isFull: 1,
	itemId: _id,
	itemStatus: status,
	itemAmount: amount
}
