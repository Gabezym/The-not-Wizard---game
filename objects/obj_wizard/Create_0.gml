// Time
coyoteJumpTimeVal = CONSTANTS.SPD_GAME*0.1;
cooldownInteraction = CONSTANTS.SPD_GAME*0.1;
cooldownEstamina =	CONSTANTS.SPD_GAME*1;
cooldownDamage = CONSTANTS.SPD_GAME*1.5;

#region Cooldown itens

cooldownAtack	= CONSTANTS.SPD_GAME * 0.4;
cooldownThrow	= CONSTANTS.SPD_GAME * 0.2;
cooldownUseItem	= CONSTANTS.SPD_GAME * 0.1;

#endregion


// Vida
maxLife = 100;
life = maxLife;


// Condição
stopCondition = false;


// Toxicity
toxicityLevel = 0;			// Nivel atual
toxicityValLevel = 0;		// Valor atual do nivel
toxicityMaxValLevel = 100;	// Maximo de toxicidade por nivel


// Dano(inimigo -> player)
recoilXDmg = 0;
recoilYDmg = 0;
alarmDmg = 5;

// Shader damage
timesShaderDmg = 5;			// Quantas vezes o efeito aparece
shadersDmgCheckVal = cooldownDamage/timesShaderDmg;
shadersDmgCheck = false;	// Booleano pra aplicar o shader


// Colisão de interação
objColInteraction = instance_create_layer(x, y, layer, obj_wizard_collision_interaction, {character: id});
// Qual instancia da array de objetos interagiveis sera usado
indexAI = 0;

// Alarm Id
alarmLiquid = 3;
alarmInt = 2;

// Array
followObjects = [];	
interactionObjects = [];

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

#endregion

#region Sprites, escala e colisão

spr_bodyArm		= [spr_wizard_body_idle, spr_wizard_body_walk, spr_wizard_body_falling, spr_wizard_body_jump];
spr_bodyNoArm	= [spr_wizard_body_noArm_idle, spr_wizard_body_noArm_walk, spr_wizard_body_noArm_falling, spr_wizard_body_noArm_jump];
spr_rightLeg	= [spr_wizard_leg_right_idle, spr_wizard_leg_right_walk, spr_wizard_leg_right_falling, spr_wizard_leg_right_jump];
spr_LeftLeg		= [spr_wizard_leg_left_idle, spr_wizard_leg_left_walk, spr_wizard_leg_left_falling, spr_wizard_leg_left_jump];

sprite_body = 0;

armXVal = -1;
armYVal = -12;
disToHand = (sprite_get_height(spr_wizard_arm) - 8);

armX = 0;
armY = 0;
armAngle = 0

armShake = 0;		// Armazena valor do shake

armShakeAttackVal = 13;
armShakeAttack = armShakeAttackVal;

armShakeThrowDirection = 40;	// Valor pra mover pra cima ou pra baixo antes de arremessar
armShakeThrow = 3;				// Valor do shake do throw


// Escala
xScaleVal = 1;		// Valor pra mudar o lado
xScale = xScaleVal;	// Inverte o sprite ou nao
image_yscale = xScaleVal;
image_xscale = xScaleVal;

// Sprite colisão
sprCollision = spr_wizard_collision;	// Sprite da colisao
mask_index = sprCollision;				// Colisao


#endregion

#region Valores Movimentação XY

// Valores XY
hval = 0;
vval = 0;
jumpVal = 0;	// Armazema pulo Pressionado(vezes q ocorreu)

spdVal = 4;
spd = spdVal;
spdJumpVal = -8;
spdJump = spdJumpVal;
maxJumpVal = 11; // Maximo q pode pressionar o pulo
grav = 0.7;
maxGravVal = 11;
slow = 1;

// Pra n da pra ficar pulando pressionando infinitamente
canJump = true;

#endregion

#region Estamina

maxEstamina = 100;
estamina = maxEstamina;
regeneracaoEstaminaVal = 2;
regeneracaoEstamina = regeneracaoEstaminaVal;
estThrow	= 15;	// Dreno de estamina por jogar itens
estAttack	= 20;

#endregion

#region Bool geral

isDead = false;
isJumping = false
isFalling = false;
isFirstJump = true;		// Se tu ainda n pulou, só pode acontecer no chão
isCoyoteJump = false;
inJumpAnimation = false;
inAtackAnimation = false;
inThrowingAnimation	= false;
inCharacterMenus = false;

#endregion

#region Inventario

var _YSize = 2;
var _XSixe = 5;

inventory = array_create(_YSize);	// Colunas
totalSlots = 0;
clearSlot = {
		
	isFull: false,
	itemId: ITEMS_ID.NOTHING,
	itemStatus: {},
	itemAmount: 0
};


for(var _y = 0; _y < array_length(inventory); _y++) {

	inventory[_y] = array_create(_XSixe)	// Linhas
	
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
itemSelectedStruct = clearSlot;
lastItemSelectedStruct = itemSelectedStruct;

// Pro inventario do draw 
slotStrClick = undefined;
slotClick = -1;
newInventory = undefined;

// Input Itens
isInputItem = false;			// Se ta mandando um input pro item em mãos(primario)
isInputPressedItem = false;		// Se deu um click de input pro item em mãos(primario)
isInputItem2 = false;			// Se ta mandando um input pro item em mãos(secundario)
isInputPressedItem2 = false;	// Se deu um click de input pro item em mãos(secundario)

isUpdateInvetory = false;
isInInventory = false;
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

#region Effects Vars

// Alarme de duração dos efeitos
effectsAlarm = array_create(global.lenAlarmEffects, 0);

// Se esta com o efeito 
effectsBoolean = array_create(global.lenAlarmEffects, false);


fWithCreateEfBigJump(self);
fWithCreateFire(self);
fWithCreateEfMoreDamage(self);

#endregion