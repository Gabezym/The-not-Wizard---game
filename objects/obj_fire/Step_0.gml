if(inPause) exit;

y+=grav;
x+=spd

if(life<=0) {

	image_alpha = lerp(0, image_alpha, random_range(0.3, 0.9));
	
	if(image_alpha <= 0) instance_destroy();
}