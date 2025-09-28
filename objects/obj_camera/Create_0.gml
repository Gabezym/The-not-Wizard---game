// Tamanho da camera original
camWidth = 1920;
camHeight= 1080;

// Aplica na câmera
camera_set_view_size(view_camera[0], 1920, 1080);

// Oq ela ta seguindp
follow = obj_wizard;

xTo = x;
yTo = y;

maxZoomVal = 2;
minZoomVal = 0.75;

zoomVal = 1;
zoomSpd = 0.05;

// Tamanho da camera
viewWidth	= camera_get_view_width(view_camera[0]);
viewHeight = camera_get_view_height(view_camera[0]);

// Keybinds
keyZoomIn	= "I";
keyZoomOut	= "O";