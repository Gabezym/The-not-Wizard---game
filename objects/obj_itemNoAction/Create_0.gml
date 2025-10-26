// Vars de parametro
// itemId
// status

// Sprite das poções
if(itemId == ITEMS_ID.POTION)	spr = obj_config.effectsData[status.effectId].spritePotion;
else							spr = obj_config.itemsData[itemId].sprite;

// Fisica
//grav = 1
hval = 0;
vval = 0;
xPlus = obj_config.itemsNoActionData[itemId].xPlus;
// Vars do Draw
scale = 1;
inHands = true;

sprite_index = spr
