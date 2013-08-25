package;
import kha.Scene;
import kha.Sprite;
import projectiles.FistOfDoom;

class PlayerBullie extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman3");
		Player.setPlayer(2, this);
		_health = 100;
	}
	
	override public function hit(sprite: Sprite): Void {
		if (sprite != fistOfDoom) {
			super.hit(sprite);
		}
	}
	
	override public function sleep() {
		super.sleep();
		if (fistOfDoom != null) {
			fistOfDoom.remove();
		}
	}
	
	/**
	  Hauen
	**/
	var fistOfDoom : FistOfDoom;
	override public function prepareSpecialAbilityA(gameTime: Float): Void {
		if (fistOfDoom == null) {
			fistOfDoom = new FistOfDoom(this, 20, 20);
			Scene.the.addProjectile( fistOfDoom );
		}
	}
	
	override public function useSpecialAbilityA(gameTime : Float) : Void {
		if (fistOfDoom != null) {
			fistOfDoom.releaseDoom();
		}
	}
	
	/**
	  Heben
	**/
	override public function useSpecialAbilityB(gameTime : Float) : Void {
		
	}
}
