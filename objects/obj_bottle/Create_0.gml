liquidId = status.liquidId;
liquidAmount = status.liquidAmount;

sprite_index = obj_config.liquidsData[liquidId].spriteBottle;

gravVal = 0.2;
spd = 6;

isThrowing = false;

xPlus = 20;

cooldownInput = 0.1 * CONSTANTS.SPD_GAME;
