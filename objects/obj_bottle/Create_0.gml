// Inherit the parent event
event_inherited();

liquidId = status.liquidId;
liquidAmount = status.liquidAmount;

sprite_index = obj_config.liquidsData[liquidId].spriteBottle;

// Liquid vars
gravVal = 0.2;
spd = 6;
// isThrowing = false;
cooldownInput = 0.1 * CONSTANTS.SPD_GAME;
