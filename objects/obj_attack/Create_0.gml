xScale = 1;	

lifeTime = CONSTANTS.SPD_GAME*0.05;

alarm[0] = lifeTime;
image_angle = angle;

var ang = image_angle % 360;
if (ang < 0) ang += 360;

image_yscale = (ang > 90 && ang < 270) ? -1 : 1;


alreadyAttacked = [];

