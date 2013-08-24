package;

import kha.Color;
import kha.Loader;
import kha.Painter;
import kha.Scene;
import projectiles.TimeProjectile;

class PlayerProfessor extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman2");
		Player.setPlayer(1, this);
	}
	
	var canFireTimeWeapon = true;
	override public function prepareSpecialAbilityA(gameTime:Float) : Void {
		isCrosshairVisible = canFireTimeWeapon;
	}
	
	/**
	  Time Cannon
	**/
	override public function useSpecialAbilityA( gameTime : Float ) : Void {
		if (canFireTimeWeapon) {
			canFireTimeWeapon = false;
			
			var projectile = new TimeProjectile( /*Loader.the.getImage("TimeProjectile")*/ null, 10, 10, this.z);
			projectile.x = this.x + (this.lookRight ? 0.5 * this.width + 0.5 * projectile.width : -0.5 * projectile.width);
			projectile.y = this.y + 10;
			projectile.speedx = 10 * crosshairX;
			projectile.speedy = 10 * crosshairY;
			projectile.accy = 0;
			Scene.the.addProjectile( projectile );
			isCrosshairVisible = false;
		}
	}
}
