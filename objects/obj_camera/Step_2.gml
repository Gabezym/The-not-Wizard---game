// Aplica posição camera
x = newX;
y = newY;

// Aplica posição a view
view_xport[view] = xView;
view_yport[view] = yView;	

// Aplica zoom
camera_set_view_size(view_camera[view], viewWidth, viewHeight);

// Centraliza na camera
camera_set_view_pos(view_camera[view], x - (viewWidth*0.5), y -(viewHeight*0.5));