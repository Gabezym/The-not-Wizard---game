if(inPause) exit;

nextIndex = keyboard_check_pressed(keyNextIndex);
	
if(nextIndex) {
		
	// Next text
	if(indexText + 1 < indexlength) indexText++;
	// End chat
	else {
			
		// Cooldown pra não entrar no texto denovo	
		if(instance_exists(obj_wizard)) {
			
			with(obj_wizard) alarm[alarmInt] = cooldownInteraction;	
		}
			
		inText = false;
		instance_destroy();
	}
}
