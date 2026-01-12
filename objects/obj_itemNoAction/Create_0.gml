// Inherit the parent event
event_inherited();

// Sprite das poções
if(itemId == ITEMS_ID.POTION)	spr = obj_config.effectsData[status.effectId].spritePotion;
else							spr = obj_config.itemsData[itemId].sprite;

// Fisica
//grav = 1
//hval = 0;
//vval = 0;
// Vars do Draw
//inHands = true;

sprite_index = spr;


