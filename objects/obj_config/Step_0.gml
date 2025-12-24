// Pause alarms
if(inPause) {

	with(all) {
	
		for(var _i = 0; _i < 12; _i++) {
		
			 alarm[_i] = pauseAlarmVal[_i];
		}
	}
}