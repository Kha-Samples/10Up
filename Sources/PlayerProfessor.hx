package;

import kha2d.Animation;
import kha.Color;
import kha.graphics2.Graphics;
import kha.math.Vector2;
import kha2d.Rectangle;
import kha2d.Scene;
import projectiles.TimeProjectile;

class PlayerProfessor extends Player {
	var timecannon : TimeCannon;
	
	public function new(x: Float, y: Float) {
		super(x, y - 8, "professor", Std.int(410 / 10) * 2, Std.int(455 / 7) * 2);
		Player.setPlayer(1, this);
				
		collider = new Rectangle(20, 30, 41 * 2 - 40, (65 - 1) * 2 - 30);
		walkLeft = Animation.createRange(11, 18, 4);
		walkRight = Animation.createRange(1, 8, 4);
		standLeft = Animation.create(10);
		standRight = Animation.create(0);
		jumpLeft = Animation.create(16);
		jumpRight = Animation.create(6);
		
		timecannon = new TimeCannon();
	}
	
	override public function leftButton(): String {
		return "Shoot";
	}
	
	override public function rightButton(): String {
		return "Hack";
	}
	
	@:access(kha.Animation) 
	override public function update() {
		super.update();
		timecannon.update();
		var c = center;
		timecannon.x = c.x - 0.5 * timecannon.width;
		//graple.x = x + 10;
		timecannon.y = c.y - 0.5 * timecannon.height - 7;
		timecannon.angle = Math.atan2(crosshair.y, crosshair.x);
		if (lookRight) {
			timecannon.x += 15;
			if (@:privateAccess timecannon.animation.indices != @:privateAccess timecannon.rightAnim.indices) {
				@:privateAccess timecannon.animation.indices = @:privateAccess timecannon.rightAnim.indices;
				timecannon.originX = timecannon.width - timecannon.originX;
			}
		}
		else {
			timecannon.x -= 15;
			timecannon.angle = timecannon.angle + Math.PI;
			if (@:privateAccess timecannon.animation.indices != @:privateAccess timecannon.leftAnim.indices) {
				@:privateAccess timecannon.animation.indices = @:privateAccess timecannon.leftAnim.indices;
				timecannon.originX = timecannon.width - timecannon.originX;
			}
		}
	}
	
	override public function render(g: Graphics): Void {
		super.render(g);
		if (isCrosshairVisible || timeCannonNextFireTime > TenUp.instance.currentGameTime + 23.5) {
			timecannon.render(g);
		}
	}
	
	/**
	  Time Cannon
	**/
	var timeCannonNextFireTime : Float = 0;
	override public function prepareSpecialAbilityA(gameTime:Float) : Void {
		isCrosshairVisible = true;
	}
	
	override public function useSpecialAbilityA( gameTime : Float ) : Void {
		if ( timeCannonNextFireTime  <= gameTime ) {
			timeCannonNextFireTime = gameTime + 25;
			
			var projectile = new TimeProjectile( crosshair, this.z );
			projectile.x = muzzlePoint.x + (0.8 * projectile.width * crosshair.x);
			projectile.y = muzzlePoint.y + (0.8 * projectile.height * crosshair.y);
			Scene.the.addProjectile( projectile );
			isCrosshairVisible = false;
		}
	}
	
	/**
	  Hacking
	 */
	override public function useSpecialAbilityB(gameTime: Float): Void {
		if (Level.the.computers.length > 0) {
			var computer = Level.the.computers[0];
			if (computer.collisionRect().collision(collisionRect())) {
				Level.the.gates[0].open();
			}
		}
	}
}
