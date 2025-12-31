if(inPause) exit;

stopCondition = (isInInventory || inText || inPause);

// Inputs
fWithInputs(self);

// Se ficar preso
fStuck(self);

// Sai das abas ao tomar dano
if(recoilXDmg != 0 || recoilYDmg != 0) {
	
	isInInventory = false;
	isCrafting = false;
	craftIndexItem1 = -1;
	craftIndexItem2 = -1;
}

// Movimentação
fWithMovementHvalVval(self);

// Estamina
fWithEstamina(self);

// Slow padrão 
slow = fResetSlow(self, false);

// Efeitos
fWithEffectsPlayer(self);

// Crafting
fWithCraftingPotions(self);

// Inventario
fWithInventory(self);

