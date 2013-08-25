package;

import kha.Painter;
import kha.Scene;
import projectiles.PistolProjectile;

class PlayerAgent extends Player {
	private var graple: GrapleHook;
	
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman");
		Player.setPlayer(0, this);
		graple = new GrapleHook();
		Scene.the.addHero(graple);
	}
	
	var lastFired : Float = 0;
	
	override public function prepareSpecialAbilityA(gameTime:Float) : Void {
		isCrosshairVisible = true;
	}
	
	/**
	  Pistole
	**/
	override public function useSpecialAbilityA(gameTime : Float) : Void {
		if (lastFired + 0.2 < gameTime) {
			var projectile = new PistolProjectile( null, 5, 5, this.z);
			projectile.x = this.x + (this.lookRight ? 0.5 * this.width + 0.5 * projectile.width : -0.5 * projectile.width);
			projectile.y = this.y + 10;
			projectile.speedx = 10 * crosshairX;
			projectile.speedy = 10 * crosshairY;
			projectile.accy = 0;
			Scene.the.addProjectile( projectile );
			lastFired = gameTime;
		}
		isCrosshairVisible = false;
	}
	
	/**
	  Haken
	**/
	override public function useSpecialAbilityB(gameTime : Float) : Void {
		
	}
	
	override public function update() {
		super.update();
		graple.x = x + 10;
		graple.y = y + 5;
		graple.rotation.angle = Math.atan2(crosshairY, crosshairX);
	}
	
	override public function render(painter:Painter): Void {
		super.render(painter);
	}
}
