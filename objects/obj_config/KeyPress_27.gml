var _charactersMenuIsOff = (instance_exists(obj_wizard) == false || obj_wizard.inCharacterMenus == false);

if(_charactersMenuIsOff) {

	inMenu = !inMenu;
	inPause = inMenu;

	if(inPause)	fPauseGame();
	else		fUnpauseGame()
}