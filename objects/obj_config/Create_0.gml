randomize();	// Gera uma seed aleatoria

enum CONSTANTS
{
	SPD_GAME = 60,
	GRID = 32
}

enum DIR
{
	RIGHT = 1,
	LEFT = -1,
	NONE = 0,
	JUMP = -1,
	FALL = 1
}

#region Effects

enum EFFCTS_TYPE {
	
	STATUS = 0,
	RESISTANCE = 1,
	CONDITIONS = 2,
	SPECIAL = 3
}

#region Efeitos 

var _sizeEffects = 5
enum EFFCTS
{
	NOTHING = 0,
	WATER = 1,
	FIRE = 2,
	BIG_JUMP = 3, 
	MORE_DAMAGE = 4,
}

effectsData = array_create(_sizeEffects);
effectsData[EFFCTS.NOTHING] = {

	spritePotion: spr_potion_damage
}
effectsData[EFFCTS.WATER] = {

	spritePotion: spr_potion_damage
}
effectsData[EFFCTS.FIRE] = {

	spritePotion: spr_potion_damage
}
effectsData[EFFCTS.BIG_JUMP] = {

	spritePotion: spr_potion_jump
}
effectsData[EFFCTS.MORE_DAMAGE] = {

	spritePotion: spr_potion_damage
}

#endregion

#region Efeitos que possuem duração

// Isso é pra organizar todos os efeitos em um só alarme
// alem de poder mostrar o sprite e descrição
// Assim: effectsAlarm = array_create(global.lenAlarmEffects, 0);

global.lenAlarmEffects = 3;
enum EFFECTS_ALARMS {

	ALARM_FIRE = 0,
	ALARM_BIG_JUMP = 1,
	ALARM_MORE_DAMAGE=  2, 
}

infoEffects = array_create(global.lenAlarmEffects);
infoEffects[EFFECTS_ALARMS.ALARM_FIRE] = {

	sprite: spr_effect_big_jump,
	description: "Você está pegando fogo!"
}
infoEffects[EFFECTS_ALARMS.ALARM_BIG_JUMP] = {

	sprite: spr_effect_big_jump,
	description: "Seu pulo está mais alto."
}
infoEffects[EFFECTS_ALARMS.ALARM_MORE_DAMAGE] = {

	sprite: spr_effect_more_damage,
	description: "Dano aumentado."
}
#endregion

#endregion


#region ITEMS

// Sempre alterar
var _sizeItemsType = 3;
enum ITEMS_TYPE
{
	NO_TYPE = 0,
	NO_ACTION = 1,
	TOOLS = 2
}

// Sempre alterar
var _sizeItemsId = 8;
enum ITEMS_ID
{	
	NOTHING = 0,
	GENERIC = 1,
	BOTTLE	= 2,
	WEAPON = 3, 
	EMPTY_BOTTLE = 4,
	PLANT_BLUE = 5,
	POTION = 6,
	PLANT_RED = 7
}

// Tem as informações dos items sem ação, os ingredientes(todos sao um mesmo item com info diferente)
// Por isso precisa de uma struct propria
#region Struct dos itens NoAction

itemsNoActionData = array_create(_sizeItemsId);

itemsNoActionData[ITEMS_ID.POTION] = {
	
	canUse: true,
	xPlus: 15,
	heal: 0,
	// Em poções o efeito é aplicado pelo status
	effect: EFFCTS.NOTHING
}

itemsNoActionData[ITEMS_ID.GENERIC] = {
	
	canUse: true,
	xPlus: 15,
	heal: 10,
	effect: EFFCTS.NOTHING
}
itemsNoActionData[ITEMS_ID.EMPTY_BOTTLE] = {
	
	canUse: false,
	xPlus: 20,
	heal: 0,
	effect: EFFCTS.NOTHING
}
itemsNoActionData[ITEMS_ID.PLANT_BLUE] = {
	
	canUse: true,
	xPlus: 15,
	heal: 2,
	effect: EFFCTS.NOTHING
}
itemsNoActionData[ITEMS_ID.PLANT_RED] = {
	
	canUse: true,
	xPlus: 15,
	heal: -5,
	effect: EFFCTS.NOTHING
}	
#endregion


#region Array com struct dos itens pro ! INVENTARIO ! 

/* Obs:

	typeData é o objeto. N sei pq eu dei esse nome, mas fds kkkkkk
*/
itemsData = array_create(_sizeItemsId);

itemsData[ITEMS_ID.NOTHING] = {

	sprite: spr_noone,
	type: ITEMS_TYPE.NO_TYPE,
	typeData: obj_noone,
	maxAmount: 0

};
	
// No action
itemsData[ITEMS_ID.POTION] = {
	
	// Sprite generico 
	sprite: spr_bottle_empty,
	type: ITEMS_TYPE.NO_ACTION,
	typeData: obj_itemNoAction,
	maxAmount: 1
};
itemsData[ITEMS_ID.GENERIC] = {

	sprite: spr_item_generic,
	type: ITEMS_TYPE.NO_ACTION,
	typeData: obj_itemNoAction,
	maxAmount: 5
};
itemsData[ITEMS_ID.EMPTY_BOTTLE] = {

	sprite: spr_bottle_empty,
	type: ITEMS_TYPE.NO_ACTION,
	typeData: obj_itemNoAction,
	maxAmount: 3
};
itemsData[ITEMS_ID.PLANT_BLUE] = {

	sprite: spr_plant_blue,
	type: ITEMS_TYPE.NO_ACTION,
	typeData: obj_itemNoAction,
	maxAmount: 5
};
itemsData[ITEMS_ID.PLANT_RED] = {

	sprite: spr_plant_red,
	type: ITEMS_TYPE.NO_ACTION,
	typeData: obj_itemNoAction,
	maxAmount: 5
};

// Tools
itemsData[ITEMS_ID.BOTTLE]	= {

	sprite: spr_bottle_water,
	type: ITEMS_TYPE.TOOLS,
	typeData:  obj_bottle,
	maxAmount: 1
}
itemsData[ITEMS_ID.WEAPON]	= {

	sprite: spr_weapon,
	type: ITEMS_TYPE.TOOLS,
	typeData:  obj_weapon,
	maxAmount: 1
}


#endregion

#endregion


#region LIQUIDOS

// Sempre alterar quando adicionar um novo liquido
var _sizeLiquidsId = 4;
enum LIQUIDS_ID 
{
	WATER	= 0,
	BLOOD	= 1,
	ACID	= 2,
	LAVA	= 3
}

#region LIQUIDS STRUCT

liquidsData	= array_create(_sizeLiquidsId); // Struct dos liquidos

liquidsData[LIQUIDS_ID.WATER] = {
	
	spriteBottle: spr_bottle_water,
	color: make_color_rgb(33, 182, 239),
	amount: 5,
	maxLiquidAmount: 100,
	damage: 0,
	slow: 1, 
	effect: EFFCTS.WATER,
};
liquidsData[LIQUIDS_ID.BLOOD] = {
	
	spriteBottle: spr_bottle_blood,
	color: make_color_rgb(102, 7, 9),
	amount: 5,
	maxLiquidAmount: 200,
	damage: 0,
	slow: 0.6, 
	effect: EFFCTS.NOTHING,
};
liquidsData[LIQUIDS_ID.ACID] = {
	
	spriteBottle: spr_bottle_acid,
	color: make_color_rgb(197, 255, 50),
	amount: 3,
	maxLiquidAmount: 60,
	damage: 4,
	slow: 1, 
	effect: EFFCTS.NOTHING,
};
liquidsData[LIQUIDS_ID.LAVA] = {
	
	spriteBottle: spr_bottle_lava,
	color: make_color_rgb(248, 146, 24),
	amount: 3,
	maxLiquidAmount: 40,
	damage: 2,
	slow: 1, 
	effect: EFFCTS.FIRE,
};

#endregion

#endregion


// Define a velocida dos frames do jogo
game_set_speed(60, gamespeed_fps);
window_set_fullscreen(true);