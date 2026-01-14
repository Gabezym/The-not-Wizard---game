if(inPause) exit;

// Aplica posição camera
x = newX;
y = newY;

// Aplica posição a view(shakeScreen)
view_xport[view] = xView;
view_yport[view] = yView;	

// Centraliza na camera
camera_set_view_pos(view_camera[view], x-camWidth/2, y-camHeight/2);