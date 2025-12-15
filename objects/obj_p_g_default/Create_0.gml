// Mesmo objeto, diferentes sprite.
if(_id == ITEMS_ID.BOTTLE) {
					
	var _liquidId = status.liquidId;
			
	_spr = obj_config.liquidsData[_liquidId].spriteBottle;
}
else _spr = obj_config.itemsData[_id].sprite;	

// Informações de fisica Padrao
_gravVal = 0.4;
_grav = 0.4;
_spd = 0;
_valHval = 0;	// Valor usado
_valVval = 0;	// Valor usado

// Quantidade de itens
amount = obj_config.itemsData[_id].maxAmount;

// Inherit the parent event
event_inherited();

