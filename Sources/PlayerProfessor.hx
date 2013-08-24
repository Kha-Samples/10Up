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
		TenUp.getInstance().crosshair.visible = canFireTimeWeapon;
	}
	
	/**
	  Time Cannon
	**/
	override public function useSpecialAbilityA( gameTime : Float ) : Void {
		if (canFireTimeWeapon) {
			canFireTimeWeapon = false;
			
			var vx = TenUp.getInstance().crosshair.x;
			var vy = TenUp.getInstance().crosshair.y;
			
			var projectile = new TimeProjectile( /*Loader.the.getImage("TimeProjectile")*/ null, 10, 10, this.z);
			projectile.x = this.x + (this.lookRight ? 0.5 * this.width + 0.5 * projectile.width : -0.5 * projectile.width);
			projectile.y = this.y + 10;
			projectile.speedx = 10 * vx;
			projectile.speedy = 10 * vy;
			projectile.accy = 0;
			Scene.the.addProjectile( projectile );
			TenUp.getInstance().crosshair.visible = false;
		}
	}
}
