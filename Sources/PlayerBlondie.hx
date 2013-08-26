package;

class PlayerBlondie extends Player {
	public function new(x: Float, y: Float) {
		super(x, y - 8, "mechanic", 21 * 2, 52 * 2);
		Player.setPlayer(3, this);
		repairAmountPerSec = 50;
	}
	
	override public function update() {
		super.update();
		
		if ( repairing != null ) {
			var amount = Math.round( repairAmountPerSec * (TenUp.instance.currentGameTime - lastRepairTime) );
			if ( amount > 0 ) {
				lastRepairTime = TenUp.instance.currentGameTime;
				repairing.health += amount;
			}
		}
		
		if (isDancing && Player.current() != this && lastDanceTime < TenUp.instance.currentGameTime) {
			isDancing = false;
			// TODO: stop dance animation
		}
	}
	
	/**
	  Tanzen
	**/
	public var isDancing(default, null) : Bool = false;
	var lastDanceTime : Float;
	override public function prepareSpecialAbilityA(gameTime : Float) : Void {
		isDancing = true;
		// TODO: start dance animation
	}
	override public function useSpecialAbilityA(gameTime : Float) : Void {
		lastDanceTime = gameTime + 7;
	}
	
	/**
	  Reparieren
	**/
	var repairAmountPerSec : Float;
	var lastRepairTime : Float;
	var repairing : DestructibleSprite;
	
	override public function prepareSpecialAbilityB(gameTime: Float): Void {
		if (repairing == null) {
			var rect = collisionRect();
			for (checkSprite in TenUp.instance.level.destructibleSprites) {
				if ( checkSprite != this && checkSprite.isRepairable ) {
					if ( rect.collision( checkSprite.collisionRect() ) ) {
						repairing = checkSprite;
						lastRepairTime = gameTime;
						return;
					}
				}
			}
		}
	}
	
	override public function useSpecialAbilityB(gameTime : Float) : Void {
		if (repairing != null) {
			repairing.health += Math.round( repairAmountPerSec * (gameTime - lastRepairTime) );
			repairing = null;
		}
	}
}
