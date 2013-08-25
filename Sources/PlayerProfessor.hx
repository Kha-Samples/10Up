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
			
			var projectile = new TimeProjectile( crosshair, 10, 10, this.z );
			projectile.x = muzzlePoint.x + (lookRight ? 0.8 : -0.8) * (projectile.width * crosshair.x);
			projectile.y = muzzlePoint.y + (lookRight ? 0.8 : -0.8) * (projectile.height * crosshair.y);
			Scene.the.addProjectile( projectile );
			isCrosshairVisible = false;
		}
	}
}
