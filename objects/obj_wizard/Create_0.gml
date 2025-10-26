#region Comandos 

escape = 0;

leftClickPressed = 0;
leftClickReleased = 0;
leftClick = 0;

rightClickPressed = 0;
rightClick = 0;

jump	= 0;
right	= 0;
left	= 0;

inputInventory = 0;
moveOneItem = 0;

interact = 0;
changeIndex = 0;

slot1	= 0;
slot2	= 0;
slot3	= 0;
slot4	= 0;
slot5	= 0;

#endregion
#region	Keybinds

keyEscape = vk_escape;

mouseLeftClick = mb_left;
mouseRightClick = mb_right;

keyJump = vk_space;
keyRight = ord("D");
keyLeft = ord("A");
keyInventory = vk_tab
keyInteract = ord("E");
keyChangeIndex = ord("Q");

keySlot1 = ord("1");
keySlot2 = ord("2");
keySlot3= ord("3");
keySlot4 = ord("4");
keySlot5 = ord("5");

keyMoveOneItem = vk_control;

#endregion

maxLife = 100;
life = maxLife;

// Valores XY
hval = 0;
vval = 0;
jumpVal = 0;	// Armazema pulo Pressionado(vezes q ocorreu)

#region Valores Movimentação

spdVal = 5
spd = spdVal;
spdJumpVal = -12;
spdJump = spdJumpVal;
maxJumpVal = 15; // Maximo q pode pressionar o pulo
grav = 1;
slow = 1;

#endregion

#region Estamina

maxEstamina = 100;
estamina = maxEstamina;
regeneracaoEstaminaVal = 2;
regeneracaoEstamina = regeneracaoEstaminaVal;
estJump = 1.5;	// Dreno de estamina por pulo

#endregion

xScaleVal = 2;		// Valor pra mudar o lado
xScale = xScaleVal;	// Inverte o sprite ou nao
image_yscale = xScaleVal;
image_xscale = xScaleVal;

sprCollision = spr_wizard_collision;	// Sprite da colisao
mask_index = sprCollision;				// Colisao

// Colisão de interação
objColInteraction = instance_create_layer(x, y, layer, obj_wizard_collision_interaction, {character: id});
// Qual instancia da array de objetos interagiveis sera usado
indexAI = 0;

#region Bool
isDead = false;
isJumping = false
isFalling = false;
isFirstJump = true;		// Se tu ainda n pulou, só pode acontecer no chão
isCoyoteJump = false;
isInInventory = false;
isInputItem = false;		// Se ta mandando um input pro item em mãos(primario)
isInputPressedItem = false;	// Se deu um click de input pro item em mão
isInputItem2 = false;		// Se ta mandando um input pro item em mãos(secundario)
inJumpAnimation = false;
isUpdateInvetory = false;
isInLadder = false;		// Se ta subindo uma escada

#endregion

#region Inventario

inventory = array_create(6);	// Colunas
totalSlots = 0;
clearSlot = {
		
	isFull: false,
	itemId: ITEMS_ID.NOTHING,
	itemStatus: {},
	itemAmount: 0
};


for(var _y = 0; _y < array_length(inventory); _y++) {

	var _xSize = 5;
	inventory[_y] = array_create(_xSize)	// Linhas
	
	// array_length(inventory[_y]) retorna a array da coluna _y
	for(var _x = 0; _x < array_length(inventory[_y]); _x++) {
	
		// Deixa o inventario zerado como padrão
		inventory[_y][_x] = clearSlot;
		totalSlots++;
	}
}
	
inventorySprBorder		= spr_inventory_border;		// Sprite inventario
inventorySprBackground	= spr_inventory_background;	// Sprite inventario
inventorySprSelected	= spr_inventory_selected;	// Sprite inventario	
inventorySprPlate		= spr_inventory_plate;		// Sprite inventario

toPick = []				// Itens a serem adicionados ao inventario
selectedSlot = 0;		// Slot selecionado
lastSelectedSlot = selectedSlot;

itemInHand = 0;		// Armazeana o id do item selecionado -> IMPORTANTE
instanceInHands = noone;

// Retorna a struct do INVENTARIO
itemSelectedStruct = {}

// Pro inventario do draw 
slotStrClick = undefined;
slotClick = -1;
newInventory = undefined;

#endregion

#region Crafting
isCrafting = false;
crafting = array_create(2, 0);	// Onde vao ficar os objetos no crafting
craftIndexItem1 = -1;	// Armazena Id do item colocado no primeiro slot
craftIndexItem2 = -1	// Armazena Id do item colocado no segundo slot
craftMoveItem	= false;// Se acabou de mover um item pro slot do crafting


craftVarInXDef	= 274;
craftVarInLen	= array_length(inventory[0]);
craftVarInSize	= 64;

var _halfWid = sprite_get_width(spr_craftingUI_base) div 2;
var _halfHei = sprite_get_height(spr_craftingUI_base) div 2;

craftVarDefX	= craftVarInXDef + (craftVarInLen*craftVarInSize);
craftVarDefY	= 150;

craftDoneVarDefX =  craftVarDefX + _halfWid;
craftDoneVarDefY = craftVarDefY + _halfHei*2.5;

craftVarB1	= craftVarDefX + 15		+32;
craftVarB2	= craftVarDefX + 144	+32;
craftVarB3	= craftVarDefX + 271	+32;

#endregion

// Array
followObjects = [];	
interactionObjects = [];

// Time
coyoteJumpTimeVal = CONSTANTS.SPD_GAME*0.1;
cooldownInteraction = CONSTANTS.SPD_GAME*0.1;
cooldownEstamina =	CONSTANTS.SPD_GAME*1;


// Effects Vars
effectsAlarm = array_create(global.lenAlarmEffects, 0);

fWithCreateEfBigJump(self);
fWithCreateFire(self);