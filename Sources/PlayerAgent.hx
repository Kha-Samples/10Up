package;

class PlayerAgent extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman");
		Player.setPlayer(0, this);
	}
	
	/**
	  Pistole
	**/
	override public function useSpecialAbilityA(gameTime : Float) : Void {
		
	}
	
	/**
	  Haken
	**/
	override public function useSpecialAbilityB(gameTime : Float) : Void {
		
	}
}
