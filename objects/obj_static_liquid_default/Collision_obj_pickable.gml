if(inPause) exit;

if(liquidId == LIQUIDS_ID.WATER) other.inFire = false;
else if(liquidId == LIQUIDS_ID.LAVA) other.inFire = true;