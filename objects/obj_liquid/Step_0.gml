if(inPause) exit;

fWithLiquidPhysicsAndCollisons(self);
	
// Diminui ocupacida e exclui obj 
if(death == 1) {
	
	if(alpha > 0.1) alpha = lerp(0, alpha, 0.9);
	
	else instance_destroy();	
}

image_alpha = alpha;
