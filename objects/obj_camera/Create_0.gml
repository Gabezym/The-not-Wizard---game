// Posição da View
view = 0;	// Qual view esta alterando
xView = 0;
yView = 0;

// Tamanho da camera
camWidth	= CONSTANTS.CAMERA_WIDTH;
camHeight	= CONSTANTS.CAMERA_HEIGHT;

#region Movimentação

// Oq ta seguindo
follow = obj_wizard;

// Pra onde XY tem q ir
xTo = x;
yTo = y;

// Novo valor XY
newX = 0;
newY = 0;

camSpd = 0.15;

#endregion

#region Shake screen

shakeVal = 0;

shakeHeavy = 25;
shakeMedium = 10;
shakeSmall = 5;
shakeRealySmall = 2;

#endregion