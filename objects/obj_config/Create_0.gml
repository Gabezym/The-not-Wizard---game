randomize();	// Gera uma seed aleatoria

enum CONSTANTS
{
	SPD_GAME = 60,
	GRID = 32
}

#region Effects

// Tipo do efeito (pra organizar melhor)
enum EFFCTS_TYPE {
	
	NOONE = 0,
	STATUS = 1,			// Altera status (poção)
	RESISTANCE = 2,		// Aumenta resistencia de algum dano (poção)
	CONDITIONS = 3,		// Aplica alguma condição diversa
	SPECIAL = 4			// Transformações (poção)
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
	MORE_TOXICITY = 5,
}

#region Efeitos que possuem duração (leia descrição abaixo)

// Isso é pra organizar todos os efeitos em um só alarme
// alem de poder mostrar o sprite e descrição
// Assim: effectsAlarm = array_create(global.lenAlarmEffects, 0);

global.lenAlarmEffects = 3;
enum EFFECTS_ALARMS {

	ALARM_FIRE = 0,
	ALARM_BIG_JUMP = 1,
	ALARM_MORE_DAMAGE=  2, 
}

// Essas são as informações de HUD sobre os efeitos
#region Database

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

#region Database dos effects 

effectsData = array_create(_sizeEffects);
effectsData[EFFCTS.NOTHING] = {

	spritePotion: spr_potion_damage,
	toxicity: 0,
	effectType: EFFCTS_TYPE.NOONE,
	duration: 0,
	effectAlarm: -1
}
effectsData[EFFCTS.WATER] = {

	spritePotion: spr_potion_damage,
	toxicity: 0,
	effectType: EFFCTS_TYPE.NOONE,
	duration: 0,
	effectAlarm: EFFECTS_ALARMS.ALARM_FIRE
}
effectsData[EFFCTS.FIRE] = {

	spritePotion: spr_potion_damage,
	toxicity: 0,
	effectType: EFFCTS_TYPE.CONDITIONS,
	duration: 5,
	effectAlarm: EFFECTS_ALARMS.ALARM_FIRE
}
effectsData[EFFCTS.BIG_JUMP] = {

	spritePotion: spr_potion_jump,
	toxicity: 10,
	effectType: EFFCTS_TYPE.STATUS,
	duration: 25,
	effectAlarm: EFFECTS_ALARMS.ALARM_BIG_JUMP
}
effectsData[EFFCTS.MORE_DAMAGE] = {

	spritePotion: spr_potion_damage,
	toxicity: 15,
	effectType: EFFCTS_TYPE.STATUS,
	duration: 25,
	effectAlarm: EFFECTS_ALARMS.ALARM_MORE_DAMAGE
}
effectsData[EFFCTS.MORE_TOXICITY] = {	// Apenas aumenta a toxicidade

	spritePotion: spr_potion_damage,
	toxicity: 15,
	effectType: EFFCTS_TYPE.NOONE,
	duration: 0,
	effectAlarm: -1
}

#endregion

#endregion

#endregion


#region ITEMS

var _sizeItemsType = 3;
enum ITEMS_TYPE
{
	NO_TYPE = 0,
	NO_ACTION = 1,
	TOOLS = 2
}

var _sizeItemsId = 8;
enum ITEMS_ID
{	
	NOTHING = 0,
	PLANT_HEAL = 1,
	BOTTLE	= 2,
	WEAPON = 3, 
	EMPTY_BOTTLE = 4,
	PLANT_BLUE = 5,
	POTION = 6,
	PLANT_RED = 7
}

// Tem as informações dos items sem ação, os ingredientes(todos sao um mesmo item com info diferente)
// Por isso precisa de uma struct propria
#region Dados dos itens NoAction

itemsNoActionData = array_create(_sizeItemsId);

var _spawnNothing = {

	item: ITEMS_ID.NOTHING,
	itemAmount: 0
};

itemsNoActionData[ITEMS_ID.POTION] = {
	
	canUse: true,
	heal: 0,
	// Em poções o efeito é aplicado pelo status
	effect: EFFCTS.NOTHING,
	spawnDeath: _spawnNothing,
	spawnFireDeath: _spawnNothing
}

itemsNoActionData[ITEMS_ID.PLANT_HEAL] = {
	
	canUse: true,
	heal: 40,
	effect: EFFCTS.MORE_TOXICITY,
	spawnDeath: _spawnNothing,
	spawnFireDeath: _spawnNothing
}
itemsNoActionData[ITEMS_ID.EMPTY_BOTTLE] = {
	
	canUse: false,
	heal: 0,
	effect: EFFCTS.NOTHING,
	spawnDeath: _spawnNothing,
	spawnFireDeath: _spawnNothing
}
itemsNoActionData[ITEMS_ID.PLANT_BLUE] = {
	
	canUse: true,
	heal: 2,
	effect: EFFCTS.NOTHING,
	spawnDeath: {
			item: ITEMS_ID.PLANT_HEAL,
			itemAmount: 3
	},
	spawnFireDeath: _spawnNothing
}
itemsNoActionData[ITEMS_ID.PLANT_RED] = {
	
	canUse: true,
	heal: -5,
	effect: EFFCTS.NOTHING,
	spawnDeath: _spawnNothing,
	spawnFireDeath: {
			item: ITEMS_ID.PLANT_BLUE,
			itemAmount: 3
	}
}	
#endregion


#region Dados dos itens pro INVENTARIO 

/* Obs:

	typeData é o objeto. N sei pq eu dei esse nome, mas fds kkkkkk
*/
itemsData = array_create(_sizeItemsId);

itemsData[ITEMS_ID.NOTHING] = {

	sprite: spr_noone,
	type: ITEMS_TYPE.NO_TYPE,
	typeData: noone,
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
itemsData[ITEMS_ID.PLANT_HEAL] = {

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
	maxLiquidAmount: 200,
	damage: 0,
	slow: 1, 
	effect: EFFCTS.WATER,
};
liquidsData[LIQUIDS_ID.BLOOD] = {
	
	spriteBottle: spr_bottle_blood,
	color: make_color_rgb(102, 7, 9),
	amount: 5,
	maxLiquidAmount: 250,
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
game_set_speed(CONSTANTS.SPD_GAME, gamespeed_fps);
window_set_fullscreen(true);

// Se esta em dialogo
global.in_text = false;
#macro inText global.in_text

// Se o jogo esta em pause
global.in_pause = false;
#macro inPause global.in_pause

// Se esta no menu
global.in_menu = false;
#macro inMenu global.in_menu

