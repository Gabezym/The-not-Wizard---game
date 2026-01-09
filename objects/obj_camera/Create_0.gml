// Keybinds
keyZoomIn	= ord("I");
keyZoomOut	= ord("O");

// Tamanho da camera original
camWidth = 1920;
camHeight= 1080;

// Posição da View
view = 0;	// Qual view esta alterando
xView = 0;
yView = 0;

// Resolução camera
camera_set_view_size(view_camera[view], camWidth, camHeight);


// Tamanho da camera
viewWidth	= camera_get_view_width(view_camera[view]);
viewHeight = camera_get_view_height(view_camera[view]);


// Oq ta seguindo
follow = obj_wizard;

// Pra onde XY tem q ir
xTo = x;
yTo = y;

// Novo valor XY
newX = 0;
newY = 0;

#region Shake screen

shakeVal = 0;

shakeHeavy = 25;
shakeMedium = 10;
shakeSmall = 5;
shakeRealySmall = 2;

#endregion

#region Zoom 

maxZoomVal = 3;
minZoomVal = 2;
zoomVal = maxZoomVal;
zoomSpd = 0.05;

#endregion
