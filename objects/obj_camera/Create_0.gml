// Tamanho da camera original
camWidth = 1920;
camHeight= 1080;

// Resolução camera
camera_set_view_size(view_camera[0], camWidth, camHeight);

// Oq ela ta seguindo
follow = obj_wizard;

xTo = x;
yTo = y;

// Zoom 
maxZoomVal = 2;
minZoomVal = 0.75;
zoomVal = 1;
zoomSpd = 0.05;

// Tamanho da camera
viewWidth	= camera_get_view_width(view_camera[0]);
viewHeight = camera_get_view_height(view_camera[0]);

// Keybinds
keyZoomIn	= ord("I");
keyZoomOut	= ord("O");

// Shake screen
shakeVal = 0;

shakeHeavy = 25;
shakeMedium = 10;
shakeSmall = 5;
shakeRealySmall = 2;
