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
	/**
	  Time Cannon
	**/
	override public function useSpecialAbilityA( gameTime : Float ) : Void {
		if (canFireTimeWeapon) {
			canFireTimeWeapon = false;
			
			var projectile = new TimeProjectile( /*Loader.the.getImage("TimeProjectile")*/ null, 10, 10, this.z);
			projectile.x = this.x + (this.lookRight ? this.width + 5 : -5);
			projectile.y = this.y + 10;
			projectile.speedx = (this.lookRight ? 10 : -10);
			projectile.accy = 0;
			Scene.the.addProjectile( projectile );
		}
	}
}
