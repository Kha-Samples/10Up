package;

import kha.Scene;
import projectiles.PistolProjectile;

class PlayerAgent extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman");
		Player.setPlayer(0, this);
	}
	
	var lastFired : Float = 0;
	
	override public function prepareSpecialAbilityA(gameTime:Float) : Void {
		TenUp.getInstance().crosshair.visible = true;
	}
	
	/**
	  Pistole
	**/
	override public function useSpecialAbilityA(gameTime : Float) : Void {
		if (lastFired + 0.2 < gameTime) {
			var vx = TenUp.getInstance().crosshair.x;
			var vy = TenUp.getInstance().crosshair.y;
			
			var projectile = new PistolProjectile( null, 5, 5, this.z);
			projectile.x = this.x + (this.lookRight ? 0.5 * this.width + 0.5 * projectile.width : -0.5 * projectile.width);
			projectile.y = this.y + 10;
			projectile.speedx = 10 * vx;
			projectile.speedy = 10 * vy;
			projectile.accy = 0;
			Scene.the.addProjectile( projectile );
			lastFired = gameTime;
		}
		TenUp.getInstance().crosshair.visible = false;
	}
	
	/**
	  Haken
	**/
	override public function useSpecialAbilityB(gameTime : Float) : Void {
		
	}
}
