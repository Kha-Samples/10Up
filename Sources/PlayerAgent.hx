package;

import kha.Color;
import kha.math.Vector2;
import kha.Painter;
import kha.Scene;
import projectiles.PistolProjectile;

class PlayerAgent extends Player {
	private var graple: GrapleHook;
	private var grapleVec: Vector2;
	private var grapleLength: Float;
	private var grapleBack = false;
	private var maxGrapleLength: Float = 350;
	
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman");
		Player.setPlayer(0, this);
		graple = new GrapleHook();
		grapleVec = null;
		grapleLength = 0;
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
		grapleVec = new Vector2(crosshairX, crosshairY);
	}
	
	override public function update() {
		super.update();
		graple.x = x + 10;
		graple.y = y + 5;
		graple.rotation.angle = Math.atan2(crosshairY, crosshairX);
		
		if (grapleVec != null) {
			if (grapleBack) {
				grapleLength -= 10;
				if (grapleLength < 0) {
					grapleLength = 0;
					grapleBack = false;
					grapleVec = null;
				}
			}
			else {
				grapleLength += 10;
				if (grapleLength > maxGrapleLength) {
					grapleLength -= (grapleLength - maxGrapleLength);
					grapleBack = true;
				}
			}
		}
	}
	
	override public function render(painter:Painter): Void {
		super.render(painter);
		if (grapleVec != null) {
			painter.setColor(Color.fromBytes(0, 0, 0));
			painter.drawLine(x + 10, y + 5, x + 10 + grapleVec.x * grapleLength, y + 5 + grapleVec.y * grapleLength);
		}
	}
}
