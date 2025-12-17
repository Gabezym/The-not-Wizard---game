stopCondition = (isInInventory || inText);

// Inputs
fWithInputs(self);

// Se ficar preso
fStuck(self);

// Se n tomou dano -> movimentação
if(recoilXDmg == 0 && recoilYDmg == 0) {
	
	// Movimentação
	fWithMovementHvalVval(self);
}
// Se tomou dano com recoil -> reseta vars
else {

	isInInventory = false;
	isCrafting = false;
	craftIndexItem1 = -1;
	craftIndexItem2 = -1;
	hval = 0;
	vval = 0;
}

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
