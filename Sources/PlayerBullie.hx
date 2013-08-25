package;

class PlayerBullie extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman3");
		Player.setPlayer(2, this);
		health = 100;
	}
	
	/**
	  Hauen
	**/
	override public function useSpecialAbilityA(gameTime : Float) : Void {
		
	}
	
	/**
	  Heben
	**/
	override public function useSpecialAbilityB(gameTime : Float) : Void {
		
	}
}
