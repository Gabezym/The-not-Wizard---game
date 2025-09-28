// Mesmo objeto, diferentes sprite.
if(_id == ITEMS_ID.BOTTLE) {
					
	var _liquidId = status.liquidId;
			
	_spr = obj_config.liquidsData[_liquidId].spriteBottle;
}
else _spr = obj_config.itemsData[_id].sprite;	

// Sprite
sprite_index = _spr;
mask_index = sprite_index;


// Fisica
grav = 0.3;
hval = _valHval;
vval = _valVval;
angl = _angl;

valAngl = _valHval
spdAngl = 0.85*_valHval;
spdMinAngl = 0.2*_valHval;
cooldownAngl = CONSTANTS.SPD_GAME * 0.1;

// Sprite do draw
spr = sprite_index;

// Col vars
addCol = 10;
colW = sprite_get_width(sprite_index) + addCol;
colH = sprite_get_height(sprite_index) + addCol;

// Se foi coletado
isInteracted = false;

// Se ta colidindo com o player(raio de interaçao)
isNextToPlayer = false;

itemData = {
	
	isFull: 1,
	itemId: _id,
	itemStatus: status,
	itemAmount: amount
}