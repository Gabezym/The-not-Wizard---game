_id = ITEMS_ID.BOTTLE;


var _liquidId = LIQUIDS_ID.ACID;
var _liquidAmount = obj_config.liquidsData[_liquidId].maxLiquidAmount;

status = {liquidId: _liquidId, liquidAmount: _liquidAmount};

// Inherit the parent event
event_inherited();

